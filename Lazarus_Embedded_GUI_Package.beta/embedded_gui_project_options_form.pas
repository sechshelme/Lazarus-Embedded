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
  Embedded_GUI_Frame_IDE_Options,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const, Types,

  Embedded_GUI_Frame_Programmer_AVRDude,
  Embedded_GUI_Frame_Programmer_STFlash,
  Embedded_GUI_Frame_Programmer_Bossac,
  Embedded_GUI_Frame_Programmer_UF2,
  Embedded_GUI_Frame_Programmer_ESPTool;

type

  { TProject_Options_Form }

  TProject_Options_Form = class(TForm)
    ButtonHelp: TButton;
    Button1: TButton;
    CheckBox_ASMFile: TCheckBox;
    CheckBox_UF2File: TCheckBox;
    ComboBox_SubArch: TComboBox;
    ComboBox_Arch: TComboBox;
    ComboBox_Controller: TComboBox;
    CPU_InfoButton: TButton;
    GroupBox_Compiler: TGroupBox;
    GroupBox_Programmer: TGroupBox;
    CancelButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Radio_None: TRadioButton;
    RadioButton_ESP_Tool: TRadioButton;
    RadioButton_AVRDude: TRadioButton;
    RadioButton_UF2: TRadioButton;
    RadioButton_Bossac: TRadioButton;
    RadioButton_ST_Flash: TRadioButton;
    TemplatesButton: TButton;
    procedure BitBtn1_Auto_avrdude_ControllerClick(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure ComboBox_ArchChange(Sender: TObject);
    procedure ComboBox_ControllerChange(Sender: TObject);
    procedure ComboBox_SubArchChange(Sender: TObject);
    procedure CPU_InfoButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton_Programmer_Change(Sender: TObject);
    procedure TemplatesButtonClick(Sender: TObject);
  private
    Frame_AVRDude:TFrame_AVRDude;
    Frame_STFlash:TFrame_STFlash;
    Frame_Bossac:TFrame_Bossac;
    Frame_UF2:TFrame_UF2;
    Frame_ESPTool:TFrame_ESPTool;
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
const FrameTop=40;
begin
  LoadFormPos_from_XML(Self);

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

  // --- Programmer

  // AVRDude
  Frame_AVRDude:=TFrame_AVRDude.Create(GroupBox_Programmer);
  Frame_AVRDude.Parent:=GroupBox_Programmer;
  Frame_AVRDude.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_AVRDude.Top:=FrameTop;
  Frame_AVRDude.Align:=alBottom;

  // ST-Link
  Frame_STFlash:=TFrame_STFlash.Create(GroupBox_Programmer);
  Frame_STFlash.Parent:=GroupBox_Programmer;
  Frame_STFlash.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_STFlash.Top:=FrameTop;
  Frame_STFlash.Align:=alBottom;

  // Bossac ( Arduino Due )
  Frame_Bossac:=TFrame_Bossac.Create(GroupBox_Programmer);
  Frame_Bossac.Parent:=GroupBox_Programmer;
  Frame_Bossac.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_Bossac.Top:=FrameTop;
  Frame_Bossac.Align:=alBottom;

  // Rasberry PI Pico
  Frame_UF2:=TFrame_UF2.Create(GroupBox_Programmer);
  Frame_UF2.Parent:=GroupBox_Programmer;
  Frame_UF2.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_UF2.Top:=FrameTop;
  Frame_UF2.Align:=alBottom;

  // ESP32 / ES8266
  Frame_ESPTool:=TFrame_ESPTool.Create(GroupBox_Programmer);
  Frame_ESPTool.Parent:=GroupBox_Programmer;
  Frame_ESPTool.Anchors:=[akBottom,akLeft,akRight,akTop];
  Frame_ESPTool.Top:=FrameTop;
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

  CheckBox_ASMFile.Checked := False;
  CheckBox_UF2File.Checked := False;

  // --- Programer

  // AVRDude
  Frame_AVRDude.DefaultMask;

  // ST-Link
  Frame_STFlash.DefaultMask;

  // Bossac
  Frame_Bossac.DefaultMask;

  // Rasberry PI Pico
  Frame_UF2.DefaultMask;

  // ESP32 / ESP8266
  Frame_ESPTool.DefaultMask;


  RadioButton_Programmer_Change(nil);
end;

procedure TProject_Options_Form.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPos_to_XML(Self);
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
  Frame_STFlash.Controller := ComboBox_Controller.Text;;
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
    RadioButton_AVRDude.Checked := True;
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
  with Frame_STFlash do begin
  if Pos(UpCase('st-flash'), ProgrammerName) > 0 then begin
    RadioButton_ST_Flash.Checked := True;
    ComboBox_STLinkPath.Text := ProgrammerPath;
    ComboBox_ARM_FlashBase.Text := '0x' + FindPara(cmd, ['0x']);
  end;
  end;

  // Bossac
  with Frame_Bossac do begin
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
  end;

  // Rasberry PI Pico
  with Frame_UF2 do begin
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
  if RadioButton_AVRDude.Checked then begin
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
  with Frame_STFlash do begin
  if RadioButton_ST_Flash.Checked then begin
    cmd := ComboBox_STLinkPath.Text + ' write ' + LazProject.LazCompilerOptions.TargetFilename + '.bin ' + ComboBox_ARM_FlashBase.Text;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;
  end;
  end;

  // Bossac
  with Frame_Bossac do begin
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
  end;

  // Rasberry PI Pico
  with Frame_UF2 do begin
  if RadioButton_UF2.Checked then begin
    sf := LazProject.LazCompilerOptions.TargetFilename + '.uf2';
    cmd := ComboBox_UF2_cp_Path.Text + ' ' + sf + ' ' + ComboBox_UF2_mount_Path.Text + DirectorySeparator + sf;
    LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;

    LazProject.LazCompilerOptions.OtherUnitFiles := ComboBox_UF2_UnitPath.Text;// Was passiert bei mehreren Pfaden ???????
  end;
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
      RadioButton_AVRDude.Checked := TemplatesPara[index].Programmer = 'avrdude';
      RadioButton_ST_Flash.Checked := TemplatesPara[index].Programmer = 'st-flash';
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
      with Frame_STFlash do begin
      ComboBox_ARM_FlashBase.Text := TemplatesPara[index].stlink.FlashBase;
      end;

      // Bossac
      with Frame_Bossac do begin
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
      end;

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
begin
  Frame_AVRDude.Visible := RadioButton_AVRDude.Checked;
  Frame_STFlash.Visible := RadioButton_ST_Flash.Checked;
  Frame_Bossac.Visible := RadioButton_Bossac.Checked;
  Frame_UF2.Visible := RadioButton_UF2.Checked;
  Frame_ESPTool.Visible := RadioButton_ESP_Tool.Checked;
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
