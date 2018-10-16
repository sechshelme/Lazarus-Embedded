unit Timer;

{$mode objfpc}{$H+}

interface

uses
  cortexm3;

type

  { TTimer }

  PTIM_Registers = ^TTIM_Registers;

  TTimer = object
  private
    fTim: PTIM_Registers; // TTIM_Registers;
    fTimIRQn: longword;
  public
    procedure Init(Prescaler, AutoReload, RCC_APB: longword);
    procedure Enable;
    procedure Disable;
    procedure Prescaler(AValue:uint16);
    procedure AutoReloadRegister(AValue:uint16);
  end;

  TProc = procedure;

  { TTimer2 }

  TTimer2 = object(TTimer)
    procedure Init(IntProc: TProc; APrescaler, AAutoReload: longword);
  end;

  { TTimer3 }

  TTimer3 = object(TTimer)
    procedure Init(IntProc: TProc; APrescaler, AAutoReload: longword);
  end;

  { TTimer4 }

  TTimer4 = object(TTimer)
    procedure Init(IntProc: TProc; APrescaler, AAutoReload: longword);
  end;

var
  Timer2: TTimer2;
  Timer3: TTimer3;
  Timer4: TTimer4;

  IntProcTimer2: procedure = nil;
  IntProcTimer3: procedure = nil;
  IntProcTimer4: procedure = nil;

implementation

const
  TIM_CR1_CEN: uInt16 = $0001;  // Counter enable
  RCC_APB1ENR_TIM2EN: uInt32 = $00000001;  // Timer 2 clock enable
  RCC_APB1ENR_TIM3EN: uInt32 = $00000002;  // Timer 3 clock enable
  RCC_APB1ENR_TIM4EN: uInt32 = $00000004;  // Timer 4 clock enable

  TIM_DIER_CC1IE: uInt16 = $0002;  // Capture/Compare 1 interrupt enable
  TIM_SR_CC1IF: uInt16 = $0002;    // Capture/Compare 1 interrupt Flag
  TIM2_IRQn = 28;     // TIM2 global Interrupt
  TIM3_IRQn = 29;     // TIM3 global Interrupt
  TIM4_IRQn = 30;     // TIM4 global Interrupt

procedure Timer2_Interrupt; public Name 'TIM2_interrupt'; interrupt;
begin
  Tim2.SR := Tim2.SR and not TIM_SR_CC1IF; // clear CC1IF
  if IntProcTimer2 <> nil then begin
    IntProcTimer2;
  end;
end;

procedure Timer3_Interrupt; public Name 'TIM3_interrupt'; interrupt;
begin
  Tim3.SR := Tim3.SR and not TIM_SR_CC1IF; // clear CC1IF
  if IntProcTimer3 <> nil then begin
    IntProcTimer3;
  end;
end;

procedure Timer4_Interrupt; public Name 'TIM4_interrupt'; interrupt;
begin
  Tim4.SR := Tim4.SR and not TIM_SR_CC1IF; // clear CC1IF
  if IntProcTimer4 <> nil then begin
    IntProcTimer4;
  end;
end;


{ TTimer }

procedure TTimer.Init(Prescaler, AutoReload, RCC_APB: longword);
begin
  //RCC enable for Timer2
  RCC.APB1ENR := RCC.APB1ENR or RCC_APB;

  ////Timer settings ----------------
  //Various settings in default
  fTim^.CR1 := $0000; //Control register 1; Wait with timer enable until settings complete
  fTim^.CR2 := $0000; //Control register 2
  fTim^.CCMR1 := $0000; //Capture/compare mode register
  fTim^.CCER := $0000; //Capture/compare enable register

  //Prescaler
  fTim^.PSC := Prescaler;
  //AutoReload value
  fTim^.ARR := AutoReload;

  //DMA and Interrupt control register
  fTim^.DIER := TIM_DIER_CC1IE; //Compare 1 interrupt enable
  //---------------------------------

  //Enable Counter
  fTim^.CR1 := fTim^.CR1 or TIM_CR1_CEN;

  // NVIC configuration
  NVIC.IP[fTimIRQn] := $20;     //IRQ-Priority, right 4bits always to be zero
  NVIC.ISER[fTimIRQn shr 5] := 1 shl (fTimIRQn and $1F); //Enable Interrupt
end;

procedure TTimer.Enable;
begin
  fTim^.CR1 := FTim^.CR1 or TIM_CR1_CEN;
end;

procedure TTimer.Disable;
begin
  fTim^.CR1 := fTim^.CR1 and not TIM_CR1_CEN;
end;

procedure TTimer.Prescaler(AValue: uint16);
begin
  Disable;
  fTim^.PSC := AValue;
  Enable;
end;

procedure TTimer.AutoReloadRegister(AValue: uint16);
begin
  Disable;
  fTim^.ARR := AValue;
  Enable;
end;

{ TTimer2 }

procedure TTimer2.Init(IntProc: TProc; APrescaler, AAutoReload: longword);
begin
  fTim := @TIM2;
  fTimIRQn := TIM2_IRQn;
  IntProcTimer2 := IntProc;
  inherited Init(APrescaler, AAutoReload, RCC_APB1ENR_TIM2EN);
end;

{ TTimer3 }

procedure TTimer3.Init(IntProc: TProc; APrescaler, AAutoReload: longword);
begin
  fTim := @TIM3;
  fTimIRQn := TIM3_IRQn;
  IntProcTimer3 := IntProc;
  inherited Init(APrescaler, AAutoReload, RCC_APB1ENR_TIM3EN);
end;

{ TTimer4 }

procedure TTimer4.Init(IntProc: TProc; APrescaler, AAutoReload: longword);
begin
  fTim := @TIM4;
  fTimIRQn := TIM4_IRQn;
  IntProcTimer4 := IntProc;
  inherited Init(APrescaler, AAutoReload, RCC_APB1ENR_TIM4EN);
end;

end.
