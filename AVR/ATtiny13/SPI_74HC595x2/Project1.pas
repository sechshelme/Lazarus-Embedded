program Project1;

{$O-}
type
  TSPIGPIO = bitpacked record
    DataIn, DataOut, Clock, SlaveSelect, p0, p1, p2, p3: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

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
  z: Int16 = 0;
  Data: array[0..1] of byte;
begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;
  Data[0] := %11001100;
  Data[1] := %10101010;

  repeat
    Inc(z);
    SPIWriteData(@Data, Length(Data));
  until 1 = 2;
end.
