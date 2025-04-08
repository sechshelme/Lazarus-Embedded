unit Embedded_GUI_Frame_Programmer_CustomPrg;

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

  { TFrame_CustomPrg }

  TFrame_CustomPrg = class(TFrame)
    ScrollBox1: TScrollBox;
  private

  public
    ComboBox_Custom_Programmer_Path, ComboBox_Custom_Programmer_Command:
    TFileNameComboBox;
    constructor Create(TheOwner: TComponent); override;
    procedure DefaultMask;
    procedure LazProjectToMask(var prg, cmd: string);
    procedure MaskToLazProject(LazProject: TLazProject);
  end;

implementation

{$R *.lfm}

{ TFrame_CustomPrg }

constructor TFrame_CustomPrg.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  ComboBox_Custom_Programmer_Path :=
    TFileNameComboBox.Create(ScrollBox1, 'CustomPrgPath');
  with ComboBox_Custom_Programmer_Path do begin
    Caption := 'Custom Programmer:';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := ScrollBox1.Width - 10;
    Top := 10;
  end;

  ComboBox_Custom_Programmer_Command := TFileNameComboBox.Create(ScrollBox1, 'CustomCmd');
  with ComboBox_Custom_Programmer_Command do begin
    Caption := 'Command Custom Programmer';
    Anchors := [akTop, akLeft, akRight];
    Left := 5;
    Width := ScrollBox1.Width - 10;
    Top := 80;
  end;

end;

procedure TFrame_CustomPrg.DefaultMask;
begin
  if Embedded_IDE_Options.CustomProgrammer.Path.Count > 0 then begin
    ComboBox_Custom_Programmer_Path.Text := Embedded_IDE_Options.CustomProgrammer.Path[0];
  end else begin
    ComboBox_Custom_Programmer_Path.Text := '';
  end;

  if Embedded_IDE_Options.CustomProgrammer.Command.Count > 0 then begin
    ComboBox_Custom_Programmer_Command.Text := Embedded_IDE_Options.CustomProgrammer.Command[0];
  end else begin
    ComboBox_Custom_Programmer_Path.Text := '';
  end;
end;

procedure TFrame_CustomPrg.LazProjectToMask(var prg, cmd: string);
begin
  ComboBox_Custom_Programmer_Path.Text := prg;
  ComboBox_Custom_Programmer_Command.Text := cmd;
end;

procedure TFrame_CustomPrg.MaskToLazProject(LazProject: TLazProject);
begin
  LazProject.LazCompilerOptions.ExecuteAfter.Command :=
    ComboBox_Custom_Programmer_Path.Text + ' ' + ComboBox_Custom_Programmer_Command.Text;
end;

initialization

end.
