unit Embedded_GUI_AVR_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,

  Embedded_GUI_SubArch_List; // Unit wird von "./Tools/Ebedded_List_to_const" generiert.

const
  AVR_Programmer = 'arduino,usbasp,stk500v1,wiring';
  AVR_UARTBaudRates = '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';

  Key_ProjectOptions_Left = 'project_options_form_left/value';
  Key_ProjectOptions_Top = 'project_options_form_top/value';

  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';

type

  { TAVR_ProjectOptions }

  TAVR_ProjectOptions = class
    AvrdudeCommand: record
      Path,
      ConfigPath,
      AVR_AVRDude_Typ,
      Programmer,
      COM_Port,
      Baud : string;
      Disable_Auto_Erase : Boolean;
    end;
    AVR_SubArch,
    AVR_FPC_Typ: string;
    SerialMonitor: record
      Port, Baud: string;
    end;
    AsmFile: boolean;
    procedure Save(AProject: TLazProject);
    procedure Load(AProject: TLazProject);
  end;

type
  TAVR_TemplatesPara = record
    Name,
    AVR_SubArch,
    AVR_FPC_Typ,
    AVR_AVRDude_Typ,
    Programmer,
    COM_Port,
    Baud : string;
    Disable_Auto_Erase : Boolean;
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
    Disable_Auto_Erase : false;),(

    Name: 'Arduino Nano (old Bootloader)';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'arduino';
    COM_Port: '/dev/ttyUSB0';
    Baud: '57600';
    Disable_Auto_Erase : false;),(

    Name: 'Arduino Nano';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'arduino';
    COM_Port: '/dev/ttyUSB0';
    Baud: '115200';
    Disable_Auto_Erase : false;),(

    Name: 'Arduino Mega';
    AVR_SubArch: 'AVR6';
    AVR_FPC_Typ: 'atmega2560';
    AVR_AVRDude_Typ: 'atmega2560';
    Programmer: 'wiring';
    COM_Port: '/dev/ttyUSB0';
    Baud: '115200';
    Disable_Auto_Erase : true;),(

    Name: 'ATmega328P';
    AVR_SubArch: 'AVR5';
    AVR_FPC_Typ: 'atmega328p';
    AVR_AVRDude_Typ: 'atmega328p';
    Programmer: 'usbasp';
    COM_Port: '';
    Baud: '';
    Disable_Auto_Erase : false;),(

    Name: 'ATtiny2313A';
    AVR_SubArch: 'AVR25';
    AVR_FPC_Typ: 'attiny2313a';
    AVR_AVRDude_Typ: 'attiny2313';
    Programmer: 'usbasp';
    COM_Port: '';
    Baud: '';
    Disable_Auto_Erase : false;),(

    Name: 'ATtiny13A';
    AVR_SubArch: 'AVR25';
    AVR_FPC_Typ: 'attiny13a';
    AVR_AVRDude_Typ: 'attiny13';
    Programmer: 'usbasp';
    COM_Port: '';
    Baud: '';
    Disable_Auto_Erase : false;));

var
  AVR_ProjectOptions: TAVR_ProjectOptions;

implementation

{ TProjectOptions }

procedure TAVR_ProjectOptions.Save(AProject: TLazProject);
var
  pr, s: string;
begin
  with AProject.LazCompilerOptions do begin
    TargetCPU := 'avr';
    TargetOS := 'embedded';
    TargetProcessor := AVR_SubArch;

    CustomOptions := '-Wp' + AVR_FPC_Typ;
    if AsmFile then begin
      CustomOptions := CustomOptions + LineEnding + '-al';
    end;
  end;

  s := AvrdudeCommand.Path + ' ';
  if AvrdudeCommand.ConfigPath <> '' then begin
    s += '-C' + AvrdudeCommand.ConfigPath + ' ';
  end;

  s += '-v ' +
    '-p' + AvrdudeCommand.AVR_AVRDude_Typ + ' ' +
    '-c' + AvrdudeCommand.Programmer + ' ';
  pr := upCase(AvrdudeCommand.Programmer);
  if (pr = 'ARDUINO') or (pr = 'STK500V1') or (pr = 'WIRING') then begin
    s += '-P' + AvrdudeCommand.COM_Port + ' ' +
      '-b' + AvrdudeCommand.Baud + ' ';
  end;

  if AvrdudeCommand.Disable_Auto_Erase then begin
    s +='-D ';
  end;
  s += '-Uflash:w:' + AProject.LazCompilerOptions.TargetFilename + '.hex:i';

  AProject.LazCompilerOptions.ExecuteAfter.Command := s;

  AProject.CustomData[Key_SerialMonitorPort] := SerialMonitor.Port;
  AProject.CustomData[Key_SerialMonitorBaud] := SerialMonitor.Baud;
end;

procedure TAVR_ProjectOptions.Load(AProject: TLazProject);
var
  s: string;

  function Find(const Source, v: string): string;
  var
    p, Index: integer;
  begin
    p := pos(v, Source);
    Result := '';
    if p > 0 then begin
      p += Length(v);
      Index := p;
      while (Index <= Length(Source)) and (s[Index] > #32) do begin
        Result += Source[Index];
        Inc(Index);
      end;
    end;
  end;

begin
  AVR_SubArch := AProject.LazCompilerOptions.TargetProcessor;

  s := AProject.LazCompilerOptions.CustomOptions;
  AsmFile := Pos('-al', s) > 0;
  AVR_FPC_Typ := Find(s, '-Wp');

  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
  AvrdudeCommand.Path := Copy(s, 0, pos(' ', s) - 1);
  AvrdudeCommand.ConfigPath := Find(s, '-C');
  AvrdudeCommand.AVR_AVRDude_Typ := Find(s, '-p');
  AvrdudeCommand.Programmer := Find(s, '-c');
  AvrdudeCommand.COM_Port := Find(s, '-P');
  AvrdudeCommand.Baud := Find(s, '-b');
  AvrdudeCommand.Disable_Auto_Erase := pos('-D', s) > 0;

  SerialMonitor.Port := AProject.CustomData[Key_SerialMonitorPort];
  SerialMonitor.Baud := AProject.CustomData[Key_SerialMonitorBaud];
end;

end.


