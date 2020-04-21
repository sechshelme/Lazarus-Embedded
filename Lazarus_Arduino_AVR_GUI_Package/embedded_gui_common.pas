unit Embedded_GUI_Common;

interface

(* Bei "Komponent-Explorer/Einstellungen/Compilereinstellungen/Benutzerdefinierte Einstellungen/"
  ist "-dKomponents" eingetragen. *)

uses
  {$IFDEF Komponents}
  BaseIDEIntf, LazConfigStorage,  // Bei Komponente
  {$ELSE}
  XMLConf,  // Bei normalen Anwendungen
  {$ENDIF}
  SysUtils, Controls, Forms;

const
  UARTBaudRates =
    //    '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';
    '50,75,110,134,150,200,300,600,1200,1800,2400,4800,9600,19200,38400,57600,115200,230400,460800';

  UARTParitys = 'none,odd,even';
  UARTBitss = '5,6,7,8';
  UARTStopBitss = '1,2';
  UARTFlowControls = 'none,RTS/CTS';

  Title = '[Embedded GUI] ';

  Embedded_Systems = 'AVR,ARM,Mips,Riscv32,XTensa';

  Embedded_Options_File = 'embedded_gui_options.xml';

  Key_AVRdude = 'avrdude/';
  Key_STFlash = 'st_flash/';

  Key_Avrdude_Path = Key_AVRdude + 'pfad/value';
  Key_Avrdude_Conf_Path = Key_AVRdude + 'conf_pfad/value';
  Key_STFlash_Path = Key_STFlash + 'pfad/value';

  {$IFDEF MSWINDOWS}
  Default_Avrdude_Path = 'c:\avrdude\avrdude.exe';
  Default_Avrdude_Conf_Path = 'c:\avrdude\avrdude.conf';
  Default_STFlash_Path = 'c:\st-link\st-flash.exe';
  UARTDefaultPort = 'COM8';

  {$ELSE}
  Default_Avrdude_Path = '/usr/bin/avrdude';
  Default_Avrdude_Conf_Path = '/etc/avrdude.conf';
  Default_STFlash_Path = '/usr/local/bin/st-flash';
  UARTDefaultPort = '/dev/ttyUSB0';
  {$ENDIF}

  UARTDefaultBaud = '9600';
  UARTDefaultParity = 'none';
  UARTDefaultBits = '8';
  UARTDefaultStopBits = '1';
  UARTDefaultFlowControl = 'none';
  UARTDefaultTimeOut = 10;
  UARTDefaultTimer = 200;

  Key_SerialMonitorPort = 'SerialMonitor/Port/value';
  Key_SerialMonitorBaud = 'SerialMonitor/Baud/value';
  Key_SerialMonitorParity = 'SerialMonitor/Parity/value';
  Key_SerialMonitorBits = 'SerialMonitor/Bits/value';
  Key_SerialMonitorStopBits = 'SerialMonitor/StopBits/value';
  Key_SerialMonitorFlowControl = 'SerialMonitor/FlowControl/value';
  Key_SerialMonitorTimeOut = 'SerialMonitor/TimeOut/value';
  Key_SerialMonitorTimer = 'SerialMonitor/Timer/value';

procedure LoadFormPos(Form: TControl);
procedure SaveFormPos(Form: TControl);


implementation

procedure LoadFormPos(Form: TControl);
var
  {$IFDEF Komponents}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  {$IFDEF Komponents}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := 'config.xml';
  {$ENDIF}
  Form.Left := Cfg.GetValue(Form.Name+ '/Left/value', Form.Left);
  Form.Top := Cfg.GetValue(Form.Name + '/Top/value', Form.Top);
  Form.Width := Cfg.GetValue(Form.Name + '/Width/value', Form.Width);
  Form.Height := Cfg.GetValue(Form.Name + '/Height/value', Form.Height);
  Cfg.Free;
end;

procedure SaveFormPos(Form: TControl);
var
  {$IFDEF Komponents}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  {$IFDEF Komponents}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  {$ELSE}
  Cfg := TXMLConfig.Create(nil);
  Cfg.Filename := 'config.xml';
  {$ENDIF}
  Cfg.SetValue(Form.Name + '/Left/value', Form.Left);
  Cfg.SetValue(Form.Name + '/Top/value', Form.Top);
  Cfg.SetValue(Form.Name + '/Width/value', Form.Width);
  Cfg.SetValue(Form.Name + '/Height/value', Form.Height);
  Cfg.Free;
end;

end.
