unit ds3231_c;
{$MODE OBJFPC}
{$H+}
interface

uses
  pico_c,
  pico_i2c_c;

type
  TDS3231 = object
  var
    FpI2C : ^TI2C_Inst;
    FDeviceAddress : byte;
  public
    (*
  Initialise the ds3231 chip to some safe defaults
  Put the ds3231 hardware into a known state, and enable it. Must be called
  before other functions. By default, alarm interrupts are off and disabled.
  Square Wave Output is also disabled and preset to 1Hz output frequency
param
  i2c Either i2c0 or i2c1
  i2c address of ds3231 (usually $68)
    *)
    constructor Initialize(var I2C : TI2C_Inst;const aDeviceAddress : byte);

    (*
  Gets the current time from the ds3231 chip
return
  current date/time in Pascal TDateTime format if year is <1900 then reading the ds3231 chip failed
    *)
    function getDateTime : TDateTime;

    (*
  Gets the current time from the ds3231 chip
return
  current date/time in TPicoDateTime format if year is <1900 then reading the ds3231 chip failed
    *)
    function getPicoDateTime : TPicoDateTime;

    (*
  Sets the date/time of the ds3231 chip
param
  aDateTime structure of type TPicoDateTime max. supported year is 2099, minimal year is 1900
return
  true if time/date could be set
    *)
    function setDateTime(const aDateTime : TPicoDateTime):boolean;

    (*
  Sets the date/time of the ds3231 chip
param
  aDateTime time to set as Pascal TDateTime
  max supported year is 2099, minimal year is 1900
return
  true if time/date could be set
    *)
    function setDateTime(const aDateTime : TDateTime):boolean;
  end;

implementation
//DateTime functions taken from rtl/objpas/sysutils/dati.inc
//so that we don not need to use (fat) sysutils in cases where TDateTime is not used

type
  TDayTable = array[1..12] of Word;
const
  HoursPerDay = 24;
  MinsPerHour = 60;
  SecsPerMin  = 60;
  MSecsPerSec = 1000;

  MinsPerDay  = HoursPerDay * MinsPerHour;
  //SecsPerHour = SecsPerMin * MinsPerHour;
  SecsPerDay  = MinsPerDay * SecsPerMin;
  MSecsPerDay = SecsPerDay * MSecsPerSec;

  DateDelta = 693594;        // Days between 1/1/0001 and 12/31/1899

  //MinDateTime: TDateTime =  -693593.99999999; { 01/01/0001 12:00:00.000 AM }
  MaxDateTime: TDateTime =  2958465.99999999;  { 12/31/9999 11:59:59.999 PM }

  MonthDays: array [Boolean] of TDayTable =
    ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
     (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));
type
  TTimeStamp = record
    Time: longint;   { Number of milliseconds since midnight }
    Date: longint;   { One plus number of days since 1/1/0001 }
  end;

function DayOfWeek(DateTime: TDateTime): integer;
begin
  Result := 1 + ((Trunc(DateTime) - 1) mod 7);
  If (Result<=0) then
    Inc(Result,7);
end;

function DateTimeToTimeStamp(DateTime: TDateTime): TTimeStamp;
Var
  D : Double;
begin
  D:=DateTime * Single(MSecsPerDay);
  if D<0 then
    D:=D-0.5
  else
    D:=D+0.5;
  result.Time := Abs(Trunc(D)) Mod MSecsPerDay;
  result.Date := DateDelta + Trunc(D) div MSecsPerDay;
end;

function IsLeapYear(Year: Word): boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function ComposeDateTime(Date,Time : TDateTime) : TDateTime;
begin
  if Date < 0 then Result := trunc(Date) - Abs(frac(Time))
  else Result := trunc(Date) + Abs(frac(Time));
end;
{$PUSH}
{$WARN 4081 off : Converting the operands to "$1" before doing the multiply could prevent overflow errors.}
{$WARN 4079 off : Converting the operands to "$1" before doing the add could prevent overflow errors.}

Function TryEncodeDate(Year,Month,Day : Word; Out Date : TDateTime) : Boolean;
var
  c, ya: cardinal;
begin
  Result:=(Year>0) and (Year<10000) and
          (Month in [1..12]) and
          (Day>0) and (Day<=MonthDays[IsleapYear(Year),Month]);
 If Result then
   begin
     if month > 2 then
      Dec(Month,3)
     else
      begin
        Inc(Month,9);
        Dec(Year);
      end;
     c:= Year DIV 100;
     ya:= Year - 100*c;
     Date := (146097*c) SHR 2 + (1461*ya) SHR 2 + (153*cardinal(Month)+2) DIV 5 + cardinal(Day);
     // Note that this line can't be part of the line above, since TDateTime is
     // signed and c and ya are not
     Date := Date - 693900;
   end
end;

function TryEncodeTime(Hour, Min, Sec, MSec:word; Out Time : TDateTime) : boolean;
begin
  Result:=(Hour<24) and (Min<60) and (Sec<60) and (MSec<1000);
  If Result then
    Time:=TDateTime(cardinal(Hour)*3600000+cardinal(Min)*60000+cardinal(Sec)*1000+MSec)/MSecsPerDay;
end;

procedure DecodeDate(Date: TDateTime; out Year, Month, Day: word);
var
  ly,ld,lm,j : cardinal;
begin
  if Date <= -datedelta then  // If Date is before 1-1-1 then return 0-0-0
    begin
    Year := 0;
    Month := 0;
    Day := 0;
    end
  else
    begin
    if Date>0 then
      Date:=Date+1/(msecsperday*2)
    else
      Date:=Date-1/(msecsperday*2);
    if Date>MaxDateTime then
      Date:=MaxDateTime;
//       Raise EConvertError.CreateFmt('%f is not a valid TDatetime encoding, maximum value is %f.',[Date,MaxDateTime]);
    j := pred((longint(Trunc(System.Int(Date))) + 693900) SHL 2);
    ly:= j DIV 146097;
    j:= j - 146097 * cardinal(ly);
    ld := j SHR 2;
    j:=(ld SHL 2 + 3) DIV 1461;
    ld:= (cardinal(ld) SHL 2 + 7 - 1461*j) SHR 2;
    lm:=(5 * ld-3) DIV 153;
    ld:= (5 * ld +2 - 153*lm) DIV 5;
    ly:= 100 * cardinal(ly) + j;
    if lm < 10 then
     inc(lm,3)
    else
      begin
        dec(lm,9);
        inc(ly);
      end;
    year:=ly;
    month:=lm;
    day:=ld;
    end;
end;
{$POP}
procedure DecodeTime(Time: TDateTime; out Hour, Minute, Second, MilliSecond: word);
Var
  l : cardinal;
begin
 l := DateTimeToTimeStamp(Time).Time;
 Hour   := l div 3600000;
 l := l mod 3600000;
 Minute := l div 60000;
 l := l mod 60000;
 Second := l div 1000;
 l := l mod 1000;
 MilliSecond := l;
end;

function byteToBCD(const value : byte) : byte;
begin
  result := ((value div 10) shl 4) + (value mod 10);
end;

function bcdToByte(const value : byte) : byte;
begin
  result := Hi(value)*10+ Lo(value);
end;

constructor TDS3231.Initialize(var I2C : TI2C_Inst;const aDeviceAddress : byte);
begin
  FpI2C := @I2C;
  FDeviceAddress := aDeviceAddress;
  // Set Squarewave outut Frequency to 1Hz, use Squarewave Output for Interrupt
  i2c_write_timeout_us(FpI2C^,FDeviceAddress,[$0E,%00000100],2,true,1000000);
  // Clear Status
  i2c_write_timeout_us(FpI2C^,FDeviceAddress,[$0F,%00000000],2,true,1000000);
end;

function TDS3231.getDateTime : TDateTime;
var
  currentTime : TPicoDateTime;
  tempTime : TDateTime;
begin
  result := 0;
  currentTime := getPicoDateTime;
  if currentTime.year = 0 then
    exit;
  TryEncodeDate(currentTime.year,currentTime.month,currentTime.day,result);
  TryEncodeTime(currentTime.hour,currentTime.min,currentTime.sec,0,tempTime);
  result := ComposeDateTime(result,tempTime);
end;

function TDS3231.getPicoDateTime : TPicoDateTime;
var
  regs : array[0..6] of byte;
begin
{$PUSH}
{$WARN 5060 off : Function result variable does not seem to be initialized}
  fillchar(result,sizeof(result),0);
{$POP}
  //Set Address Pointer to 0
  if i2c_write_timeout_us(FpI2C^,FDeviceAddress,[$00],1,true,1000000) < 0 then
    exit;
  if i2c_read_timeout_us(FpI2C^,FDeviceAddress,regs,7,true,1000000) < 0 then
    exit;
  result.sec := BcdToByte(regs[0]);
  result.min := BcdToByte(regs[1]);
  if (regs[2] and %01000000) <> 0 then
    //am/pm mode
    result.hour := ((regs[2] shr 5) and %1)*12 + ((regs[2] shr 4) and %1)*10 + lo(regs[2])
  else
    result.hour := (hi(regs[2]) and %11)*10 + lo(regs[2]);
  result.dotw := regs[3] - 1;
  result.day := BcdToByte(regs[4]);
  if (regs[5] and %10000000) <> 0 then
    result.year := 2000
  else
    result.year := 1900;
  result.month := BcdToByte(regs[5] and %11111);
  result.year := result.year +  BcdToByte(regs[6]);
end;

function TDS3231.setDateTime(const aDateTime : TPicoDateTime):boolean;
var
  regs : array[0..7] of byte;
begin
  result := false;
  if (aDateTime.year < 1900) or (aDateTime.year > 2099) then
    exit;
  regs[0] := 0; //First Register to write
  regs[1] := byteToBCD(aDateTime.sec);
  regs[2] := byteToBCD(aDateTime.min);
  regs[3] := byteToBCD(aDateTime.hour);
  regs[4] := aDateTime.dotw+1;
  regs[5] := byteToBCD(aDateTime.day);
  regs[6] := byteToBCD(aDateTime.month);

  if aDateTime.year < 2000 then
    regs[7] := byteToBCD(aDateTime.year-1900)
  else
  begin
    regs[6] := regs[6] or %10000000;
    regs[7] := byteToBCD(aDateTime.year-2000);
  end;

  if i2c_write_timeout_us(FpI2C^,FDeviceAddress,regs,sizeof(regs),true,1000000) < 0 then
    exit;
  result := true;
end;

function TDS3231.setDateTime(const aDateTime : TDateTime):boolean;
var
  tempTime : TPicoDateTime;
  _day,_month,_year,_hour,_min,_sec,_msec: word;
begin
  DecodeDate(aDateTime,_year,_month,_day);
  DecodeTime(aDateTime,_hour,_min,_sec,_msec);
  tempTime.year := _year;
  tempTime.month := _month;
  tempTime.day := _day;
  tempTime.dotw:= DayOfWeek(aDateTime)-1;
  tempTime.hour := _hour;
  tempTime.min := _min ;
  tempTime.sec := _sec;
  result := setDateTime(temptime);
end;

end.
