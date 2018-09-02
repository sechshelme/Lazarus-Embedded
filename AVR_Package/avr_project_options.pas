unit AVR_Project_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf,
  AVR_IDE_Options;


type

  { TAVR_Project_Options_Frame }

  TAVR_Project_Options_Frame = class(TAbstractIDEOptionsEditor)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
  private

  public
    function GetTitle: string; override;
    procedure Setup({%H-}ADialog: TAbstractOptionsEditorDialog); override;
    procedure ReadSettings(AOptions: TAbstractIDEOptions); override;
    procedure WriteSettings(AOptions: TAbstractIDEOptions); override;
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  end;

implementation

{$R *.lfm}

{ TAVR_Project_Options_Frame }

function TAVR_Project_Options_Frame.GetTitle: string;
begin
  Result := 'AVR_Project Optionen';
end;

procedure TAVR_Project_Options_Frame.Setup(ADialog: TAbstractOptionsEditorDialog);
begin
  // Do nothing

end;

procedure TAVR_Project_Options_Frame.ReadSettings(AOptions: TAbstractIDEOptions);
var
  Prj: TLazProject;
begin
  PRJ := LazarusIDE.ActiveProject;
  Edit1.Text := prj.CustomData['Edit1'];
  Edit2.Text := prj.CustomData['Edit2'];
  Label1.Caption:=AVR_Options.avrdudePfad;
end;

procedure TAVR_Project_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  Prj: TLazProject;
begin
  PRJ := LazarusIDE.ActiveProject;
  prj.CustomData['Edit1'] := Edit1.Text;
  prj.CustomData['Edit2'] := Edit2.Text;
end;

class function TAVR_Project_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TAbstractIDEProjectOptions;
end;

end.

