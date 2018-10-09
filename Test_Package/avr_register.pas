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
  AVR_Project_Options_Form;

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

  Form.COMPortComboBox.Text :=
    ProjectOptions.AvrdudeCommand.COM_Port;

  if Form.ShowModal = mrOk then
  begin
    ProjectOptions.AvrdudeCommand.COM_Port :=
      Form.COMPortComboBox.Text;
    ProjectOptions.Save(LazProject);
    ShowMessage(LazProject.LazCompilerOptions.ExecuteAfter.Command);
  end;

  Form.Free;
end;

procedure Register;

begin
  ProjectOptions := TProjectOptions.Create;
  RegisterProjectDescriptor(TProjectAVRApp.Create);

  // Menu
  RegisterIdeMenuCommand(mnuProject, 'AVR-Optionen', 'AVR-Optionen...',
    nil, @ShowAVROptionsDialog);
end;

{ TProjectAVRApp }

constructor TProjectAVRApp.Create;
begin
  inherited Create;
  Name := 'Test_Project';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectAVRApp.GetLocalizedName: string;
begin
  Result := 'Test-Project';
end;

function TProjectAVRApp.GetLocalizedDescription: string;
begin
  Result := 'Erstellt ein Test-Project';
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TProjectOptionsForm;
begin
  Form := TProjectOptionsForm.Create(nil);
  Form.COMPortComboBox.Text := '/dev/ttyUSB0';

  Result := Form.ShowModal;
  if Result = mrOk then
  begin
    ProjectOptions.AvrdudeCommand.COM_Port := Form.COMPortComboBox.Text;
  end;

  Form.Free;
end;

function TProjectAVRApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText =
    'program Project1;' + LineEnding + LineEnding + 'begin' + LineEnding + 'end.';

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

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  ProjectOptions.Save(AProject);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename,
    -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.
