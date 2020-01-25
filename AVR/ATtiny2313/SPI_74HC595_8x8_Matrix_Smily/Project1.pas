program Project1;

uses
  intrinsics;

{$O-}

type
  TMaske = array[0..7] of byte;

const
  Smily: array[0..1] of TMaske = ((
    %00111100,
    %01000010,
    %10100101,
    %10000001,
    %11000011,
    %10111101,
    %01000010,
    %00111100), (

    %00111100,
    %01000010,
    %10100101,
    %10000001,
    %10111101,
    %11000011,
    %01000010,
    %00111100));

type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataIn, DataOut, Clock: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_PORT.SlaveSelect := False;
    for i := len - 1 downto 0 do begin
      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%10 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

    end;
    SPI_PORT.SlaveSelect := True;
  end;

var
  p: integer;
  Zaehler: UInt16 = 0;
  Data: array[0..1] of byte;

  procedure Timer0_Interrupt; public Name 'TIMER0_COMPA_ISR'; interrupt;
  begin
    TCNT0 := 70;
    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    Data[0] := 1 shl p;
    if Zaehler > 30000 then Data[1] := Smily[0, p]
    else
      Data[1] := Smily[1, p];

    SPIWriteData(@Data, Length(Data));
  end;
begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  // -- Interupt unterbinden.
  avr_cli;
  // -- Timer0 initialisieren.
  TCCR0A := 0;
  TCCR0B := %010;                   // CPU-Takt / 1024
  TIMSK := TIMSK or (1 shl OCIE0A); // Timer0 soll Interrupt auslösen.

  // -- Interrupt aktivieren.
  avr_sei;
  repeat
    Inc(Zaehler);
    if Zaehler >= 60000 then begin
      Zaehler := 0;
    end;
  until 1 = 2;
end.
