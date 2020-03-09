unit Embedded_GUI_Serial_Monitor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,

  Embedded_GUI_Common,
  Embedded_GUI_Find_Comports, Embedded_GUI_AVR_Common;

type

  { TSerial_Monitor_Form }

  TSerial_Monitor_Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SerialMonitorBaud_ComboBox: TComboBox;
    SerialMonitorPort_ComboBox: TComboBox;
  private

  public
    procedure LoadDefaultMask;
    procedure ProjectOptionsToMask;
    procedure MaskToProjectOptions;
  end;

var
  Serial_Monitor_Form: TSerial_Monitor_Form;

implementation

{$R *.lfm}

{ TSerial_Monitor_Form }

procedure TSerial_Monitor_Form.LoadDefaultMask;
begin
  with SerialMonitorPort_ComboBox do begin
    Items.CommaText := GetSerialPortNames;
    Text := '/dev/ttyUSB0';
  end;

  with SerialMonitorBaud_ComboBox do begin
    Items.CommaText := UARTBaudRates;
    Text := '9600';
  end;
end;

procedure TSerial_Monitor_Form.ProjectOptionsToMask;
begin
  with SerialMonitorPort_ComboBox do begin
    Text := AVR_ProjectOptions.SerialMonitor.Port;
  end;

  with SerialMonitorBaud_ComboBox do begin
    Text := AVR_ProjectOptions.SerialMonitor.Baud;
  end;
end;

procedure TSerial_Monitor_Form.MaskToProjectOptions;
begin
    AVR_ProjectOptions.SerialMonitor.Port := SerialMonitorPort_ComboBox.Text;
    AVR_ProjectOptions.SerialMonitor.Baud := SerialMonitorBaud_ComboBox.Text;
end;

end.

