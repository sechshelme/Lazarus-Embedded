program Project1;

uses
  intrinsics;

{$O-}

type
  TMaske = array[0..7] of byte;

const
  Smily: TMaske = (
    %00111100,
    %01000010,
    %10100101,
    %10000001,
    %11000011,
    %10111101,
    %01000010,
    %00111100);

type
  TSPIGPIO = bitpacked record
    DataOut, Clock, SlaveSelect, p3, p4, p5, p6, p7: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

var
  p: integer;

// ATtiny13 hat kein Hardware SPI, daher ein SoftwareWrite.

  procedure Timer0_Interrupt; public Name 'TIM0_COMPA_ISR'; interrupt;
  var
    i, j: byte;
  begin
    TCNT0 := 70;

    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    SPI_Port.SlaveSelect := False;
    for j := 1 downto 0 do begin
      for i := 7 downto 0 do begin
        SPI_Port.DataOut := (Smily[j] and (1 shl i)) <> 0;

        SPI_Port.Clock := True;
        SPI_Port.Clock := False;
      end;
    end;
    SPI_Port.SlaveSelect := True;
  end;

begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  // -- Interupt unterbinden.
  avr_cli;
  // -- Timer0 initialisieren.
  TCCR0A := 0;
  TCCR0B := %001;
  TIMSK0 := TIMSK0 or (1 shl OCIE0A); // Timer0 soll Interrupt auslösen.

  // -- Interrupt aktivieren.
  avr_sei;
  repeat
  until False;
end.
