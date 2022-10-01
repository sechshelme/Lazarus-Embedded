unit Embedded_GUI_Frame_Programmer_Bossac;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls, Buttons,

  ProjectIntf,

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_Frame_IDE_Options;

type

  { TFrame_Bossac }

  TFrame_Bossac = class(TFrame)
    CheckBox_Bossac_Arduino_Erase: TCheckBox;
    CheckBox_Bossac_boot_Flash: TCheckBox;
    CheckBox_Bossac_Brownout_Detection: TCheckBox;
    CheckBox_Bossac_Brownout_Reset: TCheckBox;
    CheckBox_Bossac_Display_Device_Info: TCheckBox;
    CheckBox_Bossac_Erase_Flash: TCheckBox;
    CheckBox_Bossac_Flash_Security_Flag: TCheckBox;
    CheckBox_Bossac_Lock_Flash_Region: TCheckBox;
    CheckBox_Bossac_Override_USB_Port_Autodetection: TCheckBox;
    CheckBox_Bossac_Print_Debug: TCheckBox;
    CheckBox_Bossac_Reset_CPU: TCheckBox;
    CheckBox_Bossac_Unlock_Flash_Region: TCheckBox;
    CheckBox_Bossac_Verify_File: TCheckBox;
    ComboBox_Bossac_COMPort: TComboBox;
    Label13: TLabel;
    ScrollBox1: TScrollBox;
  private

  public
    ComboBox_BossacPath: TFileNameComboBox;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
    procedure LazProjectToMask(var prg, cmd: string);
    procedure MaskToLazProject(LazProject: TLazProject);
    procedure TemplateToMask(index: Integer);
  end;

implementation

{$R *.lfm}


{ TFrame_Bossac }

constructor TFrame_Bossac.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ComboBox_BossacPath := TFileNameComboBox.Create(ScrollBox1, 'BossacPath');
  with ComboBox_BossacPath do begin
    Caption := 'Bossac Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := ScrollBox1.Width - 10;
    Top := 10;
  end;
end;

procedure TFrame_Bossac.DefaultMask;
begin
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
end;

procedure TFrame_Bossac.LazProjectToMask(var prg, cmd: string);
begin
  ComboBox_BossacPath.Text := prg;

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

procedure TFrame_Bossac.MaskToLazProject(LazProject: TLazProject);
var
  cmd: String;
begin
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

  LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd + ' -w ' + LazProject.LazCompilerOptions.TargetFilename + '.bin';
end;

procedure TFrame_Bossac.TemplateToMask(index: Integer);
begin
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

initialization

end.

