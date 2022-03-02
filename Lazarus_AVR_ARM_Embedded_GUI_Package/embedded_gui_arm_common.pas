unit Embedded_GUI_ARM_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Embedded_List_Const; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type
  TARM_TemplatesPara = record
    Name,
    Arch,
    ARM_SubArch,
    ARM_FPC_Typ,
    Programmer,
    FlashBase: string;
    Create_UF2_File: Boolean;
  end;

const
  ARM_TemplatesPara: array of TARM_TemplatesPara = ((
    Name: 'STM32F103X8';
    Arch: 'ARM';
    ARM_SubArch: 'ARMV7M';
    ARM_FPC_Typ: 'STM32F103X8';
    Programmer: 'st-flash';
    FlashBase: '0x08000000';
    Create_UF2_File: False;), (

    Name: 'Rasberry Pico';
    Arch: 'ARM';
    ARM_SubArch: 'ARMV6M';
    ARM_FPC_Typ: 'RASPI_PICO';
    Programmer: 'uf2';
    FlashBase: '0x00000000';
    Create_UF2_File: True;), (

    Name: 'Arduino DUE';
    Arch: 'ARM';
    ARM_SubArch: 'ARMV7M';
    ARM_FPC_Typ: 'ATSAM3X8E';
    Programmer: 'bossac';
    FlashBase: '0x080000';
    Create_UF2_File: False;));

implementation

end.
