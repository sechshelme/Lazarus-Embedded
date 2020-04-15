unit Embedded_GUI_Common;

interface

uses
  {$IFDEF Komponents}
  BaseIDEIntf, LazConfigStorage,  // Bei Komponente
  {$ELSE}
  IniFiles,  // Bei normalen Anwendungen
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

  Key_Avrdude_Path = 'averdude_pfad/value';
  Key_Avrdude_Conf_Path = 'averdude_conf_pfad/value';
  Key_STFlash_Path = 'stlink_pfad/value';

  {$IFDEF MSWINDOWS}
  Default_Avrdude_Path = 'c:\avrdude\averdude.exe';
  Default_Avrdude_Conf_Path = 'c:\avrdude\avrdude.conf';
  Default_STFlash_Path = 'c:\st-link\st-flash.exe';
  {$ELSE}
  Default_Avrdude_Path = '/usr/bin/avrdude';
  Default_Avrdude_Conf_Path = '/etc/avrdude.conf';
  Default_STFlash_Path = '/usr/local/bin/st-flash';
  {$ENDIF}

  //Key_CPU_Info_Left = 'cpu_info_form_left/value';
  //Key_CPU_Info_Top = 'cpu_info_form_top/value';
  //Key_CPU_Info_Width = 'cpu_info_form_width/value';
  //Key_CPU_Info_Height = 'cpu_info_form_height/value';
  //
  //Key_AVR_ProjectOptions_Left = 'avr_project_options_form_left/value';
  //Key_AVR_ProjectOptions_Top = 'avr_project_options_form_top/value';
  //Key_AVR_ProjectOptions_Width = 'avr_project_options_form_width/value';
  //Key_AVR_ProjectOptions_Height = 'avr_project_options_form_height/value';
  //
  //Key_AVR_Templates_Left = 'avr_templates_form_left/value';
  //Key_AVR_Templates_Top = 'avr_templates_form_top/value';
  //Key_AVR_Templates_Width = 'avr_templates_form_width/value';
  //Key_AVR_Templates_Height = 'avr_templates_form_height/value';
  //
  //Key_ARM_ProjectOptions_Left = 'arm_project_options_form_left/value';
  //Key_ARM_ProjectOptions_Top = 'arm_project_options_form_top/value';
  //Key_ARM_ProjectOptions_Width = 'arm_project_options_form_width/value';
  //Key_ARM_ProjectOptions_Height = 'arm_project_options_form_height/value';
  //
  //Key_ARM_Templates_Left = 'arm_templates_form_left/value';
  //Key_ARM_Templates_Top = 'arm_templates_form_top/value';
  //Key_ARM_Templates_Width = 'arm_templates_form_width/value';
  //Key_ARM_Templates_Height = 'arm_templates_form_height/value';


  Key_SerialMonitorPort = 'SerialMonitorPort/value';
  Key_SerialMonitorBaud = 'COM_Port/value';
  //Key_SerialMonitor_Left = 'serial_monitor_form_left/value';
  //Key_SerialMonitor_Top = 'serial_monitor_form_top/value';
  //Key_SerialMonitor_Width = 'serial_monitor_form_width/value';
  //Key_SerialMonitor_Height = 'serial_monitor_form_height/value';

procedure LoadFormPos(f: TForm);
procedure SaveFormPos(f: TForm);


implementation

procedure LoadFormPos(f: TForm);
var
  {$IFDEF Komponents}
  Cfg: TConfigStorage;
    {$ELSE}
  ini: TIniFile;
    {$ENDIF}
begin
  {$IFDEF Komponents}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  f.Left := StrToInt(Cfg.GetValue('Key_' + f.Name + '_Left/value', '100'));
  f.Top := StrToInt(Cfg.GetValue('Key_' + f.Name + '_Top/value', '50'));
  f.Width := StrToInt(Cfg.GetValue('Key_' + f.Name + '_Width/value', '500'));
  f.Height := StrToInt(Cfg.GetValue('Key_' + f.Name + '_Height/value', '500'));
  Cfg.Free;
    {$ELSE}
    {$ENDIF}
end;

procedure SaveFormPos(f: TForm);
var
{$IFDEF Komponents}
  Cfg: TConfigStorage;
  {$ELSE}
  ini: TIniFile;
  {$ENDIF}
begin
{$IFDEF Komponents}
  Cfg := GetIDEConfigStorage(Embedded_Options_File, True);
  Cfg.SetDeleteValue('Key_' + f.Name + '_Left/value', IntToStr(f.Left), '90');
  Cfg.SetDeleteValue('Key_' + f.Name + '_Top/value', IntToStr(f.Top), '60');
  Cfg.SetDeleteValue('Key_' + f.Name + '_Width/value', IntToStr(f.Width), '300');
  Cfg.SetDeleteValue('Key_' + f.Name + '_Height/value', IntToStr(f.Height), '400');
  Cfg.Free;
  {$ELSE}
  {$ENDIF}
end;

end.
