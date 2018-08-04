program Project1;

{$O-}

  procedure WritePortB(Pin: byte; Value: boolean);
  begin
    if Value then begin
      PORTB := PORTB or (1 shl Pin);
    end else begin
      PORTB := PORTB and not (1 shl Pin);
    end;
  end;

const
  SPI_DataOut = 3;
  SPI_Clock = 5;
  SPI_SlaveSelect = 2;

  procedure WriteDataSoftSPI(p: PByte; len: byte);
  var
    i, j: byte;
  begin
    WritePortB(SPI_SlaveSelect, False);
    for j := 0 to len - 1 do begin

      for i := 7 downto 0 do begin
        if (p[j] and (1 shl i)) <> 0 then begin
          WritePortB(SPI_DataOut, True);
        end else begin
          WritePortB(SPI_DataOut, False);
        end;
        WritePortB(SPI_Clock, True);
        WritePortB(SPI_Clock, False);
      end;
      WritePortB(SPI_SlaveSelect, True);

    end;
  end;

  procedure WriteDataHardSPI(p: PByte; len: byte);
  var
    i: byte;
  begin
    WritePortB(SPI_SlaveSelect, False);
    for i := len - 1 downto 0 do begin
      SPDR := p[i];
      while (SPSR and (1 shl SPIF)) = 0 do begin
      end;
    end;
    WritePortB(SPI_SlaveSelect, True);
  end;


var
  z: UInt16 = 0;
begin
  DDRB := (1 shl SPI_DataOut) or (1 shl SPI_Clock) or (1 shl SPI_SlaveSelect);

  SPCR := (1 shl SPE) or (1 shl MSTR) or (%00 shl SPR);
  SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ

  repeat
    Inc(z);

    //    WriteDataSoftSPI(@z, 2);
    WriteDataHardSPI(@z, 2);
  until 1 = 2;
end.
