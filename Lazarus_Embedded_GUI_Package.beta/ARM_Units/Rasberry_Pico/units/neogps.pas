unit neogps;

{$mode ObjFPC}{$H+}
{$SCOPEDENUMS ON}
interface

type
  TGPSStatusCode=(INITIALIZING,SERIALDETECTED,GPSDETECTED,POSITIONFIX);
  TGPSGPRMCField=(UTCTime=1,Status,Lattitude,LattitudeIndicator,Longgitude,LongitudeIndicator,Speed,Course,UTCDate,MagneticVariation,MagneticVariationIndicator,Mode);
  TGPSGPGGAField=(UTCTime=1,Lattitude,LattitudeIndicator,Longgitude,LongitudeIndicator,Status,SatellitesUsed,HDOP,MSLAttitude,MSLAttitudeUnit,GeoIDSeparation,GeoIDSeparationUnit,AgeOfDifferentialCorrections,DiffReferenceStationID);

  TNeoGPS = object
  private
    fpUart : ^TUART_Registers;
    fStatus : TGPSStatusCode;
    fGPRMC : string;
    fGPGGA : string;
    //fGPVTG : string;
    fUTCDateTime : TDateTime;
    function getFieldByIndex(constref source : string;index : byte):string;
    function EncodeDate(Year,Month,Day : Word) : TDateTime;
    function EncodeTime(Hour, Min, Sec, MSec:word) : TDateTime;
    function getGPRMC(index : TGPSGPRMCField): string;
    function getGPGGA(index : TGPSGPGGAField): string;
    //function getGPVTG(index : byte): string;
  public
    (*
  Initialise the connection to the GPS
  Must be called before other functions.
param
  uart UART instance. uart0 or uart1
  baudrate Baudrate of UART in Hz
    *)
    constructor init(var uart : TUART_Registers;BaudRate:longWord=9600);
    (*
  Waits for a block of GPS data for one second and when successfull stores GPS data and Status
  This routine must be called on a regular basis to keep GPS data up to date.
    *)
    procedure poll;
    (*
  Gets the UTCTime as received by the GPS on last poll for data.
  The time is only updated after a successful poll for data.
return
  The current UTC date/time as TDateTime. When GPS Data has not yet been received 0 is returned.
    *)
    function getUTCDateTime : TDateTime;
    (*
  Returns the Latitude Information.
  The latitude is only updated after a successful poll for data.
return
  The current latitude as Real. When GPS Data has not yet been received 0 is returned.
    *)
    function getLatitude: Real;
    (*
  Returns the Longitude Information.
  The longitude is only updated after a successful poll for data.
return
  The current longitude as Real. When GPS Data has not yet been received 0 is returned.
    *)
    function getLongitude: Real;
    (*
  Returns the Speed Information im km/h unit.
  The speed is only updated after a successful poll for data.
return
  The current speed as Real. When GPS Data has not yet been received 0 is returned.
    *)
    function getSpeed: Real;
    (*
  Returns the Course Information im Degrees.
  The Couse is only updated after a successful poll for data.
return
  The current course as Real. When GPS Data has not yet been received or the device is stationary 0 is returned.
    *)
    function getCourse: Real;
    (*
  Returns the Altitude over sealevel Information in meters.
  The altitude is only updated after a successful poll for data.
return
  The current altitude as Real. When GPS Data has not yet been received 0 is returned.
    *)
    function getAltitude: Real;
    (*
  Returns the Number of Satellites used.
  The number is only updated after a successful poll for data.
return
  The current number as a byte. When GPS Data has not yet been received 0 is returned, maximum number of Satellites returned is 12
    *)
    function getSatellitesUsed: Byte;
    (*
  Low level Property that allows to read out the txt fields returned by the $GPRMC command.
  The property is only updated after a successful poll for data.
param
  The index of data to be extracted from $GPRMC. Fields are coded in TGPSGPRMCField type
return
  A string containing the content of the requested field. When there is no fix available an empty string is returned
    *)
    property GPRMC[index : TGPSGPRMCField] : string read getGPRMC;
    (*
  Low level Property that allows to read out the txt fields returned by the $GPGGA command.
  The property is only updated after a successful poll for data.
param
  The index of data to be extracted from $GPGGA. Fields are coded in TGPSGPGAAField type
return
  A string containing the content of the requested field. When there is no fix available an empty string is returned
    *)
    property GPGGA[index : TGPSGPGGAField] : string read getGPGGA;
    //property GPVTG[index : byte] : string read getGPVTG;
    (*
  Property that refects the current status of the connection to the GPS
  The property is only updated after a successful poll for data.
return
  A TGPSStatusCode which can be INITIALIZING,SERIALDETECTED,GPSDETECTED,POSITIONFIX
    *)
    property status : TGPSStatusCode read fStatus;
  end;

implementation
uses
  pico_uart_c;

// Usuall you will not need to use the Date/Time Info from GPS. So we extract date routines from sysutils to
// make it possible to ignore dependency to (very big) sysutils unit
// This code was taken from objpas/sysutils/dati.inc and simplified a small bit

{$PUSH}
{$WARN 4035 off : Mixing signed expressions and longwords gives a 64bit result}
{$WARN 4079 off : Converting the operands to "$1" before doing the add could prevent overflow errors.}
Function TNeoGPS.EncodeDate(Year,Month,Day : Word) : TDateTime;
var
  c, ya: Cardinal;
begin
  if month > 2 then
   Dec(Month,3)
  else
   begin
     Inc(Month,9);
     Dec(Year);
   end;
  c:= Year DIV 100;
  ya:= Year - 100*word(c);
  Result := cardinal(146097*c) SHR 2 + cardinal(1461*ya) SHR 2 + (153*cardinal(Month)+2) DIV 5 + cardinal(Day);
  // Note that this line can't be part of the line above, since TDateTime is
  // signed and c and ya are not
  Result := Result - 693900;
end;
{$POP}

{$PUSH}
{$WARN 4035 off : Mixing signed expressions and longwords gives a 64bit result}
{$WARN 4081 off : Converting the operands to "$1" before doing the multiply could prevent overflow errors.}
function TNeoGPS.EncodeTime(Hour, Min, Sec, MSec:word) : TDateTime;
const
  MSecsPerDay=24*60*60*1000;
begin
  Result:=TDateTime(Hour*3600000+Min*60000+Sec*1000+MSec)/MSecsPerDay;
end;
{$POP}

constructor TNeoGPS.init(var uart : TUART_Registers;Baudrate : longWord=9600);
begin
  fpUart := @uart;
  uart_set_baudrate(fpUart^,Baudrate);
  fStatus := TGPSStatusCode.INITIALIZING;
  fGPRMC := '';
  fGPGGA := '';
  //fGPVTG := '';
  fUTCDateTime := 0;
end;

function TNeoGPS.getFieldByIndex(constref source : string;index : byte):string;
var
  pos,lastpos : integer;
  count : byte;
begin
  pos := 1;
  lastpos := 0;
  count := 0;
  result := '';
  repeat
    if (source[pos] = ',') or (source[pos] = '*') then
    begin
      inc(count);
      if count = index then
      begin
        result := copy(source,lastpos+1,pos-1-lastpos);
        break;
      end;
      lastpos := pos;
    end;
    inc(pos);
  until (pos > length(source)) or (count > index);
end;

procedure TNeoGPS.poll;
var
  loopCount : integer;
  c : char;
  line : string;
  code : word;
  checkSum,tmp : byte;
  checkSumDone : byte;
begin
  fStatus := TGPSStatusCode.INITIALIZING;
  checkSum := 0;
  checkSumDone := 0;
  fGPRMC := '';
  fGPGGA := '';
  //fGPVTG := '';
  loopCount := 0;
  repeat
    inc(loopCount);
    if loopCount = 100 then
      exit;
  until uart_is_readable_within_us(fpUart^,10000);
  fStatus := TGPSStatusCode.SERIALDETECTED;
  line := '';
  while uart_is_readable_within_us(fpUart^,10000) do
  begin
    c := uart_getc(fpUart^);
    if c=#10 then
      continue;
    if c='*' then
      checkSumDone := checkSum;
    if c='$' then
    begin
      line := '$';
      checkSum := 0;
      checkSumDone := 0;
      continue;
    end;
    if c = #13 then
    begin
      tmp := pos('*',line);
      if tmp > 0 then
        val('$'+copy(line,tmp+1,2),checkSum,code);

      if (tmp < 6) or (code <> 0) or (checkSum <> checkSumDone) then
      begin
        line := '';
        continue;
      end;

      if (pos('$GNRMC,',line) = 1) or (pos('$GPRMC,',line) = 1) then
      begin
        fGPRMC := copy(line,8,length(line)-10)+',';
        fStatus := TGPSStatusCode.GPSDETECTED;
        if getFieldByIndex(fGPRMC,2) = 'V' then
          continue;
        if (getFieldByIndex(fGPRMC,12) = 'A') or (getFieldByIndex(fGPRMC,12) = 'D') then
          fStatus := TGPSStatusCode.POSITIONFIX;
      end;
      if (pos('$GNGGA,',line) = 1) or (pos('$GPGGA,',line) = 1) then
        fGPGGA := copy(line,8,length(line)-10)+',';
      //if (pos('$GNVTG,',line) = 1) or (pos('$GPVTG,',line) = 1) then
      //  fGPVTG := copy(line,8,length(line)-10)+',';
    end;
    line := line + c;
    checksum := checksum xor byte(c);
  end;
end;

{$PUSH}
{$WARN 5027 off : Local variable "$1" is assigned but never used}
function TNeoGPS.getUTCDateTime : TDateTime;
var
  tmpStr : string;
  code : word;
  day,month,year : word;
  hour,minute,second : word;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
  begin
    tmpStr := getFieldByIndex(fGPRMC,1);
    val(copy(tmpStr,1,2),hour,code);
    val(copy(tmpStr,3,2),minute,code);
    val(copy(tmpStr,5,2),second,code);
    tmpStr := getFieldByIndex(fGPRMC,9);
    val(copy(tmpStr,1,2),day,code);
    val(copy(tmpStr,3,2),month,code);
    val(copy(tmpStr,5,2),year,code);
    year := year + 2000;
    result := EncodeTime(hour,minute,second,0)+EncodeDate(Year,Month,Day);
  end;
end;
{$POP}

{$PUSH}
{$WARN 5027 off : Local variable "$1" is assigned but never used}
function TNeoGPS.getLatitude: Real;
var
  tmpStr : String;
  degree,minute,fracminute : word;
  code : byte;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
  begin
    tmpStr := getFieldByIndex(fGPRMC,3);
    val(copy(tmpStr,1,2),degree,code);
    val(copy(tmpStr,3,2),minute,code);
    tmpStr := copy(tmpStr,5,6)+'000000';
    val(copy(tmpStr,1,6),fracminute,code);
    result := degree+(minute*1000000+fracminute)/60000000;
    if getFieldByIndex(fGPRMC,4) = 'S' then
      result := result * -1;
  end;
end;

function TNeoGPS.getSpeed: Real;
var
  code : byte;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    val(GPRMC[TGPSGPRMCField.Speed],result,code);
end;

function TNeoGPS.getCourse: Real;
var
  code : byte;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    val(GPRMC[TGPSGPRMCField.Course],result,code);
end;

function TNeoGPS.getAltitude: Real;
var
  code : byte;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    val(GPGGA[TGPSGPGGAField.MSLAttitude],result,code);
end;

function TNeoGPS.getSatellitesUsed: byte;
var
  code : byte;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    val(GPGGA[TGPSGPGGAField.SatellitesUsed],result,code);
end;
{$POP}

function TNeoGPS.getGPRMC(index : TGPSGPRMCField): string;
begin
  result := '';
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    result := getFieldByIndex(fGPRMC,byte(index));
end;

function TNeoGPS.getGPGGA(index : TGPSGPGGAField): string;
begin
  result := '';
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    result := getFieldByIndex(fGPGGA,byte(index));
end;

(*
function TNeoGPS.getGPVTG(index : byte): string;
begin
  result := '';
  if (index < 1) or (index > 9) then
    exit;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
    result := getFieldByIndex(fGPVTG,index);
end;
*)
{$PUSH}
{$WARN 5027 off : Local variable "$1" is assigned but never used}
function TNeoGPS.getLongitude: Real;
var
  tmpStr : String;
  degree,minute,fracminute : word;
  code : byte;
begin
  result := 0;
  if fStatus >= TGPSStatusCode.POSITIONFIX then
  begin
    tmpStr := getFieldByIndex(fGPRMC,3);
    val(copy(tmpStr,1,2),degree,code);
    val(copy(tmpStr,3,2),minute,code);
    tmpStr := copy(tmpStr,5,6)+'000000';
    val(copy(tmpStr,1,6),fracminute,code);
    result := degree+(minute*1000000+fracminute)/60000000;
    if getFieldByIndex(fGPRMC,6) = 'W' then
      result := result * -1;
  end;
end;
{$POP}
end.

