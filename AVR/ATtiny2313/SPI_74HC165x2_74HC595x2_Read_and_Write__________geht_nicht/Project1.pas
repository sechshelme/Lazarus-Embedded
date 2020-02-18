program Project1;

{$O-,J-}

type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataIn, DataOut, Clock: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;
  SPI_PIN: TSPIGPIO absolute PINB;

  function SoftShiftIn165: byte;
  var
    i: byte;
  begin
    Result := 0;
    for i := 0 to 7 do begin  // LSBFIRST
      Result := Result shl 1;
      if SPI_PIN.DataIn then Inc(Result);
      SPI_PORT.Clock := True;
      SPI_PORT.Clock := False;
    end;
  end;

  function HardShiftIn165: byte;
  begin
    USISR := (1 shl USIOIF);

    repeat
      USICR := (%01 shl USIWM) or (%010 shl USICS) or (1 shl USICLK) or (1 shl USITC);
    until (USISR and (1 shl USIOIF)) <> 0;

    Result := USIDR;
  end;

  procedure SPIReadData(p: PByte; len: byte);
  var
    i: byte;
  begin
    for i := len - 1 downto 0 do begin
      //USIDR := 255;
      //USISR := 1 shl USIOIF;

      //repeat
      //  USICR := (%01 shl USIWM) or (%010 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      //until (USISR and (1 shl USIOIF)) <> 0;

      //p[i] := USIDR;
      p[i] := HardShiftIn165;
    end;
  end;

  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    for i := len - 1 downto 0 do begin
      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%010 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

    end;
  end;

  procedure SPILatch;
  begin
    SPI_PORT.SlaveSelect := False;
    SPI_PORT.SlaveSelect := True;
  end;

var
  buf: array[0..1] of byte;

begin
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  repeat
    SPILatch;
    SPIReadData(@buf, 2);
    buf[0] := not buf[0];
    buf[1] := not buf[1];
//         buf[0]:=10;
//          buf[1]:=10;


    SPIWriteData(@buf, 2);
  until False;

end.
