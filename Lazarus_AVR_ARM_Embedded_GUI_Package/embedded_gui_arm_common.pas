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
      COM_Port: '';
      Baud: '';
      Disable_Auto_Erase: False;
      Chip_Erase: False);
    stlink: (
      FlashBase: '0x080000')));

implementation

end.
