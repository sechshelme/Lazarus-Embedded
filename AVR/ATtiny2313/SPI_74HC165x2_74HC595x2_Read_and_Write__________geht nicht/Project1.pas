program Project1;

{$O-}
type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataIn, DataOut, Clock: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  procedure SPIReadData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_PORT.SlaveSelect := False;
    SPI_PORT.SlaveSelect := True;
    for i := len - 1 downto 0 do begin
//      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%10 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

      p[i] := USIDR;
    end;
  end;

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
  buf: array[0..1] of byte;

begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    SPIReadData(@buf, 2);
    buf[0] := not buf[0];
    buf[1] := not buf[1];
    //  buf[0]:=%11000011;
    //  buf[1]:=%11000011;


    SPIWriteData(@buf, 2);
  until False;

end.
