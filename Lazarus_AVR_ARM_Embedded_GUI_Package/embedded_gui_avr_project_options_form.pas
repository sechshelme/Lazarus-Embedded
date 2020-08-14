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
  Embedded_GUI_Embedded_List_Const;

type

  { TAVR_Project_Options_Form }

  TAVR_Project_Options_Form = class(TForm)
    Button1: TButton;
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
    Button_Cancel: TButton;
    ComboBox_Programmer: TComboBox;
    Button_CPU_Info: TButton;
    procedure ComboBox_AVR_SubArchChange(Sender: TObject);
    procedure Button_to_AVRDude_Typ_Click(Sender: TObject);
    procedure Button_CPU_InfoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button_TemplatesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ComboBox_AvrdudePath, ComboBox_AvrdudeConfigPath: TFileNameComboBox;
    procedure ChangeAVR_Typ;
  public
    procedure DefaultMask;
    procedure LazProjectToMask(LazProject: TLazProject);
    procedure MaskToLazProject(LazProject: TLazProject);
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

  // FPC_Command
  with ComboBox_AVR_SubArch do begin
    Items.CommaText := avr_SubArch_List;
    //    ItemIndex := 3;                    // ???????????????
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_AVR_Typ_FPC do begin
    Sorted := True;
  end;

  CheckBox_AsmFile.Checked := False;

  // AVRDude_Command
  ComboBox_AvrdudePath := TFileNameComboBox.Create(Self, 'AVRDudePath');
  with ComboBox_AvrdudePath do begin
    Caption := 'AVRdude Pfad';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 216 - 75;
  end;

  ComboBox_AvrdudeConfigPath := TFileNameComboBox.Create(Self, 'AVRDudeConfig');
  with ComboBox_AvrdudeConfigPath do begin
    Caption := 'AVRdude Config-Pfad ( Leer = default Konfig. )';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := Self.Width - 10;
    Top := 279 - 75;
  end;

  Edit_AVR_Typ_Avrdude.Text := 'ATMEGA328P';

  with ComboBox_Programmer do begin
    Items.AddStrings(['arduino', 'usbasp', 'stk500v1', 'wiring', 'avr109', 'jtag2updi'], True);
  end;

  with ComboBox_BitClock do begin
    Style := csOwnerDrawFixed;
    Items.AddStrings(['1', '2', '4', '8', '16', '32', '64', '128', '256', '512', '1024'], True);
  end;

  with ComboBox_COMPortBaud do begin
    Items.AddStrings(['19200', '57600', '115200'], True);
  end;

  with ComboBox_Verbose do begin
    Style := csOwnerDrawFixed;
    Items.AddStrings(['0 kein', '1 einfach', '2 mittel', '3 genau', '4 sehr genau', '5 Ultra genau'], True);
  end;

  ChangeAVR_Typ;
end;

procedure TAVR_Project_Options_Form.DefaultMask;
begin
  // FPC_Command
  with ComboBox_AVR_SubArch do begin
    Text := 'AVR5';
  end;

  with ComboBox_AVR_Typ_FPC do begin
    Text := 'ATMEGA328P';
  end;

  CheckBox_AsmFile.Checked := False;

  // AVRDude_Command
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

  Edit_AVR_Typ_Avrdude.Text := 'ATMEGA328P';

  with ComboBox_Programmer do begin
    Text := 'arduino';
  end;

  with ComboBox_COMPort do begin
    Items.CommaText := GetSerialPortNames;
  end;

  with ComboBox_BitClock do begin
    Text := Items[0];
  end;

  with ComboBox_COMPortBaud do begin
    Text := '57600';
  end;

  with ComboBox_Verbose do begin
    Text := Items[1];
  end;

  CheckBox_Disable_Auto_Erase.Checked := False;
  CheckBox_Chip_Erase.Checked := False;
end;

procedure TAVR_Project_Options_Form.FormActivate(Sender: TObject);
begin
  ComboBox_COMPort.Items.CommaText := GetSerialPortNames;
end;

procedure TAVR_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TAVR_Project_Options_Form.ComboBox_AVR_SubArchChange(Sender: TObject);
begin
  ChangeAVR_Typ;
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

procedure TAVR_Project_Options_Form.ChangeAVR_Typ;
var
  index: integer;
begin
  index := ComboBox_AVR_SubArch.ItemIndex;
  if (index < 0) or (index >= Length(AVR_SubArch_List)) then begin
    ComboBox_AVR_Typ_FPC.Items.Text := '';
  end else begin
    ComboBox_AVR_Typ_FPC.Items.CommaText := AVR_List[index];
  end;
end;

procedure TAVR_Project_Options_Form.LazProjectToMask(LazProject: TLazProject);
var
  s, bc: string;
begin

  // FPC_Command
  with LazProject.LazCompilerOptions do begin
    ComboBox_AVR_SubArch.Text := TargetProcessor;
    s := CustomOptions;
    ComboBox_AVR_Typ_FPC.Text := FindPara(s, '-Wp');
    CheckBox_AsmFile.Checked := Pos('-al', s) > 0;
  end;

  // AVRDude_Command
  s := LazProject.LazCompilerOptions.ExecuteAfter.Command;

  ComboBox_AvrdudePath.Text := Copy(s, 0, pos(' ', s) - 1);
  ComboBox_AvrdudeConfigPath.Text := FindPara(s, '-C');

  ComboBox_Programmer.Text := FindPara(s, '-c');
  with ComboBox_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    Text := FindPara(s, '-P');
  end;

  ComboBox_COMPortBaud.Text := FindPara(s, '-b');
  Edit_AVR_Typ_Avrdude.Text := FindPara(s, '-p');

  ComboBox_Verbose.Text := ComboBox_Verbose.Items[FindVerbose(s)];
  bc := FindPara(s, '-B');
  if bc = '' then begin
    ComboBox_BitClock.Text := '1';
  end else begin
    ComboBox_BitClock.Text := bc;
  end;

  CheckBox_Disable_Auto_Erase.Checked := pos('-D', s) > 0;
  CheckBox_Chip_Erase.Checked := pos('-e', s) > 0;

  ChangeAVR_Typ;
end;

procedure TAVR_Project_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  s, s1: string;
  i: integer;
begin

  // FPC_Command
  LazProject.LazCompilerOptions.TargetProcessor := ComboBox_AVR_SubArch.Text;
  s := '-Wp' + ComboBox_AVR_Typ_FPC.Text;
  if CheckBox_AsmFile.Checked then begin
    s += LineEnding + '-al';
  end;
  LazProject.LazCompilerOptions.CustomOptions := s;

  // AVRDude_Command
  s := ComboBox_AvrdudePath.Text + ' ';

  s1 := ComboBox_AvrdudeConfigPath.Text;
  if s1 <> '' then begin
    s += '-C' + s1 + ' ';
  end;

  for i := 0 to ComboBox_Verbose.ItemIndex - 1 do begin
    s += '-v ';
  end;

//  s1 := ComboBox_Programmer.Text;
  s += '-p' + Edit_AVR_Typ_Avrdude.Text + ' ' + '-c' + ComboBox_Programmer.Text + ' ';
  //  s1 := upCase(s1);
  //  if (s1 = 'ARDUINO') or (s1 = 'STK500V1') or (s1 = 'WIRING') or (s1 = 'AVR109') or (s1 = 'JTAG2UPDI') then begin
  //    s += '-P' + ComboBox_COMPort.Text + ' ' + '-b' + ComboBox_COMPortBaud.Text + ' ';
  //  end;

  if ComboBox_COMPort.Text <> '' then begin
    s += '-P' + ComboBox_COMPort.Text + ' ';
  end;

  if ComboBox_COMPortBaud.Text <> '' then begin
    s += '-b' + ComboBox_COMPortBaud.Text + ' ';
  end;

  s1 := ComboBox_BitClock.Text;
  if s1 <> '1' then begin
    s += '-B' + s1 + ' ';
  end;

  if CheckBox_Disable_Auto_Erase.Checked then begin
    s += '-D ';
  end;

  if CheckBox_Chip_Erase.Checked then begin
    s += '-e ';
  end;

  LazProject.LazCompilerOptions.ExecuteAfter.Command := s + '-Uflash:w:' + LazProject.LazCompilerOptions.TargetFilename + '.hex:i';
end;

end.
