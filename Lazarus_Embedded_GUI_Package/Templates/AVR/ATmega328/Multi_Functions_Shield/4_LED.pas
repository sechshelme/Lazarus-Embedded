// Multi Function Shield - 4 LED Blink

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  sl = 100000;
  BP2 = 2;
  BP3 = 3;
  BP4 = 4;
  BP5 = 5;

var
  i: byte;

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

begin
  // BP2 = D4, BP3 = D3, BP4 = D2, BP5 = D1
  // LED schalten inventiert, da Anode an VCC !

  DDRB  := (1 shl BP2) or (1 shl BP3) or (1 shl BP4) or (1 shl BP5);
  PORTB := (1 shl BP2) or (1 shl BP3) or (1 shl BP4) or (1 shl BP5);

  repeat
    for i := 0 to 3 do begin
      PORTB := PORTB or (1 shl BP5);
      PORTB := PORTB and not (1 shl BP2);
      mysleep(sl);

      PORTB := PORTB or (1 shl BP2);
      PORTB := PORTB and not (1 shl BP3);
      mysleep(sl);

      PORTB := PORTB or (1 shl BP3);
      PORTB := PORTB and not (1 shl BP4);
      mysleep(sl);

      PORTB := PORTB or (1 shl BP4);
      PORTB := PORTB and not (1 shl BP5);
      mysleep(sl);
    end;
  until False;
end.
