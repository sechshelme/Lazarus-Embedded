unit Embedded_GUI_Register;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  // LCL
  Forms, Controls, StdCtrls, Dialogs, ExtCtrls,
  Serial,
  // LazUtils
  LazLoggerBase,
  // IdeIntf
  ProjectIntf, CompOptsIntf, LazIDEIntf, IDEOptionsIntf, IDEOptEditorIntf, MenuIntf,
  //  DefineTemplates,  // Als Test;

  // Embedded GUI ( Eigene Units )
  Embedded_GUI_AVR_Register,
  Embedded_GUI_ARM_Register,
  Embedded_GUI_IDE_Options_Frame,
  Embedded_GUI_Common,
  Embedded_GUI_AVR_Common,
  Embedded_GUI_ARM_Common,
  Embedded_GUI_CPU_Info_Form,
  Embedded_GUI_Embedded_List_Const,
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

procedure ResetCom;
var
  SerialHandle: TSerialHandle;
begin
//  ShowMessage('hallo0    '+AVR_ProjectOptions.AvrdudeCommand.Programmer);
  if AVR_ProjectOptions.AvrdudeCommand.Programmer = 'avr109' then begin
//    ShowMessage('hallo1');
    SerialHandle := SerOpen(AVR_ProjectOptions.AvrdudeCommand.COM_Port);
    SerSetParams(SerialHandle, 1200, 8, NoneParity, 1, []);

    SerSetDTR(SerialHandle, True);
    SerSetDTR(SerialHandle, False);
    Sleep(500);
    SerClose(SerialHandle);
    Sleep(500);
  end;
end;

function TNewIDEHandle.RunHandler(Sender: TObject; var Handled: boolean): TModalResult;
begin
  ResetCom;
  if Assigned(Serial_Monitor_Form) then begin
    if Serial_Monitor_Form.Timer1.Enabled then begin
      Active := True;
      Serial_Monitor_Form.CloseSerial;
    end else begin
      Active := False;
    end;
  end;
//  Result:=mrNone;
end;

function TNewIDEHandle.RunNoDebugHandler(Sender: TObject; var Handled: boolean): TModalResult;
begin
  ResetCom;
  if Assigned(Serial_Monitor_Form) then begin
    if Serial_Monitor_Form.Timer1.Enabled then begin
      Active := True;
      Serial_Monitor_Form.CloseSerial;
    end else begin
      Active := False;
    end;
  end;
//  Result:=mrNone;
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
  CPU_Info_Titel = Title + 'CPU-Info';

begin
  Embedded_IDE_Options := TEmbedded_IDE_Options.Create;
  Embedded_IDE_Options.Load_from_XML;

  AVR_ProjectOptions := TAVR_ProjectOptions.Create;
  RegisterProjectDescriptor(TProjectAVRApp.Create);

  ARM_ProjectOptions := TARM_ProjectOptions.Create;
  RegisterProjectDescriptor(TProjectARMApp.Create);

  // Run ( without or with debugger ) hooks
  NewIDEHandle := TNewIDEHandle.Create;
  LazarusIDE.AddHandlerOnRunDebug(@NewIDEHandle.RunHandler, False);
  LazarusIDE.AddHandlerOnRunWithoutDebugInit(@NewIDEHandle.RunNoDebugHandler, False);
  LazarusIDE.AddHandlerOnRunFinished(@NewIDEHandle.StopHandler, True);

  // Werkzeuge --> Einstellungen --> Umgebung
  Embbed_IDE_OptionsFrameID :=
    RegisterIDEOptionsEditor(GroupEnvironment, TEmbedded_IDE_Options_Frame, Embbed_IDE_OptionsFrameID)^.Index;

  // Menu
  RegisterIdeMenuCommand(mnuProject, AVR_Title, AVR_Title + '...', nil, @ShowAVROptionsDialog);
  RegisterIdeMenuCommand(mnuProject, ARM_Title, ARM_Title + '...', nil, @ShowARMOptionsDialog);

  RegisterIdeMenuCommand(mnuTools, CPU_Info_Titel, CPU_Info_Titel + '...', nil, @ShowCPU_Info);
  RegisterIdeMenuCommand(mnuTools, Title + 'Serial-Monitor', Title + 'Serial-Monitor...', nil, @RegisterSerialMonitor);
end;


end.
