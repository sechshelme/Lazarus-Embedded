unit Embedded_GUI_Common;

interface

(* Bei "Packages-Inspector/Einstellungen/Compilereinstellungen/Benutzerdefinierte Einstellungen/"
   ist "-dPackages" eingetragen. *)

uses
  {$IFDEF Packages}
  BaseIDEIntf, LazConfigStorage,  // Bei Packages
  {$ELSE}
  XMLConf,  // Bei normalen Anwendungen
  {$ENDIF}
  SysUtils, Controls, Forms;

const
  UARTBaudRates =
    //    '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';
    '50,75,110,134,150,200,300,600,1200,1800,2400,4800,9600,19200,38400,57600,115200,230400,460800';

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

const
  UARTDefaultBaud = '9600';
  UARTDefaultParity = 'none';
  UARTDefaultBits = '8';
  UARTDefaultStopBits = '1';
  UARTDefaultFlowControl = 'none';
  UARTDefaultTimeOut = 10;
  UARTDefaultTimer = 200;

  OutputDefaultLineBreak = 0; // 0 = #10
  OutputDefaultAutoScroll = True;
  OutputDefaultWordWarp = False;

  UARTParitys = 'none,odd,even';
  UARTBitss = '5,6,7,8';
  UARTStopBitss = '1,2';
  UARTFlowControls = 'none,RTS/CTS';

  OutputLineBreaks: TStringArray = ('LF / #10', 'CR / #13', 'CRLF / #13#10');

procedure LoadFormPos(Form: TControl);
procedure SaveFormPos(Form: TControl);

implementation

const
  FormPos = '/FormPos/';

procedure LoadFormPos(Form: TControl);
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
  Form.Left := Cfg.GetValue(Form.Name + FormPos + 'Left', Form.Left);
  Form.Top := Cfg.GetValue(Form.Name + FormPos + 'Top', Form.Top);
  Form.Width := Cfg.GetValue(Form.Name + FormPos + 'Width', Form.Width);
  Form.Height := Cfg.GetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

procedure SaveFormPos(Form: TControl);
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
  Cfg.SetValue(Form.Name + FormPos + 'Left', Form.Left);
  Cfg.SetValue(Form.Name + FormPos + 'Top', Form.Top);
  Cfg.SetValue(Form.Name + FormPos + 'Width', Form.Width);
  Cfg.SetValue(Form.Name + FormPos + 'Height', Form.Height);
  Cfg.Free;
end;

end.
