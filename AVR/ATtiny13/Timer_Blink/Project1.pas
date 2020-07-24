program Project1;

uses
  intrinsics;

{$O-}

type
  TSPIGPIO = bitpacked record
    p0, p1, Clock, p2, p3, p4, p5: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  Zaehler: UInt16 = 0;

  procedure Timer0_Interrupt; public Name 'TIM0_COMPA_ISR'; interrupt;
  begin
    TCNT0 := 10;
    SPI_PORT.Clock := Zaehler > 30001;
  end;

begin
  SPI_DDR.Clock := True;

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
