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
    private ARM_OptionsForm: TARM_Project_Options_Form;
  public
    constructor Create; override;
    destructor Destroy; override;
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
  ARM_OptionsForm: TARM_Project_Options_Form;
begin
  ARM_OptionsForm := TARM_Project_Options_Form.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'arm') or (LazProject.LazCompilerOptions.TargetOS <> 'embedded') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein ARM Embedded Project.' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' + LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      ARM_OptionsForm.Free;
      Exit;
    end;
  end;

  ARM_OptionsForm.LazProjectToMask(LazProject);

//  ARM_ProjectOptions.Load_from_Project(LazProject);
//  ARM_OptionsForm.IsNewProject:=False;

  if ARM_OptionsForm.ShowModal = mrOk then begin
    ARM_OptionsForm.MaskToLazProject(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;

  ARM_OptionsForm.Free;
end;

{ TProjectARMApp }

constructor TProjectARMApp.Create;
begin
  inherited Create;
  Name := Title + 'ARM-Project (STM32)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
  ARM_OptionsForm := TARM_Project_Options_Form.Create(nil);
end;

destructor TProjectARMApp.Destroy;
begin
  ARM_OptionsForm.Free;
  inherited Destroy;
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
  Result := ARM_OptionsForm.ShowModal;
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

  ARM_OptionsForm.MaskToLazProject(AProject);

  Result := mrOk;
end;

function TProjectARMApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.

