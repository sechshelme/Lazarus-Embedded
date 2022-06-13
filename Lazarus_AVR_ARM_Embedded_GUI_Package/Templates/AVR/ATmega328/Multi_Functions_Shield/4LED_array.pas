// Multi Function Shield - 4 LED Blink

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  sl = 100000;

var
  ddr: bitpacked array[0..7] of boolean absolute DDRB;
  port: bitpacked array[0..7] of boolean absolute PORTB;

  i: byte;

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do begin
      asm
               Nop;
      end;
    end;
  end;

begin
  // LED schalten inventiert, da Anode an VCC !

  for i := 2 to 5 do begin
    ddr[i] := True;
    port[i] := True;
  end;

  repeat
    for i := 0 to 3 do begin
      port[i + 2] := False;
      mysleep(sl);
      port[i + 2] := True;
    end;
  until False;
end.
