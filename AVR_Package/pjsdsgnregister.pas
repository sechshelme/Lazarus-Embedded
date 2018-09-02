unit PJSDsgnRegister;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  // LCL
  Forms, Controls, StdCtrls,
  // LazUtils
  LazLoggerBase,
  // IdeIntf
  ProjectIntf, CompOptsIntf, LazIDEIntf, IDEOptionsIntf, IDEOptEditorIntf,
  // Pas2js
  PJSDsgnOptions, PJSDsgnOptsFrame,

  AVR_IDE_Options, AVR_Project_Options;

const
  ProjDescNamePas2JSWebApp = 'Web Application';
  ProjDescNamePas2JSNodeJSApp = 'NodeJS Application';


type

  { TProjectPas2JSWebApp }
  TBrowserApplicationOption = (baoCreateHtml,        // Create template HTML page
    baoMaintainHTML,      // Maintain the template HTML page
    baoRunOnReady,        // Run in document.onReady
    baoUseBrowserApp,     // Use browser app object
    baoUseBrowserConsole, // use browserconsole unit to display Writeln()
    baoStartServer,       // Start simple server
    baoUseURL             // Use this URL to run/show project in browser
    );
  TBrowserApplicationOptions = set of TBrowserApplicationOption;

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
  JSOptionsFrameID: integer = 1001;

const
  // Position in project options dialog.
  AVROptionsIndex = ProjectOptionsMisc + 100;

procedure Register;

implementation

uses
  frmpas2jswebservers,
  pjsprojectoptions,
  pjscontroller, strpas2jsdesign, MenuIntf;

procedure ShowServerDialog(Sender: TObject);
begin
  TPasJSWebserverProcessesForm.Instance.Show;
  TPasJSWebserverProcessesForm.Instance.BringToFront;
end;

procedure Register;

begin
  PJSOptions := TPas2jsOptions.Create;
  PJSOptions.Load;

  TPJSController.Instance.Hook;
  // === AVR

  AVR_Options:=TAVR_Options.Create;
  AVR_Options.Load;

  RegisterProjectDescriptor(TProjectAVRApp.Create);
  // add IDE options frame
  AVROptionsFrameID := RegisterIDEOptionsEditor(GroupEnvironment, TAVR_IDE_Options_Frame,  AVROptionsFrameID)^.Index;
  RegisterIDEOptionsEditor(GroupProject, TAVR_Project_Options_Frame, AVROptionsIndex);


  // add IDE options frame
//  AVROptionsFrameID := RegisterIDEOptionsEditor(GroupEnvironment, TPas2jsOptionsFrame,  JSOptionsFrameID)^.Index;
//  RegisterIdeMenuCommand(itmViewDebugWindows, 'Pas2JSWebservers', SPasJSWebserversCaption, nil, @ShowServerDialog);

  // Add project options frame
//  RegisterIDEOptionsEditor(GroupProject, TPas2JSProjectOptionsFrame, AVROptionsIndex);
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
  ProjectText = 'program Project1;' + LineEnding +
    LineEnding +
    '{$H-}' + LineEnding +
    '{$O-}' + LineEnding +
    LineEnding +
    'uses' + LineEnding +
    '  intrinsics;' + LineEnding +
    LineEnding +
    'begin' + LineEnding +
    '  // Setup' + LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until 1 = 2;' + LineEnding +
    'end;' + LineEnding +
    LineEnding +
    'end.';

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
  AProject.LazCompilerOptions.UnitOutputDirectory := 'lib' + PathDelim + '$(TargetCPU)-$(TargetOS)';

  AProject.LazCompilerOptions.TargetCPU := 'avr';
  AProject.LazCompilerOptions.TargetOS := 'embedded';
  AProject.LazCompilerOptions.TargetProcessor := 'avr5';

//  AProject.LazCompilerOptions.;

  AProject.MainFile.SetSourceText(ProjectText, True);

  Result := mrOk;
end;

function TProjectAVRApp.CreateStartFiles(AProject: TLazProject): TModalResult;
begin
  Result := LazarusIDE.DoOpenEditorFile(AProject.MainFile.Filename, -1, -1,
    [ofProjectLoading, ofRegularFile]);
end;

function TProjectAVRApp.DoInitDescriptor: TModalResult;
var
  Form: TForm;

  CBPort: TComboBox;
  CBProgrammer: TComboBox;
  LPort: TLabel;
  LProgrammer: TLabel;
  LTest: TLabel;
  OkButton: TButton;
begin
  Form := TForm.Create(nil);

  LProgrammer := TLabel.Create(Form);
  with LProgrammer do begin
    Left := 10;
    Top := 15;
    Caption := 'Programmer';
    Parent := Form;
  end;

  CBProgrammer := TComboBox.Create(Form);
  with CBProgrammer do begin
    Left := 10;
    Width := Form.ClientWidth - 20;
    Top := 40;
    Anchors := [akTop, akLeft, akRight];
    Items.Add('USBasp');
    Items.Add('Arduino as ISP');
    Items.Add('default');
    Text := 'USBasp';
    Parent := Form;
  end;

  LPort := TLabel.Create(Form);
  with LPort do begin
    Left := 10;
    Top := 75;
    Caption := 'COM-Port';
    Parent := Form;
  end;

  CBPort := TComboBox.Create(Form);
  with CBPort do begin
    Left := 10;
    Width := Form.ClientWidth - 20;
    Top := 100;
    Anchors := [akTop, akLeft, akRight];
    Items.Add('/dev/ttyUSB0');
    Items.Add('/dev/ttyUSB1');
    Text := '/dev/ttyUSB0';
    Parent := Form;
  end;

  OkButton := TButton.Create(Form);
  with OkButton do begin
    Left := 30;
    Top := Form.Height - 30;
    Anchors := [akTop, akLeft];
    Caption := '&Ok';
    ModalResult := mrOk;
    Parent := Form;
  end;

  LTest := TLabel.Create(Form);
  with LTest do begin
    Left := 10;
    Top := 125;
    Caption := '---' + AVR_Options.avrdudePfad+ '---';
    Parent := Form;
  end;



  Form.Position := poDesktopCenter;

  Result := Form.ShowModal;
  Form.Free;
end;

end.
