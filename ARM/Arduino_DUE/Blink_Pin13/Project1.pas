program Project1;

{$H-,J-,O-}

uses
  cortexm3;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 1000000 do begin
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
  PIOB.PER := $FFFFFFFF;
  PIOB.OER := $FFFFFFFF;

//  RTT.MR := 32768 div 1000;

  PIOB.SODR := $ffffffff;
  repeat
    // Pin13 -- High
    PIOB.SODR := $FFFFFFFF;
    //    PortC.BSRR := 1 shl 13;
    Delay;

    // Pin13 -- Low
    PIOB.CODR := $FFFFFFFF;
    //    PortC.BRR := 1 shl 13;
    Delay;
  until False;
end.
