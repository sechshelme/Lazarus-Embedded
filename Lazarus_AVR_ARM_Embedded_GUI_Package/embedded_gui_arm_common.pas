unit Embedded_GUI_ARM_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Embedded_List_Const; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type
  TTemplatesPara = record
    Name,
    Arch,
    SubArch,
    Controller,
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
    Name: 'STM32F103X8';
    Arch: 'ARM';
    SubArch: 'ARMV7M';
    Controller: 'STM32F103X8';
    Programmer: 'st-flash';
    avrdude: (
      Controller: '';
      Programmer: '';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '0x08000000')), (

    Name: 'Rasberry Pico';
    Arch: 'ARM';
    SubArch: 'ARMV6M';
    Controller: 'RASPI_PICO';
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
    Arch: 'ARM';
    SubArch: 'ARMV7M';
    Controller: 'ATSAM3X8E';
    Programmer: 'bossac';
    avrdude: (
      Controller: '';
      Programmer: '';
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '0x080000')), (

      Name: 'Arduino UNO';
      Arch: 'AVR';
      SubArch: 'AVR5';
      Controller: 'atmega328p';
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
      Arch: 'AVR';
      SubArch: 'AVR5';
      Controller: 'atmega328p';
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
      Arch: 'AVR';
      SubArch: 'AVR5';
      Controller: 'atmega328p';
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
      Arch: 'AVR';
      SubArch: 'AVR6';
      Controller: 'atmega2560';
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
      Arch: 'AVR';
      SubArch: 'AVR6';
      Controller: 'atmega4808';
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
      Arch: 'AVR';
      SubArch: 'AVR5';
      Controller: 'atmega328p';
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
      Arch: 'AVR';
      SubArch: 'AVR25';
      Controller: 'attiny2313a';
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
      Arch: 'AVR';
      SubArch: 'AVR25';
      Controller: 'attiny13a';
      Programmer: 'avrdude';
      avrdude: (
        Controller: 'attiny13';
        Programmer: 'usbasp';
        COM_Port: '';
        Baud: '';
        Disable_Auto_Erase: False;
        Chip_Erase: False; );
      stlink: (
        FlashBase: '')));

implementation

end.
