unit I2CEEPROM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, I2C;

type

  { TI2CEEPROM }

  TI2CEEPROM = class(TObject)
  private
    Device_Addr: integer;
    FPosition: Int16;
    I2C_Class: TI2C;
    procedure SetPosition(AValue: Int16);
  public
    property Position: Int16 read FPosition write SetPosition;
    constructor Create(Ai2c: TI2C; ADevice_Addr: integer);
    destructor Destroy; override;

    procedure WriteChar(ch: char);
    procedure WriteString(s: string);

    function ReadChar(): char;
    function ReadString: string;
  end;

implementation

{ TI2CEEPROM }

procedure TI2CEEPROM.SetPosition(AValue: Int16);
begin
  if FPosition = AValue then begin
    Exit;
  end;
  FPosition := AValue;
end;

constructor TI2CEEPROM.Create(Ai2c: TI2C; ADevice_Addr: integer);
begin
  inherited Create;

  Device_Addr := ADevice_Addr;
  I2C_Class := Ai2c;

  FPosition := 0;
end;

destructor TI2CEEPROM.Destroy;
begin
  inherited Destroy;
end;

procedure TI2CEEPROM.WriteChar(ch: char);
var
  buf: packed array of byte;
begin
  SetLength(buf, 3);

  buf[0] := FPosition shr 8;
  buf[1] := FPosition and $FF;
  buf[2] := byte(ch);

  I2C_Class.SetDevice(Device_Addr);
  I2C_Class.writeBuf(buf);

  Sleep(10);

  Inc(FPosition);
end;

procedure TI2CEEPROM.WriteString(s: string);
var
  i: integer;
  l: Int16;
begin
  l := Length(s);
  WriteChar(char(l shr 8));
  WriteChar(char(l and $FF));
  for i := 1 to Length(s) do begin
    WriteChar(s[i]);
  end;
end;

function TI2CEEPROM.ReadChar: char;
var
  buf: packed array[0..1] of byte;
  rbuf: byte;
begin
  buf[0] := FPosition shr 8;
  buf[1] := FPosition and $FF;

  I2C_Class.SetDevice(Device_Addr);
  I2C_Class.writeBuf(buf);

  rbuf := 32;
  I2C_Class.readBuf(rbuf);
  Result := char(rbuf);

  Inc(FPosition);
end;

function TI2CEEPROM.ReadString: string;
var
  i: integer;
  l: Int16;
begin
  l := (byte(ReadChar) shl 8) + byte(ReadChar);

  SetLength(Result, l);
  for i := 1 to l do begin
    Result[i] := ReadChar;
  end;
end;

end.
