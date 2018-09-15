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
  f: TProjectOptionsForm;
  s: string;
begin
  f := TProjectOptionsForm.Create(nil);
  f.Show;

  LazProject := LazarusIDE.ActiveProject;

  //f.AVR_Project_Options_Frame1.Label3.Caption :=
  //  LazProject.LazCompilerOptions.ExecuteBeforeCommand + LineEnding +
  //  LazProject.LazCompilerOptions.ExecuteAfterCommand;

  s := 'Before: ';
  if crCompile in LazProject.LazCompilerOptions.ExecuteBeforeCompileReasons then begin
    s += 'compile ';
  end;
  if crBuild in LazProject.LazCompilerOptions.ExecuteBeforeCompileReasons then begin
    s += 'build ';
  end;
  if crRun in LazProject.LazCompilerOptions.ExecuteBeforeCompileReasons then begin
    s += 'run ';
  end;

  s += LineEnding + 'After: ';
  if crCompile in LazProject.LazCompilerOptions.ExecuteAfterCompileReasons then begin
    s += 'compile ';
  end;
  if crBuild in LazProject.LazCompilerOptions.ExecuteAfterCompileReasons then begin
    s += 'build ';
  end;
  if crRun in LazProject.LazCompilerOptions.ExecuteAfterCompileReasons then begin
    s += 'run ';
  end;

  f.AVR_Project_Options_Frame1.Label3.Caption := s;

  ProjectOptions.Save(LazProject);
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
  RegisterIdeMenuCommand(mnuProject, 'Serial Monitor', 'Serial Monitor',
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
  CompOpts: TLazCompilerOptions;

begin
  inherited InitProject(AProject);

  MainFile := AProject.CreateProjectFile('Project1.pas');
  MainFile.IsPartOfProject := True;

  //  AProject.AddPackageDependency('AVRLaz');
  AProject.AddFile(MainFile, False);
  AProject.MainFileID := 0;

  AProject.LazCompilerOptions.TargetFilename := 'Project1';
  AProject.LazCompilerOptions.Win32GraphicApp := False;
  AProject.LazCompilerOptions.GenerateDebugInfo := False;

  AProject.LazCompilerOptions.UnitOutputDirectory := 'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'avr5';

//  AProject.LazCompilerOptions.ExecuteBeforeCompileReasons := [crCompile] + [crRun];
  AProject.LazCompilerOptions.ExecuteAfterCompileReasons := [crRun];

  AProject.MainFile.SetSourceText(ProjectText, True);

  ProjectOptions.Save(AProject);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1, [ofProjectLoading, ofRegularFile]);
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TProjectOptionsForm;
begin
  Form := TProjectOptionsForm.Create(nil);

  ProjectOptions.AvrdudeCommand.Path := AVR_Options.avrdudePfad;
  ProjectOptions.AvrdudeCommand.Programmer := 'arduino';
  ProjectOptions.AvrdudeCommand.COM_Port := '/dev/ttyUSB0';

  ProjectOptions.AVRType := 'WpATMEGA328P';
  ProjectOptions.AsmFile := False;

  ProjectOptions.SerialMonitorPort := '/dev/ttyUSB0';
  ProjectOptions.SerialMonitorBaud := '9600';


  with Form.AVR_Project_Options_Frame1 do begin
    //    avrdude_ComboBox1.Text := 'avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:Project1.hex:i';

    with avrdudePathComboBox do begin
      Items.Add('avrdude');
      Items.Add('/usr/bin/avrdude');
      Text := AVR_Options.avrdudePfad;
    end;

    with ProgrammerComboBox do begin
      Items.Add('arduino');
      Items.Add('usbasp');
      Items.Add('stk500v1');
      Text := ProjectOptions.AvrdudeCommand.Programmer;
    end;

    HexFile_CheckBox.Checked := ProjectOptions.AsmFile;

    with COMPortComboBox do begin
      Items.Add('/dev/ttyUSB0');
      Items.Add('/dev/ttyUSB1');
      Items.Add('/dev/ttyUSB2');
      Text := ProjectOptions.AvrdudeCommand.COM_Port;
    end;

    with AVR_Typ_ComboBox do begin
      Items.Add('WpATMEGA328P');
      Text := ProjectOptions.AVRType;
    end;

    with SerialMonitorPort_ComboBox do begin
      Items.Add('/dev/ttyUSB0');
      Items.Add('/dev/ttyUSB1');
      Items.Add('/dev/ttyUSB2');
      Text := ProjectOptions.SerialMonitorPort;
    end;

    with SerialMonitorBaud_ComboBox do begin
      Items.Add('4800');
      Items.Add('9600');
      Items.Add('19200');
      Text := ProjectOptions.SerialMonitorBaud;
    end;

    Result := Form.ShowModal;
    if Result = mrOk then begin
      ProjectOptions.AvrdudeCommand.Path := avrdudePathComboBox.Text;
      ProjectOptions.AvrdudeCommand.Programmer := ProgrammerComboBox.Text;
      ProjectOptions.AvrdudeCommand.COM_Port := COMPortComboBox.Text;

      ProjectOptions.AVRType := AVR_Typ_ComboBox.Text;
      ProjectOptions.AsmFile := HexFile_CheckBox.Checked;

      ProjectOptions.SerialMonitorPort := SerialMonitorPort_ComboBox.Text;
      ProjectOptions.SerialMonitorBaud := SerialMonitorBaud_ComboBox.Text;
    end;
  end;

  Form.Free;
end;

end.
