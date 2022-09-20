program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  BP7 = 7; // Pin 13 des Arduino
  sl  = 60000;

  procedure mysleep(t: int32);
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

begin
  DDRB := DDRB or (1 shl BP7);
  repeat
    PORTB := PORTB or (1 shl BP7);
    mysleep(sl);

    PORTB := PORTB and not (1 shl BP7);
    mysleep(sl);
  until False;
end.
