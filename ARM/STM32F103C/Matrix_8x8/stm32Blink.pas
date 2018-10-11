program GPIO_Write;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 1500 do begin
      asm Nop end;
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

  TIM_CR1_CEN = 1; //  #define TIM_CR1_CEN	BIT(0)

begin
  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%111 shl 2);

  // Ports auf Ausgabe schalten
  gpioA.CRL := $33333333;
  gpioA.CRH := $33333333;

  gpioB.CRL := $33333333;
  gpioB.CRH := $33333333;

  gpioC.CRL := $33333333;
  gpioC.CRH := $33333333;

  Zahl := 2;

  TIM2.SR := 0;
  TIM2.PSC := 0;
  TIM2.ARR := $FFF;
  TIM2.CR1 := TIM2.CR1 or tim_cr1_cen;

  while True do begin
    Inc(Zaehler);
    if Zaehler >= 600 then begin
      Zaehler := 0;
    end;

    if Zaehler = 0 then begin
      gpioC.ODR := not gpioC.ODR;
      Inc(Zahl);
      if Zahl >= 10 then begin
        Zahl := 0;
      end;
    end;

    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    gpioA.ODR := 1 shl p;
    gpioB.ODR := (Ziffern[Zahl, p] or ((Ziffern[(Zahl + 2) mod 10, p]) shr 5)) shl 8;

    Delay;

  end;
end.
