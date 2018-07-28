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
    procedure sendBit(Value:Boolean);
  public
    constructor Create(SDI, SCK, CS: byte; DAC, GAIN: boolean);
    procedure sendValue(Value: UInt16);
  end;

  { TMCP4922 }

    procedure TMCP4922.sendValue(Value: UInt16);
  var
    dw: boolean;
    i: int8;
  begin
    WritePortB(fSlaveSelect, False);

    // bit 15
    // 0 write to DAC_A
    // 1 write to DAC_B
    sendBit(fDAC);
    // bit 14 Vref input buffer control
    // 0 unbuffered
    // 1 buffered
    sendBit(False);
    // bit 13 Output Gain selection
    // 0 2x
    // 1 1x
    sendBit(fGain);
    // bit 12 Output shutdown control bit
    // 0 Shutdown the device
    // 1 Active mode operation *
    sendBit(True);

    Value:=%10101010101;

    for i := 11 downto 0 do begin
      dw := (Value and (UInt16(1) shl i)) <> 0;
      sendBit(dw);
    end;

    WritePortB(fSlaveSelect, True);
  end;

    procedure TMCP4922.sendBit(Value: Boolean);
  begin
    WritePortB(fDataOut, Value);
    WritePortB(fSPIClock, True);
    WritePortB(fSPIClock, False);
  end;


  constructor TMCP4922.Create(SDI, SCK, CS: byte; DAC, GAIN: boolean);
  begin
    fDataOut := SDI;
    fSPIClock := SCK;
    fSlaveSelect := CS;
    fDAC := DAC;
    fGain := GAIN;

    ModePortB(fDataOut, True);
    ModePortB(fSPIClock, True);
    ModePortB(fSlaveSelect, True);
  end;

var
  i: Int16;
  MCP4922_A, MCP4922_B: TMCP4922;

begin
  MCP4922_A.Create(3, 5, 2, False, True);
  MCP4922_B.Create(3, 5, 2, True, True);

  ModePortB(3, True);
  repeat
    for i := 0 to 4095 do begin
      MCP4922_A.sendValue(4095 - i);
      MCP4922_B.sendValue(i);
    end;
  until 1 = 2;
end.
