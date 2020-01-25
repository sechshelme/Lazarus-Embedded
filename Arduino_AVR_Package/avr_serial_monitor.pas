unit AVR_Serial_Monitor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  AVR_Common;

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
    Items.CommaText := AVR_UARTBaudRates;
    Text := '9600';
  end;
end;

procedure TSerial_Monitor_Form.ProjectOptionsToMask;
begin
  with SerialMonitorPort_ComboBox do begin
    Text := ProjectOptions.SerialMonitor.Port;
  end;

  with SerialMonitorBaud_ComboBox do begin
    Text := ProjectOptions.SerialMonitor.Baud;
  end;
end;

procedure TSerial_Monitor_Form.MaskToProjectOptions;
begin
    ProjectOptions.SerialMonitor.Port := SerialMonitorPort_ComboBox.Text;
    ProjectOptions.SerialMonitor.Baud := SerialMonitorBaud_ComboBox.Text;
end;

end.

