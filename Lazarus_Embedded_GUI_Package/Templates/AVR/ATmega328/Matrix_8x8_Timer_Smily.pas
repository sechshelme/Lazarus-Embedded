program Project1;

{$O-}

uses
  intrinsics;

// Die Matrix wird über 2 Stück 74HC595 angesteuert.

type
  TMask = array[0..7] of byte;

const
  maxCounter = 30000;
  Smily: array[0..1] of TMask = ((
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
    p0, p1, SlaveSelect, MOSI, MISO, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;


  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_Port.SlaveSelect := False;
    for i := len - 1 downto 0 do begin
      SPDR := p[i];
      while (SPSR and (1 shl SPIF)) = 0 do begin
      end;
    end;
    SPI_Port.SlaveSelect := True;
  end;


var
  p:       integer;
  Counter: UInt16 = 0;
  Data:    array[0..1] of byte;

procedure Timer2_Interrupt; public Name 'TIMER2_OVF_ISR'; interrupt;
begin
  TCNT2 := 250;

  Inc(p);
  if p >= 8 then begin
    p := 0;
  end;

  Data[0] := 1 shl p;
  if Counter > maxCounter then begin
    Data[1] := Smily[0, p];
  end else begin
    Data[1] := Smily[1, p];
  end;

  SPIWriteData(@Data, Length(Data));
end;



begin
  SPI_DDR.MOSI        := True;
  SPI_DDR.Clock       := True;
  SPI_DDR.SlaveSelect := True;

  // -- Interupt unterbinden.
  avr_cli;

  // -- Timer2 initialisieren.
  TCCR2A := %00;               // Normaler Timer
  TCCR2B := %100;
  TIMSK2 := (1 shl TOIE2);     // Enable Timer2 Interrupt.

  // -- Interrupt aktivieren
  avr_sei;

  // -- SPI inizialisieren
  SPCR := (1 shl SPE) or (1 shl MSTR) or (%00 shl SPR);
  SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ

  repeat
    Inc(Counter);
    if Counter >= maxCounter shl 1 then begin
      Counter := 0;
    end;
  until False;
end.
