unit AVR_Register;

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

  // AVR
  AVR_IDE_Options, AVR_Project_Options_Frame, Avr_Project_Options_Form;

type
  { TProjectAVRApp }

  TProjectAVRApp = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
    function DoInitDescriptor: TModalResult; override;
  end;

var
  AVROptionsFrameID: integer = 1000;

const
  AVROptionsIndex = ProjectOptionsMisc + 100;

procedure Register;

implementation

procedure ShowAVROptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
  Form: TProjectOptionsForm;
begin
  Form := TProjectOptionsForm.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  ProjectOptions.Load(LazProject);

  Form.AVR_Project_Options_Frame1.LoadDefaultMask;
  Form.AVR_Project_Options_Frame1.ProjectOptionsToMask;

  if Form.ShowModal = mrOk then begin
    Form.AVR_Project_Options_Frame1.MaskToProjectOptions;
    ProjectOptions.Save(LazProject);
    ShowMessage(LazProject.LazCompilerOptions.ExecuteAfter.Command);
    LazProject.Modified := False;
    //    ShowMessage(BoolToStr(LazProject.Modified));
  end;

  Form.Free;
end;

procedure Register;

begin
  AVR_Options := TAVR_Options.Create;
  AVR_Options.Load;

  ProjectOptions := TProjectOptions.Create;

  RegisterProjectDescriptor(TProjectAVRApp.Create);

  // IDE Option
  AVROptionsFrameID := RegisterIDEOptionsEditor(GroupEnvironment,
    TAVR_IDE_Options_Frame, AVROptionsFrameID)^.Index;

  // Project Option
  RegisterIDEOptionsEditor(GroupProject, TAVR_Project_Options_Frame, AVROptionsIndex);

  // Menu
  RegisterIdeMenuCommand(mnuProject, 'AVR-Optionen', 'AVR-Optionen',
    nil, @ShowAVROptionsDialog);
end;

{ TProjectAVRApp }

constructor TProjectAVRApp.Create;
begin
  inherited Create;
  Name := 'AVR_Project';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectAVRApp.GetLocalizedName: string;
begin
  Result := 'AVR-Project';
end;

function TProjectAVRApp.GetLocalizedDescription: string;
begin
  Result := 'Erstellt ein AVR-Project ( Arduino )';
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TProjectOptionsForm;
begin
  Form := TProjectOptionsForm.Create(nil);

  Form.AVR_Project_Options_Frame1.LoadDefaultMask;

  Result := Form.ShowModal;
  if Result = mrOk then begin
    Form.AVR_Project_Options_Frame1.MaskToProjectOptions;
  end;

  Form.Free;
end;

function TProjectAVRApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText =
    'program Project1;' + LineEnding + LineEnding +
    '{$H-}' + LineEnding +
    '{$O-}' + LineEnding + LineEnding +
    'uses' + LineEnding +
    '  intrinsics;' + LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' + LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until 1 = 2;' + LineEnding + LineEnding +
    'end.';

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
  AProject.LazCompilerOptions.UnitOutputDirectory := 'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'avr5';

  //    AProject.LazCompilerOptions.ExecuteBefore.CompileReasons := [crCompile] + [crRun];
  //    AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crBuild];
  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  ProjectOptions.Save(AProject);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.
