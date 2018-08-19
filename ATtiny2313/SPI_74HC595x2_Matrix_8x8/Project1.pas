program Project1;

{$O-}
type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataInt, DataOut, Clock: boolean;
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
  z: Int16 = 0;
begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    Inc(z);
    SPIWriteData(@z, 2);
  until 1 = 2;
end.
