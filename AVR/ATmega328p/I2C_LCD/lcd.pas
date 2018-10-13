unit lcd;

{$H-}
{$O-}

interface

uses
  twi;

type

  TCharMap = packed array[0..7] of  byte;

  { TLCD }

  TLCD = object
  private
    Device_Addr: longint;

    backlightStsMask,
    displayMode,
    displayControl: byte;

    procedure write4Bits(Value: byte);
    procedure send(Value: byte; mode: byte);

    procedure command(Value: int16);

  public
    constructor Create(ADevice_Addr: integer);
    destructor Destroy;

    procedure Write(s: string);

    procedure Clear;
    procedure home;

    procedure backlight(Value: boolean);

    procedure blink(Value: boolean);
    procedure cursor(Value: boolean);
    procedure display(Value: boolean);

    procedure setCursor(x, y: integer);
    procedure scrollDisplayLeft;
    procedure scrollDisplayRight;

    procedure leftToRight(Value: boolean);
    procedure Autoscroll(Value: boolean);

    procedure createChar(location: byte; const charMap: TCharMap);
  end;

implementation

const
  LCD_BLINK_ON = $01;
  LCD_CURSOR_ON = $02;
  LCD_DISPLAY_ON = $04;
  LCD_SET_DDRAM_ADDR = $80;
  LCD_CLEARDISPLAY = $01;
  LCD_RETURNHOME = $02;
  BACKLIGHT_MASK = $08;

  LCD_SETCGRAMADDR = $40;

  LCD_DISPLAYMOVE = $08;
  LCD_CURSORSHIFT = $10;
  LCD_MOVERIGHT = $04;
  LCD_MOVELEFT = $00;
  LCD_ENTRYLEFT = $02;
  LCD_ENTRYMODESET = $04;
  LCD_ENTRYSHIFTINCREMENT = $01;


{ TLCD }

constructor TLCD.Create(ADevice_Addr: integer);
begin
  displayControl := $08;

  Device_Addr := ADevice_Addr;

  backlightStsMask := BACKLIGHT_MASK;

  write4Bits($03 shl 4);
  write4Bits($03 shl 4);
  write4Bits($03 shl 4);
  write4Bits($02 shl 4);

  displayMode := LCD_ENTRYLEFT or LCD_ENTRYSHIFTINCREMENT;
  command(LCD_ENTRYMODESET);

  display(True);
end;

destructor TLCD.Destroy;
begin
  Clear;
  backlight(False);
end;

procedure TLCD.write4Bits(Value: byte);
const
  ENABLE_MASK: byte = $04;

  procedure Sleep;
  var
    i: Integer;
  begin
    for i := 1 to 1000 do asm nop end;
  end;

begin
  TWIwriteByte(Device_Addr, Value or ENABLE_MASK or backlightStsMask);
  Sleep;
  TWIwriteByte(Device_Addr, (Value and not ENABLE_MASK) or backlightStsMask);
  Sleep;
end;

procedure TLCD.send(Value: byte; mode: byte);
var
  highnib, lownib: byte;
begin
  highnib := Value and $F0;
  lownib := (Value and $0f) shl 4;
  write4Bits(highnib or mode);
  write4Bits(lownib or mode);
end;

procedure TLCD.command(Value: int16);
begin
  send(Value, $00);
end;

procedure TLCD.Write(s: string);
var
  i: integer;
begin
  for i := 1 to Length(s) do begin
    send(byte(s[i]), $01);
  end;
end;

procedure TLCD.Clear;
begin
  command(LCD_CLEARDISPLAY);
end;

procedure TLCD.home;
begin
  command(LCD_RETURNHOME);
end;

procedure TLCD.backlight(Value: boolean);
begin
  if Value then begin
    backlightStsMask := BACKLIGHT_MASK;
  end else begin
    backlightStsMask := $00;
  end;

  TWIwriteByte(Device_Addr, backlightStsMask);
end;

procedure TLCD.blink(Value: boolean);
begin
  if Value then begin
    displayControl := displayControl or LCD_BLINK_ON;
  end else begin
    displayControl := displayControl and not LCD_BLINK_ON;
  end;
  command(displayControl);
end;

procedure TLCD.cursor(Value: boolean);
begin
  if Value then begin
    displayControl := displayControl or LCD_CURSOR_ON;
  end else begin
    displayControl := displayControl and not LCD_CURSOR_ON;
  end;
  command(displayControl);
end;

procedure TLCD.display(Value: boolean);
begin
  if Value then begin
    displayControl := displayControl or LCD_DISPLAY_ON;
  end else begin
    displayControl := displayControl and not LCD_DISPLAY_ON;
  end;
  command(displayControl);
end;

procedure TLCD.setCursor(x, y: integer);
const
  ROW_ADDR: array [0..3] of byte = ($00, $40, $14, $54);
begin
  command(LCD_SET_DDRAM_ADDR + (ROW_ADDR[y mod 4] + x));
end;

procedure TLCD.scrollDisplayLeft;
begin
  command(LCD_CURSORSHIFT or LCD_DISPLAYMOVE or LCD_MOVELEFT);
end;

procedure TLCD.scrollDisplayRight;
begin
  command(LCD_CURSORSHIFT or LCD_DISPLAYMOVE or LCD_MOVERIGHT);
end;

procedure TLCD.leftToRight(Value: boolean);
begin
  if Value then begin
    displayMode := displayMode or LCD_ENTRYLEFT;
  end else begin
    displayMode := displayMode and not LCD_ENTRYLEFT;
  end;
  command(LCD_ENTRYMODESET or displayMode);
end;

procedure TLCD.Autoscroll(Value: boolean);
begin
  if Value then begin
    displayMode := displayMode or LCD_ENTRYSHIFTINCREMENT;
  end else begin
    displayMode := displayMode and not LCD_ENTRYSHIFTINCREMENT;
  end;
  command(LCD_ENTRYMODESET or displayMode);
end;

procedure TLCD.createChar(location: byte; const charMap: TCharMap);
var
  i: integer;
begin
  command(LCD_SETCGRAMADDR or ((location and $07) shl 3));
  for i := 0 to 7 do begin
    Self.Write(char(charMap[i]));
  end;
end;

end.
