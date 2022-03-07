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
    Programmer,

    COM_Port,
    Baud: string;
    Disable_Auto_Erase,
    Chip_Erase: boolean;

    FlashBase: string;
  end;


type
  TAVR_TemplatesPara = record
    Name,
    AVR_SubArch,
    AVR_FPC_Typ,
    AVR_AVRDude_Typ,
    Programmer,
    COM_Port,
    Baud: string;
    Disable_Auto_Erase,
    Chip_Erase: boolean;
  end;


//const
//  NewTemplatesPara: TStringArray = (
//    'caption:STM32F103X8;arch:ARM;subarch:ARMV7M;controller:STM32F103X8;programmer:st-flash;flashbase:0x08000000;',
//    'caption:Rasberry Pico;arch:ARM;subarch:ARMV6M;controller:RASPI_PICO;programmer:uf2;uf2:true',
//    'caption:Arduino DUE;arch:ARM;subarch:ARMV7M;controller:ATSAM3X8E;programmer:bossac;flashbase:0x080000;'
//    );

//const
//  TemplatesPara: array of TTemplatesPara = ((
//    Name: 'STM32F103X8';
//    Arch: 'ARM';
//    ARM_SubArch: 'ARMV7M';
//    ARM_FPC_Typ: 'STM32F103X8';
//    Programmer: 'st-flash';
//    FlashBase: '0x08000000';
//    Create_UF2_File: False; ), (
//
//    Name: 'Rasberry Pico';
//    Arch: 'ARM';
//    ARM_SubArch: 'ARMV6M';
//    ARM_FPC_Typ: 'RASPI_PICO';
//    Programmer: 'uf2';
//    FlashBase: '0x00000000';
//    Create_UF2_File: True; ), (
//
//    Name: 'Arduino DUE';
//    Arch: 'ARM';
//    ARM_SubArch: 'ARMV7M';
//    ARM_FPC_Typ: 'ATSAM3X8E';
//    Programmer: 'bossac';
//    FlashBase: '0x080000';
//    Create_UF2_File: False; ));
const
  TemplatesPara: array of TTemplatesPara = ((
    Name: 'STM32F103X8';
    Arch: 'ARM';
    SubArch: 'ARMV7M';
    Controller: 'STM32F103X8';
    Programmer: 'st-flash';
    COM_Port: '';
    Baud: '';
    Disable_Auto_Erase:False;
    Chip_Erase: False;
    FlashBase: '0x08000000';),(

    Name: 'Rasberry Pico';
    Arch: 'ARM';
    SubArch: 'ARMV6M';
    Controller: 'RASPI_PICO';
    Programmer: 'uf2';
    COM_Port: '';
    Baud: '';
    Disable_Auto_Erase:False;
    Chip_Erase: False;
    FlashBase: '0x00000000';), (

    Name: 'Arduino DUE';
    Arch: 'ARM';
    SubArch: 'ARMV7M';
    Controller: 'ATSAM3X8E';
    Programmer: 'bossac';
    COM_Port: '';
    Baud: '';
    Disable_Auto_Erase:False;
    Chip_Erase: False;
    FlashBase: '0x080000';));

//function FindTemplateCaption: string;

implementation

//function FindTemplateCaption: string;
//var
//  s: string;
//  i, p: integer;
//begin
//  Result := '';
//  for i := 0 to Length(NewTemplatesPara) - 1 do begin
//    s := NewTemplatesPara[i];
//    p := Pos(';', s);
//    s := Copy(s, 9, p - 9);
//    Result += s + ',';
//  end;
//  Delete(Result, Length(Result), 1);
//end;

end.
