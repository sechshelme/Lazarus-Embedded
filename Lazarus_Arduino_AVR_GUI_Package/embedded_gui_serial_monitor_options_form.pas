unit Embedded_GUI_Serial_Monitor_Options_Form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Buttons,
  {$IFDEF Packages}
  BaseIDEIntf, LazConfigStorage,  // Bei Packages
  {$ELSE}
  XMLConf,  // Bei normalen Anwendungen
  {$ENDIF}
  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports,
  Embedded_GUI_Serial_Monitor_Interface_Options_Frame,
  Embedded_GUI_Serial_Monitor_Output_Options_Frame;

type

  { TSerialMonitor_Options }

  TSerialMonitor_Options = class(TObject)
  public
    Com_Interface: record
      Port, Baud, Bits, Parity, StopBits, FlowControl: string;
      TimeOut, TimerInterval: integer;
    end;
    Output: record
      LineBreak: integer;
      AutoScroll, WordWarp: boolean;
    end;
    constructor Create;
    procedure Load_from_XML;
    procedure Save_to_XML;
  end;

  { TSerialMonitor_Options_Form }

  TSerialMonitor_Options_Form = class(TForm)
    Btn_Close: TBitBtn;
    Btn_Apply: TBitBtn;
    Btn_Ok: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Btn_ApplyClick(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SM_Interface_Frame: TSM_Interface_Frame;
    SM_Output_Frame: TSM_Output_Frame;
  public
  end;

var
  SerialMonitor_Options_Form: TSerialMonitor_Options_Form;

implementation

{$R *.lfm}

uses
  Embedded_GUI_Serial_Monitor_Form;

var
  Key_SerialMonitorPort, Key_SerialMonitorBaud, Key_SerialMonitorParity, Key_SerialMonitorBits, Key_SerialMonitorStopBits, Key_SerialMonitorFlowControl, Key_SerialMonitorTimeOut, Key_SerialMonitorTimer, Key_SerialMonitorLineBreak, Key_SerialMonitorAutoScroll, Key_SerialMonitorWordWarp: string;

{ TSerialMonitor_Options }

constructor TSerialMonitor_Options.Create;
const
  i = 'COMPortPara/';
  o = 'OutputScreenPara/';
var
  n: string;
begin
  inherited Create;
  n := Copy(TSerial_Monitor_Form.ClassName, 2) + '/';// Besser lösen

  Key_SerialMonitorPort := n + i + 'Port';
  Key_SerialMonitorBaud := n + i + 'Baud';
  Key_SerialMonitorParity := n + i + 'Parity';
  Key_SerialMonitorBits := n + i + 'Bits';
  Key_SerialMonitorStopBits := n + i + 'StopBits';
  Key_SerialMonitorFlowControl := n + i + 'FlowControl';
  Key_SerialMonitorTimeOut := n + i + 'TimeOut';
  Key_SerialMonitorTimer := n + i + 'TimerInterval';

  Key_SerialMonitorLineBreak := n + o + 'LineBreak';
  Key_SerialMonitorAutoScroll := n + o + 'AutoScroll';
  Key_SerialMonitorWordWarp := n + o + 'Wordwarp';
  Load_from_XML;
end;

procedure TSerialMonitor_Options.Load_from_XML;
var
  {$IFDEF Packages}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  {$IFDEF Packages}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := 'config.xml';
  {$ENDIF}
  with Com_Interface do begin
    Port := Cfg.GetValue(Key_SerialMonitorPort, UARTDefaultPort);
    Baud := Cfg.GetValue(Key_SerialMonitorBaud, UARTDefaultBaud);
    Parity := Cfg.GetValue(Key_SerialMonitorParity, UARTDefaultParity);
    Bits := Cfg.GetValue(Key_SerialMonitorBits, UARTDefaultBits);
    StopBits := Cfg.GetValue(Key_SerialMonitorStopBits, UARTDefaultStopBits);
    FlowControl := Cfg.GetValue(Key_SerialMonitorFlowControl, UARTDefaultFlowControl);

    TimeOut := Cfg.GetValue(Key_SerialMonitorTimeOut, UARTDefaultTimeOut);
    TimerInterval := Cfg.GetValue(Key_SerialMonitorTimer, UARTDefaultTimer);
  end;
  with Output do begin
    LineBreak := Cfg.GetValue(Key_SerialMonitorLineBreak, OutputDefaultLineBreak);
    AutoScroll := Cfg.GetValue(Key_SerialMonitorAutoScroll, OutputDefaultAutoScroll);
    WordWarp := Cfg.GetValue(Key_SerialMonitorWordWarp, OutputDefaultWordWarp);
  end;
  Cfg.Free;
end;

procedure TSerialMonitor_Options.Save_to_XML;
var
  {$IFDEF Packages}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  {$IFDEF Packages}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := 'config.xml';
  {$ENDIF}
  with Com_Interface do begin
    Cfg.SetValue(Key_SerialMonitorPort, Port);
    Cfg.SetValue(Key_SerialMonitorBaud, Baud);
    Cfg.SetValue(Key_SerialMonitorParity, Parity);
    Cfg.SetValue(Key_SerialMonitorBits, Bits);
    Cfg.SetValue(Key_SerialMonitorStopBits, StopBits);
    Cfg.SetValue(Key_SerialMonitorFlowControl, FlowControl);

    Cfg.SetValue(Key_SerialMonitorTimeOut, TimeOut);
    Cfg.SetValue(Key_SerialMonitorTimer, TimerInterval);
  end;
  with Output do begin
    Cfg.SetValue(Key_SerialMonitorLineBreak, LineBreak);
    Cfg.SetValue(Key_SerialMonitorAutoScroll, AutoScroll);
    Cfg.SetValue(Key_SerialMonitorWordWarp, WordWarp);
  end;
  Cfg.Free;
end;

{ TSerialMonitor_Options_Form }

procedure TSerialMonitor_Options_Form.FormCreate(Sender: TObject);
begin
  Caption := Title + 'Serial-Monitor Optionen';
  LoadFormPos_from_XML(Self);

  SM_Interface_Frame := TSM_Interface_Frame.Create(Self);
  SM_Interface_Frame.Parent := Self.TabSheet1;
  SM_Output_Frame := TSM_Output_Frame.Create(Self);
  SM_Output_Frame.Parent := Self.TabSheet2;

  SM_Interface_Frame.ComboBox_Port.Items.CommaText := GetSerialPortNames;
  SM_Interface_Frame.ComboBox_Baud.Items.CommaText := UARTBaudRates;
  SM_Interface_Frame.ComboBox_Parity.Items.CommaText := UARTParitys;
  SM_Interface_Frame.ComboBox_Bits.Items.CommaText := UARTBitss;
  SM_Interface_Frame.ComboBox_StopBits.Items.CommaText := UARTStopBitss;
  SM_Interface_Frame.ComboBox_FlowControl.Items.CommaText := UARTFlowControls;

  SM_Output_Frame.RadioGroup_LineBreak.Items.AddStrings(OutputLineBreaks, True);
end;

procedure TSerialMonitor_Options_Form.FormDestroy(Sender: TObject);
begin
end;

procedure TSerialMonitor_Options_Form.FormHide(Sender: TObject);
begin
  SaveFormPos_to_XML(Self);
end;

procedure TSerialMonitor_Options_Form.Btn_OkClick(Sender: TObject);
begin
  Btn_ApplyClick(Sender);
  Close;
end;

procedure TSerialMonitor_Options_Form.Btn_ApplyClick(Sender: TObject);
begin
  with Serial_Monitor_Form.SerialMonitor_Options do begin
    with Com_Interface do begin
      Port := SM_Interface_Frame.ComboBox_Port.Text;
      Baud := SM_Interface_Frame.ComboBox_Baud.Text;
      Bits := SM_Interface_Frame.ComboBox_Bits.Text;
      Parity := SM_Interface_Frame.ComboBox_Parity.Text;
      StopBits := SM_Interface_Frame.ComboBox_StopBits.Text;
      FlowControl := SM_Interface_Frame.ComboBox_FlowControl.Text;
      TimeOut := SM_Interface_Frame.SpinEdit_TimeOut.Value;
      TimerInterval := SM_Interface_Frame.SpinEdit_TimerInterval.Value;
    end;

    with Output do begin
      LineBreak := SM_Output_Frame.RadioGroup_LineBreak.ItemIndex;
      AutoScroll := SM_Output_Frame.CheckBox_AutoScroll.Checked;
      WordWarp := SM_Output_Frame.CheckBox_WordWarp.Checked;
    end;
    Save_to_XML;
  end;

  Serial_Monitor_Form.CloseSerial;
  Serial_Monitor_Form.OpenSerial;
end;

procedure TSerialMonitor_Options_Form.Btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSerialMonitor_Options_Form.FormShow(Sender: TObject);
begin
  with Serial_Monitor_Form.SerialMonitor_Options do begin
    with Com_Interface do begin
      SM_Interface_Frame.ComboBox_Port.Text := Port;
      SM_Interface_Frame.ComboBox_Baud.Text := Baud;
      SM_Interface_Frame.ComboBox_Bits.Text := Bits;
      SM_Interface_Frame.ComboBox_Parity.Text := Parity;
      SM_Interface_Frame.ComboBox_StopBits.Text := StopBits;
      SM_Interface_Frame.ComboBox_FlowControl.Text := FlowControl;
      SM_Interface_Frame.SpinEdit_TimeOut.Value := TimeOut;
      SM_Interface_Frame.SpinEdit_TimerInterval.Value := TimerInterval;
    end;

    with Output do begin
      SM_Output_Frame.RadioGroup_LineBreak.ItemIndex := LineBreak;
      SM_Output_Frame.CheckBox_AutoScroll.Checked := AutoScroll;
      SM_Output_Frame.CheckBox_WordWarp.Checked := WordWarp;
    end;
  end;
end;

end.
