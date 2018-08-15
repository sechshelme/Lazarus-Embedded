program Project1;

{$O-}

type
  TSPIGPIO = bitpacked record
    p0, p1, SlaveSelect, DataOut, DataIn, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  procedure SPIInit;
  begin
    // SPI-Port auf Ausgabe
    SPI_DDR.DataOut := True;
    SPI_DDR.Clock := True;
    SPI_DDR.SlaveSelect := True;

    SPCR := ((1 shl SPE) or (0 shl SPIE) or (0 shl DORD) or (1 shl MSTR) or (0 shl CPOL) or (0 shl CPHA) or (%01 shl SPR));
    SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ
  end;

  procedure SPIWrite(p: PByte; len: byte);
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


  procedure MCP4922sendValue(Value: UInt16; Channel: Byte);
  type
    TADC = bitpacked record
      Value: 0..4095;
      ShutDown,
      Gain,
      VRef,
      Dac: 0..1;
    end;

  begin
    // bit 0-11 Analog Value
    // bit 12 Output shutdown control bit  0 = Shutdown the device   1 = Active mode operation
    // bit 13 Output Gain selection        0 = 2x                    1 = 1x
    // bit 14 Vref input buffer control    0 = unbuffered(default)   1 = buffered
    // bit 15                              0 = DAC_A                 1 = DAC_B

    with TADC(Value) do begin
      ShutDown := 1;
      Gain := 1;
      VRef := 0;
      Dac := Channel;
    end;

    SPIWrite(@Value, 2);
  end;


  procedure TMCP4922sendValue2(Value: UInt16; Channel: Byte);
  var
    Data: bitpacked array[0..15] of 0..1 absolute Value;
  begin
    // bit 0-11 Analog Value
    // bit 12 Output shutdown control bit  0 = Shutdown the device   1 = Active mode operation
    // bit 13 Output Gain selection        0 = 2x                    1 = 1x
    // bit 14 Vref input buffer control    0 = unbuffered(default)   1 = buffered
    // bit 15                              0 = DAC_A                 1 = DAC_B

    Data[12] := 1;
    Data[13] := 1;
    Data[14] := 0;
    Data[15] := Channel;

    SPIWrite(@Data, 2);
  end;

var
  z: Int16;

begin
  SPIInit;

  repeat
    for z := 0 to 4095 do begin
      MCP4922sendValue(4095 - z, 0);
      MCP4922sendValue(z, 1);
    end;
  until 1 = 2;
end.
