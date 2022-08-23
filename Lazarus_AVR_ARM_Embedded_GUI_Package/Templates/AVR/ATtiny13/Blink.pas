program Project1;

uses
  intrinsics;

{$O-}

const
  sl     = 20000;  // Verzögerung
  LEDPin = 2;

  procedure mysleep(t: int32); // Ein einfaches Delay.
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

begin
  DDRB := DDRB or (1 shl LEDPin);
  repeat
    PORTB := PORTB or (1 shl LEDPin);
    mysleep(sl);

    PORTB := PORTB and not (1 shl LEDPin);
    mysleep(sl);
  until False;
end.
