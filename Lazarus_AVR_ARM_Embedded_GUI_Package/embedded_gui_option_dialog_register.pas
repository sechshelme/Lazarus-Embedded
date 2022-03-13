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
  Embedded_GUI_Templates,
  Embedded_GUI_Project_Options_Form;

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

procedure ShowOptionsDialog(Sender: TObject);


implementation

procedure ShowOptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
begin
  LazProject := LazarusIDE.ActiveProject;

  if LazProject.LazCompilerOptions.TargetOS <> 'embedded' then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein Embedded Project.' + LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' + LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
      Project_Options_Form.Free;
      Exit;
    end;
  end;

  Project_Options_Form.LazProjectToMask(LazProject);

  if Project_Options_Form.ShowModal = mrOk then begin
    Project_Options_Form.MaskToLazProject(LazProject);
    LazProject.LazCompilerOptions.GenerateDebugInfo := False;
  end;
end;

{ TProjectARMApp }

constructor TProjectARMApp.Create;
begin
  inherited Create;
  Name := Title + 'Embedded-Project (STM32 / Arduino DUE)';
  Flags := DefaultProjectNoApplicationFlags - [pfRunnable];
end;

function TProjectARMApp.GetLocalizedName: string;
begin
  Result := Title + 'Embedded-Project (STM32 / Arduino DUE)';
end;

function TProjectARMApp.GetLocalizedDescription: string;
begin
  Result := Title + 'Erstellt ein Embedded-Project (STM32 / Arduino DUE)';
end;

function TProjectARMApp.DoInitDescriptor: TModalResult;
begin
  Project_Options_Form.DefaultMask;
  Result := Project_Options_Form.ShowModal;
end;

function TProjectARMApp.InitProject(AProject: TLazProject): TModalResult;
const
  ProjectText =
    'program Project1;' + LineEnding + LineEnding +
    '{$H-,J-,O-}' +
    LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' +
    LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until false;' + LineEnding +
    'end.';

  ProjectTextARMV7M =
    'program Project1;' + LineEnding + LineEnding +
    '{$H-,J-,O-}' +
    LineEnding + LineEnding +
    'uses' + LineEnding +
    '  cortexm3;' +
    LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' +
    LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until false;' + LineEnding +
    'end.';

  ProjectTextRaspi_Pico =
    'program Project1;' + LineEnding + LineEnding +
    '{$MODE OBJFPC}' + LineEnding +
    '{$H-,J-,O-}' + LineEnding +
    '{$MEMORY 10000,10000}' + LineEnding + LineEnding +
    'uses' + LineEnding +
    '  pico_c, ' + LineEnding +
    '  pico_gpio_c,' + LineEnding +
    '  pico_adc_c,' + LineEnding +
    '  pico_clocks_c,' + LineEnding +
    '  pico_uart_c,' + LineEnding +
    '  pico_i2c_c,' + LineEnding +
    '  pico_pio_c,' + LineEnding +
    '  pico_spi_c,' + LineEnding +
    '  pico_timer_c,' + LineEnding +
    '  pico_time_c;' + LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' +
    LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until false;' + LineEnding +
    'end.';

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

  AProject.LazCompilerOptions.TargetCPU := 'arm';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'ARMV7M';

  AProject.LazCompilerOptions.ExecuteAfter.CompileReasons := [crRun];

  Project_Options_Form.MaskToLazProject(AProject);

  MainFile := AProject.CreateProjectFile('Project1.pas');
  MainFile.IsPartOfProject := True;
  AProject.AddFile(MainFile, False);

  AProject.MainFileID := 0;

  if AProject.LazCompilerOptions.TargetProcessor = 'ARMV7M' then begin
    AProject.MainFile.SetSourceText(ProjectTextARMV7M, True);
  end else begin
      if Pos('-WpRASPI_PICO',  AProject.LazCompilerOptions.CustomOptions)>0 then begin
        AProject.MainFile.SetSourceText(ProjectTextRaspi_Pico, True);
      end else begin
        AProject.MainFile.SetSourceText(ProjectText, True);
      end;
  end;

  Result := mrOk;
end;

function TProjectARMApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

end.

