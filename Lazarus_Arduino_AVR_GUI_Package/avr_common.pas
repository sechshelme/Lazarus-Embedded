unit AVR_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LCLType, Controls,
  ProjectIntf,

  AVR_SubArch_List; // Unit wird von "./Tools/AVR_List_to_const" generiert.

const
  AVR_Options_File = 'avroptions.xml';

  AVR_UARTBaudRates = '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';

  Key_ProjectOptions_Left = 'project_options_form_left/value';
  Key_ProjectOptions_Top = 'project_options_form_top/value';

  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';

type
  TAVROptions = record
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
  TemplatesPara: array of TAVROptions = ((
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

type

  { TProjectOptions }

  TProjectOptions = class
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

var
  ProjectOptions: TProjectOptions;


function GetSerialPortNames: string;


implementation


{$IFDEF MSWINDOWS}
uses
  registry;


function GetSerialPortNames: string;
var
  reg: TRegistry;
  l, v: TStringList;
  n: integer;
begin
  l := TStringList.Create;
  v := TStringList.Create;
  reg := TRegistry.Create;
  try
{$IFNDEF VER100}
{$IFNDEF VER120}
    reg.Access := KEY_READ;
{$ENDIF}
{$ENDIF}
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('\HARDWARE\DEVICEMAP\SERIALCOMM', False);
    reg.GetValueNames(l);
    for n := 0 to l.Count - 1 do begin
      v.Add(PChar(reg.ReadString(l[n])));
    end;
    Result := v.CommaText;
  finally
    reg.Free;
    l.Free;
    v.Free;
  end;
end;

{$ELSE}
//{$IFNDEF MSWINDOWS}
uses
  BaseUnix;

function GetSerialPortNames: string;
type
  TSerialStruct = packed record
    typ: Integer;
    line: Integer;
    port: Cardinal;
    irq: Integer;
    flags: Integer;
    xmit_fifo_size: Integer;
    custom_divisor: Integer;
    baud_base: Integer;
    close_delay: Word;
    io_type: Char;
    reserved_char: Char;
    hub6: Integer;
    closing_wait: Word; // time to wait before closing
    closing_wait2: Word; // no longer used...
    iomem_base: ^Char;
    iomem_reg_shift: Word;
    port_high: Cardinal;
    iomap_base: LongWord; // cookie passed into ioremap
  end;

var
  i: Integer;
  sr : TSearchRec;
  sl: TStringList;
  st: stat;
  s: String;
  fd: PtrInt;
  Ser : TSerialStruct;

const
  TIOCGSERIAL = $541E;
  PORT_UNKNOWN = 0;

begin
  Result := '';
  sl := TStringList.Create;
  try
    // 1. Alle möglichen Ports finden
    if FindFirst('/sys/class/tty/*', LongInt($FFFFFFFF), sr) = 0 then begin
      repeat
        if (sr.Name <> '.') and (sr.Name <> '..') Then
          if (sr.Attr and LongInt($FFFFFFFF)) = Sr.Attr then
            sl.Add(sr.Name);
      until FindNext(sr) <> 0;
    end;
    FindClose(sr);
    // 2. heraussuchen ob ./device/driver vorhanden ist
    for i := sl.Count - 1 Downto 0 Do Begin
      If Not DirectoryExists('/sys/class/tty/' + sl[i] + '/device/driver') Then
        sl.Delete(i); // Nicht vorhanden >> Port existiert nicht
    end;
    // 3. Herausfinden welcher Treiber
    st.st_mode := 0;
    for i := sl.Count - 1 Downto 0 Do Begin
      IF fpLstat('/sys/class/tty/' + sl[i] + '/device', st) = 0 Then Begin
        if fpS_ISLNK(st.st_mode) Then
        Begin
          s := fpReadLink('/sys/class/tty/' + sl[i] + '/device/driver');
          s := ExtractFileName(s);
          // 4. Bei serial8250 Treiber muss der Port geprüft werden
          if s = 'serial8250' then begin
            sl.Objects[i] := TObject(PtrInt(1));
            fd := FpOpen('/dev/' + sl[i], O_RDWR Or O_NONBLOCK Or O_NOCTTY);
            If fd > 0 Then Begin
              If FpIOCtl(fd, TIOCGSERIAL, @Ser) = 0 Then Begin
                If Ser.typ = PORT_UNKNOWN Then // PORT_UNKNOWN
                  sl.Delete(i);
              end;
              FpClose(fd);
            end else sl.Delete(i); // Port kann nicht geöffnet werden
          end;
        End;
      end;
    end;
    // 5. Dev anhängen
    for i := 0 To sl.Count - 1 Do
      sl[i] := '/dev/' + sl[i];
   Result := sl.CommaText;
  finally
    sl.Free;
  end;
end;
{$ENDIF}


{ TProjectOptions }

procedure TProjectOptions.Save(AProject: TLazProject);
var
  pr, s: string;
begin
  with AProject.LazCompilerOptions do begin
    TargetCPU := 'avr';
    TargetOS := 'embedded';
    TargetProcessor := ProjectOptions.AVR_SubArch;

    CustomOptions := '-Wp' + ProjectOptions.AVR_FPC_Typ;
    if ProjectOptions.AsmFile then begin
      CustomOptions := CustomOptions + LineEnding + '-al';
    end;
  end;

  s := ProjectOptions.AvrdudeCommand.Path + ' ';
  if ProjectOptions.AvrdudeCommand.ConfigPath <> '' then begin
    s += '-C' + ProjectOptions.AvrdudeCommand.ConfigPath + ' ';
  end;

  s += '-v ' +
    '-p' + ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ + ' ' +
    '-c' + ProjectOptions.AvrdudeCommand.Programmer + ' ';
  pr := upCase(ProjectOptions.AvrdudeCommand.Programmer);
  if (pr = 'ARDUINO') or (pr = 'STK500V1') or (pr = 'WIRING') then begin
    s += '-P' + ProjectOptions.AvrdudeCommand.COM_Port + ' ' +
      '-b' + ProjectOptions.AvrdudeCommand.Baud + ' ';
  end;

  if ProjectOptions.AvrdudeCommand.Disable_Auto_Erase then begin
    s +='-D ';
  end;
  s += '-Uflash:w:' + AProject.LazCompilerOptions.TargetFilename + '.hex:i';

  AProject.LazCompilerOptions.ExecuteAfter.Command := s;

  AProject.CustomData[Key_SerialMonitorPort] := ProjectOptions.SerialMonitor.Port;
  AProject.CustomData[Key_SerialMonitorBaud] := ProjectOptions.SerialMonitor.Baud;
end;

procedure TProjectOptions.Load(AProject: TLazProject);
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
  ProjectOptions.AVR_SubArch := AProject.LazCompilerOptions.TargetProcessor;

  s := AProject.LazCompilerOptions.CustomOptions;
  ProjectOptions.AsmFile := Pos('-al', s) > 0;
  ProjectOptions.AVR_FPC_Typ := Find(s, '-Wp');

  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
  ProjectOptions.AvrdudeCommand.Path := Copy(s, 0, pos(' ', s) - 1);
  ProjectOptions.AvrdudeCommand.ConfigPath := Find(s, '-C');
  ProjectOptions.AvrdudeCommand.AVR_AVRDude_Typ := Find(s, '-p');
  ProjectOptions.AvrdudeCommand.Programmer := Find(s, '-c');
  ProjectOptions.AvrdudeCommand.COM_Port := Find(s, '-P');
  ProjectOptions.AvrdudeCommand.Baud := Find(s, '-b');
  ProjectOptions.AvrdudeCommand.Disable_Auto_Erase := pos('-D', s) > 0;

  ProjectOptions.SerialMonitor.Port := AProject.CustomData[Key_SerialMonitorPort];
  ProjectOptions.SerialMonitor.Baud := AProject.CustomData[Key_SerialMonitorBaud];
end;

end.


