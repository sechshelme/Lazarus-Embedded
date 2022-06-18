// Multi Function Shield - 3 LED Timer gesteuert

program Project1;

{$H-,O-}

uses
  intrinsics;

type
  TPin = bitpacked record
    BP0, BP1, BP2, BP3, BP4, BP5, BP6, BP7: boolean;
  end;

var
  ddr:  TPin absolute DDRB;
  port: TPin absolute PORTB;

  procedure Timer0_Interrupt; public Name 'TIMER0_OVF_ISR'; interrupt;
  const
    zaehler: integer = 0;
    cl = 16000000 div 1024 div 256; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
  begin

    Inc(zaehler);
    if zaehler = cl then begin
      port.BP2 := True;
    end;
    if zaehler >= cl * 2 then begin
      port.BP2 := False;
      zaehler := 0;
    end;
  end;

  procedure Timer1_Interrupt; public Name 'TIMER1_OVF_ISR'; interrupt;
  const
    zaehler: integer = 0;
    cl = 16000000 div 1024 div 256; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
  begin
    TCNT1:=64000;

    Inc(zaehler);
    if zaehler = cl then begin
      port.BP3 := True;
    end;
    if zaehler >= cl * 2 then begin
      port.BP3 := False;
      zaehler := 0;
    end;
  end;

  procedure Timer2_Interrupt; public Name 'TIMER2_OVF_ISR'; interrupt;
  const
    zaehler: integer = 0;
    cl = 16000000 div 1024 div 256; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
  begin
    TCNT2 := 240;

    Inc(zaehler);
    if zaehler = cl then begin
      port.BP4 := True;
    end;
    if zaehler >= cl * 2 then begin
      port.BP4 := False;
      zaehler := 0;
    end;
  end;

begin
  ddr.BP2 := True;
  ddr.BP3 := True;
  ddr.BP4 := True;

  // Timer 0
  TCCR0A := %00;               // Normaler Timer
  TCCR0B := %100;              // Clock / 256
  TIMSK0 := (1 shl TOIE0);     // Enable Timer0 Interrupt.

  // Timer 1
  TCCR1A := %00;               // Normaler Timer
  TCCR1B := %011;              // Clock / 64
  TIMSK1 := (1 shl TOIE1);     // Enable Timer1 Interrupt.

  // Timer 2
  TCCR2A := %00;               // Normaler Timer
  TCCR2B := %111;              // Clock / 1024
  TIMSK2 := (1 shl TOIE2);     // Enable Timer2 Interrupt.

  asm
      Sei                      // Interrupts einschalten.
  end;

  repeat
    // Mache irgend etwas
  until False;
end.
