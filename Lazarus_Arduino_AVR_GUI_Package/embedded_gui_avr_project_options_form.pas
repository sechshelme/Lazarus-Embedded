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
  Embedded_GUI_Find_Comports,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_AVR_Common,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_AVR_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_SubArch_List;

type

  { TAVR_Project_Options_Form }

  TAVR_Project_Options_Form = class(TForm)
    CheckBox_AsmFile: TCheckBox;
    CheckBox_Chip_Erase: TCheckBox;
    ComboBox_AVR_Typ_FPC: TComboBox;
    BitBtn1: TBitBtn;
    ComboBox_BitClock: TComboBox;
    Edit_AVR_Typ_Avrdude: TEdit;
    ComboBox_AVR_SubArch: TComboBox;
    CheckBox_Disable_Auto_Erase: TCheckBox;
    ComboBox_Verbose: TComboBox;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Button_Templates: TButton;
    ComboBox_COMPortBaud: TComboBox;
    ComboBox_COMPort: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Button_Ok: TButton;
    Button_Cancel: TButton;
    ComboBox_Programmer: TComboBox;
    Button_CPU_Info: TButton;
    procedure ComboBox_AVR_SubArchChange(Sender: TObject);
    procedure Button_to_AVRDude_Typ_Click(Sender: TObject);
    procedure Button_CPU_InfoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button_OkClick(Sender: TObject);
    procedure Button_TemplatesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ComboBox_AvrdudePath, ComboBox_AvrdudeConfigPath: TFileNameComboBox;
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

  ComboBox_AvrdudePath := TFileNameComboBox.Create(Self, 'AVRDudePath');
  with ComboBox_AvrdudePath do begin
    Caption := 'AVRdude Pfad';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 216 - 24;
  end;

  ComboBox_AvrdudeConfigPath := TFileNameComboBox.Create(Self, 'AVRDudeConfig');
  with ComboBox_AvrdudeConfigPath do begin
    Caption := 'AVRdude Config-Pfad ( Leer = default Konfig. )';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 279 - 24;
  end;

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

  CheckBox_AsmFile.Checked := False;

  Edit_AVR_Typ_Avrdude.Text := 'ATMEGA328P';

  with ComboBox_Programmer do begin
    Items.AddStrings(['arduino', 'usbasp', 'stk500v1', 'wiring', 'avr109'], True);
    Text := 'arduino';
  end;

  with ComboBox_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    Text := '/dev/ttyUSB0';
  end;

  with ComboBox_BitClock do begin
    Style := csOwnerDrawFixed;
    Items.AddStrings(['1', '2', '4', '8', '16', '32', '64', '128', '256', '512', '1024'], True);
    Text := Items[0];
  end;

  with ComboBox_COMPortBaud do begin
    Items.AddStrings(['19200', '57600', '115200'], True);
    Text := '57600';
  end;

  with ComboBox_Verbose do begin
    Style := csOwnerDrawFixed;
    Items.AddStrings(['0 kein', '1 einfach', '2 mittel', '3 genau', '4 sehr genau', '5 Ultra genau'], True);
    Text := Items[1];
  end;

  CheckBox_Disable_Auto_Erase.Checked := False;
  CheckBox_Chip_Erase.Checked := False;

  //  LoadComboBox_from_XML(ComboBox_AvrdudePath);
  //  LoadComboBox_from_XML(ComboBox_AvrdudeConfigPath);

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
    ComboBox_AVR_SubArch.Text := AVR_ProjectOptions.AVR_SubArch;
    ComboBox_AVR_Typ_FPC.Text := AVR_ProjectOptions.AVR_FPC_Typ;

    CheckBox_AsmFile.Checked := AVR_ProjectOptions.AsmFile;

    ComboBox_AvrdudePath.Text := AVR_ProjectOptions.AvrdudeCommand.Path;
    ComboBox_AvrdudeConfigPath.Text := AVR_ProjectOptions.AvrdudeCommand.ConfigPath;

    ComboBox_Programmer.Text := AVR_ProjectOptions.AvrdudeCommand.Programmer;
    ComboBox_COMPort.Text := AVR_ProjectOptions.AvrdudeCommand.COM_Port;
    ComboBox_COMPortBaud.Text := AVR_ProjectOptions.AvrdudeCommand.Baud;
    Edit_AVR_Typ_Avrdude.Text := AVR_ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ;

    ComboBox_Verbose.Text := ComboBox_Verbose.Items[AVR_ProjectOptions.AvrdudeCommand.Verbose];
    if AVR_ProjectOptions.AvrdudeCommand.BitClock = '' then begin
      ComboBox_BitClock.Text := '1';
    end else begin
      ComboBox_BitClock.Text := AVR_ProjectOptions.AvrdudeCommand.BitClock;
    end;

    CheckBox_Disable_Auto_Erase.Checked := AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase;
    CheckBox_Chip_Erase.Checked := AVR_ProjectOptions.AvrdudeCommand.Chip_Erase;
  end;

  //  ComboBox_Insert_Text(ComboBox_AvrdudePath);
  //  ComboBox_Insert_Text(ComboBox_AvrdudeConfigPath);

  ChangeAVR;
end;

procedure TAVR_Project_Options_Form.Button_OkClick(Sender: TObject);
begin
  AVR_ProjectOptions.AsmFile := CheckBox_AsmFile.Checked;

  AVR_ProjectOptions.AVR_SubArch := ComboBox_AVR_SubArch.Text;
  AVR_ProjectOptions.AVR_FPC_Typ := ComboBox_AVR_Typ_FPC.Text;

  //  ComboBox_Insert_Text(ComboBox_AvrdudePath);
  //  SaveComboBox_to_XML(ComboBox_AvrdudePath);
  //  ComboBox_Insert_Text(ComboBox_AvrdudeConfigPath);
  //  SaveComboBox_to_XML(ComboBox_AvrdudeConfigPath);


  AVR_ProjectOptions.AvrdudeCommand.Path := ComboBox_AvrdudePath.Text;
  AVR_ProjectOptions.AvrdudeCommand.ConfigPath := ComboBox_AvrdudeConfigPath.Text;

  AVR_ProjectOptions.AvrdudeCommand.Programmer := ComboBox_Programmer.Text;
  AVR_ProjectOptions.AvrdudeCommand.COM_Port := ComboBox_COMPort.Text;
  AVR_ProjectOptions.AvrdudeCommand.Baud := ComboBox_COMPortBaud.Text;
  AVR_ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ := Edit_AVR_Typ_Avrdude.Text;

  AVR_ProjectOptions.AvrdudeCommand.Verbose := ComboBox_Verbose.ItemIndex;
  AVR_ProjectOptions.AvrdudeCommand.BitClock := ComboBox_BitClock.Text;

  AVR_ProjectOptions.AvrdudeCommand.Disable_Auto_Erase := CheckBox_Disable_Auto_Erase.Checked;
  AVR_ProjectOptions.AvrdudeCommand.Chip_Erase := CheckBox_Chip_Erase.Checked;
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
  index: integer;
begin
  TemplatesForm := TAVRProjectTemplatesForm.Create(nil);

  for index := 0 to Length(AVR_TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(AVR_TemplatesPara[index].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := AVR_TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    index := TemplatesForm.ListBox_Template.ItemIndex;

    ComboBox_AVR_SubArch.Text := AVR_TemplatesPara[index].AVR_SubArch;
    ComboBox_AVR_Typ_FPC.Text := AVR_TemplatesPara[index].AVR_FPC_Typ;
    Edit_AVR_Typ_Avrdude.Text := AVR_TemplatesPara[index].AVR_AVRDude_Typ;
    ComboBox_Programmer.Text := AVR_TemplatesPara[index].Programmer;
    ComboBox_COMPort.Text := AVR_TemplatesPara[index].COM_Port;
    ComboBox_COMPortBaud.Text := AVR_TemplatesPara[index].Baud;
    CheckBox_Disable_Auto_Erase.Checked := AVR_TemplatesPara[index].Disable_Auto_Erase;
    CheckBox_Chip_Erase.Checked := AVR_TemplatesPara[index].Chip_Erase;
    ComboBox_Verbose.Text := ComboBox_Verbose.Items[AVR_TemplatesPara[index].Verbose];
    ComboBox_BitClock.Text := AVR_TemplatesPara[index].BitClock;
    ComboBox_AVR_SubArch.OnChange(Sender);
  end;

  TemplatesForm.Free;
end;

procedure TAVR_Project_Options_Form.FormDestroy(Sender: TObject);
begin
  ComboBox_AvrdudePath.Free;
  ComboBox_AvrdudeConfigPath.Free;
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
