// -- Ansteuerung einer 8x8 LED Matrix über Software SPI --

// Dies ist nötig, da der Atiny13 kein Hardware  USI/SPI besitzt.

// Der Ablauf läuft über das Polling Verfahren.
// Das hat den Nachteil, das die CPU keine andere Aufgabe parallel ausführen kann, 
// ohne das die Anzeige ins Wanken kommt.

// Die Matrix wird über 2 Stück Schieberegister 74HC595 angesteuert, 
// welche an der SPI-Schnittstelle angeschlossen sind.program Project1;

{$O-}

uses
  intrinsics;

type
  TMask = array[0..7] of byte;

const
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
    DataIn, DataOut, Clock, SlaveSelect, p0, p1, p2, p3: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR:  TSPIGPIO absolute DDRB;

  i, j:    byte;
  p:       uint16 = 0;
  Counter: uint16 = 0;
  Data:    array[0..1] of byte;

begin
  SPI_DDR.DataOut     := True;
  SPI_DDR.Clock       := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    Data[0] := 1 shl p;
    if Counter > 300 then begin
      Data[1] := Smily[0, p];
    end else begin
      Data[1] := Smily[1, p];
    end;

    Inc(Counter);
    if Counter >= 600 then begin
      Counter := 0;
    end;

    SPI_Port.SlaveSelect := False;
    for j := 1 downto 0 do begin
      for i := 7 downto 0 do begin
        SPI_Port.DataOut := (Data[j] and (1 shl i)) <> 0;

        SPI_Port.Clock := True;
        SPI_Port.Clock := False;
      end;
    end;
    SPI_Port.SlaveSelect := True;

  until False;
end.