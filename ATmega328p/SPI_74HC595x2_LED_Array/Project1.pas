program Project1;

{$O-}

const
  DataLen = 9;

type
  TSPIGPIO = bitpacked record
    p0, p1, SlaveSelect, DataOut, DataIn, Clock, p6, p7: boolean;
  end;

  TData = packed array [0..DataLen - 1] of byte;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  Buffer: TData;
  SPIWrite: byte = 0;

  procedure SPIInit;
  begin
    SPI_DDR.DataOut := True;
    SPI_DDR.Clock := True;
    SPI_DDR.SlaveSelect := True;

    SPCR := (1 shl SPE) or (1 shl MSTR) or (%00 shl SPR);
    SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ
  end;

  //procedure SPIWriteData(p: PByte; len: byte);
  //var
  //  i: byte;
  //begin
  //  SPI_Port.SlaveSelect := False;
  //  for i := len - 1 downto 0 do begin
  //    SPDR := p[i];
  //    while (SPSR and (1 shl SPIF)) = 0 do begin
  //    end;
  //  end;
  //  SPI_Port.SlaveSelect := True;
  //end;

  procedure SPI_Int_Send; public Name 'SPI__STC_ISR'; interrupt;
  begin
//    SPDR := Buffer[SPIWrite];
    SPDR := 127;

    Inc(SPIWrite);

    if SPIWrite = Length(Buffer) then begin
      SPI_Port.SlaveSelect := True;
      SPI_Port.SlaveSelect := False;
      SPIWrite:=0;
      SPCR := SPCR and not (1 shl SPIE);
    end;

  end;

  procedure SPISend(var AData: TData);
  begin
    Buffer := AData;
    SPCR := SPCR or (1 shl SPIE);
  end;

var
  Data: TData;

begin
  SPIInit;

  Data[0] := 34;
  Data[2] := 255;
  Data[3] := 255;

  SPISend(Data);
  repeat

//        SPIWriteData(@Data, Length(Data));
  until 1 = 2;
end.
