program Project1;

procedure Delay;
var
  i: uint32;
begin
  for i := 0 to 130000 do
    ;
end;

begin
  EFC0.FMR := (EFC0.FMR and $fffff0ff) or (5 shl 8);
  WDT.MR := 1 shl 15;
  //PMC.PCER0 := 1 shl 12;
  PIOB.PER := 1 shl 27;
  PIOB.OER := 1 shl 27;

  while true do
  begin
    PIOB.CODR := 1 shl 27;
    Delay;
    PIOB.SODR := 1 shl 27;
    Delay;
  end;
end.
