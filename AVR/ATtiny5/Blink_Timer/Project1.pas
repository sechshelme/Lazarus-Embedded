program Project1;

{$H-,J-,O-}

uses
  intrinsics;

  procedure Timer0_Interrupt; public Name 'TIM0_COMPA_ISR'; interrupt;
  begin
    TCNT0 := 128;
    PORTB := not PORTB;
  end;


begin
  // Setup
  DDRB := $FF;

  // -- Interupt unterbinden.
  avr_cli;
  // -- Timer0 initialisieren.
  TCCR0A := 0;
//  TCCR0B := %010;                     // CPU-Takt / 1024
  TCCR0B := %001;                     // CPU-Takt / 1024
  TIMSK0 := TIMSK0 or (1 shl OCIE0A); // Timer0 soll Interrupt auslösen.

  // -- Interrupt aktivieren.
  avr_sei;
  repeat
    // Loop;
  until False;
end.
