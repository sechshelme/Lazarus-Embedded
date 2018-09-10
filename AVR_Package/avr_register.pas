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
  ProjectIntf, CompOptsIntf, LazIDEIntf, IDEOptionsIntf, IDEOptEditorIntf,

  // AVR
  AVR_IDE_Options, AVR_Project_Options;

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
  //  AVROptionsIndex = ProjectOptionsMisc + 100;
  AVROptionsIndex = 50;

procedure Register;

implementation

uses
  MenuIntf;

procedure ShowServerDialog(Sender: TObject);
var
  LazProject: TLazProject;
  f: TForm;
begin
  f := TForm.Create(nil);
  f.Show;
  Randomize;
  f.Color := Random($FFFFFF);

  LazProject := LazarusIDE.ActiveProject;

  ProjectOptions.CompilerSettings := IntToStr(f.Color);
  ProjectOptions.Save(LazProject);

  //  ProjectOptions.SaveAfter( LazProject.MainFile.Filename, '-test');
  ProjectOptions.SaveAfter('/n4800/avr_test/Project1.lpi', '-test');

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
  //  RegisterIdeMenuCommand(itmViewDebugWindows, 'Serial Monitor', 'Serial Monitor', nil, @ShowServerDialog);
  RegisterIdeMenuCommand(mnuProject, 'Serial Monitor', 'Serial Monitor',
    nil, @ShowServerDialog);
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

function TProjectAVRApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText = 'program Project1;' + LineEnding + LineEnding +
    '{$H-}' + LineEnding + '{$O-}' + LineEnding + LineEnding +
    'uses' + LineEnding + '  intrinsics;' + LineEnding + LineEnding +
    'begin' + LineEnding + '  // Setup' + LineEnding + '  repeat' +
    LineEnding + '    // Loop;' + LineEnding + '  until 1 = 2;' +
    LineEnding + 'end;' + LineEnding + LineEnding + 'end.';

var
  MainFile: TLazProjectFile;
  CompOpts: TLazCompilerOptions;

begin
  inherited InitProject(AProject);

  MainFile := AProject.CreateProjectFile('Project1.lpr');
  MainFile.IsPartOfProject := True;

  //  AProject.AddPackageDependency('AVRLaz');
  AProject.AddFile(MainFile, False);
  AProject.MainFileID := 0;

  AProject.LazCompilerOptions.Win32GraphicApp := False;
  AProject.LazCompilerOptions.UnitOutputDirectory :=
    'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'avr5';

  //  AProject.LazCompilerOptions.ObjectPath:='Project1';
//    AProject.LazCompilerOptions.Namespaces:='Project1';


//  AProject.LazCompilerOptions.CompilerPath := 'Compiler Pfad';
//  AProject.LazCompilerOptions.SetAlternativeCompile('Vorher...', True);
  AProject.LazCompilerOptions.SetAlternativeCompile('avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:Project1.hex:i', True, True);

  ProjectOptions.Save(AProject);

  //  AProject.LazCompilerOptions.;

  AProject.MainFile.SetSourceText(ProjectText, True);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename,
    -1, -1, [ofProjectLoading, ofRegularFile]);
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TForm;
  Frame: TAVR_Project_Options_Frame;
  OkButton: TButton;

begin
  Form := TForm.Create(nil);
  Form.Position := poDesktopCenter;

  Frame := TAVR_Project_Options_Frame.Create(Form);
  with Frame do
  begin
    Anchors := [akTop, akLeft, akRight];
    Parent := Form;

    Form.Width := Width + 130;
    Form.ClientHeight := Height + 30;
  end;

  OkButton := TButton.Create(Form);
  with OkButton do
  begin
    Left := 30;
    Top := Form.Height - 30;
    Anchors := [akTop, akLeft];
    Caption := '&Ok';
    ModalResult := mrOk;
    Parent := Form;
  end;

  Frame.SerialMonitorPort_ComboBox.Text := '/dev/ttyUSB0';
  Frame.SerialMonitorBaud_ComboBox.Text := '9600';
  Frame.Memo1.Text := '-WpATMEGA328P' + LineEnding + '-al';

  Result := Form.ShowModal;

  if Result = mrOk then
  begin
    ProjectOptions.SerialMonitorPort := Frame.SerialMonitorPort_ComboBox.Text;
    ProjectOptions.SerialMonitorBaud := Frame.SerialMonitorBaud_ComboBox.Text;

    ProjectOptions.CompilerSettings := Frame.Memo1.Text;
  end;

  Form.Free;
end;

end.
