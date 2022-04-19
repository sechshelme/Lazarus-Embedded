program stm32Blink;

uses
  cortexm3;

{$O-}

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 400000 do
    begin
      asm
               NOP
      end; // Leerbefehl
    end;
  end;

begin
  RCC.APB2ENR := RCC.APB2ENR or (1 shl 4); // Clock für PortC freigeben.
  RCC.APB2ENR := RCC.APB2ENR or (1 shl 3); // Clock für PortB freigeben.
  RCC.APB2ENR := RCC.APB2ENR or (1 shl 2); // Clock für PortA freigeben.

  // Pin P13 von PortC auf Output.
  PortC.CRH := $00300000;

  // Hinweis: Die LED leuchtet bei LOW.
  repeat

    // Pin13 -- High
    PortC.BSRR := 1 shl 13;
    Delay;

    // Pin13 -- Low
    PortC.BRR := 1 shl 13;
    Delay;
  until False;
end.
