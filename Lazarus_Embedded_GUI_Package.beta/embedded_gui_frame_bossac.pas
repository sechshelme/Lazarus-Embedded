unit Embedded_GUI_Frame_Bossac;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls, Buttons,
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_IDE_Options_Frame;

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
    GroupBox_Bossac: TGroupBox;
    Label13: TLabel;
    ScrollBox1: TScrollBox;
  private

  public
    ComboBox_BossacPath: TFileNameComboBox;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
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
    Width := GroupBox_Bossac.Width - 10;
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

initialization

end.

