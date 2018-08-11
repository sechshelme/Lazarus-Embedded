program Project1;

{$O-}

  procedure mysleep(t: int32);
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      asm
               Nop;
      end;
    end;
  end;

  procedure ModePortB(Pin: byte; Value: boolean);
  begin
    if Value then begin
      DDRB := DDRB or (1 shl Pin);
    end else begin
      DDRB := DDRB and not (1 shl Pin);
    end;
  end;

  procedure WritePortB(Pin: byte; Value: boolean);
  begin
    if Value then begin
      PORTB := PORTB or (1 shl Pin);
    end else begin
      PORTB := PORTB and not (1 shl Pin);
    end;
  end;

type

  { TMCP4922 }

  TMCP4922 = object
  private
    fDataOut, fSPIClock, fSlaveSelect: byte;
    fDAC, fGain: boolean;
    procedure SPI_Write(p: PByte; len: byte);
    procedure WriteDataSoftSPI(val: UInt16);
    procedure WriteDataHardSPI(val: UInt16);
  public
    constructor Create(MOSI, SCK, CS: byte; DAC, GAIN: boolean);
    procedure sendValue(Value: UInt16);
  end;

  { TMCP4922 }

  constructor TMCP4922.Create(MOSI, SCK, CS: byte; DAC, GAIN: boolean);
  begin
    fDataOut := MOSI;
    fSPIClock := SCK;
    fSlaveSelect := CS;
    fDAC := DAC;
    fGain := GAIN;

    ModePortB(fDataOut, True);
    ModePortB(fSPIClock, True);
    ModePortB(fSlaveSelect, True);
  end;

  procedure TMCP4922.SPI_Write(p: PByte; len: byte);
  var
    i: byte;
  begin
    WritePortB(fSlaveSelect, False);
    for i := len - 1 downto 0 do begin
      SPDR := p[i];
      while (SPSR and (1 shl SPIF)) = 0 do begin
      end;
    end;
    WritePortB(fSlaveSelect, True);
  end;

  procedure TMCP4922.sendValue(Value: UInt16);
  var
    Data: UInt16;
  begin
    Data := Value;

    // bit 15                              0 = DAC_A                 1 = DAC_B
    // bit 14 Vref input buffer control    0 = unbuffered(default)   1 = buffered
    // bit 13 Output Gain selection        0 = 2x                    1 = 1x
    // bit 12 Output shutdown control bit  0 = Shutdown the device   1 = Active mode operation

    if fDAC then begin
      Data := Data or (UInt16(1) shl 15);
    end;
    Data := Data and not (UInt16(1) shl 14);
    if fGain then begin
      Data := Data or (UInt16(1) shl 13);
    end;
    Data := Data or (UInt16(1) shl 12);

    //    WriteDataSoftSPI(Data);
//    WriteDataHardSPI(Data);
    SPI_Write(@Data, 2);
  end;

  procedure TMCP4922.WriteDataSoftSPI(val: UInt16);
  var
    i: byte;
  begin
    WritePortB(fSlaveSelect, False);
    for i := 15 downto 0 do begin
      if (val and (UInt16(1) shl i)) <> 0 then begin
        WritePortB(fDataOut, True);
      end else begin
        WritePortB(fDataOut, False);
      end;
      WritePortB(fSPIClock, True);
      WritePortB(fSPIClock, False);
    end;
    WritePortB(fSlaveSelect, True);
  end;

  procedure TMCP4922.WriteDataHardSPI(val: UInt16);
  begin

    SPI_Write(@val, 2);
  end;

var
  i: Int16;
  MCP4922_A, MCP4922_B: TMCP4922;

begin
  MCP4922_A.Create(3, 5, 2, False, True);
  MCP4922_B.Create(3, 5, 2, True, True);

  SPCR := ((1 shl SPE) or (0 shl SPIE) or (0 shl DORD) or (1 shl MSTR) or (0 shl CPOL) or (0 shl CPHA) or (%01 shl SPR));
  SPSR := (1 shl SPI2X);  // SCK x 2 auf 1 MHZ

  ModePortB(3, True);
  repeat
    for i := 0 to 4095 do begin
      //            mysleep(1000);
      MCP4922_A.sendValue(4095 - i);
      MCP4922_B.sendValue(i);
    end;
  until 1 = 2;
end.
