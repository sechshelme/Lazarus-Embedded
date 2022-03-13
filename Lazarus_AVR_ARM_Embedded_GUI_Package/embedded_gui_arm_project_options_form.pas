unit Embedded_GUI_ARM_Project_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons, ComCtrls,
  //  LazConfigStorage, BaseIDEIntf,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  IDEExternToolIntf,
  //  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  Embedded_GUI_Common,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_ARM_Common,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const;

type

  { TARM_Project_Options_Form }

  TARM_Project_Options_Form = class(TForm)
    ComboBox_ARM_FlashBase: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn_Auto_Flash_Base: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    CheckBox_ASMFile: TCheckBox;
    CheckBox_boot: TCheckBox;
    CheckBox_Brownout_Detection: TCheckBox;
    CheckBox_Brownout_Reset: TCheckBox;
    CheckBox_Chip_Erase: TCheckBox;
    CheckBox_Debug: TCheckBox;
    CheckBox_Disable_Auto_Erase: TCheckBox;
    CheckBox_Erase: TCheckBox;
    CheckBox_force_USB_Port: TCheckBox;
    CheckBox_Info: TCheckBox;
    CheckBox_Lock: TCheckBox;
    CheckBox_Reset: TCheckBox;
    CheckBox_Security: TCheckBox;
    CheckBox_UF2File: TCheckBox;
    CheckBox_UnLock: TCheckBox;
    CheckBox_Verify: TCheckBox;
    ComboBox_BitClock: TComboBox;
    ComboBox_COMPort: TComboBox;
    ComboBox_COMPortBaud: TComboBox;
    ComboBox_Programmer: TComboBox;
    ComboBox_SubArch: TComboBox;
    ComboBox_Arch: TComboBox;
    ComboBox_Typ_FPC: TComboBox;
    ComboBox_Verbose: TComboBox;
    CPU_InfoButton: TButton;
    Edit_AVR_Typ_Avrdude: TEdit;
    GroupBox_Compiler: TGroupBox;
    GroupBox_Programmer: TGroupBox;
    CancelButton: TButton;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label_FlashBase: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    RadioButton_avrdude: TRadioButton;
    RadioButton_UF2: TRadioButton;
    RadioButton_Bossac: TRadioButton;
    RadioButton_st_flash: TRadioButton;
    TabSheet_avrdude: TTabSheet;
    TabSheet_UF2: TTabSheet;
    TabSheet_stflash: TTabSheet;
    TabSheet_Bossac: TTabSheet;
    TemplatesButton: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox_ArchChange(Sender: TObject);
    procedure ComboBox_SubArchChange(Sender: TObject);
    procedure Button_to_FlashBase_Click(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton_Programmer_Change(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    ComboBox_AvrdudePath, ComboBox_AvrdudeConfigPath, ComboBox_STLinkPath, ComboBox_BossacPath, ComboBox_UF2_UnitPath, ComboBox_UF2_cp_Path, ComboBox_UF2_mount_Path: TFileNameComboBox;
    SubArchList: string;
    List: TStringArray;
    //    procedure ChangeARM_Typ;
  public
    procedure DefaultMask;
    procedure LazProjectToMask(LazProject: TLazProject);
    procedure MaskToLazProject(LazProject: TLazProject);
  end;

var
  ARM_Project_Options_Form: TARM_Project_Options_Form;

implementation

{$R *.lfm}

{ TARM_Project_Options_Form }

// public

procedure TARM_Project_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'ARM Project Options';
  LoadFormPos_from_XML(Self);
  PageControl1.PageIndex := 0;

  // --- Compiler
  with ComboBox_Arch do begin
    Items.CommaText := 'avr,arm,xtensa';
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_SubArch do begin
    Items.CommaText := ARM_SubArch_List;
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Typ_FPC do begin
    Sorted := True;
  end;

  // --- Programer

  // AVRDude
  ComboBox_AvrdudePath := TFileNameComboBox.Create(TabSheet_avrdude, 'AVRDudePath');
  with ComboBox_AvrdudePath do begin
    Caption := 'AVRdude Pfad';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_avrdude.Width - 10;
    Top := 10;
  end;

  ComboBox_AvrdudeConfigPath := TFileNameComboBox.Create(TabSheet_avrdude, 'AVRDudeConfig');
  with ComboBox_AvrdudeConfigPath do begin
    Caption := 'AVRdude Config-Pfad ( Leer = default Konfig. )';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_avrdude.Width - 10;
    Top := 80;
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

  // ST-Link
  ComboBox_STLinkPath := TFileNameComboBox.Create(TabSheet_stflash, 'STLinkPath');
  with ComboBox_STLinkPath do begin
    Caption := 'ST-Link Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_stflash.Width - 10;
    Top := 10;
  end;

  with ComboBox_ARM_FlashBase do begin
    Sorted := True;
    Items.AddStrings(['0x00000000', '0x00080000', '0x08000000']);
  end;

  // Bossac ( Arduino Due )
  ComboBox_BossacPath := TFileNameComboBox.Create(TabSheet_Bossac, 'BossacPath');
  with ComboBox_BossacPath do begin
    Caption := 'Bossac Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_Bossac.Width - 10;
    Top := 10;
  end;

  // Rasberry PI Pico
  ComboBox_UF2_UnitPath := TFileNameComboBox.Create(TabSheet_UF2, 'UnitPath');
  with ComboBox_UF2_UnitPath do begin
    Caption := 'Unit Pfad:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
    //    Width := Self.Width - 10;
    Top := 10;
  end;

  ComboBox_UF2_cp_Path := TFileNameComboBox.Create(TabSheet_UF2, 'cpPath');
  with ComboBox_UF2_cp_Path do begin
    Caption := 'cp Pfad:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
    //    Width := Self.Width - 10;
    Top := 80;
  end;

  ComboBox_UF2_mount_Path := TFileNameComboBox.Create(TabSheet_UF2, 'mountPath');
  with ComboBox_UF2_mount_Path do begin
    Caption := 'Mount Pfad:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
    //    Width := Self.Width - 10;
    Top := 150;
  end;

end;

procedure TARM_Project_Options_Form.DefaultMask;
begin
  // --- Compiler
  with ComboBox_Arch do begin
    Text := 'arm';
    ItemIndex := Items.IndexOf(Text);
  end;

  with ComboBox_SubArch do begin
    Text := 'ARMV7M';
    ItemIndex := Items.IndexOf(Text);
  end;

  ComboBox_ArchChange(nil);

  with ComboBox_Typ_FPC do begin
    Text := 'STM32F103X8';
  end;

  with ComboBox_ARM_FlashBase do begin
    Text := '0x08000000';
  end;

  CheckBox_ASMFile.Checked := False;
  CheckBox_UF2File.Checked := False;

  // --- Programer

  // AVRDude
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
    Text := Items[0];  // Default = 1
  end;

  with ComboBox_COMPortBaud do begin
    Text := '57600';
  end;

  with ComboBox_Verbose do begin
    Text := Items[1];  // Default = einfache Genauigkeit
  end;

  CheckBox_Disable_Auto_Erase.Checked := False;
  CheckBox_Chip_Erase.Checked := False;

  // ST-Link
  if Embedded_IDE_Options.ARM.STFlashPath.Count > 0 then begin
    ComboBox_STLinkPath.Text := Embedded_IDE_Options.ARM.STFlashPath[0];
  end else begin
    ComboBox_STLinkPath.Text := '';
  end;

  // Bossac
  if Embedded_IDE_Options.ARM.BossacPath.Count > 0 then begin
    ComboBox_BossacPath.Text := Embedded_IDE_Options.ARM.BossacPath[0];
  end else begin
    ComboBox_BossacPath.Text := '';
  end;

  // Rasberry PI Pico
  if Embedded_IDE_Options.ARM.Raspi_Pico.Unit_Path.Count > 0 then begin
    ComboBox_UF2_UnitPath.Text := Embedded_IDE_Options.ARM.Raspi_Pico.Unit_Path[0];
  end else begin
    ComboBox_UF2_UnitPath.Text := '';
  end;

  if Embedded_IDE_Options.ARM.Raspi_Pico.cp_Path.Count > 0 then begin
    ComboBox_UF2_cp_Path.Text := Embedded_IDE_Options.ARM.Raspi_Pico.cp_Path[0];
  end else begin
    ComboBox_UF2_cp_Path.Text := '';
  end;

  if Embedded_IDE_Options.ARM.Raspi_Pico.mount_Path.Count > 0 then begin
    ComboBox_UF2_mount_Path.Text := Embedded_IDE_Options.ARM.Raspi_Pico.mount_Path[0];
  end else begin
    ComboBox_UF2_mount_Path.Text := '';
  end;

  RadioButton_Programmer_Change(nil);
end;

procedure TARM_Project_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TARM_Project_Options_Form.FormActivate(Sender: TObject);
begin
  ComboBox_COMPort.Items.CommaText := GetSerialPortNames;
end;

procedure TARM_Project_Options_Form.Button_to_FlashBase_Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 1 to Length(ARM_ControllerDataList) - 1 do begin
    if ARM_ControllerDataList[i, 0] = ComboBox_Typ_FPC.Text then begin
      s := ARM_ControllerDataList[i, 4].ToInteger.ToHexString(8);
      ComboBox_ARM_FlashBase.Text := '0x' + s;
      Break;
    end;
  end;
end;

procedure TARM_Project_Options_Form.ComboBox_ArchChange(Sender: TObject);
begin
  if ComboBox_Arch.Text = 'avr' then begin
    SubArchList := AVR_SubArch_List;
    List := avr_List;
  end;
  if ComboBox_Arch.Text = 'arm' then begin
    SubArchList := ARM_SubArch_List;
    List := arm_List;
  end;
  if ComboBox_Arch.Text = 'xtensa' then begin
    SubArchList := xtensa_SubArch_List;
    List := xtensa_List;
  end;
  ComboBox_SubArch.Items.CommaText := SubArchList;

  ComboBox_SubArchChange(Sender);
  //  ChangeARM_Typ;
end;

procedure TARM_Project_Options_Form.BitBtn1Click(Sender: TObject);
begin
  Edit_AVR_Typ_Avrdude.Text := ComboBox_Typ_FPC.Text;
end;

procedure TARM_Project_Options_Form.ComboBox_SubArchChange(Sender: TObject);
var
  index: integer;
begin
  index := ComboBox_SubArch.ItemIndex;
  if (index < 0) or (index >= Length(List)) then begin
    ComboBox_Typ_FPC.Items.CommaText := '';
  end else begin
    ComboBox_Typ_FPC.Items.CommaText := List[index];
  end;
end;

procedure TARM_Project_Options_Form.LazProjectToMask(LazProject: TLazProject);
var
  s, path, p, bc: string;
  sa: TStringArray;
begin
  // --- FPC Command
  with LazProject.LazCompilerOptions do begin
    ComboBox_Arch.Text := TargetCPU;
    ComboBox_Arch.ItemIndex := ComboBox_Arch.Items.IndexOf(ComboBox_Arch.Text);
    ComboBox_ArchChange(nil);
    ComboBox_SubArch.Text := TargetProcessor;
    ComboBox_SubArch.ItemIndex := ComboBox_SubArch.Items.IndexOf(ComboBox_SubArch.Text);
    ComboBox_SubArchChange(nil);

    s := CustomOptions;
    ComboBox_Typ_FPC.Text := FindPara(s, '-Wp');
    ComboBox_Typ_FPC.Items.IndexOf(ComboBox_Typ_FPC.Text);
    CheckBox_AsmFile.Checked := Pos('-al', s) > 0;
    CheckBox_UF2File.Checked := Pos('-Xu', s) > 0;
  end;

  // --- Programmer Command
  s := LazProject.LazCompilerOptions.ExecuteAfter.Command;
  path := Copy(s, 0, pos(' ', s) - 1);
  p := UpCase(ExtractFileName(path));

  // AVRDude
  if Pos(UpCase('avrdude'), p) > 0 then begin
    ComboBox_AvrdudePath.Text := path;
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
  end;

  // ST-Link
  if Pos(UpCase('st-flash'), p) > 0 then begin
    RadioButton_st_flash.Checked := True;
    ComboBox_STLinkPath.Text := path;
    ComboBox_ARM_FlashBase.Text := '0x' + FindPara(s, '0x');
  end;

  // Bossac
  if Pos(UpCase('bossac'), p) > 0 then begin
    RadioButton_Bossac.Checked := True;
    ComboBox_BossacPath.Text := path;
  end;

  // Rasberry PI Pico
  if Pos(UpCase('.uf2 '), s) > 0 then begin
    RadioButton_UF2.Checked := True;
    //    ComboBox_UF2_UnitPath.Text := path;
    ComboBox_UF2_cp_Path.Text := path;
    sa := s.Split(' ');
    if Length(sa) >= 3 then begin
      ComboBox_UF2_mount_Path.Text := sa[2];
    end else begin
      ComboBox_UF2_mount_Path.Text := '';
    end;
  end;

  RadioButton_Programmer_Change(nil);
end;

procedure TARM_Project_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  s, s1, sf: string;
  i: Integer;
begin
  // --- FPC_Command
  LazProject.LazCompilerOptions.TargetCPU := ComboBox_Arch.Text;
  LazProject.LazCompilerOptions.TargetProcessor := ComboBox_SubArch.Text;
  s := '-Wp' + ComboBox_Typ_FPC.Text;
  if CheckBox_AsmFile.Checked then begin
    s += LineEnding + '-al';
  end;
  if CheckBox_UF2File.Checked then begin
    s += LineEnding + '-Xu';
  end;
  LazProject.LazCompilerOptions.CustomOptions := s;

  // --- Programmer Command

  // AVRDude
  if RadioButton_avrdude.Checked then begin
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

  // ST-Link
  if RadioButton_st_flash.Checked then begin
    s := ComboBox_STLinkPath.Text + ' write ' + LazProject.LazCompilerOptions.TargetFilename + '.bin ' + ComboBox_ARM_FlashBase.Text;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;
  end;

  // Bossac
  if RadioButton_Bossac.Checked then begin
    // /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/bossac/BOSSA-1.7.0/bin/bossac -e -w -v -b  /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Arduino_DUE/von_MIR/Project1.bin -R
    s := ComboBox_BossacPath.Text + ' -e -w -v -b  ' + LazProject.LazCompilerOptions.TargetFilename + '.bin -R';
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;
  end;

  // Rasberry PI Pico
  if RadioButton_UF2.Checked then begin
    sf := LazProject.LazCompilerOptions.TargetFilename + '.uf2';
    s := ComboBox_UF2_cp_Path.Text + ' ' + sf + ' ' + ComboBox_UF2_mount_Path.Text + DirectorySeparator + sf;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := s;

    LazProject.LazCompilerOptions.OtherUnitFiles := ComboBox_UF2_UnitPath.Text;// Was passiert bei mehreren Pfaden ???????
  end;
end;

procedure TARM_Project_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TProjectTemplatesForm;
  index: integer;

begin
  TemplatesForm := TProjectTemplatesForm.Create(nil);
  TemplatesForm.Caption := Title + 'Vorlagen';

  for index := 0 to Length(TemplatesPara) - 1 do begin
    TemplatesForm.ListBox_Template.Items.AddStrings(TemplatesPara[index].Name);
  end;
  TemplatesForm.ListBox_Template.Caption := TemplatesPara[0].Name;
  TemplatesForm.ListBox_Template.ItemIndex := 0;

  if TemplatesForm.ShowModal = mrOk then begin
    index := TemplatesForm.ListBox_Template.ItemIndex;

    // --- FPC_Command

    ComboBox_Arch.Text := TemplatesPara[index].Arch;
    ComboBox_Arch.ItemIndex := ComboBox_Arch.Items.IndexOf(ComboBox_Arch.Text);
    ComboBox_ArchChange(nil);
    ComboBox_SubArch.Text := TemplatesPara[index].SubArch;
    ComboBox_SubArch.ItemIndex := ComboBox_SubArch.Items.IndexOf(ComboBox_SubArch.Text);
    ComboBox_SubArchChange(nil);
    ComboBox_Typ_FPC.Text := TemplatesPara[index].Controller;

    // --- Programmer Command

    RadioButton_avrdude.Checked := TemplatesPara[index].Programmer = 'avrdude';
    RadioButton_st_flash.Checked := TemplatesPara[index].Programmer = 'st-flash';
    RadioButton_UF2.Checked := TemplatesPara[index].Programmer = 'uf2';
    RadioButton_Bossac.Checked := TemplatesPara[index].Programmer = 'bossac';

    // AVRDude
    Edit_AVR_Typ_Avrdude.Text := TemplatesPara[index].avrdude.Controller;
    ComboBox_Programmer.Text := TemplatesPara[index].avrdude.Programmer;
    ComboBox_COMPort.Text := TemplatesPara[index].avrdude.COM_Port;
    ComboBox_COMPortBaud.Text := TemplatesPara[index].avrdude.Baud;
    CheckBox_Disable_Auto_Erase.Checked := TemplatesPara[index].avrdude.Disable_Auto_Erase;
    CheckBox_Chip_Erase.Checked := TemplatesPara[index].avrdude.Chip_Erase;
//    ComboBox_AVR_SubArch.OnChange(Sender);

    // ST-Link
    ComboBox_ARM_FlashBase.Text := TemplatesPara[index].stlink.FlashBase;

    // Rasberry PI Pico
    CheckBox_UF2File.Checked := TemplatesPara[index].Programmer = 'uf2';
  end;

  TemplatesForm.Free;
end;

procedure TARM_Project_Options_Form.RadioButton_Programmer_Change(Sender: TObject);
begin
  TabSheet_avrdude.Enabled := RadioButton_avrdude.Checked;
  TabSheet_stflash.Enabled := RadioButton_st_flash.Checked;
  TabSheet_Bossac.Enabled := RadioButton_Bossac.Checked;
  TabSheet_UF2.Enabled := RadioButton_UF2.Checked;
end;

procedure TARM_Project_Options_Form.CPU_InfoButtonClick(Sender: TObject);
var
  Form: TCPU_InfoForm;
begin
  Form := TCPU_InfoForm.Create(nil);
  Form.Load(ARM_ControllerDataList);
  Form.ShowModal;
  Form.Free;
end;

end.
