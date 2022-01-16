unit Embedded_GUI_Xtensa_Register;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  // LCL
  Forms, Controls, StdCtrls, Dialogs, ExtCtrls,
  // LazUtils
  LazLoggerBase,
  // IdeIntf
  ProjectIntf, CompOptsIntf, LazIDEIntf, IDEOptionsIntf, IDEOptEditorIntf, MenuIntf,

  // Embedded ( Eigene Units )
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_Common,
  Embedded_GUI_Xtensa_Common,
  Embedded_GUI_Xtensa_Project_Options_Form;

type

  { TProjectARMApp }

  TProjectXtensaApp = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
    function DoInitDescriptor: TModalResult; override;
  end;

procedure ShowXtensaOptionsDialog(Sender: TObject);

implementation

procedure ShowXtensaOptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'xtensa') or (LazProject.LazCompilerOptions.TargetOS <> 'freertos') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein Xtensa Project.' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' +
      LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      Xtensa_Project_Options_Form.Free;
      Exit;
    end;
  end;

  Xtensa_Project_Options_Form.LazProjectToMask(LazProject);

  if Xtensa_Project_Options_Form.ShowModal = mrOk then begin
    Xtensa_Project_Options_Form.MaskToLazProject(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;
end;

{ TProjectARMApp }

constructor TProjectXtensaApp.Create;
begin
  inherited Create;
  Name := Title + 'Xtensa-Project (ESP32 / ESP8266)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectXtensaApp.GetLocalizedName: string;
begin
  Result := Title + 'Xtensa-Project (ESP32 / ESP8266)';
end;

function TProjectXtensaApp.GetLocalizedDescription: string;
begin
  Result := Title + 'Erstellt ein Xtensa-Project (ESP32 / ESP8266)';
end;

function TProjectXtensaApp.DoInitDescriptor: TModalResult;
begin
  Xtensa_Project_Options_Form.DefaultMask;
  Result := Xtensa_Project_Options_Form.ShowModal;
end;

function TProjectXtensaApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText =
    'program Project1;' + LineEnding + LineEnding + '{$H-,J-,O-}' +
    LineEnding + LineEnding + 'uses' + LineEnding + '  cortexm3;' +
    LineEnding + LineEnding + 'begin' + LineEnding + '  // Setup' +
    LineEnding + '  repeat' + LineEnding + '    // Loop;' + LineEnding +
    '  until false;' + LineEnding + 'end.';

var
  MainFile: TLazProjectFile;
begin
  inherited InitProject(AProject);

  MainFile := AProject.CreateProjectFile('Project1.pas');
  MainFile.IsPartOfProject := True;
  AProject.AddFile(MainFile, False);

  AProject.MainFileID := 0;
  AProject.MainFile.SetSourceText(ProjectText, True);

  AProject.LazCompilerOptions.TargetFilename := 'Project1';
  AProject.LazCompilerOptions.Win32GraphicApp := False;
  AProject.LazCompilerOptions.GenerateDebugInfo := False;
  AProject.LazCompilerOptions.UnitOutputDirectory :=
    'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';

  AProject.Flags := AProject.Flags + [pfRunnable];

  AProject.LazCompilerOptions.TargetCPU := 'xtensa';
  AProject.LazCompilerOptions.TargetOS := 'freertos';
  AProject.LazCompilerOptions.TargetProcessor := 'lx6';

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

//  Xtensa_Project_Options_Form.MaskToLazProject(AProject);

  Result := mrOk;
end;

function TProjectXtensaApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.

