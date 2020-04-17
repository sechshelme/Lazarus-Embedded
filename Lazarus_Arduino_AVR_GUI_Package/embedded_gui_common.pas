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
  SysUtils,Controls, Forms;

type
  TSerialMonitor_Para = record
    Port, Baud: string;
  end;

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
  Default_Avrdude_Path = 'c:\avrdude\averdude.exe';
  Default_Avrdude_Conf_Path = 'c:\avrdude\avrdude.conf';
  Default_STFlash_Path = 'c:\st-link\st-flash.exe';
  {$ELSE}
  Default_Avrdude_Path = '/usr/bin/avrdude';
  Default_Avrdude_Conf_Path = '/etc/avrdude.conf';
  Default_STFlash_Path = '/usr/local/bin/st-flash';
  {$ENDIF}

  Key_SerialMonitorPort = 'SerialMonitorPort/value';
  Key_SerialMonitorBaud = 'COM_Port/value';

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
  with Form do begin
    {$IFDEF Komponents}
    Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
    {$ELSE}
    Cfg := TXMLConfig.Create(nil);
    Cfg.Filename := 'config.xml';
    {$ENDIF}
    Left := Cfg.GetValue(WideString(Name) + '/Left/value', Left);
    Top := Cfg.GetValue(WideString(Name) + '/Top/value', Top);
    Width := Cfg.GetValue(WideString(Name) + '/Width/value', Width);
    Height := Cfg.GetValue(WideString(Name) + '/Height/value', Height);
    Cfg.Free;
  end;
end;

procedure SaveFormPos(Form: TControl);
var
  {$IFDEF Komponents}
  Cfg: TConfigStorage;
  {$ELSE}
  Cfg: TXMLConfig;
  {$ENDIF}
begin
  with Form do begin
    {$IFDEF Komponents}
    Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
    {$ELSE}
    Cfg := TXMLConfig.Create(nil);
    Cfg.Filename := 'config.xml';
    {$ENDIF}
    Cfg.SetValue(WideString(Name) + '/Left/value', Left);
    Cfg.SetValue(WideString(Name) + '/Top/value', Top);
    Cfg.SetValue(WideString(Name) + '/Width/value', Width);
    Cfg.SetValue(WideString(Name) + '/Height/value', Height);
    Cfg.Free;
  end;
end;

end.
