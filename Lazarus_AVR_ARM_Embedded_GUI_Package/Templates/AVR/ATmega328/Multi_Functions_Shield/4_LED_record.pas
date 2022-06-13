// Multi Function Shield - 4 LED Blink

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  sl = 100000;

type
  TPin = bitpacked record
    BP0, BP1, BP2, BP3, BP4, BP5, BP6, BP7: boolean;
  end;

var
  ddr:  TPin absolute DDRB;
  port: TPin absolute PORTB;

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
  // BP2 = D4, BP3 = D3, BP4 = D2, BP5 = D1
  // LED schalten inventiert, da Anode an VCC !

  ddr.BP2 := True;
  ddr.BP3 := True;
  ddr.BP4 := True;
  ddr.BP5 := True;

  port.BP2 := True;
  port.BP3 := True;
  port.BP4 := True;
  port.BP5 := True;

  repeat
    for i := 0 to 3 do begin
      port.BP5 := True;
      port.BP2 := False;
      mysleep(sl);

      port.BP2 := True;
      port.BP3 := False;
      mysleep(sl);

      port.BP3 := True;
      port.BP4 := False;
      mysleep(sl);

      port.BP4 := True;
      port.BP5 := False;
      mysleep(sl);
    end;
  until False;
end.
