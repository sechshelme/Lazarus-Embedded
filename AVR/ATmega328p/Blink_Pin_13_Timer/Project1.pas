program Project1;

uses
  intrinsics;

const
  BP5 = 5; // Pin 13 des Arduino

  procedure sei; assembler;
  asm
    Sei
  end;

  procedure Timer2_Interrupt; alias: 'TIMER2_OVF_ISR'; interrupt; public;
  const
    zaehler: integer = 0;
    cl = 1600001 div 1024 div 256 div 2; // 16'000'000Hz / Clock / TCNT / 2 = 0,5Sek
  begin
    Inc(zaehler);
    if zaehler = cl then begin
      PORTB := PORTB or (1 shl BP5);
    end;
    if zaehler >= cl * 2 then begin
      PORTB := PORTB and not (1 shl BP5);
      zaehler := 0;
    end;
  end;

begin
  DDRB := DDRB or (1 shl BP5); // Pin 13 Output

  TCCR2A := %00;               // Normaler Timer
  TCCR2B := %111;              // Clock / 1024
  TIMSK2 := (1 shl TOIE2);     // enable timer2 overflow interrupt.
  avr_sei;                     // Interrupts einschalten.

  repeat
    // mache Irgendwas
  until False;
end.
