program Project1;

{$H-,J-,O-}

uses
  cortexm3;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 100000 do begin
      asm
               Nop // Leerbefehl
      end;
    end;
  end;

const
  led = 1 shl 27;

begin
  PIOB.PER := led;
  PIOB.OER := led;

//  WDT.MR := 1 shl 15; // Watchdog deaktivieren


  repeat
    // Pin13 -- High
    WDT.CR:= $A5000001;

    PIOB.SODR := led;
    Delay;

    // Pin13 -- Low
    PIOB.CODR := led;
    Delay;
  until False;
end.

