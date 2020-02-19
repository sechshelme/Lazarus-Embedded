unit AVR_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons,
  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  AVR_IDE_Options, AVR_Common, AVR_Project_Templates_Form, AVR_SubArch_List;

type

  { TProjectOptionsForm }

  TProjectOptionsForm = class(TForm)
    AsmFile_CheckBox: TCheckBox;
    avrdudeConfigPathComboBox: TComboBox;
    avrdudePathComboBox: TComboBox;
    AVR_Typ_FPC_ComboBox: TComboBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    AVR_Typ_avrdude_Edit: TEdit;
    AVR_SubArch_ComboBox: TComboBox;
    Disable_Auto_Erase_CheckBox: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Memo1: TMemo;
    TemplatesButton: TButton;
    COMPortBaudComboBox: TComboBox;
    COMPortComboBox: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    OpenDialogAVRConfigPath: TOpenDialog;
    OpenDialogAVRPath: TOpenDialog;
    ProgrammerComboBox: TComboBox;
    procedure AVR_SubArch_ComboBoxChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    procedure ChangeAVR;
  public
    procedure LoadDefaultMask;
    procedure ProjectOptionsToMask;
    procedure MaskToProjectOptions;
  end;

var
  ProjectOptionsForm: TProjectOptionsForm;

implementation

{$R *.lfm}

{ TProjectOptionsForm }

procedure TProjectOptionsForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TProjectOptionsForm.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TProjectTemplatesForm;
  i: integer;

begin
  TemplatesForm := TProjectTemplatesForm.Create(nil);

  for i := 0 to Length(TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(TemplatesPara[i].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    i := TemplatesForm.ListBox_Template.ItemIndex;

    ProgrammerComboBox.Text := TemplatesPara[i].Programmer;
    COMPortComboBox.Text := TemplatesPara[i].COM_Port;
    COMPortBaudComboBox.Text := TemplatesPara[i].Baud;
    AVR_Typ_FPC_ComboBox.Text := TemplatesPara[i].AVR_FPC_Typ;
    AVR_Typ_avrdude_Edit.Text := TemplatesPara[i].AVR_AVRDude_Typ;
    AVR_SubArch_ComboBox.Text := TemplatesPara[i].AVR_SubArch;
    AVR_SubArch_ComboBox.OnChange(Sender);

    Disable_Auto_Erase_CheckBox.Checked := TemplatesPara[i].Disable_Auto_Erase;
  end;

  TemplatesForm.Free;
end;

procedure TProjectOptionsForm.LoadDefaultMask;
begin

  with avrdudePathComboBox do begin
    Items.Add('avrdude');
    {$IFDEF MSWINDOWS}
    Items.Add('c:\averdude\averdude.exe');
    {$ELSE}
    Items.Add('/usr/bin/avrdude');
    {$ENDIF}
    Text := AVR_Options.avrdudePfad;
  end;

  with avrdudeConfigPathComboBox do begin
    {$IFDEF MSWINDOWS}
    Items.Add('c:\averdude\avrdude.conf');
    {$ELSE}
    Items.Add('avrdude.conf');
    {$ENDIF}
    Text := AVR_Options.avrdudeConfigPath;
  end;

  with AVR_SubArch_ComboBox do begin
    Items.CommaText := SubArch_List;
    ItemIndex := 3;
    Style := csOwnerDrawFixed;
    Text := 'AVR5';
  end;

  with AVR_Typ_FPC_ComboBox do begin
    Sorted := True;
    Text := 'atmega328P';
  end;

  AVR_Typ_avrdude_Edit.Text := 'atmega328P';

  with ProgrammerComboBox do begin
    Items.CommaText := 'arduino,usbasp,stk500v1,wiring';
    Text := 'arduino';
  end;

  with COMPortComboBox do begin
    Items.CommaText := GetSerialPortNames;
    Text := '/dev/ttyUSB0';
  end;

  with COMPortBaudComboBox do begin
    Items.CommaText := '19200,57600,115200';
    Text := '57600';
  end;

  AsmFile_CheckBox.Checked := False;
  Disable_Auto_Erase_CheckBox.Checked := False;
end;

procedure TProjectOptionsForm.ProjectOptionsToMask;
begin
  AVR_SubArch_ComboBox.Text := ProjectOptions.AVR_SubArch;
  AVR_Typ_FPC_ComboBox.Text := ProjectOptions.AVR_FPC_Typ;

  avrdudePathComboBox.Text := ProjectOptions.AvrdudeCommand.Path;
  avrdudeConfigPathComboBox.Text := ProjectOptions.AvrdudeCommand.ConfigPath;
  ProgrammerComboBox.Text := ProjectOptions.AvrdudeCommand.Programmer;
  COMPortComboBox.Text := ProjectOptions.AvrdudeCommand.COM_Port;
  COMPortBaudComboBox.Text := ProjectOptions.AvrdudeCommand.Baud;
  AVR_Typ_avrdude_Edit.Text := ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ;

  AsmFile_CheckBox.Checked := ProjectOptions.AsmFile;
  Disable_Auto_Erase_CheckBox.Checked :=
    ProjectOptions.AvrdudeCommand.Disable_Auto_Erase;
end;

procedure TProjectOptionsForm.MaskToProjectOptions;
begin
  ProjectOptions.AVR_SubArch := AVR_SubArch_ComboBox.Text;
  ProjectOptions.AVR_FPC_Typ := AVR_Typ_FPC_ComboBox.Text;

  ProjectOptions.AvrdudeCommand.Path := avrdudePathComboBox.Text;
  ProjectOptions.AvrdudeCommand.ConfigPath := avrdudeConfigPathComboBox.Text;
  ProjectOptions.AvrdudeCommand.Programmer := ProgrammerComboBox.Text;
  ProjectOptions.AvrdudeCommand.COM_Port := COMPortComboBox.Text;
  ProjectOptions.AvrdudeCommand.Baud := COMPortBaudComboBox.Text;
  ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ := AVR_Typ_avrdude_Edit.Text;

  ProjectOptions.AsmFile := AsmFile_CheckBox.Checked;
  ProjectOptions.AvrdudeCommand.Disable_Auto_Erase :=
    Disable_Auto_Erase_CheckBox.Checked;
end;

procedure TProjectOptionsForm.ChangeAVR;
var
  ind: integer;
begin
  ind := AVR_SubArch_ComboBox.ItemIndex;
  if (ind < 0) or (ind >= Length(SubArch_List)) then begin
    AVR_Typ_FPC_ComboBox.Items.CommaText := '';
  end else begin
    AVR_Typ_FPC_ComboBox.Items.CommaText := AVR_List[ind];
  end;
end;

procedure TProjectOptionsForm.AVR_SubArch_ComboBoxChange(Sender: TObject);
begin
  ChangeAVR;
end;

procedure TProjectOptionsForm.OkButtonClick(Sender: TObject);
begin
  //  Close;
end;

procedure TProjectOptionsForm.FormCreate(Sender: TObject);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_ProjectOptions_Left, '100'));
  Top := StrToInt(Cfg.GetValue(Key_ProjectOptions_Top, '50'));
  Cfg.Free;
end;

procedure TProjectOptionsForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(AVR_Options_File, False);
  Cfg.SetDeleteValue(Key_ProjectOptions_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_ProjectOptions_Top, IntToStr(Top), '50');
  Cfg.Free;
end;

procedure TProjectOptionsForm.Button1Click(Sender: TObject);
begin
  OpenDialogAVRPath.FileName := avrdudePathComboBox.Text;
  if OpenDialogAVRPath.Execute then begin
    avrdudePathComboBox.Text := OpenDialogAVRPath.FileName;
  end;
end;

procedure TProjectOptionsForm.BitBtn1Click(Sender: TObject);
begin
  AVR_Typ_avrdude_Edit.Text := AVR_Typ_FPC_ComboBox.Text;
end;

procedure TProjectOptionsForm.Button2Click(Sender: TObject);
begin
  OpenDialogAVRConfigPath.FileName := avrdudeConfigPathComboBox.Text;
  if OpenDialogAVRConfigPath.Execute then begin
    avrdudeConfigPathComboBox.Text := OpenDialogAVRConfigPath.FileName;
  end;
end;

procedure TProjectOptionsForm.FormActivate(Sender: TObject);
begin
  ChangeAVR;
end;

end.
