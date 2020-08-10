program Project1;

const
  d0 = 10000;
  d1 = 50000;


  procedure Delay0;
  var
    i: uint32;
  begin
    for i := 0 to d0 do begin
    end;
  end;

  procedure Delay1;
  var
    i: uint32;
  begin
    for i := 0 to d1 do begin
    end;
  end;

begin
  EFC0.FMR := (EFC0.FMR and $FFFFF0FF) or (5 shl 8);
  WDT.MR := 1 shl 15;
  //PMC.PCER0 := 1 shl 12;
  PIOB.PER := 1 shl 27;
  PIOB.OER := 1 shl 27;

  repeat
    PIOB.CODR := 1 shl 27;
    Delay0;
    PIOB.SODR := 1 shl 27;
    Delay1;
  until False;
end.
