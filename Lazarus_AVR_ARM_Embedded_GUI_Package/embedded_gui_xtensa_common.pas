unit Embedded_GUI_Xtensa_Common;

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
    Xtensa_SubArch,
    Xtensa_FPC_Typ,
    FlashBase: string;
  end;

const
  ARM_TemplatesPara: array of TARM_TemplatesPara = ((
    Name: 'ESP32';
    Xtensa_SubArch: 'freertos';
    Xtensa_FPC_Typ: 'lx6';
    FlashBase: '0x08000000'; ), (

    Name: 'ESP8266';
    Xtensa_SubArch: 'freertos';
    Xtensa_FPC_Typ: 'lx106';
    FlashBase: '0x080000'));

implementation

end.

