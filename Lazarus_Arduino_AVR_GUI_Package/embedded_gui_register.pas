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
  //  DefineTemplates,  // Als Test;

  // Embedded GUI ( Eigene Units )
  Embedded_GUI_AVR_Register,
  Embedded_GUI_ARM_Register,
  Embedded_GUI_IDE_Options,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common,
  Embedded_GUI_ARM_Common,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_SubArch_List,
  Embedded_GUI_Serial_Monitor_Form;

var
  Embbed_IDE_OptionsFrameID: integer = 1000;

procedure Register;

implementation

type

  { TNewIDEHandle }

  TNewIDEHandle = class(TObject)
  private
    Active: boolean;
  public
    constructor Create;
    function RunHandler(Sender: TObject; var Handled: boolean): TModalResult;
    function RunNoDebugHandler(Sender: TObject; var Handled: boolean): TModalResult;
    procedure StopHandler(Sender: TObject);

  end;

function TNewIDEHandle.RunHandler(Sender: TObject; var Handled: boolean): TModalResult;
begin
  if Assigned(Serial_Monitor_Form) then begin
    if Serial_Monitor_Form.Timer1.Enabled then begin
      Active := True;
      Serial_Monitor_Form.CloseSerial;
    end else begin
      Active := False;
    end;
  end;
end;

function TNewIDEHandle.RunNoDebugHandler(Sender: TObject; var Handled: boolean): TModalResult;
begin
  if Assigned(Serial_Monitor_Form) then begin
    if Serial_Monitor_Form.Timer1.Enabled then begin
      Active := True;
      Serial_Monitor_Form.CloseSerial;
    end else begin
      Active := False;
    end;
  end;
end;

procedure TNewIDEHandle.StopHandler(Sender: TObject);
begin
  if Assigned(Serial_Monitor_Form) then begin
    if Active then begin
      Serial_Monitor_Form.OpenSerial;
    end;
  end;
end;

constructor TNewIDEHandle.Create;
begin
  inherited Create;
  Active := False;
end;

var
  NewIDEHandle: TNewIDEHandle;

procedure ShowCPU_Info(Sender: TObject);
var
  Form: TCPU_InfoForm;
begin
  Form := TCPU_InfoForm.Create(nil);
  //  Form.Load(AVR_ControllerDataList);        // Lazarus auslesen ??????????
  Form.ComboBox1.ItemIndex := 0;
  Form.ComboBox1Select(Sender);
  Form.ShowModal;
  Form.Free;
end;

procedure RegisterSerialMonitor(Sender: TObject);
begin
  if not Assigned(Serial_Monitor_Form) then begin
    Serial_Monitor_Form := TSerial_Monitor_Form.Create(nil);
  end;
  Serial_Monitor_Form.Show;
end;

procedure Register;
const
  AVR_Title = Title + 'AVR-Optionen (Arduino)';
  ARM_Title = Title + 'ARM-Optionen (STM32)';
  Embedded_Titel = Title + 'CPU-Info';

begin
  Embedded_IDE_Options := TEmbedded_IDE_Options.Create;

  AVR_ProjectOptions := TAVR_ProjectOptions.Create;
  RegisterProjectDescriptor(TProjectAVRApp.Create);

  ARM_ProjectOptions := TARM_ProjectOptions.Create;
  RegisterProjectDescriptor(TProjectARMApp.Create);

  // Run ( without or with debugger ) hooks
  NewIDEHandle := TNewIDEHandle.Create;
  LazarusIDE.AddHandlerOnRunDebug(@NewIDEHandle.RunHandler);
  LazarusIDE.AddHandlerOnRunWithoutDebugInit(@NewIDEHandle.RunNoDebugHandler);
  LazarusIDE.AddHandlerOnRunFinished(@NewIDEHandle.StopHandler, True);

  // Werkzeuge --> Einstellungen --> Umgebung
  Embbed_IDE_OptionsFrameID :=
    RegisterIDEOptionsEditor(GroupEnvironment, TEmbedded_IDE_Options_Frame, Embbed_IDE_OptionsFrameID)^.Index;

  // Menu
  RegisterIdeMenuCommand(mnuProject, AVR_Title, AVR_Title + '...', nil, @ShowAVROptionsDialog);
  RegisterIdeMenuCommand(mnuProject, ARM_Title, ARM_Title + '...', nil, @ShowARMOptionsDialog);

  RegisterIdeMenuCommand(mnuTools, Embedded_Titel, Embedded_Titel + '...', nil, @ShowCPU_Info);
  RegisterIdeMenuCommand(mnuTools, Title + 'Serial-Monitor', Title + 'Serial-Monitor...', nil, @RegisterSerialMonitor);
end;


end.
