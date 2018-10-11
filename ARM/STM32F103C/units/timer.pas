unit uTimer2;
{$mode objfpc}
interface
uses
  STM32F10x_BitDefs, cortexm3;

var Timer2OnTimerCompare: Procedure;

    Procedure Timer2Init;
    procedure Timer2SetPrescaler(AValue: uInt16);
    procedure Timer2SetAutoReloadRegister(AValue: uInt16);
    Procedure Timer2Enable;
    Procedure Timer2Disable;


//##############################################################################
IMPLEMENTATION
uses
  uUART;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure Timer2Init;
begin

  //RCC enable for Timer2
  RCC.APB1ENR := RCC.APB1ENR or RCC_APB1ENR_TIM2EN;

  ////Timer settings ----------------
  //Various settings in default
  Timer2.CR1:=   $0000; //Control register 1; Wait with timer enable until settings complete
  Timer2.CR2:=   $0000; //Control register 2
  Timer2.CCMR1:= $0000; //Capture/compare mode register
  Timer2.CCER:=  $0000; //Capture/compare enable register

  //Prescaler
  Timer2.PSC:= 2000;
  //AutoReload value
  Timer2.Arr:= 10000;

  //DMA and Interrupt control register
  Timer2.DIER:= TIM_DIER_CC1IE; //Compare 1 interrupt enable
  //---------------------------------

  // NVIC configuration
  NVIC.IP[TIM2_IRQn]:= $20;     //IRQ-Priority, right 4bits always to be zero
  NVIC.ISER[TIM2_IRQn shr 5] := 1 shl (TIM2_IRQn and $1F); //Enable Interrupt

  //Enable Counter
  Timer2.CR1:= Timer2.CR1 or TIM_CR1_CEN;

end;

//---------------------------------------------------------
procedure Timer2SetPrescaler(AValue: uInt16);
begin
  Timer2Disable;
  Timer2.PSC:= AValue;
  Timer2Enable;
end;

//---------------------------------------------------------
procedure Timer2SetAutoReloadRegister(AValue: uInt16);
begin
  Timer2Disable;
  Timer2.Arr:= AValue;
  Timer2Enable;
end;

//---------------------------------------------------------
procedure Timer2Enable;
begin Timer2.CR1:= Timer2.CR1 or TIM_CR1_CEN; end;

//---------------------------------------------------------
procedure Timer2Disable;
begin Timer2.CR1:= Timer2.CR1 and not TIM_CR1_CEN; end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++ INTERRUPT SERVICE ROUTINE
procedure TIM2_ISR; Alias: 'TIM2_global_interrupt'; Interrupt; Public;
begin
  Timer2.SR:= Timer2.SR and not TIM_SR_CC1IF; //clear CC1IF

  //UART.SendString('TIM2_ISR');

  ////Toggle LED on PB8
{  if (PortB.ODR and (1 shl 8)) > 0  // if Output Data Bit 8 set..
   then PortB.BSRR:= GPIO_BSRR_BR8  // PB8 Reset
   else PortB.BSRR:= GPIO_BSRR_BS8; // PB8 Set}

  if assigned(Timer2OnTimerCompare) then Timer2OnTimerCompare;

end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
end.

