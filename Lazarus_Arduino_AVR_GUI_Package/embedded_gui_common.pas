unit Embedded_GUI_Common;

interface

type
  TSerialMonitor_Para = record
    Port, Baud: string;
  end;

const
  UARTBaudRates =
    '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';

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

  Key_CPU_Info_Left = 'cpu_info_form_left/value';
  Key_CPU_Info_Top = 'cpu_info_form_top/value';
  Key_CPU_Info_Width = 'cpu_info_form_width/value';
  Key_CPU_Info_Height = 'cpu_info_form_height/value';

  Key_AVR_ProjectOptions_Left = 'avr_project_options_form_left/value';
  Key_AVR_ProjectOptions_Top = 'avr_project_options_form_top/value';
  Key_AVR_ProjectOptions_Width = 'avr_project_options_form_width/value';
  Key_AVR_ProjectOptions_Height = 'avr_project_options_form_height/value';

  Key_AVR_Templates_Left = 'avr_templates_form_left/value';
  Key_AVR_Templates_Top = 'avr_templates_form_top/value';
  Key_AVR_Templates_Width = 'avr_templates_form_width/value';
  Key_AVR_Templates_Height = 'avr_templates_form_height/value';

  Key_ARM_ProjectOptions_Left = 'arm_project_options_form_left/value';
  Key_ARM_ProjectOptions_Top = 'arm_project_options_form_top/value';
  Key_ARM_ProjectOptions_Width = 'arm_project_options_form_width/value';
  Key_ARM_ProjectOptions_Height = 'arm_project_options_form_height/value';

  Key_ARM_Templates_Left = 'arm_templates_form_left/value';
  Key_ARM_Templates_Top = 'arm_templates_form_top/value';
  Key_ARM_Templates_Width = 'arm_templates_form_width/value';
  Key_ARM_Templates_Height = 'arm_templates_form_height/value';


  Key_SerialMonitorPort = 'SerialMonitorPort/value';
  Key_SerialMonitorBaud = 'COM_Port/value';
  Key_SerialMonitor_Left = 'serial_monitor_form_left/value';
  Key_SerialMonitor_Top = 'serial_monitor_form_top/value';
  Key_SerialMonitor_Width = 'serial_monitor_form_width/value';
  Key_SerialMonitor_Height = 'serial_monitor_form_height/value';


implementation

end.
