program Blinker_PC13;

procedure Delay;
var
  i: uint32;
begin
  for i := 0 to 500000 do begin
    asm nop end; // Leerbefehl
  end;
end;

begin
  // PortC einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%1 shl 4);

  // Pin P13 von PortC aud Output.
  PortC.CRH := $00300000;

  // Hinweis: Die LED leuchtet bei LOW.
  while true do begin

    // Pin13 -- High
    PortC.BSRR := 1 shl 13;
    Delay;

    // Pin13 -- Low
    PortC.BRR := 1 shl 13;
    Delay;
  end;
end.
