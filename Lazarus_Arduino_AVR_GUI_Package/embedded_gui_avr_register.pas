unit Embedded_GUI_AVR_Register;

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
  Embedded_GUI_AVR_Common,
  Embedded_GUI_AVR_Project_Options_Form;

type
  TProjectAVRApp = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
    function DoInitDescriptor: TModalResult; override;
  end;

procedure ShowAVROptionsDialog(Sender: TObject);

implementation

procedure ShowAVROptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
  ProjOptiForm: TAVR_Project_Options_Form;
begin
  ProjOptiForm := TAVR_Project_Options_Form.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'avr') or (LazProject.LazCompilerOptions.TargetOS <> 'embedded') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein AVR Embedded Project.' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' + LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      ProjOptiForm.Free;
      Exit;
    end;
  end;

  AVR_ProjectOptions.Load_from_Project(LazProject);

  ProjOptiForm.LoadDefaultMask;
  ProjOptiForm.ProjectOptionsToMask;

  if ProjOptiForm.ShowModal = mrOk then begin
    ProjOptiForm.MaskToProjectOptions;
    AVR_ProjectOptions.Save_to_Project(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;

  ProjOptiForm.Free;
end;

{ TProjectAVRApp }

constructor TProjectAVRApp.Create;
begin
  inherited Create;
  Name := Title + 'AVR-Project (Arduino)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectAVRApp.GetLocalizedName: string;
begin
  Result := Title + 'AVR-Project (Arduino)';
end;

function TProjectAVRApp.GetLocalizedDescription: string;
begin
  Result := Title + 'Erstellt ein AVR-Project (Arduino)';
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TAVR_Project_Options_Form;
begin
  Form := TAVR_Project_Options_Form.Create(nil);
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

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'avr5';

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  AVR_ProjectOptions.Save_to_Project(AProject);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename,
    -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.

