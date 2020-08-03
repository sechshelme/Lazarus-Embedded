program Project1;

{$H-,J-,O-}

uses
  intrinsics;

  procedure Delay;
  var
    i: Int16;
  begin
    for i := 0 to 30000 do begin
    end;
  end;

const
  pin0 = 1 shl 0;
  pin1 = 1 shl 1;
  pin2 = 1 shl 2;
  pin3 = 1 shl 3;
  pin4 = 1 shl 4;
  pin5 = 1 shl 5;
  pin6 = 1 shl 6;
  pin7 = 1 shl 7;

begin
  // Setup

  PORTC.DIRSET := %11111111;
  PORTF.DIRSET := pin5;

  repeat
    // Schaltet Pin um
    PORTC.OUTTGL := pin2;
    PORTC.OUTTGL := pin3;
    PORTF.OUTTGL := pin5;

    // Klassisch
    PORTC.OUT_ := PORTC.OUT_ or pin1;
    Delay;
    PORTC.OUT_ := PORTC.OUT_ and not pin1;
    Delay;

    // Setzt Pin
    PORTC.OUTSET := pin0;
    Delay;
    // Löscht Pin
    PORTC.OUTCLR := pin0;
    Delay;

  until False;
end.
