program Project1;

{$O-}

type
  TSPIGPIO = bitpacked record
    p0, p1, SlaveSelect, MOSI, MISO, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_In: TSPIGPIO absolute PINB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  function ShiftIn74HC165: byte;
  var
    i: byte;
  begin
    Result := 0;
    for i := 0 to 7 do begin
      Result := (Result shl 1);
      if SPI_In.MISO then Inc(Result);

      SPI_Port.Clock := True;
      SPI_Port.Clock := False;
    end;
  end;

  procedure shiftOut595(val: byte);
  var
    i: byte;
  begin
    for i := 7 downto 0 do begin
      if (val and (1 shl i)) <> 0 then begin
        SPI_Port.MOSI := True;
      end else begin
        SPI_Port.MOSI := False;
      end;
      SPI_Port.Clock := True;
      SPI_Port.Clock := False;
    end;
  end;


  procedure SPIReadData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_Port.SlaveSelect := False;
    SPI_Port.SlaveSelect := True;
    for i := len - 1 downto 0 do begin
      p[i] := ShiftIn74HC165;
    end;
  end;

  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_Port.SlaveSelect := False;
    for i := len - 1 downto 0 do begin
      shiftOut595(p[i]);
    end;
    SPI_Port.SlaveSelect := True;
  end;


var
  buf: array[0..1] of byte;
begin
  SPI_DDR.MOSI := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    SPIReadData(@buf, 2);
    SPIWriteData(@buf, 2);
  until False;
end.
