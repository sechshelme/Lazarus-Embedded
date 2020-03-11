unit Embedded_GUI_AVR_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons,
  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports, Embedded_GUI_IDE_Options,
  Embedded_GUI_AVR_Common, Embedded_GUI_AVR_Project_Templates_Form, Embedded_GUI_SubArch_List;

type

  { TAVR_Project_Options_Form }

  TAVR_Project_Options_Form = class(TForm)
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
  AVR_Project_Options_Form: TAVR_Project_Options_Form;

implementation

{$R *.lfm}

{ TAVR_Project_Options_Form }

procedure TAVR_Project_Options_Form.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAVR_Project_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TAVRProjectTemplatesForm;
  i: integer;

begin
  TemplatesForm := TAVRProjectTemplatesForm.Create(nil);

  for i := 0 to Length(AVR_TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(AVR_TemplatesPara[i].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := AVR_TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    i := TemplatesForm.ListBox_Template.ItemIndex;

    ProgrammerComboBox.Text := AVR_TemplatesPara[i].Programmer;
    COMPortComboBox.Text := AVR_TemplatesPara[i].COM_Port;
    COMPortBaudComboBox.Text := AVR_TemplatesPara[i].Baud;
    AVR_Typ_FPC_ComboBox.Text := AVR_TemplatesPara[i].AVR_FPC_Typ;
    AVR_Typ_avrdude_Edit.Text := AVR_TemplatesPara[i].AVR_AVRDude_Typ;
    AVR_SubArch_ComboBox.Text := AVR_TemplatesPara[i].AVR_SubArch;
    AVR_SubArch_ComboBox.OnChange(Sender);

    Disable_Auto_Erase_CheckBox.Checked := AVR_TemplatesPara[i].Disable_Auto_Erase;
  end;

  TemplatesForm.Free;
end;

procedure TAVR_Project_Options_Form.AVR_SubArch_ComboBoxChange(Sender: TObject);
begin
  ChangeAVR;
end;

procedure TAVR_Project_Options_Form.OkButtonClick(Sender: TObject);
begin
  //  Close;
end;

procedure TAVR_Project_Options_Form.FormCreate(Sender: TObject);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Left := StrToInt(Cfg.GetValue(Key_AVR_ProjectOptions_Left, '100'));
  Top := StrToInt(Cfg.GetValue(Key_AVR_ProjectOptions_Top, '50'));
  Width := StrToInt(Cfg.GetValue(Key_AVR_ProjectOptions_Width, '500'));
  Height := StrToInt(Cfg.GetValue(Key_AVR_ProjectOptions_Height, '500'));
  Cfg.Free;
end;

procedure TAVR_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Cfg: TConfigStorage;
begin
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetDeleteValue(Key_AVR_ProjectOptions_Left, IntToStr(Left), '100');
  Cfg.SetDeleteValue(Key_AVR_ProjectOptions_Top, IntToStr(Top), '50');
  Cfg.SetDeleteValue(Key_AVR_ProjectOptions_Width, IntToStr(Width), '500');
  Cfg.SetDeleteValue(Key_AVR_ProjectOptions_Height, IntToStr(Height), '500');
  Cfg.Free;
end;

procedure TAVR_Project_Options_Form.Button1Click(Sender: TObject);
begin
  OpenDialogAVRPath.FileName := avrdudePathComboBox.Text;
  if OpenDialogAVRPath.Execute then begin
    avrdudePathComboBox.Text := OpenDialogAVRPath.FileName;
  end;
end;

procedure TAVR_Project_Options_Form.BitBtn1Click(Sender: TObject);
begin
  AVR_Typ_avrdude_Edit.Text := AVR_Typ_FPC_ComboBox.Text;
end;

procedure TAVR_Project_Options_Form.Button2Click(Sender: TObject);
begin
  OpenDialogAVRConfigPath.FileName := avrdudeConfigPathComboBox.Text;
  if OpenDialogAVRConfigPath.Execute then begin
    avrdudeConfigPathComboBox.Text := OpenDialogAVRConfigPath.FileName;
  end;
end;

procedure TAVR_Project_Options_Form.FormActivate(Sender: TObject);
begin
  ChangeAVR;
end;

// private

procedure TAVR_Project_Options_Form.ChangeAVR;
var
  ind: integer;
begin
  ind := AVR_SubArch_ComboBox.ItemIndex;
  if (ind < 0) or (ind >= Length(AVR_SubArch_List)) then begin
    AVR_Typ_FPC_ComboBox.Items.CommaText := '';
  end else begin
    AVR_Typ_FPC_ComboBox.Items.CommaText := AVR_List[ind];
  end;
end;

// public

procedure TAVR_Project_Options_Form.LoadDefaultMask;
begin

  with avrdudePathComboBox do begin
    Items.Add('avrdude');
    //{$IFDEF MSWINDOWS}
    //Items.Add('c:\averdude\averdude.exe');
    //{$ELSE}
    //Items.Add('/usr/bin/avrdude');
    //{$ENDIF}
    Items.Add(Default_Avrdude_Path);
    Text := Embedded_IDE_Options.avrdudePath;
  end;

  with avrdudeConfigPathComboBox do begin
    //{$IFDEF MSWINDOWS}
    //Items.Add('c:\averdude\avrdude.conf');
    //{$ELSE}
    //Items.Add('avrdude.conf');
    //{$ENDIF}
    Items.Add(Default_Avrdude_Conf_Path);
    Text := Embedded_IDE_Options.avrdudeConfigPath;
  end;

  with AVR_SubArch_ComboBox do begin
    Items.CommaText := avr_SubArch_List;
    ItemIndex := 3;                    // ???????????????
    Style := csOwnerDrawFixed;
    Text := 'AVR5';
  end;

  with AVR_Typ_FPC_ComboBox do begin
    Sorted := True;
    Text := 'ATMEGA328P';
  end;

  AVR_Typ_avrdude_Edit.Text := 'ATMEGA328P';

  with ProgrammerComboBox do begin
    Items.CommaText := AVR_Programmer;
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

procedure TAVR_Project_Options_Form.ProjectOptionsToMask;
begin
  AVR_SubArch_ComboBox.Text := AVR_ProjectOptions.AVR_SubArch;
  AVR_Typ_FPC_ComboBox.Text := AVR_ProjectOptions.AVR_FPC_Typ;

  avrdudePathComboBox.Text := AVR_ProjectOptions.AvrdudeCommand.Path;
  avrdudeConfigPathComboBox.Text := AVR_ProjectOptions.AvrdudeCommand.ConfigPath;
  ProgrammerComboBox.Text := AVR_ProjectOptions.AvrdudeCommand.Programmer;
  COMPortComboBox.Text := AVR_ProjectOptions.AvrdudeCommand.COM_Port;
  COMPortBaudComboBox.Text := AVR_ProjectOptions.AvrdudeCommand.Baud;
  AVR_Typ_avrdude_Edit.Text := AVR_ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ;

  AsmFile_CheckBox.Checked := AVR_ProjectOptions.AsmFile;
  Disable_Auto_Erase_CheckBox.Checked := AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase;
end;

procedure TAVR_Project_Options_Form.MaskToProjectOptions;
begin
  AVR_ProjectOptions.AVR_SubArch := AVR_SubArch_ComboBox.Text;
  AVR_ProjectOptions.AVR_FPC_Typ := AVR_Typ_FPC_ComboBox.Text;

  AVR_ProjectOptions.AvrdudeCommand.Path := avrdudePathComboBox.Text;
  AVR_ProjectOptions.AvrdudeCommand.ConfigPath := avrdudeConfigPathComboBox.Text;
  AVR_ProjectOptions.AvrdudeCommand.Programmer := ProgrammerComboBox.Text;
  AVR_ProjectOptions.AvrdudeCommand.COM_Port := COMPortComboBox.Text;
  AVR_ProjectOptions.AvrdudeCommand.Baud := COMPortBaudComboBox.Text;
  AVR_ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ := AVR_Typ_avrdude_Edit.Text;

  AVR_ProjectOptions.AsmFile := AsmFile_CheckBox.Checked;
  AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase :=
    Disable_Auto_Erase_CheckBox.Checked;
end;

end.
