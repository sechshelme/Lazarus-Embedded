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

  { TProjectAVRApp }

  TProjectAVRApp = class(TProjectDescriptor)
  private
    AVR_OptionsForm: TAVR_Project_Options_Form;
  public
    constructor Create; override;
    destructor Destroy; override;
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
  AVR_OptionsForm: TAVR_Project_Options_Form;
begin
  AVR_OptionsForm := TAVR_Project_Options_Form.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'avr') or (LazProject.LazCompilerOptions.TargetOS <> 'embedded') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein AVR Embedded Project.' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' + LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      AVR_OptionsForm.Free;
      Exit;
    end;
  end;

  AVR_OptionsForm.LazProjectToMask(LazProject);

  if AVR_OptionsForm.ShowModal = mrOk then begin
    AVR_OptionsForm.MaskToLazProject(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;

  AVR_OptionsForm.Free;
end;

{ TProjectAVRApp }

constructor TProjectAVRApp.Create;
begin
  inherited Create;
  Name := Title + 'AVR-Project (Arduino)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
  AVR_OptionsForm := TAVR_Project_Options_Form.Create(nil);
end;

destructor TProjectAVRApp.Destroy;
begin
  AVR_OptionsForm.Free;
  inherited Destroy;
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
begin
  Result := AVR_OptionsForm.ShowModal;
end;

function TProjectAVRApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText =
    'program Project1;' + LineEnding + LineEnding + '{$H-,J-,O-}' + LineEnding + LineEnding + 'uses' + LineEnding + '  intrinsics;' + LineEnding + LineEnding + 'begin' + LineEnding + '  // Setup' + LineEnding + '  repeat' + LineEnding + '    // Loop;' + LineEnding + '  until false;' + LineEnding + 'end.';

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

  AVR_OptionsForm.MaskToLazProject(AProject);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.





