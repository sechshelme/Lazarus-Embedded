program Project1;

uses
  intrinsics;

{$O-}

// Die Matrix wird über 2 Stück 74HC595 angesteuert.

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
    DataIn, DataOut, Clock, SlaveSelect, p0, p1, p2, p3: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR:  TSPIGPIO absolute DDRB;

// ATtiny13 hat kein Hardware SPI, daher ein SoftwareWrite.

  procedure SPIWriteData(p: PByte; len: byte);
  var
    i, j: byte;
  begin
    SPI_Port.SlaveSelect := False;
    for j := len - 1 downto 0 do begin
      for i := 7 downto 0 do begin
        SPI_Port.DataOut := (p[j] and (1 shl i)) <> 0;

        SPI_Port.Clock := True;
        SPI_Port.Clock := False;
      end;
    end;
    SPI_Port.SlaveSelect := True;
  end;

var
  p:       integer;
  Zaehler: UInt16 = 0;
  Data:    array[0..1] of byte;

  procedure Timer0_Interrupt; public Name 'TIM0_COMPA_ISR'; interrupt;
  begin
    TCNT0 := 70;

    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    Data[0] := 1 shl p;
    if Zaehler > 2500 then begin
      Data[1] := Smily[0, p];
    end else begin
      Data[1] := Smily[1, p];
    end;

    SPIWriteData(@Data, Length(Data));
  end;

begin
  SPI_DDR.DataOut     := True;
  SPI_DDR.Clock       := True;
  SPI_DDR.SlaveSelect := True;

  // -- Interrupt unterbinden.
  avr_cli;
  // -- Timer0 initialisieren.
  TCCR0A := 0;
  TCCR0B := %010;
  TIMSK0 := TIMSK0 or (1 shl OCIE0A); // Timer0 soll Interrupt auslösen.

  // -- Interrupt aktivieren.
  avr_sei;
  repeat
    Inc(Zaehler);
    if Zaehler >= 5000 then begin
      Zaehler := 0;
    end;
  until False;
end.
