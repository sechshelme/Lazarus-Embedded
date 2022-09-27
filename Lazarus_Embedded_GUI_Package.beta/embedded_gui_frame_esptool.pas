unit Embedded_GUI_Frame_ESPTool;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls,
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_IDE_Options_Frame;

type

  { TFrame_ESPTool }

  TFrame_ESPTool = class(TFrame)
    ComboBox_ESPTool: TComboBox;
    ComboBox_ESPTool_COMPort: TComboBox;
    ComboBox_ESPTool_COMPortBaud: TComboBox;
    GroupBox_ESPTool: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label8: TLabel;
    ScrollBox1: TScrollBox;
  private
  public
    ComboBox_ESP_Bootloader_Path, ComboBox_ESP_Tool_Path: TFileNameComboBox;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
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
    Width := GroupBox_ESPTool.Width - 10;
    Top := 10;
  end;

  ComboBox_ESP_Bootloader_Path := TFileNameComboBox.Create(ScrollBox1, 'ESPBootloaderPath');
  with ComboBox_ESP_Bootloader_Path do begin
    Caption := 'Bootloader Path (boootloader.bin, partitions_singleapp.bin)';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_ESPTool.Width - 10;
    Top := 80;
  end;

  with  ComboBox_ESPTool do begin
    Items.AddStrings(['auto','esp32','esp8266'], True);
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



initialization



end.

