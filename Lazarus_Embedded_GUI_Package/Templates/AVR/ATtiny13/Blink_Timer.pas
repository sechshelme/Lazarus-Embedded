program Project1;

uses
  intrinsics;

{$O-}

const
  LEDPin = 2;

var
  Zaehler: UInt16 = 0;

  procedure Timer0_Interrupt; public Name 'TIM0_COMPA_ISR'; interrupt;
  begin
    TCNT0 := 10;
    if Zaehler > 30000 then PORTB := PORTB or (1 shl LEDPin)else PORTB := PORTB and not (1 shl LEDPin);;
  end;

begin
  DDRB := DDRB or (1 shl LEDPin);

  // -- Interupt unterbinden.
  avr_cli;
  // -- Timer0 initialisieren.
  TCCR0A := 0;
  TCCR0B := %010;                     // CPU-Takt / 1024
  TIMSK0 := TIMSK0 or (1 shl OCIE0A); // Timer0 soll Interrupt auslösen.

  // -- Interrupt aktivieren.
  avr_sei;
  repeat
    Inc(Zaehler);
    if Zaehler >= 60000 then begin
      Zaehler := 0;
    end;
  until False;
end.
