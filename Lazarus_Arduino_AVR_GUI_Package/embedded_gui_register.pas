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

  // Embedded ( Eigene Units )
  Embedded_GUI_AVR_Register,
  Embedded_GUI_ARM_Register,
  Embedded_GUI_IDE_Options,
  Embedded_GUI_AVR_Common, Embedded_GUI_AVR_Project_Options_Form,
  Embedded_GUI_ARM_Common, Embedded_GUI_ARM_Project_Options_Form,
  Embedded_GUI_Serial_Monitor;

var
  Embbed_IDE_OptionsFrameID: integer = 1000;

//const
//  AVROptionsIndex = ProjectOptionsMisc + 100;

procedure Register;

implementation

procedure ShowAVROptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
  ProjOptiForm: TAVR_Project_Options_Form;
begin
  ProjOptiForm := TAVR_Project_Options_Form.Create(nil);

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

procedure ShowARMOptionsDialog(Sender: TObject);
var
  LazProject: TLazProject;
  ProjOptiForm: TARM_Project_Options_Form;
begin
  ProjOptiForm := TARM_Project_Options_Form.Create(nil);

  LazProject := LazarusIDE.ActiveProject;

  if (LazProject.LazCompilerOptions.TargetCPU <> 'arm') or
    (LazProject.LazCompilerOptions.TargetOS <> 'embedded') then begin
    if MessageDlg('Warnung', 'Es handelt sich nicht um ein ARM Embedded Project.' +
      LineEnding + 'Diese Funktion kann aktuelles Projekt zerstören' +
      LineEnding + LineEnding + 'Trotzdem ausführen ?', mtWarning,
      [mbYes, mbNo], 0) = mrNo then begin
      ProjOptiForm.Free;
      Exit;
    end;
  end;

  ARM_ProjectOptions.Load(LazProject);

  ProjOptiForm.LoadDefaultMask;
  ProjOptiForm.ProjectOptionsToMask;

  if ProjOptiForm.ShowModal = mrOk then begin
    ProjOptiForm.MaskToProjectOptions;
    ARM_ProjectOptions.Save(LazProject);
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
  Embedded_IDE_Options := TEmbedded_IDE_Options.Create;
  Embedded_IDE_Options.Load;

  AVR_ProjectOptions := TAVR_ProjectOptions.Create;
  RegisterProjectDescriptor(TProjectAVRApp.Create);


  ARM_ProjectOptions := TARM_ProjectOptions.Create;
  RegisterProjectDescriptor(TProjectARMApp.Create);

  // IDE Option
  Embbed_IDE_OptionsFrameID := RegisterIDEOptionsEditor(GroupEnvironment, TEmbedded_IDE_Options_Frame, Embbed_IDE_OptionsFrameID)^.Index;

  // Menu
  RegisterIdeMenuCommand(mnuProject, 'AVR-Embedded-Optionen (Arduino)',
    'AVR-Embedded-Optionen (Arduino)...', nil, @ShowAVROptionsDialog);

  RegisterIdeMenuCommand(mnuProject, 'ARM-Embedded-Optionen (STM32)',
    'ARM-Embedded-Optionen (STM32)...', nil, @ShowARMOptionsDialog);

//  RegisterIdeMenuCommand(mnuProject, 'Serial-Monitor', 'Serial-Monitor...', nil, @ShowSerialMonitor);
end;


end.
