program GPIO_Write;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 1500 do begin
      asm
               Nop end;
    end;
  end;

type
  TMaske = array[0..7] of byte;

const
  maxZiffern = 10;
  Ziffern: array[0..maxZiffern - 1] of TMaske = ((
    %11100000,
    %10100000,
    %10100000,
    %10100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %01000000,
    %11000000,
    %01000000,
    %01000000,
    %01000000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %00100000,
    %11100000,
    %10000000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %00100000,
    %11100000,
    %00100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %10100000,
    %10100000,
    %11100000,
    %00100000,
    %00100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10000000,
    %11100000,
    %00100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10000000,
    %11100000,
    %10100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %00100000,
    %00100000,
    %00100000,
    %00100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10100000,
    %11100000,
    %10100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10100000,
    %11100000,
    %00100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000));

var
  Zaehler: integer = 0;
  p, Zahl: integer;
const
  Zae=300;

begin
  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (1 shl 4); // Clock für GPIOC freigeben.
  RCC.APB2ENR := RCC.APB2ENR or (1 shl 3); // Clock für GPIOB freigeben.
  RCC.APB2ENR := RCC.APB2ENR or (1 shl 2); // Clock für GPIOA freigeben.

  // Ports auf Ausgabe schalten
  PortA.CRL := $33333333;
  PortA.CRH := $33333333;
  PortB.CRL := $33333333;
  PortB.CRH := $33333333;
  PortC.CRL := $33333333;
  PortC.CRH := $33333333;

  Zahl := 3;
  p := 0;

  while True do begin
    Inc(Zaehler);
    if Zaehler >= Zae shl 1 then begin
      Zaehler := 0;
    end;

    if Zaehler < Zae then begin
      PortC.BSRR := 1 shl 13;
    end else begin
      PortC.BRR := 1 shl 13;
    end;

    if Zaehler = 0 then begin
      Inc(Zahl);
      if Zahl >= 10 then begin
        Zahl := 0;
      end;
    end;

    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    PortA.ODR := 1 shl p;
    PortB.ODR := (Ziffern[Zahl, p] or ((Ziffern[(Zahl + 2) mod 10, p]) shr 5)) shl 8;

    Delay;
  end;
end.

