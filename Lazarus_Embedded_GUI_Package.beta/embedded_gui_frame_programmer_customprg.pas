unit Embedded_GUI_Frame_Programmer_CustomPrg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, StdCtrls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Common_FileComboBox,
  Embedded_GUI_Frame_IDE_Options;

type

  { TFrameCustomPrg }

  TFrameCustomPrg = class(TFrame)
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

{ TFrameCustomPrg }

constructor TFrameCustomPrg.Create(TheOwner: TComponent);
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

procedure TFrameCustomPrg.DefaultMask;
begin

end;

procedure TFrameCustomPrg.LazProjectToMask(var prg, cmd: string);
begin

end;

procedure TFrameCustomPrg.MaskToLazProject(LazProject: TLazProject);
begin

end;

initialization

end.
