unit Embedded_GUI_AVR_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons,
  //  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports, Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_AVR_Common, Embedded_GUI_AVR_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_SubArch_List;

type

  { TAVR_Project_Options_Form }

  TAVR_Project_Options_Form = class(TForm)
    CheckBox_AsmFile: TCheckBox;
    avrdudeConfigPathComboBox: TComboBox;
    avrdudePathComboBox: TComboBox;
    AVR_Typ_FPC_ComboBox: TComboBox;
    BitBtn1: TBitBtn;
    Button_AVRDude_Path: TButton;
    Button_AVERDude_Config_Path: TButton;
    AVR_Typ_avrdude_Edit: TEdit;
    AVR_SubArch_ComboBox: TComboBox;
    CheckBox_Disable_Auto_Erase: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Memo1: TMemo;
    Button_Templates: TButton;
    COMPortBaudComboBox: TComboBox;
    COMPortComboBox: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button_Ok: TButton;
    Button_Cancel: TButton;
    OpenDialog: TOpenDialog;
    ProgrammerComboBox: TComboBox;
    Button_CPU_Info: TButton;
    procedure AVR_SubArch_ComboBoxChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button_AVRDude_PathClick(Sender: TObject);
    procedure Button_AVERDude_Config_PathClick(Sender: TObject);
    procedure Button_CPU_InfoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button_OkClick(Sender: TObject);
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_TemplatesClick(Sender: TObject);
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

procedure TAVR_Project_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'AVR Project Options';
  LoadFormPos_from_XML(Self);
end;

procedure TAVR_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);

begin
  SaveFormPos_to_XML(Self);
end;

procedure TAVR_Project_Options_Form.Button_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TAVR_Project_Options_Form.Button_CPU_InfoClick(Sender: TObject);
var
  Form: TCPU_InfoForm;
begin
  Form := TCPU_InfoForm.Create(nil);
  Form.Load(AVR_ControllerDataList);
  Form.ShowModal;
  Form.Free;
end;

procedure TAVR_Project_Options_Form.Button_TemplatesClick(Sender: TObject);
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

    AVR_SubArch_ComboBox.Text := AVR_TemplatesPara[i].AVR_SubArch;
    AVR_Typ_FPC_ComboBox.Text := AVR_TemplatesPara[i].AVR_FPC_Typ;
    AVR_Typ_avrdude_Edit.Text := AVR_TemplatesPara[i].AVR_AVRDude_Typ;
    ProgrammerComboBox.Text := AVR_TemplatesPara[i].Programmer;
    COMPortComboBox.Text := AVR_TemplatesPara[i].COM_Port;
    COMPortBaudComboBox.Text := AVR_TemplatesPara[i].Baud;
    CheckBox_Disable_Auto_Erase.Checked := AVR_TemplatesPara[i].Disable_Auto_Erase;
    AVR_SubArch_ComboBox.OnChange(Sender);
  end;

  TemplatesForm.Free;
end;

procedure TAVR_Project_Options_Form.FormActivate(Sender: TObject);
begin
  ChangeAVR;
end;

procedure TAVR_Project_Options_Form.AVR_SubArch_ComboBoxChange(Sender: TObject);
begin
  ChangeAVR;
end;

procedure TAVR_Project_Options_Form.Button_OkClick(Sender: TObject);
begin
  //  Close;
end;

procedure TAVR_Project_Options_Form.Button_AVRDude_PathClick(Sender: TObject);
begin
  OpenDialog.FileName := avrdudePathComboBox.Text;
  if OpenDialog.Execute then begin
    avrdudePathComboBox.Text := OpenDialog.FileName;
  end;
end;

procedure TAVR_Project_Options_Form.BitBtn1Click(Sender: TObject);
begin
  AVR_Typ_avrdude_Edit.Text := AVR_Typ_FPC_ComboBox.Text;
end;

procedure TAVR_Project_Options_Form.Button_AVERDude_Config_PathClick(Sender: TObject);
begin
  OpenDialog.FileName := avrdudeConfigPathComboBox.Text;
  if OpenDialog.Execute then begin
    avrdudeConfigPathComboBox.Text := OpenDialog.FileName;
  end;
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
    Items.Add(Default_Avrdude_Path);
    Text := Embedded_IDE_Options.AVR.avrdudePath;
  end;

  with avrdudeConfigPathComboBox do begin
    Items.Add(Default_Avrdude_Conf_Path);
    Text := Embedded_IDE_Options.AVR.avrdudeConfigPath;
  end;

  with AVR_SubArch_ComboBox do begin
    Items.CommaText := avr_SubArch_List;
    //    ItemIndex := 3;                    // ???????????????
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

  CheckBox_AsmFile.Checked := False;
  CheckBox_Disable_Auto_Erase.Checked := False;
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

  CheckBox_AsmFile.Checked := AVR_ProjectOptions.AsmFile;
  CheckBox_Disable_Auto_Erase.Checked := AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase;
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

  AVR_ProjectOptions.AsmFile := CheckBox_AsmFile.Checked;
  AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase := CheckBox_Disable_Auto_Erase.Checked;
end;

end.
