unit Embedded_GUI_ARM_Register;

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
  Embedded_GUI_ARM_Common,
  Embedded_GUI_ARM_Project_Options_Form;

type

  { TProjectARMApp }

  TProjectARMApp = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
    function DoInitDescriptor: TModalResult; override;
  end;

procedure ShowARMOptionsDialog(Sender: TObject);


implementation

procedure ShowARMOptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'arm') or (LazProject.LazCompilerOptions.TargetOS <> 'embedded') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein ARM Embedded Project.' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' + LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      ARM_Project_Options_Form.Free;
      Exit;
    end;
  end;

  ARM_Project_Options_Form.LazProjectToMask(LazProject);

  if ARM_Project_Options_Form.ShowModal = mrOk then begin
    ARM_Project_Options_Form.MaskToLazProject(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;
end;

{ TProjectARMApp }

constructor TProjectARMApp.Create;
begin
  inherited Create;
  Name := Title + 'ARM-Project (STM32)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectARMApp.GetLocalizedName: string;
begin
  Result := Title + 'ARM-Project (STM32)';
end;

function TProjectARMApp.GetLocalizedDescription: string;
begin
  Result := Title + 'Erstellt ein ARM-Project (STM32)';
end;

function TProjectARMApp.DoInitDescriptor: TModalResult;
begin
  ARM_Project_Options_Form.DefaultMask;
  Result := ARM_Project_Options_Form.ShowModal;
end;

function TProjectARMApp.InitProject(AProject: TLazProject): TModalResult;
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

  AProject.LazCompilerOptions.TargetCPU := 'arm';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'ARMV7M';

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  ARM_Project_Options_Form.MaskToLazProject(AProject);

  Result := mrOk;
end;

function TProjectARMApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.

