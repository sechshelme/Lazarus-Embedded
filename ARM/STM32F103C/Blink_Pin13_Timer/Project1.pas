program Project1;

uses
  cortexm3;

const
  TIM_CR1_CEN = 1; //  #define TIM_CR1_CEN  BIT(0)
  RCC_APB1ENR_TIM2EN = 1;

  TIM_DIER_CC1IE: uInt16 = $0002;  // Capture/Compare 1 interrupt enable
  TIM2_IRQn = 28;     // TIM2 global Interrupt
  TIM_SR_CC1IF: uInt16 = $0002;  // Capture/Compare 1 interrupt Flag

var
  c:Integer;

  procedure Timer2Init;
  begin
    //RCC enable for Timer2
    RCC.APB1ENR := RCC.APB1ENR or RCC_APB1ENR_TIM2EN;

    ////Timer settings ----------------
    //Various settings in default
    Timer2.CR1 := $0000; //Control register 1; Wait with timer enable until settings complete
    Timer2.CR2 := $0000; //Control register 2
    Timer2.CCMR1 := $0000; //Capture/compare mode register
    Timer2.CCER := $0000; //Capture/compare enable register

    //Prescaler
    Timer2.PSC := 2000;
    //AutoReload value
    Timer2.Arr := 10;

    //DMA and Interrupt control register
    Timer2.DIER := TIM_DIER_CC1IE; //Compare 1 interrupt enable
    //---------------------------------

    // NVIC configuration
    NVIC.IP[Tim2_IRQn] := $20;     //IRQ-Priority, right 4bits always to be zero
    NVIC.ISER[Tim2_IRQn shr 5] := 1 shl (Tim2_IRQn and $1F); //Enable Interrupt

    //Enable Counter
    Timer2.CR1 := Timer2.CR1 or TIM_CR1_CEN;

  end;

  procedure Timer2_Interrupt; public Name 'TIM2_global_interrupt'; interrupt;
  begin
    Timer2.SR := Timer2.SR and not TIM_SR_CC1IF; //clear CC1IF

    Inc(c);
    if c >= 100 then begin
      PortC.ODR := not PortC.ODR;
      c := 0;
    end;

  end;


begin
  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%111 shl 2);

  // Ports auf Ausgabe schalten
  PortA.CRL := $33333333;
  PortA.CRH := $33333333;

  PortB.CRL := $33333333;
  PortB.CRH := $33333333;

  PortC.CRL := $33333333;
  PortC.CRH := $33333333;

  // Timer
  Timer2Init;

  repeat

  until False;
end.
