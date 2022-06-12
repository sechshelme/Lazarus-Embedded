// Multi Function Shield - LED Blink

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  sl = 100000;

type
  TSetLed = set of (BP0, BP1, BP2, BP3, BP4, BP5, BP6, BP7);

var
  LedPORT: TSetLed absolute PORTB;
  LedDDR: TSetLed absolute DDRB;
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

  LedDDR := [BP2, BP3, BP4, BP5];
  repeat
    for i := 0 to 3 do begin
      LedPORT := [BP2, BP3, BP4];
      mysleep(sl);

      LedPORT := [BP2, BP3, BP5];
      mysleep(sl);

      LedPORT := [BP2, BP4, BP5];
      mysleep(sl);

      LedPORT := [BP3, BP4, BP5];
      mysleep(sl);
    end;
  until False;
end.
