program Timer_Blink;

uses
  cortexm3;


const
  TIM_CR1_CEN: uInt16 = $0001;            // Counter enable
  RCC_APB1ENR_TIM2EN: uInt32 = $00000001; // TIM2 clock enabled

  TIM_DIER_CC1IE: uInt16 = $0002;         // Capture/Compare 1 interrupt enable
  TIM_SR_CC1IF: uInt16 = $0002;           // Capture/Compare 1 interrupt Flag
  TIM2_IRQn = 28;                         // TIM2 global Interrupt

type
  TLed = bitpacked array[0..15] of boolean;

var
  LedC: TLed absolute PortC.ODR;

  procedure Timer2_Interrupt; public Name 'TIM2_global_interrupt'; interrupt;
  begin
    TIMer2.SR := TIMer2.SR and not TIM_SR_CC1IF; // clear CC1IF
    LedC[13] := not LedC[13];   // LED PC13  umschalten
  end;

begin
  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%111 shl 2);

  // Ports auf Ausgabe schalten
  PortC.CRL := $33333333;
  PortC.CRH := $33333333;

  // --- Timer ---
  // RCC enable for Timer2
  RCC.APB1ENR := RCC.APB1ENR or RCC_APB1ENR_TIM2EN;

  // Various settings in default
  Timer2.CR1 := $0000;   // Control register 1; Wait with timer enable until settings complete
  Timer2.CR2 := $0000;   // Control register 2
  Timer2.CCMR1 := $0000; // Capture/compare mode register
  Timer2.CCER := $0000;  // Capture/compare enable register

  // Prescaler
  TIMer2.PSC := 1000;
  // AutoReload value
  TIMer2.ARR := 1000;

  // DMA and Interrupt control register
  Timer2.DIER := TIM_DIER_CC1IE; // Compare 1 interrupt enable

  // Enable Counter
  Timer2.CR1 := Timer2.CR1 or TIM_CR1_CEN;

  // NVIC configuration
  NVIC.IP[TIM2_IRQn] := $20;   // IRQ-Priority, right 4bits always to be zero
  NVIC.ISER[TIM2_IRQn shr 5] := 1 shl (TIM2_IRQn and $1F); // Enable Interrupt

  while True do begin
  end;
end.
