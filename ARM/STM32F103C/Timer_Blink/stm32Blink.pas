program GPIO_Write;

uses
  cortexm3,
  Timer;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 1500 do begin
      asm
               Nop end;
    end;
  end;


var
  Zaehler: integer = 0;
  Zahl: integer;

type
  TLed = bitpacked array[0..15] of boolean;

  // A = 0-7
  // B = 8-15

var
  LedA: TLed absolute gpioA.ODR;
  LedB: TLed absolute gpioB.ODR;
  LedC: TLed absolute gpioC.ODR;


  procedure Timer2_Interrupt;
  begin
    LedA[2] := not LedA[2];
  end;

  procedure Timer3_Interrupt;
  begin
    LedB[12] := not LedB[12];
  end;

  procedure Timer4_Interrupt;
  begin
    LedB[10] := not LedB[10];
  end;


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

  // Timer
  Timer2.Init(@Timer2_Interrupt, 2000, 1234);
  Timer3.Init(@Timer3_Interrupt, 2000, 2000);
  Timer4.Init(@Timer4_Interrupt, 1220, 2000);

  Timer4.Prescaler(1000);

  while True do begin
    Inc(Zaehler);
    if Zaehler >= 100 then begin
      Zaehler := 0;
    end;

    if Zaehler = 0 then begin
      LedC[13] := not LedC[13];
      Inc(Zahl);
      if Zahl >= 10 then begin
        Zahl := 0;
      end;
    end;

    Delay;
  end;
end.
