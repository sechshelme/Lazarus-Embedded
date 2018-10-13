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


var
  Zaehler: integer = 0;
  Zahl: integer;

const
  TIM_CR1_CEN: uInt16 = $0001;  // Counter enable
  RCC_APB1ENR_TIM2EN: uInt32 = $00000001;  // Timer 2 clock enabled
  RCC_APB1ENR_TIM3EN: uInt32 = $00000002;  // Timer 3 clock enable
  RCC_APB1ENR_TIM4EN: uInt32 = $00000004;  // Timer 4 clock enable

  TIM_DIER_CC1IE: uInt16 = $0002;  // Capture/Compare 1 interrupt enable
  TIM_SR_CC1IF: uInt16 = $0002;  // Capture/Compare 1 interrupt Flag
  TIM2_IRQn = 28;     // TIM2 global Interrupt
  TIM3_IRQn = 29;     // TIM3 global Interrupt
  TIM4_IRQn = 30;     // TIM4 global Interrupt

type
  TLed = bitpacked array[0..15] of boolean;

  // A = 0-7
  // B = 8-15

var
  LedA: TLed absolute gpioA.ODR;
  LedB: TLed absolute gpioB.ODR;
  LedC: TLed absolute gpioC.ODR;

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

    //Enable Counter
    Tim2.CR1 := Tim2.CR1 or TIM_CR1_CEN;

    // NVIC configuration
    NVIC.IP[TIM2_IRQn] := $20;     //IRQ-Priority, right 4bits always to be zero
    NVIC.ISER[TIM2_IRQn shr 5] := 1 shl (TIM2_IRQn and $1F); //Enable Interrupt

  end;

  procedure Timer3Init;
  begin
    //RCC enable for Timer3
    RCC.APB1ENR := RCC.APB1ENR or RCC_APB1ENR_TIM3EN;

    ////Timer settings ----------------
    //Various settings in default
    Tim3.CR1 := $0000; //Control register 1; Wait with timer enable until settings complete
    Tim3.CR2 := $0000; //Control register 2
    Tim3.CCMR1 := $0000; //Capture/compare mode register
    Tim3.CCER := $0000; //Capture/compare enable register

    //Prescaler
    Tim3.PSC := 2000;
    //AutoReload value
    Tim3.Arr := 11;

    //DMA and Interrupt control register
    Tim3.DIER := TIM_DIER_CC1IE; //Compare 1 interrupt enable
    //---------------------------------

    //Enable Counter
    Tim3.CR1 := Tim3.CR1 or TIM_CR1_CEN;

    // NVIC configuration
    NVIC.IP[TIM3_IRQn] := $20;     //IRQ-Priority, right 4bits always to be zero
    NVIC.ISER[TIM3_IRQn shr 5] := 1 shl (TIM3_IRQn and $1F); //Enable Interrupt

  end;

  procedure Timer4Init;
  begin
    //RCC enable for Timer2
    RCC.APB1ENR := RCC.APB1ENR or RCC_APB1ENR_TIM4EN;

    ////Timer settings ----------------
    //Various settings in default
    Tim4.CR1 := $0000; //Control register 1; Wait with timer enable until settings complete
    Tim4.CR2 := $0000; //Control register 2
    Tim4.CCMR1 := $0000; //Capture/compare mode register
    Tim4.CCER := $0000; //Capture/compare enable register

    //Prescaler
    Tim4.PSC := 2000;
    //AutoReload value
    Tim4.Arr := 19;

    //DMA and Interrupt control register
    Tim4.DIER := TIM_DIER_CC1IE; //Compare 1 interrupt enable
    //---------------------------------

    //Enable Counter
    Tim4.CR1 := Tim4.CR1 or TIM_CR1_CEN;

    // NVIC configuration
    NVIC.IP[TIM4_IRQn] := $20;     //IRQ-Priority, right 4bits always to be zero
    NVIC.ISER[TIM4_IRQn shr 5] := 1 shl (TIM4_IRQn and $1F); //Enable Interrupt

  end;

  procedure Timer2_Interrupt; public Name 'TIM2_interrupt'; interrupt;
  const
    p: integer = 0;
  begin
    Tim2.SR := Tim2.SR and not TIM_SR_CC1IF; //clear CC1IF
    Inc(p);
    if p >= 80 then begin
      p := 0;
      LedA[2] := not LedA[2];
    end;
  end;

  procedure Timer3_Interrupt; public Name 'TIM3_interrupt'; interrupt;
  const
    p: integer = 0;
  begin
    Tim3.SR := Tim3.SR and not TIM_SR_CC1IF; //clear CC1IF
    Inc(p);
    if p >= 80 then begin
      p := 0;
      LedB[12] := not LedB[12];
    end;
  end;

  procedure Timer4_Interrupt; public Name 'TIM4_interrupt'; interrupt;
  const
    p: integer = 0;
  begin
    Tim4.SR := Tim4.SR and not TIM_SR_CC1IF; //clear CC1IF
    Inc(p);
    if p >= 80 then begin
      p := 0;
      LedB[10] := not LedB[10];
    end;
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
  Timer3Init;
  Timer4Init;

  while True do begin
    Inc(Zaehler);
    if Zaehler >= 600 then begin
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
