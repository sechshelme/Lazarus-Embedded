program GPIO_Write;
uses
  cortexm3;
  
procedure Delay;
var
  i: uint32;
begin
  for i := 0 to 15000 do asm nop end;
end;

type
  TMaske = array[0..7] of Byte;
  
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
  p,
  Zaehler,
  Zahl: integer;
  
const SYSTIMER_IN_FREQ  = 72000000;     // Quarzfrequenz 72 MHz bei meinem LPC1347
const SYSTIMER_INTERVAL = 10000;         // Interrupts pro Sekunde ==> 1ms
 
procedure SYSTICK_global_interrupt; public Name 'SysTick_interrupt'; interrupt;
const
  z:integer=0;
begin
  inc(z);
  if z > 1000 then begin
    PortC.ODR := not PortC.ODR;
    z := 0;
  end; 
  
  Inc(p);
  if p >= 8 then p := 0;
  PortA.ODR := 0;    
  PortB.ODR := (Ziffern[Zahl, p] or ((Ziffern[(Zahl + 2) mod 10, p]) shr 5)) shl 8;
  PortA.ODR := 1 shl p;      
end; 
 
// SysTick auf eine Millisekunde initialisieren
// bei meinem LPCxx läuft das zumindest so:
procedure InitTimer;
begin
  SysTick.Load := (SYSTIMER_IN_FREQ DIV SYSTIMER_INTERVAL)-1;  // 1 Millisekunden Interrupt
  SysTick.Ctrl := 7;                                           // counter enable, enable interrupt, use processor clock
end;  
  
procedure TIM2_global_interrupt; public Name 'TIM2_global_interrupt'; interrupt;
begin
//  PortC.ODR := $FFFF;
end; 

begin
  InitTimer;  

  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%111 shl 2);

  // Ports auf Ausgabe schalten
  PortA.CRL := $33333333;
  PortA.CRH := $33333333;

  PortB.CRL := $33333333;
  PortB.CRH := $33333333;

  PortC.CRL := $33333333;
  PortC.CRH := $33333333;    
  
  Zahl := 2;
  
  while true do begin  
    Inc(Zaehler); 
    if Zaehler >= 60 then Zaehler := 0;

    if Zaehler = 0 then begin 
      Inc(Zahl); 
      if Zahl >= 10 then Zahl := 0;
    end;
  
    Delay;
  end;
end.
