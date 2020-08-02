program Project1;

{$H-,J-,O-}

uses
  intrinsics;

procedure Delay;
var
  i:Int16;
begin
   for i:=0 to 30000 do;
end;

const
  pin2=1 shl 2;


begin
  // Setup

  PORTC.DIRSET:=pin2;

  repeat
    // Loop;
//    PORTC.OUTTGL:=pin2;
//    Delay;

    PORTC.OUTSET:=pin2;
    Delay;
    PORTC.OUTCLR:=pin2;
    Delay;

  until false;
end.
