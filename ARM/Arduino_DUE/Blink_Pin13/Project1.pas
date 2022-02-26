program Project1;

{$H-,J-,O-}

uses
  cortexm3;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 9000000 do begin
      asm
               Nop end; // Leerbefehl
    end;
  end;

  procedure Delay_ms(x: Int32);
  var
    y: Int32;
  begin
    y := RTT.VR + x;
    while y >= RTT.VR do begin
    end;
  end;

const
  led = 1 shl 27;

begin
  PMC.PCER0 := 1 shl 12;
  PIOB.PER := 1 shl 27;
  PIOB.OER := 1 shl 27;

  repeat
    // Pin13 -- High
    PIOB.SODR := 1 shl 27;
    Delay;

    // Pin13 -- Low
    PIOB.CODR := 1 shl 27;
    Delay;
  until False;
end.

