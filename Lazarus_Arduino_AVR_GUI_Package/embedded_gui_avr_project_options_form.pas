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
    ComboBox_AvrdudeConfigPath: TComboBox;
    ComboBox_AvrdudePath: TComboBox;
    ComboBox_AVR_Typ_FPC: TComboBox;
    BitBtn1: TBitBtn;
    Button_AVRDude_Path: TButton;
    Button_AVERDude_Config_Path: TButton;
    Edit_AVR_Typ_Avrdude: TEdit;
    ComboBox_AVR_SubArch: TComboBox;
    CheckBox_Disable_Auto_Erase: TCheckBox;
    ComboBox_Verbose: TComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Button_Templates: TButton;
    ComboBox_COMPortBaud: TComboBox;
    ComboBox_COMPort: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button_Ok: TButton;
    Button_Cancel: TButton;
    OpenDialog: TOpenDialog;
    ComboBox_Programmer: TComboBox;
    Button_CPU_Info: TButton;
    procedure ComboBox_AVR_SubArchChange(Sender: TObject);
    procedure Button_to_AVRDude_Typ_Click(Sender: TObject);
    procedure Button_AVRDude_PathClick(Sender: TObject);
    procedure Button_AVERDude_Config_PathClick(Sender: TObject);
    procedure Button_CPU_InfoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button_OkClick(Sender: TObject);
    procedure Button_TemplatesClick(Sender: TObject);
  private
    procedure ChangeAVR;
  public
    IsNewProject: boolean;
  end;

var
  AVR_Project_Options_Form: TAVR_Project_Options_Form;

implementation

{$R *.lfm}

{ TAVR_Project_Options_Form }


// public

procedure TAVR_Project_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'AVR Project Options';
  LoadFormPos_from_XML(Self);
  IsNewProject := False;
end;

procedure TAVR_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TAVR_Project_Options_Form.FormActivate(Sender: TObject);
begin
  with ComboBox_AVR_SubArch do begin
    Items.CommaText := avr_SubArch_List;
    //    ItemIndex := 3;                    // ???????????????
    Style := csOwnerDrawFixed;
    Text := 'AVR5';
  end;

  with ComboBox_AVR_Typ_FPC do begin
    Sorted := True;
    Text := 'ATMEGA328P';
  end;

  Edit_AVR_Typ_Avrdude.Text := 'ATMEGA328P';

  with ComboBox_Programmer do begin
    Items.AddStrings(AVR_Programmer, True);
//    Items.CommaText := AVR_Programmer;
    Text := 'arduino';
  end;

  with ComboBox_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    Text := '/dev/ttyUSB0';
  end;

  with ComboBox_COMPortBaud do begin
    Items.AddStrings(['19200', '57600', '115200'], True);
    Text := '57600';
  end;

  with ComboBox_Verbose do begin
    Items.AddStrings(AVR_Verboses, True);
    Style := csOwnerDrawFixed;
    Text := Items[1];
  end;

  CheckBox_AsmFile.Checked := False;
  CheckBox_Disable_Auto_Erase.Checked := False;

  LoadComboBox_from_XML(ComboBox_AvrdudePath);
  LoadComboBox_from_XML(ComboBox_AvrdudeConfigPath);

  if IsNewProject then begin
    if Embedded_IDE_Options.AVR.avrdudePath.Count > 0 then begin
      ComboBox_AvrdudePath.Text := Embedded_IDE_Options.AVR.avrdudePath[0];
    end else begin
      ComboBox_AvrdudePath.Text := '';
    end;

    if Embedded_IDE_Options.AVR.avrdudeConfigPath.Count > 0 then begin
      ComboBox_AvrdudeConfigPath.Text := Embedded_IDE_Options.AVR.avrdudeConfigPath[0];
    end else begin
      ComboBox_AvrdudeConfigPath.Text := '';
    end;
  end else begin
    ComboBox_AvrdudePath.Text := AVR_ProjectOptions.AvrdudeCommand.Path;
    ComboBox_AvrdudeConfigPath.Text := AVR_ProjectOptions.AvrdudeCommand.ConfigPath;

    ComboBox_AVR_SubArch.Text := AVR_ProjectOptions.AVR_SubArch;
    ComboBox_AVR_Typ_FPC.Text := AVR_ProjectOptions.AVR_FPC_Typ;

    ComboBox_Programmer.Text := AVR_ProjectOptions.AvrdudeCommand.Programmer;
    ComboBox_COMPort.Text := AVR_ProjectOptions.AvrdudeCommand.COM_Port;
    ComboBox_COMPortBaud.Text := AVR_ProjectOptions.AvrdudeCommand.Baud;
    Edit_AVR_Typ_Avrdude.Text := AVR_ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ;

    CheckBox_Disable_Auto_Erase.Checked := AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase;
    ComboBox_Verbose.Text := AVR_Verboses[AVR_ProjectOptions.AvrdudeCommand.Verbose];

    CheckBox_AsmFile.Checked := AVR_ProjectOptions.AsmFile;
  end;

  ComboBox_Insert_Text(ComboBox_AvrdudePath);
  ComboBox_Insert_Text(ComboBox_AvrdudeConfigPath);

  ChangeAVR;
end;

procedure TAVR_Project_Options_Form.Button_OkClick(Sender: TObject);
begin
  ComboBox_Insert_Text(ComboBox_AvrdudePath);
  SaveComboBox_to_XML(ComboBox_AvrdudePath);
  ComboBox_Insert_Text(ComboBox_AvrdudeConfigPath);
  SaveComboBox_to_XML(ComboBox_AvrdudeConfigPath);

  AVR_ProjectOptions.AvrdudeCommand.Path := ComboBox_AvrdudePath.Text;
  AVR_ProjectOptions.AvrdudeCommand.ConfigPath := ComboBox_AvrdudeConfigPath.Text;

  AVR_ProjectOptions.AVR_SubArch := ComboBox_AVR_SubArch.Text;
  AVR_ProjectOptions.AVR_FPC_Typ := ComboBox_AVR_Typ_FPC.Text;

  AVR_ProjectOptions.AvrdudeCommand.Programmer := ComboBox_Programmer.Text;
  AVR_ProjectOptions.AvrdudeCommand.COM_Port := ComboBox_COMPort.Text;
  AVR_ProjectOptions.AvrdudeCommand.Baud := ComboBox_COMPortBaud.Text;
  AVR_ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ := Edit_AVR_Typ_Avrdude.Text;

  AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase := CheckBox_Disable_Auto_Erase.Checked;
  AVR_ProjectOptions.AvrdudeCommand.Verbose := ComboBox_Verbose.ItemIndex;
  //  AVR_ProjectOptions.AvrdudeCommand.Verbose := ComboBox_Verbose.Items.IndexOf(ComboBox_Verbose.Text);

  AVR_ProjectOptions.AsmFile := CheckBox_AsmFile.Checked;
end;

procedure TAVR_Project_Options_Form.Button_AVRDude_PathClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_AvrdudePath.Text;
  if OpenDialog.Execute then begin
    ComboBox_AvrdudePath.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_AvrdudePath);
  end;
end;

procedure TAVR_Project_Options_Form.Button_AVERDude_Config_PathClick(Sender: TObject);
begin
  OpenDialog.FileName := ComboBox_AvrdudeConfigPath.Text;
  if OpenDialog.Execute then begin
    ComboBox_AvrdudeConfigPath.Text := OpenDialog.FileName;
    ComboBox_Insert_Text(ComboBox_AvrdudeConfigPath);
  end;
end;

procedure TAVR_Project_Options_Form.ComboBox_AVR_SubArchChange(Sender: TObject);
begin
  ChangeAVR;
end;

procedure TAVR_Project_Options_Form.Button_to_AVRDude_Typ_Click(Sender: TObject);
begin
  Edit_AVR_Typ_Avrdude.Text := ComboBox_AVR_Typ_FPC.Text;
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

    ComboBox_AVR_SubArch.Text := AVR_TemplatesPara[i].AVR_SubArch;
    ComboBox_AVR_Typ_FPC.Text := AVR_TemplatesPara[i].AVR_FPC_Typ;
    Edit_AVR_Typ_Avrdude.Text := AVR_TemplatesPara[i].AVR_AVRDude_Typ;
    ComboBox_Programmer.Text := AVR_TemplatesPara[i].Programmer;
    ComboBox_COMPort.Text := AVR_TemplatesPara[i].COM_Port;
    ComboBox_COMPortBaud.Text := AVR_TemplatesPara[i].Baud;
    CheckBox_Disable_Auto_Erase.Checked := AVR_TemplatesPara[i].Disable_Auto_Erase;
    ComboBox_Verbose.Text := AVR_Verboses[AVR_TemplatesPara[i].Verbose];
    ComboBox_AVR_SubArch.OnChange(Sender);
  end;

  TemplatesForm.Free;
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

// private

procedure TAVR_Project_Options_Form.ChangeAVR;
var
  ind: integer;
begin
  ind := ComboBox_AVR_SubArch.ItemIndex;
  if (ind < 0) or (ind >= Length(AVR_SubArch_List)) then begin
    ComboBox_AVR_Typ_FPC.Items.CommaText := '';
  end else begin
    ComboBox_AVR_Typ_FPC.Items.CommaText := AVR_List[ind];
  end;
end;

end.
