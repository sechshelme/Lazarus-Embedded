unit Embedded_GUI_Project_Options_Form;

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
  //  Embedded_GUI_Templates,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const, Types,

  Embedded_GUI_Frame_AVRDude,
  Embedded_GUI_Frame_ESPTool;

type

  { TProject_Options_Form }

  TProject_Options_Form = class(TForm)
    ButtonHelp: TButton;
    CheckBox_Bossac_Arduino_Erase: TCheckBox;
    ComboBox_ARM_FlashBase: TComboBox;
    BitBtn_Auto_Flash_Base: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    CheckBox_ASMFile: TCheckBox;
    CheckBox_Bossac_boot_Flash: TCheckBox;
    CheckBox_Bossac_Brownout_Detection: TCheckBox;
    CheckBox_Bossac_Brownout_Reset: TCheckBox;
    CheckBox_Bossac_Print_Debug: TCheckBox;
    CheckBox_Bossac_Erase_Flash: TCheckBox;
    CheckBox_Bossac_Override_USB_Port_Autodetection: TCheckBox;
    CheckBox_Bossac_Display_Device_Info: TCheckBox;
    CheckBox_Bossac_Lock_Flash_Region: TCheckBox;
    CheckBox_Bossac_Reset_CPU: TCheckBox;
    CheckBox_Bossac_Flash_Security_Flag: TCheckBox;
    CheckBox_UF2File: TCheckBox;
    CheckBox_Bossac_Unlock_Flash_Region: TCheckBox;
    CheckBox_Bossac_Verify_File: TCheckBox;
    ComboBox_Bossac_COMPort: TComboBox;
    ComboBox_SubArch: TComboBox;
    ComboBox_Arch: TComboBox;
    ComboBox_Controller: TComboBox;
    CPU_InfoButton: TButton;
    GroupBox_Compiler: TGroupBox;
    GroupBox_Programmer: TGroupBox;
    CancelButton: TButton;
    Label1: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label_FlashBase: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    RadioButton_ESP_Tool: TRadioButton;
    RadioButton_avrdude: TRadioButton;
    RadioButton_UF2: TRadioButton;
    RadioButton_Bossac: TRadioButton;
    RadioButton_st_flash: TRadioButton;
    TabSheet_ESP_Tool: TTabSheet;
    TabSheet_avrdude: TTabSheet;
    TabSheet_UF2: TTabSheet;
    TabSheet_stflash: TTabSheet;
    TabSheet_Bossac: TTabSheet;
    TemplatesButton: TButton;
    procedure BitBtn1_Auto_avrdude_ControllerClick(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure ComboBox_ArchChange(Sender: TObject);
    procedure ComboBox_ControllerChange(Sender: TObject);
    procedure ComboBox_SubArchChange(Sender: TObject);
    procedure Button_to_FlashBase_Click(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton_Programmer_Change(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    Frame_AVRDude:TFrame_AVRDude;
    Frame_ESPTool:TFrame_ESPTool;
    ComboBox_STLinkPath, ComboBox_BossacPath, ComboBox_UF2_UnitPath, ComboBox_UF2_cp_Path, ComboBox_UF2_mount_Path : TFileNameComboBox;
    FIsNewProject: Boolean;
    SubArchList: string;
    List: TStringArray;
    FProjectSource: string;
  public
    property ProjectSource: string read FProjectSource;
    property IsNewProject: Boolean write FIsNewProject;
    procedure DefaultMask;
    procedure LazProjectToMask(LazProject: TLazProject);
    procedure MaskToLazProject(LazProject: TLazProject);
  end;

var
  Project_Options_Form: TProject_Options_Form;

implementation

{$R *.lfm}

{ TProject_Options_Form }

// public

procedure TProject_Options_Form.FormCreate(Sender: TObject);
begin
  LoadFormPos_from_XML(Self);
  PageControl1.PageIndex := 0;

  // --- Compiler
  with ComboBox_Arch do begin
    Items.CommaText := 'avr,arm,xtensa';
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_SubArch do begin
    Style := csOwnerDrawFixed;
  end;

  with ComboBox_Controller do begin
    Sorted := True;
  end;

  // --- Programer

  // AVRDude
  Frame_AVRDude:=TFrame_AVRDude.Create(GroupBox_Programmer);
  Frame_AVRDude.Parent:=GroupBox_Programmer;
  Frame_AVRDude.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_AVRDude.Top:=35;
  Frame_AVRDude.Align:=alBottom;

  // ST-Link
  ComboBox_STLinkPath := TFileNameComboBox.Create(TabSheet_stflash, 'STLinkPath');
  with ComboBox_STLinkPath do begin
    Caption := 'ST-Link Path:';
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
    Caption := 'Bossac Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_Bossac.Width - 10;
    Top := 10;
  end;

  // Rasberry PI Pico
  ComboBox_UF2_UnitPath := TFileNameComboBox.Create(TabSheet_UF2, 'UnitPath');
  with ComboBox_UF2_UnitPath do begin
    Caption := 'Unit Path:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
    Top := 10;
  end;

  ComboBox_UF2_cp_Path := TFileNameComboBox.Create(TabSheet_UF2, 'cpPath');
  with ComboBox_UF2_cp_Path do begin
    Caption := 'cp Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
    Top := 80;
  end;

  ComboBox_UF2_mount_Path := TFileNameComboBox.Create(TabSheet_UF2, 'mountPath');
  with ComboBox_UF2_mount_Path do begin
    Caption := 'Mount Path:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := TabSheet_UF2.Width - 10;
    Top := 150;
  end;

  // ESP32 / ES8266
  Frame_ESPTool:=TFrame_ESPTool.Create(GroupBox_Programmer);
  Frame_ESPTool.Parent:=GroupBox_Programmer;
  Frame_ESPTool.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_ESPTool.Top:=35;
  Frame_ESPTool.Align:=alBottom;

  DefaultMask;
end;

procedure TProject_Options_Form.FormShow(Sender: TObject);
begin
  if FIsNewProject then
  Caption := Title + 'New Project'else   Caption := Title + 'Project Options';
end;

procedure TProject_Options_Form.DefaultMask;
begin
  // --- Compiler
  with ComboBox_Arch do begin
    Text := 'avr';
    ItemIndex := Items.IndexOf(Text);
  end;

  with ComboBox_SubArch do begin
    Text := 'AVR5';
    Items.CommaText := AVR_SubArch_List;
    ItemIndex := Items.IndexOf(Text);
  end;

  with ComboBox_Controller do begin
    Text := 'atmega328p';
    Frame_AVRDude.Controller := Text;;
  end;

  with ComboBox_ARM_FlashBase do begin
    Text := '0x08000000';
  end;

  CheckBox_ASMFile.Checked := False;
  CheckBox_UF2File.Checked := False;

  // --- Programer

  // AVRDude
  Frame_AVRDude.DefaultMask;

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

  with ComboBox_Bossac_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    if Items.Count > 0 then begin
      Text := Items[0];
    end;
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

  // ESP32 / ESP8266
  Frame_ESPTool.DefaultMask;


  RadioButton_Programmer_Change(nil);
end;

procedure TProject_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TProject_Options_Form.FormActivate(Sender: TObject);
begin
//  ComboBox_avrdude_COMPort.Items.CommaText := GetSerialPortNames;
end;

procedure TProject_Options_Form.Button_to_FlashBase_Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  for i := 1 to Length(ARM_ControllerDataList) - 1 do begin
    if ARM_ControllerDataList[i, 0] = ComboBox_Controller.Text then begin
      s := ARM_ControllerDataList[i, 4].ToInteger.ToHexString(8);
      ComboBox_ARM_FlashBase.Text := '0x' + s;
      Break;
    end;
  end;
end;

procedure TProject_Options_Form.ComboBox_ArchChange(Sender: TObject);
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
end;

procedure TProject_Options_Form.ComboBox_ControllerChange(Sender: TObject);
begin
  Frame_AVRDude.Controller := ComboBox_Controller.Text;;
end;

procedure TProject_Options_Form.BitBtn1_Auto_avrdude_ControllerClick(Sender: TObject);
begin
//  Edit_avrdude_Controller.Text := ComboBox_Controller.Text;
end;

procedure TProject_Options_Form.ButtonHelpClick(Sender: TObject);
begin
  ShowMessage('Für folgende Programmer muss folgende Baud eingestellt werden:' + LineEnding + LineEnding +
  'Arduino UNO: 1152000' + LineEnding +
  'Arduino Nano old: 57600' + LineEnding +
  'Arduino Nano: 1152000' + LineEnding +
  'Arduino Mega: 1152000' + LineEnding +
  'STK500v1: ???' + LineEnding +
  'usbas, usbtiny, avr109: Braucht kein Baud');
end;

procedure TProject_Options_Form.ComboBox_SubArchChange(Sender: TObject);
var
  index: integer;
begin
  index := ComboBox_SubArch.ItemIndex;
  if (index < 0) or (index >= Length(List)) then begin
    ComboBox_Controller.Items.CommaText := '';
  end else begin
    ComboBox_Controller.Items.CommaText := List[index];
  end;
end;

procedure TProject_Options_Form.LazProjectToMask(LazProject: TLazProject);
var
  cmd, ProgrammerPath, ProgrammerName, bc: string;
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

    cmd := CustomOptions;
    ComboBox_Controller.Text := FindFPCPara(cmd, '-Wp');
    ComboBox_Controller.Items.IndexOf(ComboBox_Controller.Text);
    CheckBox_AsmFile.Checked := Pos('-al', cmd) > 0;
    CheckBox_UF2File.Checked := Pos('-Xu', cmd) > 0;
  end;

  // --- Programmer Command
  cmd := LazProject.LazCompilerOptions.ExecuteAfter.Command;
  cmd := StringReplace(cmd, '"', '', [rfIgnoreCase, rfReplaceAll]);
  ProgrammerPath := Copy(cmd, 0, pos(' ', cmd) - 1);
  ProgrammerName := UpCase(ExtractFileName(ProgrammerPath));

  // AVRDude
  with Frame_AVRDude do begin
  if Pos(UpCase('avrdude'), ProgrammerName) > 0 then begin
    RadioButton_avrdude.Checked := True;
    ComboBox_AvrdudePath.Text := ProgrammerPath;
    ComboBox_AvrdudeConfigPath.Text := FindPara(cmd, ['-C']);

    ComboBox_avrdude_Programmer.Text := FindPara(cmd, ['-c']);
    with ComboBox_avrdude_COMPort do begin
      Items.CommaText := GetSerialPortNames;
      Text := FindPara(cmd, ['-P']);
    end;

    ComboBox_avrdude_COMPortBaud.Text := FindPara(cmd, ['-b']);
    Edit_avrdude_Controller.Text := FindPara(cmd, ['-p']);

    ComboBox_avrdude_Verbose.Text := ComboBox_avrdude_Verbose.Items[FindVerbose(cmd)];
    bc := FindPara(cmd, ['-B']);
    if bc = '' then begin
      ComboBox_avrrdude_BitClock.Text := '1';
    end else begin
      ComboBox_avrrdude_BitClock.Text := bc;
    end;

    CheckBox_avrdude_Disable_Auto_Erase.Checked := pos(' -D', cmd) > 0;
    CheckBox_avrdude_Chip_Erase.Checked := pos(' -e', cmd) > 0;
    CheckBox_avrdude_Override_signature_check.Checked := pos(' -F', cmd) > 0;
  end;
  end;

  // ST-Link
  if Pos(UpCase('st-flash'), ProgrammerName) > 0 then begin
    RadioButton_st_flash.Checked := True;
    ComboBox_STLinkPath.Text := ProgrammerPath;
    ComboBox_ARM_FlashBase.Text := '0x' + FindPara(cmd, ['0x']);
  end;

  // Bossac
  if Pos(UpCase('bossac'), ProgrammerName) > 0 then begin
    RadioButton_Bossac.Checked := True;
    ComboBox_BossacPath.Text := ProgrammerPath;

    with ComboBox_Bossac_COMPort do begin
      Items.CommaText := GetSerialPortNames;
      Text := FindPara(cmd, ['-p', '--port']);
      {$IFDEF UNIX}
      if Text <> '' then begin
        Text := '/dev/' + Text;
      end;
      {$ENDIF}
    end;

    CheckBox_Bossac_Erase_Flash.Checked := (Pos(' -e', cmd) > 0) or (Pos(' --erase', cmd) > 0);
    CheckBox_Bossac_Verify_File.Checked := (Pos(' -v', cmd) > 9) or (Pos(' --verify', cmd) > 0);
    CheckBox_Bossac_boot_Flash.Checked := FindBossacPara(cmd, '-b', '--boot');
    CheckBox_Bossac_Brownout_Detection.Checked := FindBossacPara(cmd, '-c', '--bod');
    CheckBox_Bossac_Brownout_Reset.Checked := FindBossacPara(cmd, '-t', '--bor');
    CheckBox_Bossac_Lock_Flash_Region.Checked := (Pos(' -l', cmd) > 9) or (Pos(' --lock', cmd) > 0); // [=REGION]
    CheckBox_Bossac_Unlock_Flash_Region.Checked := (Pos(' -u', cmd) > 9) or (Pos(' --unlock', cmd) > 0); // [=REGION]
    CheckBox_Bossac_Flash_Security_Flag.Checked := (Pos(' -s', cmd) > 9) or (Pos(' --security', cmd) > 0);
    CheckBox_Bossac_Display_Device_Info.Checked := (Pos(' -i', cmd) > 9) or (Pos(' --info', cmd) > 0);
    CheckBox_Bossac_Print_Debug.Checked := (Pos(' -d', cmd) > 9) or (Pos(' --debug', cmd) > 0);
    CheckBox_Bossac_Override_USB_Port_Autodetection.Checked := FindBossacPara(cmd, '-U', '--usb-port');
    CheckBox_Bossac_Reset_CPU.Checked := (Pos(' -R', cmd) > 9) or (Pos(' --reset', cmd) > 0);
    CheckBox_Bossac_Arduino_Erase.Checked := (Pos(' -a', cmd) > 9) or (Pos(' --arduino-erase', cmd) > 0);
  end;

  // Rasberry PI Pico
  if Pos(UpCase('.uf2 '), UpCase(cmd)) > 0 then begin
    RadioButton_UF2.Checked := True;
    //    ComboBox_UF2_UnitPath.Text := ProgrammerPath;
    ComboBox_UF2_cp_Path.Text := ProgrammerPath;
    sa := cmd.Split(' ');
    if Length(sa) >= 3 then begin
      ComboBox_UF2_mount_Path.Text := sa[2];
    end else begin
      ComboBox_UF2_mount_Path.Text := '';
    end;
  end;

  // ESP32 / ESP8266
  with Frame_ESPTool do begin
  if Pos(UpCase('esptool'), ProgrammerName) > 0 then begin
    //    if Pos(UpCase('esptool'), ProgrammerName) > 0 then begin
    RadioButton_ESP_Tool.Checked := True;
    ComboBox_ESP_Tool_Path.Text := ProgrammerPath;
    //    ComboBox_ESP_Bootloader_Path.Text := ProgrammerPath; ??????????????????

    ComboBox_ESPTool.Text := FindPara(cmd, ['-c', '--chip']);

    with ComboBox_ESPTool_COMPort do begin
      Items.CommaText := GetSerialPortNames;
      Text := FindPara(cmd, ['-p', '--port']);
    end;
    Frame_ESPTool.ComboBox_ESPTool_COMPortBaud.Text := FindPara(cmd, ['-b', '--baud']);
  end;
  end;

  RadioButton_Programmer_Change(nil);
end;

procedure TProject_Options_Form.MaskToLazProject(LazProject: TLazProject);
var
  cmd, s1, sf: string;
  i: integer;
begin
  // --- FPC_Command
  if UpCase(ComboBox_Arch.Text) = 'XTENSA' then begin
    LazProject.LazCompilerOptions.TargetOS := 'FreeRTOS';
  end else begin
    LazProject.LazCompilerOptions.TargetOS := 'Embedded';
  end;
  LazProject.LazCompilerOptions.TargetCPU := ComboBox_Arch.Text;
  LazProject.LazCompilerOptions.TargetProcessor := ComboBox_SubArch.Text;
  cmd := '-Wp' + ComboBox_Controller.Text;
  if CheckBox_AsmFile.Checked then begin
    cmd += LineEnding + '-al';
  end;
  if CheckBox_UF2File.Checked then begin
    cmd += LineEnding + '-Xu';
  end;
  LazProject.LazCompilerOptions.CustomOptions := cmd;

  // --- Programmer Command

  // AVRDude
  with Frame_AVRDude do begin
  if RadioButton_avrdude.Checked then begin
    cmd := ComboBox_AvrdudePath.Text + ' ';

    s1 := ComboBox_AvrdudeConfigPath.Text;
    if s1 <> '' then begin
      cmd += '-C' + s1 + ' ';
    end;

    for i := 0 to ComboBox_avrdude_Verbose.ItemIndex - 1 do begin
      cmd += '-v ';
    end;

    cmd += '-p' + Edit_avrdude_Controller.Text + ' ' + '-c' + ComboBox_avrdude_Programmer.Text + ' ';

    if ComboBox_avrdude_COMPort.Text <> '' then begin
      cmd += '-P' + ComboBox_avrdude_COMPort.Text + ' ';
    end;

    if ComboBox_avrdude_COMPortBaud.Text <> '' then begin
      cmd += '-b' + ComboBox_avrdude_COMPortBaud.Text + ' ';
    end;

    s1 := ComboBox_avrrdude_BitClock.Text;
    if s1 <> '1' then begin
      cmd += '-B' + s1 + ' ';
    end;

    if CheckBox_avrdude_Disable_Auto_Erase.Checked then begin
      cmd += '-D ';
    end;

    if CheckBox_avrdude_Chip_Erase.Checked then begin
      cmd += '-e ';
    end;

    if CheckBox_avrdude_Override_signature_check.Checked then begin
      cmd += '-F ';
    end;

    LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd + '-Uflash:w:' + LazProject.LazCompilerOptions.TargetFilename + '.hex:i';
  end;
  end;

  // ST-Link
  if RadioButton_st_flash.Checked then begin
    cmd := ComboBox_STLinkPath.Text + ' write ' + LazProject.LazCompilerOptions.TargetFilename + '.bin ' + ComboBox_ARM_FlashBase.Text;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;
  end;

  // Bossac
  if RadioButton_Bossac.Checked then begin
    // /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/bossac/BOSSA-1.7.0/bin/bossac -e -w -v -b  /n4800/DATEN/Programmierung/Lazarus/Tutorials/Embedded/ARM/Arduino_DUE/von_MIR/Project1.bin -R
    //    cmd := ComboBox_BossacPath.Text + sf + ' -w -e -v -b ' + LazProject.LazCompilerOptions.TargetFilename + '.bin -R';
    // /bin/bossac -e -b -cmd -R -v -w Project1.bin

    cmd := ComboBox_BossacPath.Text;

    if ComboBox_Bossac_COMPort.Text <> '' then begin
      cmd := cmd + ' --port=' + ExtractFileName(ComboBox_Bossac_COMPort.Text);
    end;
    if CheckBox_Bossac_Erase_Flash.Checked then begin
      cmd := cmd + ' -e';
    end;
    if CheckBox_Bossac_Verify_File.Checked then begin
      cmd := cmd + ' -v';
    end;
    if CheckBox_Bossac_boot_Flash.Checked then begin
      cmd := cmd + ' -b';
    end;
    if CheckBox_Bossac_Brownout_Detection.Checked then begin
      cmd := cmd + ' -c';
    end;
    if CheckBox_Bossac_Brownout_Reset.Checked then begin
      cmd := cmd + ' -t';
    end;
    if CheckBox_Bossac_Lock_Flash_Region.Checked then begin
      cmd := cmd + ' -l';
    end;
    if CheckBox_Bossac_Unlock_Flash_Region.Checked then begin
      cmd := cmd + ' -u';
    end;
    if CheckBox_Bossac_Flash_Security_Flag.Checked then begin
      cmd := cmd + ' -s';
    end;
    if CheckBox_Bossac_Display_Device_Info.Checked then begin
      cmd := cmd + ' -i';
    end;
    if CheckBox_Bossac_Print_Debug.Checked then begin
      cmd := cmd + ' -d';
    end;
    if CheckBox_Bossac_Override_USB_Port_Autodetection.Checked then begin
      cmd := cmd + ' -U';
    end;
    if CheckBox_Bossac_Reset_CPU.Checked then begin
      cmd := cmd + ' -R';
    end;
    if CheckBox_Bossac_Arduino_Erase.Checked then begin
      cmd := cmd + ' -a';
    end;

    cmd := cmd + ' -w ' + LazProject.LazCompilerOptions.TargetFilename + '.bin';

    LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;
  end;

  // Rasberry PI Pico
  if RadioButton_UF2.Checked then begin
    sf := LazProject.LazCompilerOptions.TargetFilename + '.uf2';
    cmd := ComboBox_UF2_cp_Path.Text + ' ' + sf + ' ' + ComboBox_UF2_mount_Path.Text + DirectorySeparator + sf;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;

    LazProject.LazCompilerOptions.OtherUnitFiles := ComboBox_UF2_UnitPath.Text;// Was passiert bei mehreren Pfaden ???????
  end;

  // ESP32 / ESP8266
  //  https://github.com/espressif/esptool/blob/master/esptool/__init__.py
  if RadioButton_ESP_Tool.Checked then begin
    with Frame_ESPTool do begin
    //    cmd := ComboBox_ESP_Tool_Path.Text + ' -c' + Edit_ESPTool_Chip.Text + ' -p ' + ComboBox_ESPTool_COMPort.Text + ' -b' + ComboBox_ESPTool_COMPortBaud.Text + ' --before default_reset --after hard_reset write_flash 0x0 ' +
    //      ComboBox_ESP_Bootloader_Path.Text + '/bootloader.bin 0x10000 ' + LazProject.LazCompilerOptions.TargetFilename + '.bin 0x8000 ' + ComboBox_ESP_Bootloader_Path.Text + '/partitions_singleapp.bin';
      cmd := ComboBox_ESP_Tool_Path.Text + ' -c' + ComboBox_ESPTool.Text + ' -p ' + ComboBox_ESPTool_COMPort.Text + ' -b' + ComboBox_ESPTool_COMPortBaud.Text + ' --before default_reset --after hard_reset write_flash 0x0 ' + ComboBox_ESP_Bootloader_Path.Text +
        '/bootloader.bin 0x8000 ' + ComboBox_ESP_Bootloader_Path.Text + '/partitions_singleapp.bin 0x10000 ' + LazProject.LazCompilerOptions.TargetFilename + '.bin';
      LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;
    end;
  end;

end;

procedure TProject_Options_Form.TemplatesButtonClick(Sender: TObject);
var
  TemplatesForm: TProjectTemplatesForm;
  index: integer;

begin
  TemplatesForm := TProjectTemplatesForm.Create(nil);
  TemplatesForm.IsNewProject := FIsNewProject;

  if TemplatesForm.ShowModal = mrOk then begin
    index := TemplatesForm.ListBox_Board.ItemIndex;
    if index >= 0 then begin

      // --- FPC_Command
      ComboBox_Arch.Text := TemplatesPara[index].Arch;
      ComboBox_Arch.ItemIndex := ComboBox_Arch.Items.IndexOf(ComboBox_Arch.Text);
      ComboBox_ArchChange(nil);
      ComboBox_SubArch.Text := TemplatesPara[index].SubArch;
      ComboBox_SubArch.ItemIndex := ComboBox_SubArch.Items.IndexOf(ComboBox_SubArch.Text);
      ComboBox_SubArchChange(nil);
      ComboBox_Controller.Text := TemplatesPara[index].Controller;

      // --- Programmer Command
      RadioButton_avrdude.Checked := TemplatesPara[index].Programmer = 'avrdude';
      RadioButton_st_flash.Checked := TemplatesPara[index].Programmer = 'st-flash';
      RadioButton_UF2.Checked := TemplatesPara[index].Programmer = 'uf2';
      RadioButton_Bossac.Checked := TemplatesPara[index].Programmer = 'bossac';
      RadioButton_ESP_Tool.Checked := TemplatesPara[index].Programmer = 'ESPTool';

      // AVRDude
      with Frame_AVRDude do begin
      Edit_avrdude_Controller.Text := TemplatesPara[index].avrdude.Controller;
      ComboBox_avrdude_Programmer.Text := TemplatesPara[index].avrdude.Programmer;
      ComboBox_avrdude_COMPort.Text := TemplatesPara[index].avrdude.COM_Port;
      ComboBox_avrdude_COMPortBaud.Text := TemplatesPara[index].avrdude.Baud;
      CheckBox_avrdude_Disable_Auto_Erase.Checked := TemplatesPara[index].avrdude.Disable_Auto_Erase;
      CheckBox_avrdude_Chip_Erase.Checked := TemplatesPara[index].avrdude.Chip_Erase;
      CheckBox_avrdude_Override_signature_check.Checked := TemplatesPara[index].avrdude.Override_Signature_Check;
      end;

      // ST-Link
      ComboBox_ARM_FlashBase.Text := TemplatesPara[index].stlink.FlashBase;

      // Bossac
      ComboBox_Bossac_COMPort.Text := TemplatesPara[index].Bossac.COM_Port;

      CheckBox_Bossac_Erase_Flash.Checked := TemplatesPara[index].Bossac.Erase_Flash;
      CheckBox_Bossac_Verify_File.Checked := TemplatesPara[index].Bossac.Verify_File;
      CheckBox_Bossac_boot_Flash.Checked := TemplatesPara[index].Bossac.Boot_from_Flash;
      CheckBox_Bossac_Brownout_Detection.Checked := TemplatesPara[index].Bossac.Brownout_Detection;
      CheckBox_Bossac_Brownout_Reset.Checked := TemplatesPara[index].Bossac.Brownout_Reset;
      CheckBox_Bossac_Lock_Flash_Region.Checked := TemplatesPara[index].Bossac.Lock_Flash_Region;
      CheckBox_Bossac_Unlock_Flash_Region.Checked := TemplatesPara[index].Bossac.Unlock_Flash_Region;
      CheckBox_Bossac_Flash_Security_Flag.Checked := TemplatesPara[index].Bossac.Flash_Security_Flag;
      CheckBox_Bossac_Display_Device_Info.Checked := TemplatesPara[index].Bossac.Display_Device_Info;
      CheckBox_Bossac_Print_Debug.Checked := TemplatesPara[index].Bossac.Print_Debug;
      CheckBox_Bossac_Override_USB_Port_Autodetection.Checked := TemplatesPara[index].Bossac.Override_USB_Port_Autodetection;
      CheckBox_Bossac_Reset_CPU.Checked := TemplatesPara[index].Bossac.Reset_CPU;
      CheckBox_Bossac_Arduino_Erase.Checked := TemplatesPara[index].Bossac.Arduino_Erase;

      // Rasberry PI Pico
      CheckBox_UF2File.Checked := TemplatesPara[index].Programmer = 'uf2';
      FProjectSource := TemplatesForm.getSource;

      // ESP32 / ESP8266
      with Frame_ESPTool do begin
        ComboBox_ESPTool.Text := TemplatesPara[index].ESPTool.Controller;
        ComboBox_ESPTool_COMPort.Text := TemplatesPara[index].ESPTool.COM_Port;
        ComboBox_ESPTool_COMPortBaud.Text := TemplatesPara[index].ESPTool.Baud;
      end;
    end;
  end;
  TemplatesForm.Free;
end;

procedure TProject_Options_Form.RadioButton_Programmer_Change(Sender: TObject);
var
  i, n: integer;
begin
  n := 0;
  for i := 0 to GroupBox_Programmer.ControlCount - 1 do begin
    if (GroupBox_Programmer.Controls[i] is TRadioButton) then begin
      if TRadioButton(GroupBox_Programmer.Controls[i]).Checked then begin
        PageControl1.PageIndex := n;
      end;
      Inc(n);
    end;
  end;

  Frame_AVRDude.Visible := RadioButton_avrdude.Checked;
  Frame_ESPTool.Enabled := RadioButton_ESP_Tool.Checked;


  TabSheet_avrdude.Enabled := RadioButton_avrdude.Checked;
  TabSheet_stflash.Enabled := RadioButton_st_flash.Checked;
  TabSheet_Bossac.Enabled := RadioButton_Bossac.Checked;
  TabSheet_UF2.Enabled := RadioButton_UF2.Checked;
  TabSheet_ESP_Tool.Enabled := RadioButton_ESP_Tool.Checked;
end;

procedure TProject_Options_Form.CPU_InfoButtonClick(Sender: TObject);
var
  CPU_InfoForm: TCPU_InfoForm;
  s: String;
begin
  CPU_InfoForm := TCPU_InfoForm.Create(nil);
  s := ComboBox_Arch.Text;
  CPU_InfoForm.ComboBox_Controller.ItemIndex := CPU_InfoForm.ComboBox_Controller.Items.IndexOf(s);
  CPU_InfoForm.ComboBox_Controller.Text := s;
  CPU_InfoForm.ComboBox_ControllerSelect(Sender);
  CPU_InfoForm.ShowModal;
  CPU_InfoForm.Free;
end;

end.