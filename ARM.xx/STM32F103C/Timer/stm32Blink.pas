program GPIO_Write;

uses
  cortexm3;

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
  Zahl: integer;

const
  TIM_CR1_CEN = 1; //  #define TIM_CR1_CEN  BIT(0)
  RCC_APB1ENR_TIM2EN = 1;

  TIM_DIER_CC1IE: uInt16 = $0002;  // Capture/Compare 1 interrupt enable
  TIM2_IRQn = 28;     // TIM2 global Interrupt
  TIM_SR_CC1IF: uInt16 = $0002;  // Capture/Compare 1 interrupt Flag

  procedure Multi;
  const
    p: integer = 0;
  begin
    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    gpioA.ODR := 1 shl p;
    gpioB.ODR := (Ziffern[Zahl, p] or ((Ziffern[(Zahl + 2) mod 10, p]) shr 5)) shl 8;
  end;

  procedure Timer2Init;
  begin
    //RCC enable for Timer2
    RCC.APB1ENR := RCC.APB1ENR or RCC_APB1ENR_TIM2EN;

    ////Timer settings ----------------
    //Various settings in default
    Tim2.CR1 := $0000; //Control register 1; Wait with timer enable until settings complete
    Tim2.CR2 := $0000; //Control register 2
    Tim2.CCMR1 := $0000; //Capture/compare mode register
    Tim2.CCER := $0000; //Capture/compare enable register

    //Prescaler
    Tim2.PSC := 2000;
    //AutoReload value
    Tim2.Arr := 10;

    //DMA and Interrupt control register
    Tim2.DIER := TIM_DIER_CC1IE; //Compare 1 interrupt enable
    //---------------------------------

    // NVIC configuration
    NVIC.IP[TIM2_IRQn] := $20;     //IRQ-Priority, right 4bits always to be zero
    NVIC.ISER[TIM2_IRQn shr 5] := 1 shl (TIM2_IRQn and $1F); //Enable Interrupt

    //Enable Counter
    Tim2.CR1 := Tim2.CR1 or TIM_CR1_CEN;

  end;

  procedure Timer1_Interrupt; public Name 'TIM2_interrupt'; interrupt;
  begin
    Tim2.SR := Tim2.SR and not TIM_SR_CC1IF; //clear CC1IF
    multi;
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
  Timer2Init;

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

    Delay;
  end;
end.
