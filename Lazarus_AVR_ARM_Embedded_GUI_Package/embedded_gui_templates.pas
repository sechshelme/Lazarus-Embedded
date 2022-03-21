unit Embedded_GUI_Templates;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Embedded_List_Const; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

const
  SourceDefault =
    '// Default' + LineEnding + LineEnding +
    'program Project1;' + LineEnding + LineEnding +
    '{$H-,J-,O-}' + LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' + LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until false;' + LineEnding +
    'end.';

// --- AVR

SourceAVRDefault =
  '// Default' + LineEnding + LineEnding +
  'program Project1;' + LineEnding + LineEnding +
  '{$H-,J-,O-}' + LineEnding + LineEnding +
  'uses' + LineEnding +
  '  intrinsics;' + LineEnding + LineEnding +
  'begin' + LineEnding + '  // Setup' + LineEnding +
  '  repeat' + LineEnding +
  '    // Loop;' + LineEnding +
  '  until false;' + LineEnding +
  'end.';

SourceAVRATmega328Blink_Pin_13 =
  '// Blink Pin 13' + LineEnding +
    '' + LineEnding +
  'program Project1;' + LineEnding +
    '' + LineEnding +
  '{$H-,J-,O-}' + LineEnding +
  '' + LineEnding +
  'const' + LineEnding +
  '  BP5 = 5; // Pin 13 des Arduino' + LineEnding +
  '  sl = 20000;' + LineEnding +
  '' + LineEnding +
  '  procedure mysleep(t: int32);' + LineEnding +
  '  var' + LineEnding +
  '    i: Int32;' + LineEnding +
  '  begin' + LineEnding +
  '    for i := 0 to t do begin' + LineEnding +
  '      asm' + LineEnding +
  '               NOP;' + LineEnding +
  '      end;' + LineEnding +
  '    end;' + LineEnding +
  '  end;' + LineEnding +
  '' + LineEnding +
  'begin' + LineEnding +
  '  DDRB := DDRB or (1 shl BP5);' + LineEnding +
  '  repeat' + LineEnding +
  '    PORTB := PORTB or (1 shl BP5);' + LineEnding +
  '    mysleep(sl);' + LineEnding +
  '' + LineEnding +
  '    PORTB := PORTB and not (1 shl BP5);' + LineEnding +
  '    mysleep(sl);' + LineEnding +
  '  until False;' + LineEnding +
  'end.';

  // --- ARM

  SourceARMV7MDefault =
    '// Default' + LineEnding + LineEnding +
    'program Project1;' + LineEnding + LineEnding +
    '{$H-,J-,O-}' +  LineEnding + LineEnding +
    'uses' + LineEnding +
    '  cortexm3;' + LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' + LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until false;' + LineEnding +
    'end.';

  SourceRaspi_PicoDefault =
    '// Default' + LineEnding + LineEnding +
    'program Project1;' + LineEnding + LineEnding +
    '{$MODE OBJFPC}' + LineEnding +
    '{$H-,J-,O-}' + LineEnding +
    '{$MEMORY 10000,10000}' + LineEnding + LineEnding +
    'uses' + LineEnding +
    '  pico_c, ' + LineEnding +
    '  pico_gpio_c,' + LineEnding +
    '  pico_adc_c,' + LineEnding +
    '  pico_clocks_c,' + LineEnding +
    '  pico_uart_c,' + LineEnding +
    '  pico_i2c_c,' + LineEnding +
    '  pico_pio_c,' + LineEnding +
    '  pico_spi_c,' + LineEnding +
    '  pico_timer_c,' + LineEnding +
    '  pico_time_c;' + LineEnding + LineEnding +
    'begin' + LineEnding +
    '  // Setup' + LineEnding +
    '  repeat' + LineEnding +
    '    // Loop;' + LineEnding +
    '  until false;' + LineEnding +
    'end.';


type
  TTemplatesPara = record
    Name,
    Arch,
    SubArch,
    Controller : string;
    Examples: TStringArray;
    Programmer: string;
    avrdude: record
      Controller,
      Programmer,
      COM_Port,
      Baud: string;
      Disable_Auto_Erase,
      Chip_Erase: boolean;
    end;
    stlink: record
      FlashBase: string;
    end;
  end;


const
  TemplatesPara: array of TTemplatesPara = ((

// --- AVR

    Name: 'Arduino UNO';
    Arch: 'avr';
    SubArch: 'AVR5';
    Controller: 'atmega328p';
    Examples: (SourceAVRDefault, SourceAVRATmega328Blink_Pin_13);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'atmega328p';
      Programmer: 'arduino';
      COM_Port: '/dev/ttyACM0';
      Baud: '115200';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '')), (

    Name: 'Arduino Nano (old Bootloader)';
    Arch: 'avr';
    SubArch: 'AVR5';
    Controller: 'atmega328p';
    Examples: (SourceAVRDefault, SourceAVRATmega328Blink_Pin_13);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'atmega328p';
      Programmer: 'arduino';
      COM_Port: '/dev/ttyUSB0';
      Baud: '57600';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '')), (

    Name: 'Arduino Nano';
    Arch: 'avr';
    SubArch: 'AVR5';
    Controller: 'atmega328p';
    Examples: (SourceAVRDefault, SourceAVRATmega328Blink_Pin_13);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'atmega328p';
      Programmer: 'arduino';
      COM_Port: '/dev/ttyUSB0';
      Baud: '115200';
      Disable_Auto_Erase: False;
      Chip_Erase: False; );
    stlink: (
      FlashBase: '')), (

    Name: 'Arduino Mega';
    Arch: 'avr';
    SubArch: 'AVR6';
    Controller: 'atmega2560';
    Examples: (SourceAVRDefault);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'atmega2560';
      Programmer: 'wiring';
      COM_Port: '/dev/ttyUSB0';
      Baud: '115200';
      Disable_Auto_Erase: True;
      Chip_Erase: False; );
    stlink: (
      FlashBase: '')), (

    Name: 'Arduino Nano Every';
    Arch: 'avr';
    SubArch: 'AVR6';
    Controller: 'atmega4808';
    Examples: (SourceAVRDefault);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'atmega4808';
      Programmer: 'jtag2updi';
      COM_Port: '/dev/ttyUSB0';
      Baud: '115200';
      Disable_Auto_Erase: True;
      Chip_Erase: True; );
    stlink: (
      FlashBase: '')), (

    Name: 'ATmega328P';
    Arch: 'avr';
    SubArch: 'AVR5';
    Controller: 'atmega328p';
    Examples: (SourceAVRDefault, SourceAVRATmega328Blink_Pin_13);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'atmega328p';
      Programmer: 'usbasp';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False; );
    stlink: (
      FlashBase: '')), (

    Name: 'ATtiny2313A';
    Arch: 'avr';
    SubArch: 'AVR25';
    Controller: 'attiny2313a';
    Examples: (SourceAVRDefault);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'attiny2313';
      Programmer: 'usbasp';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False; );
    stlink: (
      FlashBase: '')), (

    Name: 'ATtiny13A';
    Arch: 'avr';
    SubArch: 'AVR25';
    Controller: 'attiny13a';
    Examples: (SourceAVRDefault);
    Programmer: 'avrdude';
    avrdude: (
      Controller: 'attiny13';
      Programmer: 'usbasp';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False; );
    stlink: (
      FlashBase: '')), (

  // --- ARM

    Name: 'STM32F103X8';
    Arch: 'arm';
    SubArch: 'ARMV7M';
    Controller: 'STM32F103X8';
    Examples: (SourceARMV7MDefault);
    Programmer: 'st-flash';
    avrdude: (
      Controller: '';
      Programmer: '';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '0x08000000')
      ), (

    Name: 'Rasberry Pico';
    Arch: 'arm';
    SubArch: 'ARMV6M';
    Controller: 'RASPI_PICO';
    Examples: (SourceRaspi_PicoDefault);
    Programmer: 'uf2';
    avrdude: (
      Controller: '';
      Programmer: '';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '0x00000000')), (

    Name: 'Arduino DUE';
    Arch: 'arm';
    SubArch: 'ARMV7M';
    Controller: 'ATSAM3X8E';
    Examples: (SourceDefault);
    Programmer: 'bossac';
    avrdude: (
      Controller: '';
      Programmer: '';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '0x080000')));

implementation

end.
