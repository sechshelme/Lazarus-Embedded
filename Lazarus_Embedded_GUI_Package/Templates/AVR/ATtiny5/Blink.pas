program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  sl = 5000;  // Verzögerung

  procedure mysleep(t: int32); // Ein einfaches Delay.
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

begin
  // Setup
  DDRB:=$FF;

  repeat
    // Loop;
    PORTB := $FF;
    mysleep(sl);

    PORTB := $00;
    mysleep(sl);

  until False;
end.
