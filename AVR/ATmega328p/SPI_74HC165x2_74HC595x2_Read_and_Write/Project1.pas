program Project1;

{$O-}

type
  TSPIGPIO = bitpacked record
    p0, p1, SlaveSelect, MOSI, MISO, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;


  procedure SPIReadData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_Port.SlaveSelect := False;
    SPI_Port.SlaveSelect := True;
    for i := len - 1 downto 0 do begin
      SPDR := 0;
      while (SPSR and (1 shl SPIF)) = 0 do begin
      end;
      p[i] := SPDR;
    end;
  end;

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
  buf: array[0..1] of byte;
begin
  SPI_DDR.MOSI := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  SPCR := (1 shl SPE) or (1 shl MSTR) or (%00 shl SPR);
  SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ

  repeat
    SPIReadData(@buf, 2);
    buf[0] := not buf[0];
    buf[1] := not buf[1];
    SPIWriteData(@buf, 2);
  until False;
end.
