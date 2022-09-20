program Project1;

{$O-}

uses
  intrinsics;

// Die Matrix wird über 2 Stück 74HC595 angesteuert.

type
  TMask = array[0..7] of byte;

const
  maxCounter = 300;
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
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR:  TSPIGPIO absolute DDRB;

  i, j:    byte;
  p:       uint16 = 0;
  Counter: uint16 = 0;
  Data:    array[0..1] of byte;

begin
  SPI_DDR.MOSI        := True;
  SPI_DDR.Clock       := True;
  SPI_DDR.SlaveSelect := True;

  repeat
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

    Inc(Counter);
    if Counter >= maxCounter shl 1 then begin
      Counter := 0;
    end;

    SPI_Port.SlaveSelect := False;
    for j := 1 downto 0 do begin
      for i := 7 downto 0 do begin
        SPI_Port.MOSI := (Data[j] and (1 shl i)) <> 0;

        SPI_Port.Clock := True;
        SPI_Port.Clock := False;
      end;
    end;
    SPI_Port.SlaveSelect := True;

  until False;
end.
