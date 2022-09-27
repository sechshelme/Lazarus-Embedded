unit Embedded_GUI_Option_Dialog_Register;

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
  //  Embedded_GUI_Templates,
  Embedded_GUI_Project_Options_Form;

type

  { TProjectApp }

  TProjectApp = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
    function DoInitDescriptor: TModalResult; override;
  end;

procedure ShowOptionsDialog(Sender: TObject);


implementation

procedure ShowOptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetOS <> 'embedded') and (LazProject.LazCompilerOptions.TargetOS <> 'freertos') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein Embedded Project. ('+LazProject.LazCompilerOptions.TargetOS+')' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' + LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      Exit;
    end;
  end;

  Project_Options_Form.LazProjectToMask(LazProject);
  Project_Options_Form.IsNewProject := False;

  if Project_Options_Form.ShowModal = mrOk then begin
    Project_Options_Form.MaskToLazProject(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;
end;

{ TProjectApp }

constructor TProjectApp.Create;
begin
  inherited Create;
  Name := Title + 'Embedded-Project (Arduino, STM32, etc.)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectApp.GetLocalizedName: string;
begin
  Result := Title + 'Embedded-Project (Arduino, STM32, etc.)';
end;

function TProjectApp.GetLocalizedDescription: string;
begin
  Result := 'Erstellt ein Embedded-Project (Arduino, STM32, etc.), bei dem man auch den Programmer mit seine Parameter angeben kann.' +
    ' Die Parameter können auch nachträglich modifiziert werden.';
end;

function TProjectApp.DoInitDescriptor: TModalResult;
begin
  Project_Options_Form.DefaultMask;

  Project_Options_Form.IsNewProject := True;
  Result := Project_Options_Form.ShowModal;
end;

function TProjectApp.InitProject(AProject: TLazProject): TModalResult;
var
  MainFile: TLazProjectFile;
begin
  inherited InitProject(AProject);

  AProject.LazCompilerOptions.TargetFilename := 'Project1';
  AProject.LazCompilerOptions.Win32GraphicApp := False;
  AProject.LazCompilerOptions.GenerateDebugInfo := False;
  AProject.LazCompilerOptions.UnitOutputDirectory :=
    'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';

  AProject.Flags := AProject.Flags + [pfRunnable];

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'AVR5';

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  Project_Options_Form.MaskToLazProject(AProject);

  MainFile := AProject.CreateProjectFile('Project1.pas');
  MainFile.IsPartOfProject := True;
  AProject.AddFile(MainFile, False);

  AProject.MainFileID := 0;

  AProject.MainFile.SetSourceText(Project_Options_Form.ProjectSource, True);

  Result := mrOk;
end;

function TProjectApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.
