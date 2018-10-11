program Project1;

procedure Timer0_Interrupt; public Name 'TIMER0_OVF_ISR'; interrupt;
const
  zaehler: integer = 0;
  cl = 16000000 div 1024 div 256; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
begin

  Inc(zaehler);
  if zaehler = cl then begin
    PORTD := PORTD or %00001000;
  end;
  if zaehler >= cl * 2 then begin
    PORTD := PORTD and not %00001000;
    zaehler := 0;
  end;
end;

procedure Timer1_Interrupt; public Name 'TIMER1_OVF_ISR'; interrupt;
const
  zaehler: integer = 0;
//    cl = 64 shr 1; // 4194304 shr 16 shr 1 ;
//    cl = 16000000 div 1024 div 256 div 256; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
cl = 2;
begin

  Inc(zaehler);
  if zaehler = cl then begin
    PORTD := PORTD or %00000100;
  end;
  if zaehler >= cl * 2 then begin
    PORTD := PORTD and not %00000100;
    zaehler := 0;
  end;
end;

procedure Timer2_Interrupt; public Name 'TIMER2_OVF_ISR'; interrupt;
const
  zaehler: integer = 0;
  cl = 16000000 div 1024 div 256; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
begin
//  TCNT2 := 240;

  Inc(zaehler);
  if zaehler = cl then begin
    PORTB := PORTB or %00100000;
  end;
  if zaehler >= cl * 2 then begin
    PORTB := PORTB and not %00100000;
    zaehler := 0;
  end;
end;

begin
  DDRB := %00100000; // Pin D13
  DDRD := %00001100; // Pin D2 + D3

  // Timer 0
  TCCR0A := %00;               // Normaler Timer
  TCCR0B := %101;              // Clock / 1024
  TIMSK0 := (1 shl TOIE0);     // Enable Timer0 Interrupt.

  // Timer 1
  TCCR1A := %00;               // Normaler Timer
  TCCR1B := %101;              // Clock / 1024
  TIMSK1 := (1 shl TOIE1);     // Enable Timer1 Interrupt.

  // Timer 2
  TCCR2A := %00;               // Normaler Timer
  TCCR2B := %111;              // Clock / 1024
  TIMSK2 := (1 shl TOIE2);     // Enable Timer2 Interrupt.

  asm sei end;                 // Interrupts einschalten.

  repeat
  until 1 = 2;
end.
