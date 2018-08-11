program Project1;

{$O-}

type
  TSPIGPIO = bitpacked record
    p0, p1, SlaveSelect, DataOut, DataIn, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;


  procedure SPIWriteDataSoft(p: PByte; len: byte);
  var
    i, j: byte;
  begin
    SPI_Port.SlaveSelect := False;
    for j := 0 to len - 1 do begin
      for i := 7 downto 0 do begin
        SPI_Port.DataOut := (p[j] and (1 shl i)) <> 0;

        SPI_Port.Clock := True;
        SPI_Port.Clock := False;
      end;
      SPI_Port.SlaveSelect := True;
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
  z: UInt16 = 0;
begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  SPCR := (1 shl SPE) or (1 shl MSTR) or (%00 shl SPR);
  SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ

  repeat
    Inc(z);

    //    SPIWriteDataSoft(@z, 2);
    SPIWriteData(@z, 2);
  until 1 = 2;
end.
