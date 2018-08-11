program Project1;

{$O-}

type
  TSPIGPIO = bitpacked record
    p0, p1, SlaveSelect, DataOut, DataIn, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

type

  { TMCP4922 }

  TMCP4922 = object
  private
    fDataOut, fSPIClock, fSlaveSelect: byte;
    fDAC, fGain: boolean;
    procedure SPI_Write(p: PByte; len: byte);
  public
    constructor Create(DAC, GAIN: boolean);
    procedure sendValue(Value: UInt16);
  end;

  { TMCP4922 }

  constructor TMCP4922.Create(DAC, GAIN: boolean);
  begin
    fDAC := DAC;
    fGain := GAIN;

    SPI_DDR.DataOut := True;
    SPI_DDR.Clock := True;
    SPI_DDR.SlaveSelect := True;
  end;

  procedure TMCP4922.SPI_Write(p: PByte; len: byte);
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

  procedure TMCP4922.sendValue(Value: UInt16);
  var
    Data: bitpacked array[0..15] of boolean absolute Value;
  begin
    // bit 0-11 Analog Value
    // bit 12 Output shutdown control bit  0 = Shutdown the device   1 = Active mode operation
    // bit 13 Output Gain selection        0 = 2x                    1 = 1x
    // bit 14 Vref input buffer control    0 = unbuffered(default)   1 = buffered
    // bit 15                              0 = DAC_A                 1 = DAC_B

    Data[12] := True;
    Data[13] := fGain;
    Data[14] := False;
    Data[15] := fDAC;

    SPI_Write(@Data, 2);
  end;

var
  i: Int16;
  MCP4922_A, MCP4922_B: TMCP4922;

begin
  MCP4922_A.Create(False, True);
  MCP4922_B.Create(True, True);

  SPCR := ((1 shl SPE) or (0 shl SPIE) or (0 shl DORD) or (1 shl MSTR) or (0 shl CPOL) or (0 shl CPHA) or (%01 shl SPR));
  SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ

  repeat
    for i := 0 to 4095 do begin
      MCP4922_A.sendValue(4095 - i);
      MCP4922_B.sendValue(i);
    end;
  until 1 = 2;
end.
