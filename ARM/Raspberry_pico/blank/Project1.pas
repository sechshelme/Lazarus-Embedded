program Project1;

{$mode objfpc}
{$H+}
{$O-}

{$L platform.c.obj}

{$L clocks.c.obj}
{$L xosc.c.obj}
{$L pll.c.obj}
{$L watchdog.c.obj}

{$L boot2_pico.obj}
{$LinkLib gcc-armv6m,static}
{$L gpio.c.obj}

{$MEMORY 10000,10000}

procedure gpio_init(gpio:Byte);cdecl; external;
procedure clocks_init; cdecl; external;

procedure runtime_init;
var
  lw:LongWord;
const
  RESETS_SAFE_BITS=     %1111111111100110110111111;
  RESETS_PRECLOCK_BITS= %0001111000100110110111110;
  RESETS_POSTCLOCK_BITS=%1110000111000000000000001;
begin
//  $4000c000

  pLongWord(pointer(@resets.reset) + $2000)^ := RESETS_SAFE_BITS;
  pLongWord(pointer(@resets.reset) + $3000)^ := RESETS_PRECLOCK_BITS;
  repeat
  until (resets.reset_done and RESETS_PRECLOCK_BITS) = RESETS_PRECLOCK_BITS;
  clocks_init;
  pLongWord(pointer(@resets.reset) + $3000)^ := RESETS_POSTCLOCK_BITS;
  repeat
  until (resets.reset_done and RESETS_POSTCLOCK_BITS) = RESETS_POSTCLOCK_BITS;
end;


procedure Delay;
var
  i:Integer;
begin
  for i:=0 to 600000 do;
end;

begin
  runtime_init;
  gpio_init(25);
  sio.gpio_oe_set := 1 shl 25;
  repeat
    sio.gpio_togl := 1 shl 25;
    Delay;
  until 1=0;
end.

