unit AVR_Project_Options;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs,
  LazIDEIntf, ProjectIntf, CompOptsIntf, IDEOptionsIntf, IDEOptEditorIntf, IDEExternToolIntf,

  Laz2_XMLCfg, // Für direkte *.lpi Zugriff

  AVR_IDE_Options;

const
  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';

type

  { TProjectOptions }

  TProjectOptions = class
    CompilerSettings,

    SerialMonitorPort,
    SerialMonitorBaud: string;
    procedure Save(AProject: TLazProject);

    function SaveAfter(const APathToLPI, ACommand: string): boolean;
  end;

var
  ProjectOptions: TProjectOptions;


type

  { TAVR_Project_Options_Frame }

  TAVR_Project_Options_Frame = class(TAbstractIDEOptionsEditor)
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    SerialMonitorPort_ComboBox: TComboBox;
    SerialMonitorBaud_ComboBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    avrdude_ComboBox1: TComboBox;
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

{ TProjectOptions }

procedure TProjectOptions.Save(AProject: TLazProject);
begin
  AProject.CustomData[Key_SerialMonitorPort] := ProjectOptions.SerialMonitorPort;
  AProject.CustomData[Key_SerialMonitorBaud] := ProjectOptions.SerialMonitorBaud;

  AProject.LazCompilerOptions.CustomOptions := ProjectOptions.CompilerSettings;
end;

// Nur Test ???????????
function TProjectOptions.SaveAfter(const APathToLPI, ACommand: string): boolean;
var
  XML: TXMLConfig;
begin
  ShowMessage('pfad: ' + APathToLPI);

  Result := False;
  if not FileExists(APathToLPI) then begin
    ShowMessage('nicht gefunden');
  end;
  Exit;
  XML := TXMLConfig.Create(APathToLPI);
  try
    try
      XML.SetValue('CompilerOptions/Other/ExecuteAfter/Command/Value', ACommand);
      XML.Flush;
      Result := True;
    except
    end;
  finally
    XML.Free;
  end;
end;

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
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  ProjectOptions.SerialMonitorPort := LazProject.CustomData[Key_SerialMonitorPort];
  ProjectOptions.SerialMonitorBaud := LazProject.CustomData[Key_SerialMonitorBaud];
  ProjectOptions.CompilerSettings := LazProject.LazCompilerOptions.CustomOptions;

  SerialMonitorPort_ComboBox.Text := ProjectOptions.SerialMonitorPort;
  SerialMonitorBaud_ComboBox.Text := ProjectOptions.SerialMonitorBaud;
  Memo1.Text := ProjectOptions.CompilerSettings;

  //  avrdude_ComboBox1.Text:=LazProject.;

  Label3.Caption := AVR_Options.avrdudePfad;
end;

procedure TAVR_Project_Options_Frame.WriteSettings(AOptions: TAbstractIDEOptions);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  ProjectOptions.SerialMonitorPort := SerialMonitorPort_ComboBox.Text;
  ProjectOptions.SerialMonitorBaud := SerialMonitorBaud_ComboBox.Text;
  ProjectOptions.CompilerSettings := Memo1.Text;

  ProjectOptions.Save(LazProject);
end;

class function TAVR_Project_Options_Frame.SupportedOptionsClass: TAbstractIDEOptionsClass;
begin
  Result := TAbstractIDEProjectOptions;
end;

end.
