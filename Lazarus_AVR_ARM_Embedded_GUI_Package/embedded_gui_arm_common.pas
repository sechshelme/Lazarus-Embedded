unit Embedded_GUI_ARM_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Embedded_List_Const;
// Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type
  TARM_TemplatesPara = record
    Name,
    ARM_SubArch,
    ARM_FPC_Typ,
    FlashBase: string;
  end;

const
  ARM_TemplatesPara: array of TARM_TemplatesPara = ((
    Name: 'STM32F103X8';
    ARM_SubArch: 'ARMV7M';
    ARM_FPC_Typ: 'STM32F103X8';
    FlashBase: '0x08000000'; ), (

    Name: 'Rasberry Pico';
    ARM_SubArch: 'ARMV6M';
    ARM_FPC_Typ: 'RASPI_PICO';
    FlashBase: '0x00000000'; ), (

    Name: 'Arduino DUE';
    ARM_SubArch: 'ARMV7M';
    ARM_FPC_Typ: 'ATSAM3X8E';
    FlashBase: '0x080000'));

implementation

end.
