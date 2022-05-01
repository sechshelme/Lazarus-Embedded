program Project1;

uses
  intrinsics;

{$O+,J-}

const
  Smily: array[0..7] of byte = (
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

  i, j: byte;
  p: byte = 0;
  Data: array[0..1] of byte;

begin
  DDRB := %111;

  repeat
    Inc(p);
    if p >= 8 then begin
      p := 0;
    end;

    Data[0] := 1 shl p;
    Data[1] := Smily[p];

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
