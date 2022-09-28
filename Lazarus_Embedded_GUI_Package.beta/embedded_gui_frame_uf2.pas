unit Embedded_GUI_Frame_UF2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls, Buttons,
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_IDE_Options_Frame;

type

  { TFrame_UF2 }

  TFrame_UF2 = class(TFrame)
    GroupBox_UF2: TGroupBox;
    ScrollBox1: TScrollBox;
  private

  public
    ComboBox_UF2_UnitPath, ComboBox_UF2_cp_Path, ComboBox_UF2_mount_Path : TFileNameComboBox;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
  end;

implementation

{$R *.lfm}

{ TFrame_UF2 }

constructor TFrame_UF2.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ComboBox_UF2_UnitPath := TFileNameComboBox.Create(ScrollBox1, 'UnitPath');
  with ComboBox_UF2_UnitPath do begin
    Caption := 'Unit Path:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_UF2.Width - 10;
    Top := 10;
  end;

  ComboBox_UF2_cp_Path := TFileNameComboBox.Create(ScrollBox1, 'cpPath');
  with ComboBox_UF2_cp_Path do begin
    Caption := 'cp Path:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_UF2.Width - 10;
    Top := 80;
  end;

  ComboBox_UF2_mount_Path := TFileNameComboBox.Create(ScrollBox1, 'mountPath');
  with ComboBox_UF2_mount_Path do begin
    Caption := 'Mount Path:';
    Directory := True;
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := GroupBox_UF2.Width - 10;
    Top := 150;
  end;
end;

procedure TFrame_UF2.DefaultMask;
begin
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
end;

initialization

end.

