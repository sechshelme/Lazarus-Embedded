
{==============================================================================|
| Project : Ararat Synapse                                       | 007.006.001 |
|==============================================================================|
| Content: Serial port support                                                 |
|==============================================================================|
| Copyright (c)2001-2017, Lukas Gebauer                                        |
| All rights reserved.                                                         |
|                                                                              |
| Redistribution and use in source and binary forms, with or without           |
| modification, are permitted provided that the following conditions are met:  |
|                                                                              |
| Redistributions of source code must retain the above copyright notice, this  |
| list of conditions and the following disclaimer.                             |
|                                                                              |
| Redistributions in binary form must reproduce the above copyright notice,    |
| this list of conditions and the following disclaimer in the documentation    |
| and/or other materials provided with the distribution.                       |
|                                                                              |
| Neither the name of Lukas Gebauer nor the names of its contributors may      |
| be used to endorse or promote products derived from this software without    |
| specific prior written permission.                                           |
|                                                                              |
| THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  |
| AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    |
| IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   |
| ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR  |
| ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL       |
| DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR   |
| SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER   |
| CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT           |
| LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    |
| OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH  |
| DAMAGE.                                                                      |
|==============================================================================|
| The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
| Portions created by Lukas Gebauer are Copyright (c)2001-2017.                |
| All Rights Reserved.                                                         |
|==============================================================================|
| Contributor(s):                                                              |
|  (c)2002, Hans-Georg Joepgen (cpom Comport Ownership Manager and bugfixes)   |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================}


// Die ist eine modifizierte Version von "synaser.pas" 13.04.2020


{$mode objfpc} {$H+,$Q-,$M+}

{$IFDEF MSWINDOWS}
  {$ASMMODE intel}
{$ENDIF}

unit Modifed_Synaser;

interface

uses
{$IFNDEF MSWINDOWS}
  termio, baseunix, unix,
{$ELSE}
  Windows, registry,
  winver,
{$ENDIF}
  Classes, SysUtils;

const
  CR = #$0d;
  LF = #$0a;
  CRLF = CR + LF;
  cSerialChunk = 8192;

  LockfileDirectory = '/var/lock'; {HGJ}
  PortIsClosed = -1;               {HGJ}
  ErrAlreadyOwned = 9991;          {HGJ}
  ErrAlreadyInUse = 9992;          {HGJ}
  ErrWrongParameter = 9993;        {HGJ}
  ErrPortNotOpen = 9994;           {HGJ}
  ErrNoDeviceAnswer =  9995;       {HGJ}
  ErrMaxBuffer = 9996;
  ErrTimeout = 9997;
  ErrNotRead = 9998;
  ErrFrame = 9999;
  ErrOverrun = 10000;
  ErrRxOver = 10001;
  ErrRxParity = 10002;
  ErrTxFull = 10003;

  dcb_Binary = $00000001;
  dcb_ParityCheck = $00000002;
  dcb_OutxCtsFlow = $00000004;
  dcb_OutxDsrFlow = $00000008;
  dcb_DtrControlMask = $00000030;
  dcb_DtrControlDisable = $00000000;
  dcb_DtrControlEnable = $00000010;
  dcb_DtrControlHandshake = $00000020;
  dcb_DsrSensivity = $00000040;
  dcb_TXContinueOnXoff = $00000080;
  dcb_OutX = $00000100;
  dcb_InX = $00000200;
  dcb_ErrorChar = $00000400;
  dcb_NullStrip = $00000800;
  dcb_RtsControlMask = $00003000;
  dcb_RtsControlDisable = $00000000;
  dcb_RtsControlEnable = $00001000;
  dcb_RtsControlHandshake = $00002000;
  dcb_RtsControlToggle = $00003000;
  dcb_AbortOnError = $00004000;
  dcb_Reserveds = $FFFF8000;

  {:stopbit value for 1 stopbit}
  SB1 = 0;
  {:stopbit value for 1.5 stopbit}
  SB1andHalf = 1;
  {:stopbit value for 2 stopbits}
  SB2 = 2;

{$IFNDEF MSWINDOWS}
const
  INVALID_HANDLE_VALUE = THandle(-1);
  CS7fix = $0000020;

type
  TDCB = record
    DCBlength: DWORD;
    BaudRate: DWORD;
    Flags: Longint;
    wReserved: Word;
    XonLim: Word;
    XoffLim: Word;
    ByteSize: Byte;
    Parity: Byte;
    StopBits: Byte;
    XonChar: CHAR;
    XoffChar: CHAR;
    ErrorChar: CHAR;
    EofChar: CHAR;
    EvtChar: CHAR;
    wReserved1: Word;
  end;
  PDCB = ^TDCB;

const
{$IFDEF UNIX}
  {$IFDEF BSD}
  MaxRates = 18;  //MAC
  {$ELSE}
   MaxRates = 30; //UNIX
  {$ENDIF}
{$ELSE}
  MaxRates = 19;  //WIN
{$ENDIF}
  Rates: array[0..MaxRates, 0..1] of cardinal =
  (
    (0, B0),
    (50, B50),
    (75, B75),
    (110, B110),
    (134, B134),
    (150, B150),
    (200, B200),
    (300, B300),
    (600, B600),
    (1200, B1200),
    (1800, B1800),
    (2400, B2400),
    (4800, B4800),
    (9600, B9600),
    (19200, B19200),
    (38400, B38400),
    (57600, B57600),
    (115200, B115200),
    (230400, B230400)
{$IFNDEF BSD}
    ,(460800, B460800)
  {$IFDEF UNIX}
    ,(500000, B500000),
    (576000, B576000),
    (921600, B921600),
    (1000000, B1000000),
    (1152000, B1152000),
    (1500000, B1500000),
    (2000000, B2000000),
    (2500000, B2500000),
    (3000000, B3000000),
    (3500000, B3500000),
    (4000000, B4000000)
  {$ENDIF}
{$ENDIF}
    );
{$ENDIF}

{$IFDEF BSD}
const // From fcntl.h
  O_SYNC = $0080;  { synchronous writes }
{$ENDIF}

const
  sOK = 0;
  sErr = integer(-1);

type

  {:Possible status event types for @link(THookSerialStatus)}
  THookSerialReason = (
    HR_SerialClose,
    HR_Connect,
    HR_CanRead,
    HR_CanWrite,
    HR_ReadCount,
    HR_WriteCount,
    HR_Wait
    );

  {:procedural prototype for status event hooking}
  THookSerialStatus = procedure(Sender: TObject; Reason: THookSerialReason;
    const Value: string) of object;

  {:@abstract(Exception type for SynaSer errors)}
  ESynaSerError = class(Exception)
  public
    ErrorCode: integer;
    ErrorMessage: string;
  end;


 {:@abstract(Main class implementing all communication routines)}
  TBlockSerial = class(TObject)
  protected
    FOnStatus: THookSerialStatus;
    Fhandle: THandle;
    FTag: integer;
    FDevice: string;
    FLastError: integer;
    FLastErrorDesc: string;
    FBuffer: AnsiString;
    FRaiseExcept: boolean;
    FRecvBuffer: integer;
    FSendBuffer: integer;
    FModemWord: integer;
    FRTSToggle: Boolean;
    FDeadlockTimeout: integer;
    FInstanceActive: boolean;
    FTestDSR: Boolean;
    FTestCTS: Boolean;
    FLastCR: Boolean;
    FLastLF: Boolean;
    FMaxLineLength: Integer;
    FLinuxLock: Boolean;
    FMaxSendBandwidth: Integer;
    FNextSend: LongWord;
    FMaxRecvBandwidth: Integer;
    FNextRecv: LongWord;
    FConvertLineEnd: Boolean;
    FATResult: Boolean;
    FAtTimeout: integer;
    FInterPacketTimeout: Boolean;
    FComNr: integer;
{$IFDEF MSWINDOWS}
    FPortAddr: Word;
    function CanEvent(Event: dword; Timeout: integer): boolean;
    procedure DecodeCommError(Error: DWord); virtual;
 {$IFDEF WIN32}
    function GetPortAddr: Word;  virtual;
    function ReadTxEmpty(PortAddr: Word): Boolean; virtual;
 {$ENDIF}
{$ENDIF}
    procedure SetSizeRecvBuffer(size: integer); virtual;
    function GetDSR: Boolean; virtual;
    procedure SetDTRF(Value: Boolean); virtual;
    function GetCTS: Boolean; virtual;
    procedure SetRTSF(Value: Boolean); virtual;
    function GetCarrier: Boolean; virtual;
    function GetRing: Boolean; virtual;
    procedure DoStatus(Reason: THookSerialReason; const Value: string); virtual;
    procedure GetComNr(Value: string); virtual;
    function PreTestFailing: boolean; virtual;
    function TestCtrlLine: Boolean; virtual;
{$IFDEF UNIX}
    procedure DcbToTermios(const dcb: TDCB; var term: termios); virtual;
    procedure TermiosToDcb(const term: termios; var dcb: TDCB); virtual;
    function ReadLockfile: integer; virtual;
    function LockfileName: String; virtual;
    procedure CreateLockfile(PidNr: integer); virtual;
{$ENDIF}
    procedure LimitBandwidth(Length: Integer; MaxB: integer; var Next: LongWord); virtual;
    procedure SetBandwidth(Value: Integer); virtual;
  public
    DCB: Tdcb;
{$IFDEF UNIX}
    TermiosStruc: termios;
{$ENDIF}
    constructor Create;
    destructor Destroy; override;
    class function GetVersion: string; virtual;
    procedure CloseSocket; virtual;
    procedure Config(baud, bits: integer; parity: char; stop: integer;
      softflow, hardflow: boolean); virtual;
    procedure Connect(comport: string); virtual;
    procedure SetCommState; virtual;
    procedure GetCommState; virtual;
    function SendBuffer(buffer: pointer; length: integer): integer; virtual;
    procedure SendByte(data: byte); virtual;
    procedure SendString(data: AnsiString); virtual;
    procedure SendInteger(Data: integer); virtual;
    procedure SendBlock(const Data: AnsiString); virtual;
    procedure SendStreamRaw(const Stream: TStream); virtual;
    procedure SendStream(const Stream: TStream); virtual;
    procedure SendStreamIndy(const Stream: TStream); virtual;
    function RecvBuffer(buffer: pointer; length: integer): integer; virtual;
    function RecvBufferEx(buffer: pointer; length: integer; timeout: integer): integer; virtual;
    function RecvBufferStr(Length: Integer; Timeout: Integer): AnsiString; virtual;
    function RecvPacket(Timeout: Integer): AnsiString; virtual;
    function RecvByte(timeout: integer): byte; virtual;
    function RecvTerminated(Timeout: Integer; const Terminator: AnsiString): AnsiString; virtual;
    function Recvstring(timeout: integer): AnsiString; virtual;
    function RecvInteger(Timeout: Integer): Integer; virtual;
    function RecvBlock(Timeout: Integer): AnsiString; virtual;
    procedure RecvStreamRaw(const Stream: TStream; Timeout: Integer); virtual;
    procedure RecvStreamSize(const Stream: TStream; Timeout: Integer; Size: Integer); virtual;
    procedure RecvStream(const Stream: TStream; Timeout: Integer); virtual;
    procedure RecvStreamIndy(const Stream: TStream; Timeout: Integer); virtual;
    function WaitingData: integer; virtual;
    function WaitingDataEx: integer; virtual;
    function SendingData: integer; virtual;
    procedure EnableRTSToggle(value: boolean); virtual;
    procedure Flush; virtual;
    procedure Purge; virtual;
    function CanRead(Timeout: integer): boolean; virtual;
    function CanWrite(Timeout: integer): boolean; virtual;
    function CanReadEx(Timeout: integer): boolean; virtual;
    function ModemStatus: integer; virtual;
    procedure SetBreak(Duration: integer); virtual;
    function ATCommand(value: AnsiString): AnsiString; virtual;
    function ATConnect(value: AnsiString): AnsiString; virtual;
    function SerialCheck(SerialResult: integer): integer; virtual;
    procedure ExceptCheck; virtual;
    procedure SetSynaError(ErrNumber: integer); virtual;
    procedure RaiseSynaError(ErrNumber: integer); virtual;
{$IFDEF UNIX}
    function  cpomComportAccessible: boolean; virtual;{HGJ}
    procedure cpomReleaseComport; virtual; {HGJ}
{$ENDIF}
    property Device: string read FDevice;
    property LastError: integer read FLastError;
    property LastErrorDesc: string read FLastErrorDesc;
    property ATResult: Boolean read FATResult;
    property RTS: Boolean write SetRTSF;
    property CTS: boolean read GetCTS;
    property DTR: Boolean write SetDTRF;
    property DSR: boolean read GetDSR;
    property Carrier: boolean read GetCarrier;
    property Ring: boolean read GetRing;
    property InstanceActive: boolean read FInstanceActive; {HGJ}
    property MaxSendBandwidth: Integer read FMaxSendBandwidth Write FMaxSendBandwidth;
    property MaxRecvBandwidth: Integer read FMaxRecvBandwidth Write FMaxRecvBandwidth;
    property MaxBandwidth: Integer Write SetBandwidth;
    property SizeRecvBuffer: integer read FRecvBuffer write SetSizeRecvBuffer;
  published
    class function GetErrorDesc(ErrorCode: integer): string;
    property Tag: integer read FTag write FTag;
    property Handle: THandle read Fhandle write FHandle;
    property LineBuffer: AnsiString read FBuffer write FBuffer;
    property RaiseExcept: boolean read FRaiseExcept write FRaiseExcept;
    property OnStatus: THookSerialStatus read FOnStatus write FOnStatus;
    property TestDSR: boolean read FTestDSR write FTestDSR;
    property TestCTS: boolean read FTestCTS write FTestCTS;
    property MaxLineLength: Integer read FMaxLineLength Write FMaxLineLength;
    property DeadlockTimeout: Integer read FDeadlockTimeout Write FDeadlockTimeout;
    property LinuxLock: Boolean read FLinuxLock write FLinuxLock;
    property ConvertLineEnd: Boolean read FConvertLineEnd Write FConvertLineEnd;
    property AtTimeout: integer read FAtTimeout Write FAtTimeout;
    property InterPacketTimeout: Boolean read FInterPacketTimeout Write FInterPacketTimeout;
  end;


  function GetSerialPortNames: string;

implementation

function SeparateRight(const Value, Delimiter: string): string;
var
  x: Integer;
begin
  x := Pos(Delimiter, Value);
  if x > 0 then
    x := x + Length(Delimiter) - 1;
  Result := Copy(Value, x + 1, Length(Value) - x);
end;

procedure WriteStrToStream(const Stream: TStream; Value: AnsiString);
begin
  Stream.Write(PAnsiChar(Value)^, Length(Value));
end;

function PosCRLF(const Value: AnsiString; var Terminator: AnsiString): integer;
var
  n, l: integer;
begin
  Result := -1;
  Terminator := '';
  l := length(value);
  for n := 1 to l do
    if value[n] in [#$0d, #$0a] then
    begin
      Result := n;
      Terminator := Value[n];
      if n <> l then
        case value[n] of
          #$0d:
            if value[n + 1] = #$0a then
              Terminator := #$0d + #$0a;
          #$0a:
            if value[n + 1] = #$0d then
              Terminator := #$0a + #$0d;
        end;
      Break;
    end;
end;

function TickDelta(TickOld, TickNew: LongWord): LongWord;
begin
  Result := 0;
  if TickOld <> TickNew then
  begin
    if TickNew < TickOld then
    begin
      TickNew := TickNew + LongWord(MaxInt) + 1;
      TickOld := TickOld + LongWord(MaxInt) + 1;
    end;
    Result := TickNew - TickOld;
    if TickNew < TickOld then
      if Result > 0 then
        Result := 0 - Result;
  end;
end;

{$IFNDEF CIL}
function IncPoint(const p: pointer; Value: integer): pointer;
begin
  Result := PAnsiChar(p) + Value;
end;
{$ENDIF}

function CodeLongInt(Value: Longint): Ansistring;
var
  x, y: word;
begin
  // this is fix for negative numbers on systems where longint = integer
  x := (Value shr 16) and integer($ffff);
  y := Value and integer($ffff);
  setlength(result, 4);
  result[1] := AnsiChar(x div 256);
  result[2] := AnsiChar(x mod 256);
  result[3] := AnsiChar(y div 256);
  result[4] := AnsiChar(y mod 256);
end;

function SwapBytes(Value: integer): integer;
var
  s: AnsiString;
  x, y, xl, yl: Byte;
begin
  s := CodeLongInt(Value);
  x := Ord(s[4]);
  y := Ord(s[3]);
  xl := Ord(s[2]);
  yl := Ord(s[1]);
  Result := ((x * 256 + y) * 65536) + (xl * 256 + yl);
end;

{$IFNDEF MSWINDOWS}
function GetTick: LongWord;
var
  Stamp: TTimeStamp;
begin
  Stamp := DateTimeToTimeStamp(Now);
  Result := Stamp.Time;
end;
{$ELSE}
function GetTick: LongWord;
var
  tick, freq: TLargeInteger;
{$IFDEF VER100}
  x: TLargeInteger;
{$ENDIF}
begin
  if Windows.QueryPerformanceFrequency(freq) then
  begin
    Windows.QueryPerformanceCounter(tick);
{$IFDEF VER100}
    x.QuadPart := (tick.QuadPart / freq.QuadPart) * 1000;
    Result := x.LowPart;
{$ELSE}
    Result := Trunc((tick / freq) * 1000) and High(LongWord)
{$ENDIF}
  end
  else
    Result := Windows.GetTickCount;
end;
{$ENDIF}


constructor TBlockSerial.Create;
begin
  inherited create;
  FRaiseExcept := false;
  FHandle := INVALID_HANDLE_VALUE;
  FDevice := '';
  FComNr:= PortIsClosed;
  FInstanceActive:= false;
  Fbuffer := '';
  FRTSToggle := False;
  FMaxLineLength := 0;
  FTestDSR := False;
  FTestCTS := False;
  FDeadlockTimeout := 30000;
  FLinuxLock := True;
  FMaxSendBandwidth := 0;
  FNextSend := 0;
  FMaxRecvBandwidth := 0;
  FNextRecv := 0;
  FConvertLineEnd := False;
  SetSynaError(sOK);
  FRecvBuffer := 4096;
  FLastCR := False;
  FLastLF := False;
  FAtTimeout := 1000;
  FInterPacketTimeout := True;
end;

destructor TBlockSerial.Destroy;
begin
  CloseSocket;
  inherited destroy;
end;

class function TBlockSerial.GetVersion: string;
begin
	Result := 'SynaSer 7.6.0';
end;

procedure TBlockSerial.CloseSocket;
begin
  if Fhandle <> INVALID_HANDLE_VALUE then
  begin
    Purge;
    RTS := False;
    DTR := False;
    FileClose(FHandle);
  end;
  if InstanceActive then
  begin
    {$IFDEF UNIX}
    if FLinuxLock then
      cpomReleaseComport;
    {$ENDIF}
    FInstanceActive:= false
  end;
  Fhandle := INVALID_HANDLE_VALUE;
  FComNr:= PortIsClosed;
  SetSynaError(sOK);
  DoStatus(HR_SerialClose, FDevice);
end;

{$IFDEF WIN32}
function TBlockSerial.GetPortAddr: Word;
begin
  Result := 0;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
    EscapeCommFunction(FHandle, 10);
    asm
      MOV @Result, DX;
    end;
  end;
end;

function TBlockSerial.ReadTxEmpty(PortAddr: Word): Boolean;
begin
  Result := True;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
    asm
      MOV DX, PortAddr;
      ADD DX, 5;
      IN AL, DX;
      AND AL, $40;
      JZ @K;
      MOV AL,1;
    @K: MOV @Result, AL;
    end;
  end;
end;
{$ENDIF}

procedure TBlockSerial.GetComNr(Value: string);
begin
  FComNr := PortIsClosed;
  if pos('COM', uppercase(Value)) = 1 then
    FComNr := StrToIntdef(copy(Value, 4, Length(Value) - 3), PortIsClosed + 1) - 1;
  if pos('/DEV/TTYS', uppercase(Value)) = 1 then
    FComNr := StrToIntdef(copy(Value, 10, Length(Value) - 9), PortIsClosed - 1);
end;

procedure TBlockSerial.SetBandwidth(Value: Integer);
begin
  MaxSendBandwidth := Value;
  MaxRecvBandwidth := Value;
end;

procedure TBlockSerial.LimitBandwidth(Length: Integer; MaxB: integer; var Next: LongWord);
var
  x: LongWord;
  y: LongWord;
begin
  if MaxB > 0 then
  begin
    y := GetTick;
    if Next > y then
    begin
      x := Next - y;
      if x > 0 then
      begin
        DoStatus(HR_Wait, IntToStr(x));
        sleep(x);
      end;
    end;
    Next := GetTick + Trunc((Length / MaxB) * 1000);
  end;
end;

procedure TBlockSerial.Config(baud, bits: integer; parity: char; stop: integer;
  softflow, hardflow: boolean);
begin
  FillChar(dcb, SizeOf(dcb), 0);
  GetCommState;
  dcb.DCBlength := SizeOf(dcb);
  dcb.BaudRate := baud;
  dcb.ByteSize := bits;
  case parity of
    'N', 'n': dcb.parity := 0;
    'O', 'o': dcb.parity := 1;
    'E', 'e': dcb.parity := 2;
    'M', 'm': dcb.parity := 3;
    'S', 's': dcb.parity := 4;
  end;
  dcb.StopBits := stop;
  dcb.XonChar := #17;
  dcb.XoffChar := #19;
  dcb.XonLim := FRecvBuffer div 4;
  dcb.XoffLim := FRecvBuffer div 4;
  dcb.Flags := dcb_Binary;
  if softflow then
    dcb.Flags := dcb.Flags or dcb_OutX or dcb_InX;
  if hardflow then
    dcb.Flags := dcb.Flags or dcb_OutxCtsFlow or dcb_RtsControlHandshake
  else
    dcb.Flags := dcb.Flags or dcb_RtsControlEnable;
  dcb.Flags := dcb.Flags or dcb_DtrControlEnable;
  if dcb.Parity > 0 then
    dcb.Flags := dcb.Flags or dcb_ParityCheck;
  SetCommState;
end;

procedure TBlockSerial.Connect(comport: string);
{$IFDEF MSWINDOWS}
var
  CommTimeouts: TCommTimeouts;
{$ENDIF}
begin
  // Is this TBlockSerial Instance already busy?
  if InstanceActive then           {HGJ}
  begin                            {HGJ}
    RaiseSynaError(ErrAlreadyInUse);
    Exit;                          {HGJ}
  end;                             {HGJ}
  FBuffer := '';
  FDevice := comport;
  GetComNr(comport);
{$IFDEF MSWINDOWS}
  SetLastError (sOK);
{$ELSE}
  fpSetErrno(sOK);
{$ENDIF}
{$IFNDEF MSWINDOWS}
  if FComNr <> PortIsClosed then
    FDevice := '/dev/ttyS' + IntToStr(FComNr);
  // Comport already owned by another process?          {HGJ}
  if FLinuxLock then
    if not cpomComportAccessible then
    begin
      RaiseSynaError(ErrAlreadyOwned);
      Exit;
    end;
  FHandle := THandle(fpOpen(FDevice, O_RDWR or O_SYNC));
  if FHandle = INVALID_HANDLE_VALUE then  //because THandle is not integer on all platforms!
    SerialCheck(-1)
  else
    SerialCheck(0);
  {$IFDEF UNIX}
  if FLastError <> sOK then
    if FLinuxLock then
      cpomReleaseComport;
  {$ENDIF}
  ExceptCheck;
  if FLastError <> sOK then
    Exit;
{$ELSE}
  if FComNr <> PortIsClosed then
    FDevice := '\\.\COM' + IntToStr(FComNr + 1);
  FHandle := THandle(CreateFile(PChar(FDevice), GENERIC_READ or GENERIC_WRITE,
    0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED, 0));
  if FHandle = INVALID_HANDLE_VALUE then  //because THandle is not integer on all platforms!
    SerialCheck(-1)
  else
    SerialCheck(0);
  ExceptCheck;
  if FLastError <> sOK then
    Exit;
  SetCommMask(FHandle, 0);
  SetupComm(Fhandle, FRecvBuffer, 0);
  CommTimeOuts.ReadIntervalTimeout := MAXWORD;
  CommTimeOuts.ReadTotalTimeoutMultiplier := 0;
  CommTimeOuts.ReadTotalTimeoutConstant := 0;
  CommTimeOuts.WriteTotalTimeoutMultiplier := 0;
  CommTimeOuts.WriteTotalTimeoutConstant := 0;
  SetCommTimeOuts(FHandle, CommTimeOuts);
  {$IFDEF WIN32}
  FPortAddr := GetPortAddr;
  {$ENDIF}
{$ENDIF}
  SetSynaError(sOK);
  if not TestCtrlLine then  {HGJ}
  begin
    SetSynaError(ErrNoDeviceAnswer);
    FileClose(FHandle);         {HGJ}
    {$IFDEF UNIX}
    if FLinuxLock then
      cpomReleaseComport;                {HGJ}
    {$ENDIF}                             {HGJ}
    Fhandle := INVALID_HANDLE_VALUE;     {HGJ}
    FComNr:= PortIsClosed;               {HGJ}
  end
  else
  begin
    FInstanceActive:= True;
    RTS := True;
    DTR := True;
    Purge;
  end;
  ExceptCheck;
  DoStatus(HR_Connect, FDevice);
end;

function TBlockSerial.SendBuffer(buffer: pointer; length: integer): integer;
{$IFDEF MSWINDOWS}
var
  Overlapped: TOverlapped;
  x, y, Err: DWord;
{$ENDIF}
begin
  Result := 0;
  if PreTestFailing then   {HGJ}
    Exit;                  {HGJ}
  LimitBandwidth(Length, FMaxSendBandwidth, FNextsend);
  if FRTSToggle then
  begin
    Flush;
    RTS := True;
  end;
{$IFNDEF MSWINDOWS}
  result := FileWrite(Fhandle, Buffer^, Length);
  serialcheck(result);
{$ELSE}
  FillChar(Overlapped, Sizeof(Overlapped), 0);
  SetSynaError(sOK);
  y := 0;
  if not WriteFile(FHandle, Buffer^, Length, DWord(Result), @Overlapped) then
    y := GetLastError;
  if y = ERROR_IO_PENDING then
  begin
    x := WaitForSingleObject(FHandle, FDeadlockTimeout);
    if x = WAIT_TIMEOUT then
    begin
      PurgeComm(FHandle, PURGE_TXABORT);
      SetSynaError(ErrTimeout);
    end;
    GetOverlappedResult(FHandle, Overlapped, Dword(Result), False);
  end
  else
    SetSynaError(y);
  err := 0;
  ClearCommError(FHandle, err, nil);
  if err <> 0 then
    DecodeCommError(err);
{$ENDIF}
  if FRTSToggle then
  begin
    Flush;
    CanWrite(255);
    RTS := False;
  end;
  ExceptCheck;
  DoStatus(HR_WriteCount, IntToStr(Result));
end;

procedure TBlockSerial.SendByte(data: byte);
begin
  SendBuffer(@Data, 1);
end;

procedure TBlockSerial.SendString(data: AnsiString);
begin
  SendBuffer(Pointer(Data), Length(Data));
end;

procedure TBlockSerial.SendInteger(Data: integer);
begin
  SendBuffer(@data, SizeOf(Data));
end;

procedure TBlockSerial.SendBlock(const Data: AnsiString);
begin
  SendInteger(Length(data));
  SendString(Data);
end;

procedure TBlockSerial.SendStreamRaw(const Stream: TStream);
var
  si: integer;
  x, y, yr: integer;
  s: AnsiString='';
begin
  si := Stream.Size - Stream.Position;
  x := 0;
  while x < si do
  begin
    y := si - x;
    if y > cSerialChunk then
      y := cSerialChunk;
    Setlength(s, y);
    yr := Stream.read(PAnsiChar(s)^, y);
    if yr > 0 then
    begin
      SetLength(s, yr);
      SendString(s);
      Inc(x, yr);
    end
    else
      break;
  end;
end;

procedure TBlockSerial.SendStreamIndy(const Stream: TStream);
var
  si: integer;
begin
  si := Stream.Size - Stream.Position;
  si := Swapbytes(si);
  SendInteger(si);
  SendStreamRaw(Stream);
end;

procedure TBlockSerial.SendStream(const Stream: TStream);
var
  si: integer;
begin
  si := Stream.Size - Stream.Position;
  SendInteger(si);
  SendStreamRaw(Stream);
end;

function TBlockSerial.RecvBuffer(buffer: pointer; length: integer): integer;
{$IFNDEF MSWINDOWS}
begin
  Result := 0;
  if PreTestFailing then   {HGJ}
    Exit;                  {HGJ}
  LimitBandwidth(Length, FMaxRecvBandwidth, FNextRecv);
  result := FileRead(FHandle, Buffer^, length);
  serialcheck(result);
{$ELSE}
var
  Overlapped: TOverlapped;
  x, y, Err: DWord;
begin
  Result := 0;
  if PreTestFailing then   {HGJ}
    Exit;                  {HGJ}
  LimitBandwidth(Length, FMaxRecvBandwidth, FNextRecv);
  FillChar(Overlapped, Sizeof(Overlapped), 0);
  SetSynaError(sOK);
  y := 0;
  if not ReadFile(FHandle, Buffer^, length, Dword(Result), @Overlapped) then
    y := GetLastError;
  if y = ERROR_IO_PENDING then
  begin
    x := WaitForSingleObject(FHandle, FDeadlockTimeout);
    if x = WAIT_TIMEOUT then
    begin
      PurgeComm(FHandle, PURGE_RXABORT);
      SetSynaError(ErrTimeout);
    end;
    GetOverlappedResult(FHandle, Overlapped, Dword(Result), False);
  end
  else
    SetSynaError(y);
  err := 0;
  ClearCommError(FHandle, err, nil);
  if err <> 0 then
    DecodeCommError(err);
{$ENDIF}
  ExceptCheck;
  DoStatus(HR_ReadCount, IntToStr(Result));
end;

function TBlockSerial.RecvBufferEx(buffer: pointer; length: integer; timeout: integer): integer;
var
  s: AnsiString;
  rl, l: integer;
  ti: LongWord;
begin
  Result := 0;
  if PreTestFailing then   {HGJ}
    Exit;
  SetSynaError(sOK);
  rl := 0;
  repeat
    ti := GetTick;
    s := RecvPacket(Timeout);
    l := System.Length(s);
    if (rl + l) > Length then
      l := Length - rl;
    Move(Pointer(s)^, IncPoint(Buffer, rl)^, l);
    rl := rl + l;
    if FLastError <> sOK then
      Break;
    if rl >= Length then
      Break;
    if not FInterPacketTimeout then
    begin
      Timeout := Timeout - integer(TickDelta(ti, GetTick));
      if Timeout <= 0 then
      begin
        SetSynaError(ErrTimeout);
        Break;
      end;
    end;
  until False;
  delete(s, 1, l);
  FBuffer := s;
  Result := rl;
end;

function TBlockSerial.RecvBufferStr(Length: Integer; Timeout: Integer): AnsiString;
var
  x: integer;
begin
  Result := '';
  if PreTestFailing then
    Exit;
  SetSynaError(sOK);
  if Length > 0 then
  begin
    Setlength(Result, Length);
    x := RecvBufferEx(PAnsiChar(Result), Length , Timeout);
    if FLastError = sOK then
      SetLength(Result, x)
    else
      Result := '';
  end;
end;

function TBlockSerial.RecvPacket(Timeout: Integer): AnsiString;
var
  x: integer;
begin
  Result := '';
  if PreTestFailing then
    Exit;
  SetSynaError(sOK);
  if FBuffer <> '' then
  begin
    Result := FBuffer;
    FBuffer := '';
  end
  else
  begin
    //not drain CPU on large downloads...
    Sleep(0);
    x := WaitingData;
    if x > 0 then
    begin
      SetLength(Result, x);
      x := RecvBuffer(Pointer(Result), x);
      if x >= 0 then
        SetLength(Result, x);
    end
    else
    begin
      if CanRead(Timeout) then
      begin
        x := WaitingData;
        if x = 0 then
          SetSynaError(ErrTimeout);
        if x > 0 then
        begin
          SetLength(Result, x);
          x := RecvBuffer(Pointer(Result), x);
          if x >= 0 then
            SetLength(Result, x);
        end;
      end
      else
        SetSynaError(ErrTimeout);
    end;
  end;
  ExceptCheck;
end;


function TBlockSerial.RecvByte(timeout: integer): byte;
begin
  Result := 0;
  if PreTestFailing then
    Exit;
  SetSynaError(sOK);
  if FBuffer = '' then
    FBuffer := RecvPacket(Timeout);
  if (FLastError = sOK) and (FBuffer <> '') then
  begin
    Result := Ord(FBuffer[1]);
    System.Delete(FBuffer, 1, 1);
  end;
  ExceptCheck;
end;

function TBlockSerial.RecvTerminated(Timeout: Integer; const Terminator: AnsiString): AnsiString;
var
  x: Integer;
  s: AnsiString;
  l: Integer;
  CorCRLF: Boolean;
  t: ansistring;
  tl: integer;
  ti: LongWord;
begin
  Result := '';
  if PreTestFailing then
    Exit;
  SetSynaError(sOK);
  l := system.Length(Terminator);
  if l = 0 then
    Exit;
  tl := l;
  CorCRLF := FConvertLineEnd and (Terminator = CRLF);
  s := '';
  x := 0;
  repeat
    ti := GetTick;
    //get rest of FBuffer or incomming new data...
    s := s + RecvPacket(Timeout);
    if FLastError <> sOK then
      Break;
    x := 0;
    if Length(s) > 0 then
      if CorCRLF then
      begin
        if FLastCR and (s[1] = LF) then
          Delete(s, 1, 1);
        if FLastLF and (s[1] = CR) then
          Delete(s, 1, 1);
        FLastCR := False;
        FLastLF := False;
        t := '';
        x := PosCRLF(s, t);
        tl := system.Length(t);
        if t = CR then
          FLastCR := True;
        if t = LF then
          FLastLF := True;
      end
      else
      begin
        x := pos(Terminator, s);
        tl := l;
      end;
    if (FMaxLineLength <> 0) and (system.Length(s) > FMaxLineLength) then
    begin
      SetSynaError(ErrMaxBuffer);
      Break;
    end;
    if x > 0 then
      Break;
    if not FInterPacketTimeout then
    begin
      Timeout := Timeout - integer(TickDelta(ti, GetTick));
      if Timeout <= 0 then
      begin
        SetSynaError(ErrTimeout);
        Break;
      end;
    end;
  until False;
  if x > 0 then
  begin
    Result := Copy(s, 1, x - 1);
    System.Delete(s, 1, x + tl - 1);
  end;
  FBuffer := s;
  ExceptCheck;
end;


function TBlockSerial.RecvString(Timeout: Integer): AnsiString;
var
  s: AnsiString;
begin
  Result := '';
  s := RecvTerminated(Timeout, #13 + #10);
  if FLastError = sOK then
    Result := s;
end;

function TBlockSerial.RecvInteger(Timeout: Integer): Integer;
var
  s: AnsiString;
begin
  Result := 0;
  s := RecvBufferStr(4, Timeout);
  if FLastError = 0 then
    Result := (ord(s[1]) + ord(s[2]) * 256) + (ord(s[3]) + ord(s[4]) * 256) * 65536;
end;

function TBlockSerial.RecvBlock(Timeout: Integer): AnsiString;
var
  x: integer;
begin
  Result := '';
  x := RecvInteger(Timeout);
  if FLastError = 0 then
    Result := RecvBufferStr(x, Timeout);
end;

procedure TBlockSerial.RecvStreamRaw(const Stream: TStream; Timeout: Integer);
var
  s: AnsiString;
begin
  repeat
    s := RecvPacket(Timeout);
    if FLastError = 0 then
      WriteStrToStream(Stream, s);
  until FLastError <> 0;
end;

procedure TBlockSerial.RecvStreamSize(const Stream: TStream; Timeout: Integer; Size: Integer);
var
  s: AnsiString;
  n: integer;
begin
  for n := 1 to (Size div cSerialChunk) do
  begin
    s := RecvBufferStr(cSerialChunk, Timeout);
    if FLastError <> 0 then
      Exit;
    Stream.Write(PAnsichar(s)^, cSerialChunk);
  end;
  n := Size mod cSerialChunk;
  if n > 0 then
  begin
    s := RecvBufferStr(n, Timeout);
    if FLastError <> 0 then
      Exit;
    Stream.Write(PAnsichar(s)^, n);
  end;
end;

procedure TBlockSerial.RecvStreamIndy(const Stream: TStream; Timeout: Integer);
var
  x: integer;
begin
  x := RecvInteger(Timeout);
  x := SwapBytes(x);
  if FLastError = 0 then
    RecvStreamSize(Stream, Timeout, x);
end;

procedure TBlockSerial.RecvStream(const Stream: TStream; Timeout: Integer);
var
  x: integer;
begin
  x := RecvInteger(Timeout);
  if FLastError = 0 then
    RecvStreamSize(Stream, Timeout, x);
end;

{$IFNDEF MSWINDOWS}
function TBlockSerial.WaitingData: integer;
begin
  serialcheck(fpIoctl(FHandle, FIONREAD, @result));
  if FLastError <> 0 then
    Result := 0;
  ExceptCheck;
end;
{$ELSE}
function TBlockSerial.WaitingData: integer;
var
  stat: TComStat;
  err: DWORD;
begin
  err := 0;
  if ClearCommError(FHandle, err, @stat) then
  begin
    SetSynaError(sOK);
    Result := stat.cbInQue;
  end
  else
  begin
    SerialCheck(sErr);
    Result := 0;
  end;
  ExceptCheck;
end;
{$ENDIF}

function TBlockSerial.WaitingDataEx: integer;
begin
	if FBuffer <> '' then
  	Result := Length(FBuffer)
  else
  	Result := Waitingdata;
end;

{$IFNDEF MSWINDOWS}
function TBlockSerial.SendingData: integer;
begin
  SetSynaError(sOK);
  Result := 0;
end;
{$ELSE}
function TBlockSerial.SendingData: integer;
var
  stat: TComStat;
  err: DWORD;
begin
  SetSynaError(sOK);
  err := 0;
  if not ClearCommError(FHandle, err, @stat) then
    serialcheck(sErr);
  ExceptCheck;
  result := stat.cbOutQue;
end;
{$ENDIF}

{$IFNDEF MSWINDOWS}
procedure TBlockSerial.DcbToTermios(const dcb: TDCB; var term: termios);
var
  n: integer;
  x: cardinal;
begin
  //others
  cfmakeraw(term);
  term.c_cflag := term.c_cflag or CREAD;
  term.c_cflag := term.c_cflag or CLOCAL;
  term.c_cflag := term.c_cflag or HUPCL;
  //hardware handshake
  if (dcb.flags and dcb_RtsControlHandshake) > 0 then
    term.c_cflag := term.c_cflag or CRTSCTS
  else
    term.c_cflag := term.c_cflag and (not CRTSCTS);
  //software handshake
  if (dcb.flags and dcb_OutX) > 0 then
    term.c_iflag := term.c_iflag or IXON or IXOFF or IXANY
  else
    term.c_iflag := term.c_iflag and (not (IXON or IXOFF or IXANY));
  //size of byte
  term.c_cflag := term.c_cflag and (not CSIZE);
  case dcb.bytesize of
    5:
      term.c_cflag := term.c_cflag or CS5;
    6:
      term.c_cflag := term.c_cflag or CS6;
    7:
      term.c_cflag := term.c_cflag or CS7;
    8:
      term.c_cflag := term.c_cflag or CS8;
  end;
  //parity
  if (dcb.flags and dcb_ParityCheck) > 0 then
    term.c_cflag := term.c_cflag or PARENB
  else
    term.c_cflag := term.c_cflag and (not PARENB);
  case dcb.parity of
    1: //'O'
      term.c_cflag := term.c_cflag or PARODD;
    2: //'E'
      term.c_cflag := term.c_cflag and (not PARODD);
  end;
  //stop bits
  if dcb.stopbits > 0 then
    term.c_cflag := term.c_cflag or CSTOPB
  else
    term.c_cflag := term.c_cflag and (not CSTOPB);
  //set baudrate;
  x := 0;
  for n := 0 to Maxrates do
    if rates[n, 0] = dcb.BaudRate then
    begin
      x := rates[n, 1];
      break;
    end;
  cfsetospeed(term, x);
  cfsetispeed(term, x);
end;

procedure TBlockSerial.TermiosToDcb(const term: termios; var dcb: TDCB);
var
  n: integer;
  x: cardinal;
begin
  //set baudrate;
  dcb.baudrate := 0;
  //why FPC not have cfgetospeed???
  x := term.c_oflag and $0F;
  for n := 0 to Maxrates do
    if rates[n, 1] = x then
    begin
      dcb.baudrate := rates[n, 0];
      break;
    end;
  //hardware handshake
  if (term.c_cflag and CRTSCTS) > 0 then
    dcb.flags := dcb.flags or dcb_RtsControlHandshake or dcb_OutxCtsFlow
  else
    dcb.flags := dcb.flags and (not (dcb_RtsControlHandshake or dcb_OutxCtsFlow));
  //software handshake
  if (term.c_cflag and IXOFF) > 0 then
    dcb.flags := dcb.flags or dcb_OutX or dcb_InX
  else
    dcb.flags := dcb.flags and (not (dcb_OutX or dcb_InX));
  //size of byte
  case term.c_cflag and CSIZE of
    CS5:
      dcb.bytesize := 5;
    CS6:
      dcb.bytesize := 6;
    CS7fix:
      dcb.bytesize := 7;
    CS8:
      dcb.bytesize := 8;
  end;
  //parity
  if (term.c_cflag and PARENB) > 0 then
    dcb.flags := dcb.flags or dcb_ParityCheck
  else
    dcb.flags := dcb.flags and (not dcb_ParityCheck);
  dcb.parity := 0;
  if (term.c_cflag and PARODD) > 0 then
    dcb.parity := 1
  else
    dcb.parity := 2;
  //stop bits
  if (term.c_cflag and CSTOPB) > 0 then
    dcb.stopbits := 2
  else
    dcb.stopbits := 0;
end;
{$ENDIF}

{$IFNDEF MSWINDOWS}
procedure TBlockSerial.SetCommState;
begin
  DcbToTermios(dcb, termiosstruc);
  SerialCheck(tcsetattr(FHandle, TCSANOW, termiosstruc));
  ExceptCheck;
end;
{$ELSE}
procedure TBlockSerial.SetCommState;
begin
  SetSynaError(sOK);
  if not windows.SetCommState(Fhandle, dcb) then
    SerialCheck(sErr);
  ExceptCheck;
end;
{$ENDIF}

{$IFNDEF MSWINDOWS}
procedure TBlockSerial.GetCommState;
begin
  SerialCheck(tcgetattr(FHandle, termiosstruc));
  ExceptCheck;
  TermiostoDCB(termiosstruc, dcb);
end;
{$ELSE}
procedure TBlockSerial.GetCommState;
begin
  SetSynaError(sOK);
  if not windows.GetCommState(Fhandle, dcb) then
    SerialCheck(sErr);
  ExceptCheck;
end;
{$ENDIF}

procedure TBlockSerial.SetSizeRecvBuffer(size: integer);
begin
{$IFDEF MSWINDOWS}
  SetupComm(Fhandle, size, 0);
  GetCommState;
  dcb.XonLim := size div 4;
  dcb.XoffLim := size div 4;
  SetCommState;
{$ENDIF}
  FRecvBuffer := size;
end;

function TBlockSerial.GetDSR: Boolean;
begin
  ModemStatus;
{$IFNDEF MSWINDOWS}
  Result := (FModemWord and TIOCM_DSR) > 0;
{$ELSE}
  Result := (FModemWord and MS_DSR_ON) > 0;
{$ENDIF}
end;

procedure TBlockSerial.SetDTRF(Value: Boolean);
begin
{$IFNDEF MSWINDOWS}
  ModemStatus;
  if Value then
    FModemWord := FModemWord or TIOCM_DTR
  else
    FModemWord := FModemWord and not TIOCM_DTR;
  fpioctl(FHandle, TIOCMSET, @FModemWord);
{$ELSE}
  if Value then
    EscapeCommFunction(FHandle, SETDTR)
  else
    EscapeCommFunction(FHandle, CLRDTR);
{$ENDIF}
end;

function TBlockSerial.GetCTS: Boolean;
begin
  ModemStatus;
{$IFNDEF MSWINDOWS}
  Result := (FModemWord and TIOCM_CTS) > 0;
{$ELSE}
  Result := (FModemWord and MS_CTS_ON) > 0;
{$ENDIF}
end;

procedure TBlockSerial.SetRTSF(Value: Boolean);
begin
{$IFNDEF MSWINDOWS}
  ModemStatus;
  if Value then
    FModemWord := FModemWord or TIOCM_RTS
  else
    FModemWord := FModemWord and not TIOCM_RTS;
  fpioctl(FHandle, TIOCMSET, @FModemWord);
{$ELSE}
  if Value then
    EscapeCommFunction(FHandle, SETRTS)
  else
    EscapeCommFunction(FHandle, CLRRTS);
{$ENDIF}
end;

function TBlockSerial.GetCarrier: Boolean;
begin
  ModemStatus;
{$IFNDEF MSWINDOWS}
  Result := (FModemWord and TIOCM_CAR) > 0;
{$ELSE}
  Result := (FModemWord and MS_RLSD_ON) > 0;
{$ENDIF}
end;

function TBlockSerial.GetRing: Boolean;
begin
  ModemStatus;
{$IFNDEF MSWINDOWS}
  Result := (FModemWord and TIOCM_RNG) > 0;
{$ELSE}
  Result := (FModemWord and MS_RING_ON) > 0;
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
function TBlockSerial.CanEvent(Event: dword; Timeout: integer): boolean;
var
  ex: DWord;
  y: Integer;
  Overlapped: TOverlapped;
begin
  FillChar(Overlapped, Sizeof(Overlapped), 0);
  Overlapped.hEvent := CreateEvent(nil, True, False, nil);
  try
    SetCommMask(FHandle, Event);
    SetSynaError(sOK);
    if (Event = EV_RXCHAR) and (Waitingdata > 0) then
      Result := True
    else
    begin
      y := 0;
      ex := 0;
      if not WaitCommEvent(FHandle, ex, @Overlapped) then
        y := GetLastError;
      if y = ERROR_IO_PENDING then
      begin
        //timedout
        WaitForSingleObject(Overlapped.hEvent, Timeout);
        SetCommMask(FHandle, 0);
        GetOverlappedResult(FHandle, Overlapped, DWord(y), True);
      end;
      Result := (ex and Event) = Event;
    end;
  finally
    SetCommMask(FHandle, 0);
    CloseHandle(Overlapped.hEvent);
  end;
end;
{$ENDIF}

{$IFNDEF MSWINDOWS}
function TBlockSerial.CanRead(Timeout: integer): boolean;
var
  FDSet: TFDSet;
  TimeVal: PTimeVal;
  TimeV: TTimeVal;
  x: Integer;
begin
  TimeV.tv_usec := (Timeout mod 1000) * 1000;
  TimeV.tv_sec := Timeout div 1000;
  TimeVal := @TimeV;
  if Timeout = -1 then
    TimeVal := nil;
  fpFD_ZERO(FDSet);
  fpFD_SET(FHandle, FDSet);
  x := fpSelect(FHandle + 1, @FDSet, nil, nil, TimeVal);
  SerialCheck(x);
  if FLastError <> sOK then
    x := 0;
  Result := x > 0;
  ExceptCheck;
  if Result then
    DoStatus(HR_CanRead, '');
end;
{$ELSE}
function TBlockSerial.CanRead(Timeout: integer): boolean;
begin
  Result := WaitingData > 0;
  if not Result then
    Result := CanEvent(EV_RXCHAR, Timeout) or (WaitingData > 0);
    //check WaitingData again due some broken virtual ports
  if Result then
    DoStatus(HR_CanRead, '');
end;
{$ENDIF}

{$IFNDEF MSWINDOWS}
function TBlockSerial.CanWrite(Timeout: integer): boolean;
var
  FDSet: TFDSet;
  TimeVal: PTimeVal;
  TimeV: TTimeVal;
  x: Integer;
begin
  TimeV.tv_usec := (Timeout mod 1000) * 1000;
  TimeV.tv_sec := Timeout div 1000;
  TimeVal := @TimeV;
  if Timeout = -1 then
    TimeVal := nil;
  fpFD_ZERO(FDSet);
  fpFD_SET(FHandle, FDSet);
  x := fpSelect(FHandle + 1, nil, @FDSet, nil, TimeVal);
  SerialCheck(x);
  if FLastError <> sOK then
    x := 0;
  Result := x > 0;
  ExceptCheck;
  if Result then
    DoStatus(HR_CanWrite, '');
end;
{$ELSE}
function TBlockSerial.CanWrite(Timeout: integer): boolean;
var
  t: LongWord;
begin
  Result := SendingData = 0;
  if not Result then
	  Result := CanEvent(EV_TXEMPTY, Timeout);
  {$IFDEF WIN32}
  if Result and (Win32Platform <> VER_PLATFORM_WIN32_NT) then
  begin
    t := GetTick;
    while not ReadTxEmpty(FPortAddr) do
    begin
      if TickDelta(t, GetTick) > 255 then
        Break;
      Sleep(0);
    end;
  end;
  {$ENDIF}
  if Result then
    DoStatus(HR_CanWrite, '');
end;
{$ENDIF}

function TBlockSerial.CanReadEx(Timeout: integer): boolean;
begin
	if Fbuffer <> '' then
  	Result := True
  else
  	Result := CanRead(Timeout);
end;

procedure TBlockSerial.EnableRTSToggle(Value: boolean);
begin
  SetSynaError(sOK);
{$IFNDEF MSWINDOWS}
  FRTSToggle := Value;
  if Value then
    RTS:=False;
{$ELSE}
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    GetCommState;
    if value then
      dcb.Flags := dcb.Flags or dcb_RtsControlToggle
    else
      dcb.flags := dcb.flags and (not dcb_RtsControlToggle);
    SetCommState;
  end
  else
  begin
    FRTSToggle := Value;
    if Value then
      RTS:=False;
  end;
{$ENDIF}
end;

procedure TBlockSerial.Flush;
begin
{$IFNDEF MSWINDOWS}
  SerialCheck(tcdrain(FHandle));
{$ELSE}
  SetSynaError(sOK);
  if not Flushfilebuffers(FHandle) then
    SerialCheck(sErr);
{$ENDIF}
  ExceptCheck;
end;

{$IFNDEF MSWINDOWS}
procedure TBlockSerial.Purge;
begin
    {$IFDEF DARWIN}
    SerialCheck(fpioctl(FHandle, TCIOflush, Pointer(PtrInt(TCIOFLUSH))));
    {$ELSE}
    SerialCheck(fpioctl(FHandle, {$IFDEF FreeBSD}TCIOFLUSH{$ELSE}TCFLSH{$ENDIF}, Pointer(PtrInt(TCIOFLUSH))));
    {$ENDIF}
  FBuffer := '';
  ExceptCheck;
end;
{$ELSE}
procedure TBlockSerial.Purge;
var
  x: integer;
begin
  SetSynaError(sOK);
  x := PURGE_TXABORT or PURGE_TXCLEAR or PURGE_RXABORT or PURGE_RXCLEAR;
  if not PurgeComm(FHandle, x) then
    SerialCheck(sErr);
  FBuffer := '';
  ExceptCheck;
end;
{$ENDIF}

function TBlockSerial.ModemStatus: integer;
begin
  Result := 0;
{$IFNDEF MSWINDOWS}
  SerialCheck(fpioctl(FHandle, TIOCMGET, @Result));
{$ELSE}
  SetSynaError(sOK);
  if not GetCommModemStatus(FHandle, dword(Result)) then
    SerialCheck(sErr);
{$ENDIF}
  ExceptCheck;
  FModemWord := Result;
end;

procedure TBlockSerial.SetBreak(Duration: integer);
begin
{$IFNDEF MSWINDOWS}
  SerialCheck(tcsendbreak(FHandle, Duration));
{$ELSE}
  SetCommBreak(FHandle);
  Sleep(Duration);
  SetSynaError(sOK);
  if not ClearCommBreak(FHandle) then
    SerialCheck(sErr);
{$ENDIF}
end;

{$IFDEF MSWINDOWS}
procedure TBlockSerial.DecodeCommError(Error: DWord);
begin
  if (Error and DWord(CE_FRAME)) > 1 then
    FLastError := ErrFrame;
  if (Error and DWord(CE_OVERRUN)) > 1 then
    FLastError := ErrOverrun;
  if (Error and DWord(CE_RXOVER)) > 1 then
    FLastError := ErrRxOver;
  if (Error and DWord(CE_RXPARITY)) > 1 then
    FLastError := ErrRxParity;
  if (Error and DWord(CE_TXFULL)) > 1 then
    FLastError := ErrTxFull;
end;
{$ENDIF}

//HGJ
function TBlockSerial.PreTestFailing: Boolean;
begin
  if not FInstanceActive then
  begin
    RaiseSynaError(ErrPortNotOpen);
    result:= true;
    Exit;
  end;
  Result := not TestCtrlLine;
  if result then
    RaiseSynaError(ErrNoDeviceAnswer)
end;

function TBlockSerial.TestCtrlLine: Boolean;
begin
  result := ((not FTestDSR) or DSR) and ((not FTestCTS) or CTS);
end;

function TBlockSerial.ATCommand(value: AnsiString): AnsiString;
var
  s: AnsiString;
  ConvSave: Boolean;
begin
  result := '';
  FAtResult := False;
  ConvSave := FConvertLineEnd;
  try
    FConvertLineEnd := True;
    SendString(value + #$0D);
    repeat
      s := RecvString(FAtTimeout);
      if s <> Value then
        result := result + s + CRLF;
      if s = 'OK' then
      begin
        FAtResult := True;
        break;
      end;
      if s = 'ERROR' then
        break;
    until FLastError <> sOK;
  finally
    FConvertLineEnd := Convsave;
  end;
end;


function TBlockSerial.ATConnect(value: AnsiString): AnsiString;
var
  s: AnsiString;
  ConvSave: Boolean;
begin
  result := '';
  FAtResult := False;
  ConvSave := FConvertLineEnd;
  try
    FConvertLineEnd := True;
    SendString(value + #$0D);
    repeat
      s := RecvString(90 * FAtTimeout);
      if s <> Value then
        result := result + s + CRLF;
      if s = 'NO CARRIER' then
        break;
      if s = 'ERROR' then
        break;
      if s = 'BUSY' then
        break;
      if s = 'NO DIALTONE' then
        break;
      if Pos('CONNECT', s) = 1 then
      begin
        FAtResult := True;
        break;
      end;
    until FLastError <> sOK;
  finally
    FConvertLineEnd := Convsave;
  end;
end;

function TBlockSerial.SerialCheck(SerialResult: integer): integer;
begin
  if SerialResult = integer(INVALID_HANDLE_VALUE) then
{$IFDEF MSWINDOWS}
    result := GetLastError
{$ELSE}
    result := fpGetErrno
{$ENDIF}
  else
    result := sOK;
  FLastError := result;
  FLastErrorDesc := GetErrorDesc(FLastError);
end;

procedure TBlockSerial.ExceptCheck;
var
  e: ESynaSerError;
  s: string;
begin
  if FRaiseExcept and (FLastError <> sOK) then
  begin
    s := GetErrorDesc(FLastError);
    e := ESynaSerError.CreateFmt('Communication error %d: %s', [FLastError, s]);
    e.ErrorCode := FLastError;
    e.ErrorMessage := s;
    raise e;
  end;
end;

procedure TBlockSerial.SetSynaError(ErrNumber: integer);
begin
  FLastError := ErrNumber;
  FLastErrorDesc := GetErrorDesc(FLastError);
end;

procedure TBlockSerial.RaiseSynaError(ErrNumber: integer);
begin
  SetSynaError(ErrNumber);
  ExceptCheck;
end;

procedure TBlockSerial.DoStatus(Reason: THookSerialReason; const Value: string);
begin
  if assigned(OnStatus) then
    OnStatus(Self, Reason, Value);
end;

{======================================================================}

class function TBlockSerial.GetErrorDesc(ErrorCode: integer): string;
begin
  Result:= '';
  case ErrorCode of
    sOK:               Result := 'OK';
    ErrAlreadyOwned:   Result := 'Port owned by other process';
    ErrAlreadyInUse:   Result := 'Instance already in use';
    ErrWrongParameter: Result := 'Wrong parameter at call';
    ErrPortNotOpen:    Result := 'Instance not yet connected';
    ErrNoDeviceAnswer: Result := 'No device answer detected';
    ErrMaxBuffer:      Result := 'Maximal buffer length exceeded';
    ErrTimeout:        Result := 'Timeout during operation';
    ErrNotRead:        Result := 'Reading of data failed';
    ErrFrame:          Result := 'Receive framing error';
    ErrOverrun:        Result := 'Receive Overrun Error';
    ErrRxOver:         Result := 'Receive Queue overflow';
    ErrRxParity:       Result := 'Receive Parity Error';
    ErrTxFull:         Result := 'Tranceive Queue is full';
  end;
  if Result = '' then
  begin
    Result := SysErrorMessage(ErrorCode);
  end;
end;


{---------- cpom Comport Ownership Manager Routines -------------
 by Hans-Georg Joepgen of Stuttgart, Germany.
 Copyright (c) 2002, by Hans-Georg Joepgen

  Stefan Krauss of Stuttgart, Germany, contributed literature and Internet
  research results, invaluable advice and excellent answers to the Comport
  Ownership Manager.
}

{$IFDEF UNIX}

function TBlockSerial.LockfileName: String;
var
  s: string;
begin
  s := SeparateRight(FDevice, '/dev/');
  result := LockfileDirectory + '/LCK..' + s;
end;

procedure TBlockSerial.CreateLockfile(PidNr: integer);
var
  f: TextFile;
  s: string;
begin
  // Create content for file
  s := IntToStr(PidNr);
  while length(s) < 10 do
    s := ' ' + s;
  // Create file
  try
    AssignFile(f, LockfileName);
    try
      Rewrite(f);
      writeln(f, s);
    finally
      CloseFile(f);
    end;
    // Allow all users to enjoy the benefits of cpom
    s := 'chmod a+rw ' + LockfileName;
    fpSystem(s);
  except
    // not raise exception, if you not have write permission for lock.
    on Exception do
      ;
  end;
end;

function TBlockSerial.ReadLockfile: integer;
{Returns PID from Lockfile. Lockfile must exist.}
var
  f: TextFile;
  s: string;
begin
  AssignFile(f, LockfileName);
  Reset(f);
  try
    readln(f, s);
  finally
    CloseFile(f);
  end;
  Result := StrToIntDef(s, -1)
end;

function TBlockSerial.cpomComportAccessible: boolean;
var
  MyPid: integer;
  Filename: string;
begin
  Filename := LockfileName;
  MyPid := fpGetPid;
  // Make sure, the Lock Files Directory exists. We need it.
  if not DirectoryExists(LockfileDirectory) then
    CreateDir(LockfileDirectory);
  // Check the Lockfile
  if not FileExists (Filename) then
  begin // comport is not locked. Lock it for us.
    CreateLockfile(MyPid);
    result := true;
    exit;  // done.
  end;
  // Is port owned by orphan? Then it's time for error recovery.
  //FPC forgot to add getsid.. :-(
  result := false // Sorry, port is owned by living PID and locked
end;

procedure TBlockSerial.cpomReleaseComport;
begin
  DeleteFile(LockfileName);
end;

{$ENDIF}

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

{$IFDEF UNIX}

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


end.
