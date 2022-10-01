unit Embedded_GUI_Frame_Programmer_ESPTool;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Project_Templates_Form,
  Embedded_GUI_Frame_IDE_Options;

type

  { TFrame_ESPTool }

  TFrame_ESPTool = class(TFrame)
    ComboBox_ESPTool: TComboBox;
    ComboBox_ESPTool_COMPort: TComboBox;
    ComboBox_ESPTool_COMPortBaud: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    ScrollBox1: TScrollBox;
  private
  public
    ComboBox_ESP_Bootloader_Path, ComboBox_ESP_Tool_Path: TFileNameComboBox;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
    procedure LazProjectToMask(var prg, cmd: string);
    procedure MaskToLazProject(LazProject: TLazProject);
    procedure TemplateToMask(index: Integer);
  end;

implementation

{$R *.lfm}

{ TFrame_ESPTool }

constructor TFrame_ESPTool.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  ComboBox_ESP_Tool_Path := TFileNameComboBox.Create(ScrollBox1, 'ESPToolPath');
  with ComboBox_ESP_Tool_Path do begin
    Caption := 'ESP Tools Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := ScrollBox1.Width - 10;
    Top := 10;
  end;

  ComboBox_ESP_Bootloader_Path :=
    TFileNameComboBox.Create(ScrollBox1, 'ESPBootloaderPath');
  with ComboBox_ESP_Bootloader_Path do begin
    Caption := 'Bootloader Path (boootloader.bin, partitions_singleapp.bin)';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := ScrollBox1.Width - 10;
    Top := 80;
  end;

  with ComboBox_ESPTool do begin
    Items.AddStrings(['auto', 'esp32', 'esp8266'], True);
  end;

  with ComboBox_ESPTool_COMPortBaud do begin
    Items.AddStrings(['115200'], True);
  end;

end;

procedure TFrame_ESPTool.DefaultMask;
begin
  if Embedded_IDE_Options.ESP.Tools_Path.Count > 0 then begin
    ComboBox_ESP_Tool_Path.Text := Embedded_IDE_Options.ESP.Tools_Path[0];
  end else begin
    ComboBox_ESP_Tool_Path.Text := '';
  end;

  if Embedded_IDE_Options.ESP.Bootloader_Path.Count > 0 then begin
    ComboBox_ESP_Bootloader_Path.Text := Embedded_IDE_Options.ESP.Bootloader_Path[0];
  end else begin
    ComboBox_ESP_Bootloader_Path.Text := '';
  end;

  ComboBox_ESPTool.Text := 'esp8266';

  with ComboBox_ESPTool_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    if Items.Count > 0 then begin
      Text := Items[0];
    end;
  end;

  with ComboBox_ESPTool_COMPortBaud do begin
    Text := '115200';
  end;
end;

procedure TFrame_ESPTool.LazProjectToMask(var prg, cmd: string);
begin
  ComboBox_ESP_Tool_Path.Text := prg;
  //    ComboBox_ESP_Bootloader_Path.Text := ProgrammerPath; ??????????????????

  ComboBox_ESPTool.Text := FindPara(cmd, ['-c', '--chip']);

  with ComboBox_ESPTool_COMPort do begin
    Items.CommaText := GetSerialPortNames;
    Text := FindPara(cmd, ['-p', '--port']);
  end;
  ComboBox_ESPTool_COMPortBaud.Text := FindPara(cmd, ['-b', '--baud']);
end;

procedure TFrame_ESPTool.MaskToLazProject(LazProject: TLazProject);
var
  cmd: string;
begin
  //  https://github.com/espressif/esptool/blob/master/esptool/__init__.py

  //    cmd := ComboBox_ESP_Tool_Path.Text + ' -c' + Edit_ESPTool_Chip.Text + ' -p ' + ComboBox_ESPTool_COMPort.Text + ' -b' + ComboBox_ESPTool_COMPortBaud.Text + ' --before default_reset --after hard_reset write_flash 0x0 ' +
  //      ComboBox_ESP_Bootloader_Path.Text + '/bootloader.bin 0x10000 ' + LazProject.LazCompilerOptions.TargetFilename + '.bin 0x8000 ' + ComboBox_ESP_Bootloader_Path.Text + '/partitions_singleapp.bin';
  cmd := ComboBox_ESP_Tool_Path.Text + ' -c' + ComboBox_ESPTool.Text +
    ' -p ' + ComboBox_ESPTool_COMPort.Text + ' -b' + ComboBox_ESPTool_COMPortBaud.Text +
    ' --before default_reset --after hard_reset write_flash 0x0 ' +
    ComboBox_ESP_Bootloader_Path.Text + '/bootloader.bin 0x8000 ' +
    ComboBox_ESP_Bootloader_Path.Text + '/partitions_singleapp.bin 0x10000 ' +
    LazProject.LazCompilerOptions.TargetFilename + '.bin';
  LazProject.LazCompilerOptions.ExecuteAfter.Command := cmd;
end;

procedure TFrame_ESPTool.TemplateToMask(index: Integer);
begin
  ComboBox_ESPTool.Text := TemplatesPara[index].ESPTool.Controller;
  ComboBox_ESPTool_COMPort.Text := TemplatesPara[index].ESPTool.COM_Port;
  ComboBox_ESPTool_COMPortBaud.Text := TemplatesPara[index].ESPTool.Baud;
end;

initialization

end.
