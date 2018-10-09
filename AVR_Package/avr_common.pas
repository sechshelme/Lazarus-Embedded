unit AVR_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  ProjectIntf;

const
  AVR_Options_File = 'avroptions.xml';
  AVR5_Typ =  // fpcsrc/rtl/embedded/Makefile
    'atmega645,atmega165a,atmega649a,atmega32u4,atmega168p,atmega3250pa,atmega3290a,' +
    'atmega165p,atmega16u4,atmega6490p,atmega324p,atmega328,atmega64m1,atmega645p,' +
    'atmega329a,atmega324pa,atmega32hvb,at90pwm316,at90usb646,atmega16,atmega644,' +
    'at90can64,at90can32,at90pwm216,atmega3250a,atmega3290pa,atmega325p,atmega328p,' +
    'atmega3250,atmega329,atmega32a,atmega6490,atmega168a,atmega164pa,atmega645a,' +
    'atmega3290p,atmega644p,atmega164a,atmega162,atmega32c1,atmega324a,atmega169a,' +
    'atmega644a,atmega3290,atmega64a,atmega169p,atmega32,atmega168pa,atmega16m1,' +
    'atmega16hvb,atmega164p,atmega325a,atmega640,atmega6450,atmega329p,at90usb647,' +
    'atmega168,atmega6490a,atmega32m1,atmega64c1,atmega644pa,atmega325pa,atmega6450a,' +
    'atmega329pa,atmega6450p,atmega64,atmega165pa,atmega16a,atmega649,atmega649p,' +
    'atmega3250p,atmega325,atmega169pa,avrsim';

  AVR_UARTBaudRates = '300,600,1200,2400,9600,14400,19200,38400,57600,76800,115200,230400,250000,500000,1000000,2000000';

  Key_ProjectOptions_Left = 'project_options_form_left/value';
  Key_ProjectOptions_Top = 'project_options_form_top/value';

  Key_SerialMonitorPort = 'SerialMonitorPort';
  Key_SerialMonitorBaud = 'COM_Port';


type

  { TProjectOptions }

  TProjectOptions = class
    AvrdudeCommand: record
      Path,
      ConfigPath,
      Programmer,
      COM_Port,
      Baud: string;
    end;
    AVRType,
    SerialMonitorPort,
    SerialMonitorBaud: string;
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

{$ENDIF}
{$IFNDEF MSWINDOWS}
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
const TIOCGSERIAL = $541E;
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
end;{$ENDIF}


{ TProjectOptions }

procedure TProjectOptions.Save(AProject: TLazProject);
var
  s: string;
begin
  with AProject.LazCompilerOptions do begin
    CustomOptions := '-Wp' + ProjectOptions.AVRType;
    if ProjectOptions.AsmFile then begin
      CustomOptions := CustomOptions + LineEnding + '-al';
    end;
  end;

  s := ProjectOptions.AvrdudeCommand.Path + ' ';
  if ProjectOptions.AvrdudeCommand.ConfigPath <> '' then begin
    s += '-C' + ProjectOptions.AvrdudeCommand.ConfigPath + ' ';
  end;

  s += '-v ' +
    '-p' + ProjectOptions.AVRType + ' ' +
    '-c' + ProjectOptions.AvrdudeCommand.Programmer + ' ';
  if upCase(ProjectOptions.AvrdudeCommand.Programmer) = 'ARDUINO' then begin
    s += '-P' + ProjectOptions.AvrdudeCommand.COM_Port + ' ' +
      '-b' + ProjectOptions.AvrdudeCommand.Baud + ' ';
  end;
  s += '-D -Uflash:w:' + AProject.LazCompilerOptions.TargetFilename + '.hex:i';

  AProject.LazCompilerOptions.ExecuteAfter.Command := s;

  //    avrdude_ComboBox1.Text := 'avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:Project1.hex:i';

  AProject.CustomData[Key_SerialMonitorPort] := ProjectOptions.SerialMonitorPort;
  AProject.CustomData[Key_SerialMonitorBaud] := ProjectOptions.SerialMonitorBaud;
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
  s := AProject.LazCompilerOptions.CustomOptions;
  ProjectOptions.AsmFile := Pos('-al', s) > 0;
  ProjectOptions.AVRType := Find(s, '-Wp');

  s := AProject.LazCompilerOptions.ExecuteAfter.Command;
  ProjectOptions.AvrdudeCommand.Path := Copy(s, 0, pos(' ', s) - 1);
  ProjectOptions.AvrdudeCommand.ConfigPath := Find(s, '-C');
  ProjectOptions.AvrdudeCommand.Programmer := Find(s, '-c');
  ProjectOptions.AvrdudeCommand.COM_Port := Find(s, '-P');
  ProjectOptions.AvrdudeCommand.Baud := Find(s, '-b');

  ProjectOptions.SerialMonitorPort := AProject.CustomData[Key_SerialMonitorPort];
  ProjectOptions.SerialMonitorBaud := AProject.CustomData[Key_SerialMonitorBaud];
end;

end.


