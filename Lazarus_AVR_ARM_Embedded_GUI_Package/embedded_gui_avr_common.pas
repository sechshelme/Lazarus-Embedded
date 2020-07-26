unit Embedded_GUI_AVR_Common;

{$mode objfpc}{$H+}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,
  Embedded_GUI_Common,
  Embedded_GUI_Embedded_List_Const; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

type

  { TFPCCommand }

  TFPCCommand = record
    AVR_FPC_Typ: string;
    AsmFile: boolean;
    procedure SetPara(s: string);
    function GetPara: string;
  end;

  { TAvrdudeCommand }

  TAvrdudeCommand = record
    Path, ConfigPath, AVR_AVRDude_Typ, Programmer, COM_Port, Baud: string;
    BitClock: string;
    Verbose: integer;
    Disable_Auto_Erase, Chip_Erase: boolean;
    procedure SetPara(s: string);
    function GetPara: string;
  end;


  //{ TAVR_ProjectOptions }
  //
  //TAVR_ProjectOptions = class
  //  AvrdudeCommand: record
  //    Path, ConfigPath, AVR_AVRDude_Typ, Programmer, COM_Port, Baud: string;
  //    BitClock: string;
  //    Verbose: integer;
  //    Disable_Auto_Erase, Chip_Erase: boolean;
  //  end;
  //  AVR_SubArch, AVR_FPC_Typ: string;
  //  AsmFile: boolean;
  //  procedure Save_to_Project(AProject: TLazProject);
  //  procedure Load_from_Project(AProject: TLazProject);
  //end;

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

//var
//  AVR_ProjectOptions: TAVR_ProjectOptions;

implementation

{ TFPCCommand }

procedure TFPCCommand.SetPara(s: string);
begin
  //s := AProject.LazCompilerOptions.CustomOptions;
  AsmFile := Pos('-al', s) > 0;
  AVR_FPC_Typ := FindPara(s, '-Wp');
end;

function TFPCCommand.GetPara: string;
begin
  Result := '-Wp' + AVR_FPC_Typ;
  if AsmFile then begin
    Result += LineEnding + '-al';
  end;
end;

{ TAvrdudeCommand }

procedure TAvrdudeCommand.SetPara(s: string);

  function FindVerbose(Source: string): integer;
  var
    ofs: integer = 1;
    p: integer;
  begin
    Result := 0;
    repeat
      p := pos('-v', Source, ofs);
      if p > 0 then begin
        Inc(Result);
        ofs := p + 2;
      end;
    until p = 0;
  end;

begin
  //AVR_SubArch := AProject.LazCompilerOptions.TargetProcessor;

  Path := Copy(s, 0, pos(' ', s) - 1);
  ConfigPath := FindPara(s, '-C');
  AVR_AVRDude_Typ := FindPara(s, '-p');
  Programmer := FindPara(s, '-c');
  COM_Port := FindPara(s, '-P');
  Baud := FindPara(s, '-b');
  Verbose := FindVerbose(s);
  BitClock := FindPara(s, '-B');
  Disable_Auto_Erase := pos('-D', s) > 0;
  Chip_Erase := pos('-e', s) > 0;
end;

function TAvrdudeCommand.GetPara: string;
var
  pr: string;
  i: integer;
begin
  Result := Path + ' ';
  if ConfigPath <> '' then begin
    Result += '-C' + ConfigPath + ' ';
  end;

  for i := 0 to Verbose - 1 do begin
    Result += '-v ';
  end;

  Result += '-p' + AVR_AVRDude_Typ + ' ' + '-c' + Programmer + ' ';
  pr := upCase(Programmer);
  if (pr = 'ARDUINO') or (pr = 'STK500V1') or (pr = 'WIRING') then begin
    Result += '-P' + COM_Port + ' ' + '-b' + Baud + ' ';
  end;
  if (pr = 'AVR109') then begin
    Result += '-P' + COM_Port + ' ';
  end;

  if BitClock <> '1' then begin
    Result += '-B' + BitClock + ' ';
  end;

  if Disable_Auto_Erase then begin
    Result += '-D ';
  end;

  if Chip_Erase then begin
    Result += '-e ';
  end;

end;

//{ TProjectOptions }
//
//procedure TAVR_ProjectOptions.Save_to_Project(AProject: TLazProject);
//var
//  pr, s: string;
//  i: integer;
//begin
//  s := AvrdudeCommand.Path + ' ';
//  if AvrdudeCommand.ConfigPath <> '' then begin
//    s += '-C' + AvrdudeCommand.ConfigPath + ' ';
//  end;
//
//  for i := 0 to AvrdudeCommand.Verbose - 1 do begin
//    s += '-v ';
//  end;
//
//  s += '-p' + AvrdudeCommand.AVR_AVRDude_Typ + ' ' + '-c' + AvrdudeCommand.Programmer + ' ';
//  pr := upCase(AvrdudeCommand.Programmer);
//  if (pr = 'ARDUINO') or (pr = 'STK500V1') or (pr = 'WIRING') then begin
//    s += '-P' + AvrdudeCommand.COM_Port + ' ' + '-b' + AvrdudeCommand.Baud + ' ';
//  end;
//  if (pr = 'AVR109') then begin
//    s += '-P' + AvrdudeCommand.COM_Port + ' ';
//  end;
//
//  if AvrdudeCommand.BitClock <> '1' then begin
//    s += '-B' + AvrdudeCommand.BitClock + ' ';
//  end;
//
//  if AvrdudeCommand.Disable_Auto_Erase then begin
//    s += '-D ';
//  end;
//
//  if AvrdudeCommand.Chip_Erase then begin
//    s += '-e ';
//  end;
//
//  with AProject.LazCompilerOptions do begin
//    s += '-Uflash:w:' + TargetFilename + '.hex:i';
//    ExecuteAfter.Command := s;
//    TargetCPU := 'avr';
//    TargetOS := 'embedded';
//    TargetProcessor := AVR_SubArch;
//
//    CustomOptions := '-Wp' + AVR_FPC_Typ;
//    if AsmFile then begin
//      CustomOptions := CustomOptions + LineEnding + '-al';
//    end;
//  end;
//
//end;
//
//procedure TAVR_ProjectOptions.Load_from_Project(AProject: TLazProject);
//var
//  s: string;
//
//  function FindVerbose(Source: string): integer;
//  var
//    ofs: integer = 1;
//    p: integer;
//  begin
//    Result := 0;
//    repeat
//      p := pos('-v', Source, ofs);
//      if p > 0 then begin
//        Inc(Result);
//        ofs := p + 2;
//      end;
//    until p = 0;
//  end;
//
//begin
//  AVR_SubArch := AProject.LazCompilerOptions.TargetProcessor;
//
//  s := AProject.LazCompilerOptions.CustomOptions;
//  AsmFile := Pos('-al', s) > 0;
//  AVR_FPC_Typ := FindPara(s, '-Wp');
//
//  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
//  AvrdudeCommand.Path := Copy(s, 0, pos(' ', s) - 1);
//  AvrdudeCommand.ConfigPath := FindPara(s, '-C');
//
//  AvrdudeCommand.AVR_AVRDude_Typ := FindPara(s, '-p');
//  AvrdudeCommand.Programmer := FindPara(s, '-c');
//  AvrdudeCommand.COM_Port := FindPara(s, '-P');
//  AvrdudeCommand.Baud := FindPara(s, '-b');
//  AvrdudeCommand.Verbose := FindVerbose(s);
//  AvrdudeCommand.BitClock := FindPara(s, '-B');
//  AvrdudeCommand.Disable_Auto_Erase := pos('-D', s) > 0;
//  AvrdudeCommand.Chip_Erase := pos('-e', s) > 0;
//end;
//
end.
