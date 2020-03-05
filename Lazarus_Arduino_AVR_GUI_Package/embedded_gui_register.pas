unit Embedded_GUI_Register;

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

  DefineTemplates,  // Als Test;

  // AVR ( Eigene Units )
  Embedded_GUI_IDE_Options,
  Embedded_GUI_AVR_Common, Embedded_GUI_AVR_Project_Options_Form, Embedded_GUI_Serial_Monitor;

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
  ProjOptiForm: TProjectOptionsForm;
begin
  ProjOptiForm := TProjectOptionsForm.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'avr') or
    (LazProject.LazCompilerOptions.TargetOS <> 'embedded') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein AVR Embedded Project.' +
      LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' +
      LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning,
      [mbYes, mbNo], 0) = mrNo then begin
      ProjOptiForm.Free;
      Exit;
    end;
  end;

  AVR_ProjectOptions.Load(LazProject);

  ProjOptiForm.LoadDefaultMask;
  ProjOptiForm.ProjectOptionsToMask;

  if ProjOptiForm.ShowModal = mrOk then begin
    ProjOptiForm.MaskToProjectOptions;
    AVR_ProjectOptions.Save(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
    //    ShowMessage(LazProject.LazCompilerOptions.ExecuteAfter.Command);
  end;

  ProjOptiForm.Free;
end;

procedure ShowSerialMonitor(Sender: TObject);
var
  LazProject: TLazProject;
  Form: TSerial_Monitor_Form;
begin
  Form := TSerial_Monitor_Form.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  AVR_ProjectOptions.Load(LazProject);

  Form.LoadDefaultMask;
  Form.ProjectOptionsToMask;

  if Form.ShowModal = mrOk then begin
    Form.MaskToProjectOptions;
    AVR_ProjectOptions.Save(LazProject);
  end;

  Form.Free;
end;

procedure Register;

begin
  AVR_Options := TAVR_Options.Create;
  AVR_Options.Load;

  AVR_ProjectOptions := TAVR_ProjectOptions.Create;

  RegisterProjectDescriptor(TProjectAVRApp.Create);

  // IDE Option
  AVROptionsFrameID := RegisterIDEOptionsEditor(GroupEnvironment,
    TAVR_IDE_Options_Frame, AVROptionsFrameID)^.Index;

  // Menu
  RegisterIdeMenuCommand(mnuProject, 'AVR-Embedded-Optionen (Arduino)',
    'AVR-Embedded-Optionen (Arduino)...', nil, @ShowAVROptionsDialog);
  RegisterIdeMenuCommand(mnuProject, 'Serial-Monitor', 'Serial-Monitor...',
    nil, @ShowSerialMonitor);
end;

{ TProjectAVRApp }

constructor TProjectAVRApp.Create;
begin
  inherited Create;
  Name := 'AVR-Embedded-Project (Arduino)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectAVRApp.GetLocalizedName: string;
begin
  Result := 'AVR-Embedded-Project (Arduino)';
end;

function TProjectAVRApp.GetLocalizedDescription: string;
begin
  Result := 'Erstellt ein AVR-Embedded-Project (Arduino)';
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TProjectOptionsForm;
begin
  Form := TProjectOptionsForm.Create(nil);

  Form.LoadDefaultMask;

  Result := Form.ShowModal;
  if Result = mrOk then begin
    Form.MaskToProjectOptions;
  end;

  Form.Free;
end;


function TProjectAVRApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText =
    'program Project1;' + LineEnding + LineEnding + '{$H-,J-,O-}' +
    LineEnding + LineEnding + 'uses' + LineEnding + '  intrinsics;' +
    LineEnding + LineEnding + 'begin' + LineEnding + '  // Setup' +
    LineEnding + '  repeat' + LineEnding + '    // Loop;' + LineEnding +
    '  until false;' + LineEnding + 'end.';

var
  MainFile: TLazProjectFile;


//procedure test;
//var
//  sl:TStringList;
//begin
//  sl:=TStringList.Create;
//  sl.LoadFromFile('avr_register.pas');
//  ShowMessage(sl.Text);
//
//  sl.Free;
//end;

begin
//  test;
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

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'avr5';

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  AVR_ProjectOptions.Save(AProject);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename,
    -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.
