program Project1;

{$O-}
type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataInt, DataOut, Clock: boolean;
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
      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%10 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

    end;
    SPI_Port.SlaveSelect := True;
  end;

  // Für Test;
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
    end;
    SPI_Port.SlaveSelect := True;
  end;

var
  z: Int16 = 0;
  i:Int16;

begin

  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    for i:=0 to 100 do;
    Inc(z);

    SPIWriteData(@z, 2);
    //        SPIWriteDataSoft(@z, 2);
  until 1 = 2;
end.
