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
  SysUtils, Forms;

type
  TSerialMonitor_Para = record
    Port, Baud: string;
  end;

const
  UARTBaudRates =
    //    '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';
    '50,75,110,134,150,200,300,600,1200,1800,2400,4800,19200,38400,57600,115200,230400,460800';

  Title = '[Embedded GUI] ';

  Embedded_Systems = 'AVR,ARM,Mips,Riscv32,XTensa';

  Embedded_Options_File = 'embedded_gui_options.xml';

  Key_AVRdude = 'avrdude/';
  Key_STFlash = 'st_flashe/';

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

procedure LoadFormPos(Form: TForm);
procedure SaveFormPos(Form: TForm);


implementation

procedure LoadFormPos(Form: TForm);
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
    Left := StrToInt(Cfg.GetValue(Name + '/Left/value', IntToStr(Left)));
    Top := StrToInt(Cfg.GetValue(Name + '/Top/value', IntToStr(Top)));
    Width := StrToInt(Cfg.GetValue(Name + '/Width/value', IntToStr(Width)));
    Height := StrToInt(Cfg.GetValue(Name + '/Height/value', IntToStr(Height)));
    Cfg.Free;
  end;
end;

procedure SaveFormPos(Form: TForm);
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
    Cfg.SetDeleteValue(Name + '/Left/value', IntToStr(Left), '90');
    Cfg.SetDeleteValue(Name + '/Top/value', IntToStr(Top), '60');
    Cfg.SetDeleteValue(Name + '/Width/value', IntToStr(Width), '300');
    Cfg.SetDeleteValue(Name + '/Height/value', IntToStr(Height), '400');
    Cfg.Free;
  end;
end;

end.
