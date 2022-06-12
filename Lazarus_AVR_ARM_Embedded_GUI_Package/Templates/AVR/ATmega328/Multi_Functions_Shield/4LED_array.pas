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

  ddr[2] := True;
  ddr[3] := True;
  ddr[4] := True;
  ddr[5] := True;

  port[2] := True;
  port[3] := True;
  port[4] := True;
  port[5] := True;

  repeat
    for i := 0 to 3 do begin
      port[5] := True;
      port[2] := False;
      mysleep(sl);

      port[2] := True;
      port[3] := False;
      mysleep(sl);

      port[3] := True;
      port[4] := False;
      mysleep(sl);

      port[4] := True;
      port[5] := False;
      mysleep(sl);
    end;
  until False;
end.
