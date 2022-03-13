unit Embedded_GUI_AVR_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Embedded_List_Const; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type
  TAVR_TemplatesPara = record
    Name,
    AVR_SubArch,
    AVR_FPC_Typ,
    AVR_AVRDude_Typ,
    Programmer,
    COM_Port,
    Baud: string;
    BitClock: string;
    Verbose: integer;
    Disable_Auto_Erase,
    Chip_Erase: boolean;
  end;

const
  AVR_TemplatesPara: array of TAVR_TemplatesPara = ((
    Name: 'Arduino UNO';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'arduino';
    COM_Port: '/dev/ttyACM0';
    Baud: '115200';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: False;
    Chip_Erase: False; ), (

    Name: 'Arduino Nano (old Bootloader)';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'arduino';
    COM_Port: '/dev/ttyUSB0';
    Baud: '57600';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: False;
    Chip_Erase: False; ), (

    Name: 'Arduino Nano';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'arduino';
    COM_Port: '/dev/ttyUSB0';
    Baud: '115200';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: False;
    Chip_Erase: False; ), (

    Name: 'Arduino Mega';
    AVR_SubArch: 'AVR6';
    AVR_FPC_Typ: 'atmega2560';
    AVR_AVRDude_Typ: 'atmega2560';
    Programmer: 'wiring';
    COM_Port: '/dev/ttyUSB0';
    Baud: '115200';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: True;
    Chip_Erase: False; ), (

    Name: 'Arduino Nano Every';
    AVR_SubArch: 'AVR6';
    AVR_FPC_Typ: 'atmega4808';
    AVR_AVRDude_Typ: 'atmega4808';
    Programmer: 'jtag2updi';
    COM_Port: '/dev/ttyUSB0';
    Baud: '115200';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: True;
    Chip_Erase: True; ), (

    Name: 'ATmega328P';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'usbasp';
    COM_Port: '';
    Baud: '';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: False;
    Chip_Erase: False; ), (

    Name: 'ATtiny2313A';
    AVR_SubArch: 'AVR25';
    AVR_FPC_Typ: 'attiny2313a';
    AVR_AVRDude_Typ: 'attiny2313';
    Programmer: 'usbasp';
    COM_Port: '';
    Baud: '';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: False;
    Chip_Erase: False; ), (

    Name: 'ATtiny13A';
    AVR_SubArch: 'AVR25';
    AVR_FPC_Typ: 'attiny13a';
    AVR_AVRDude_Typ: 'attiny13';
    Programmer: 'usbasp';
    COM_Port: '';
    Baud: '';
    BitClock: '1';
    Verbose: 1;
    Disable_Auto_Erase: False;
    Chip_Erase: False; ));

implementation

end.
