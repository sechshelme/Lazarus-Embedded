program Project1;

{$O-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate

  TXpin = (1 shl 1);
  RXpin = (1 shl 0);

  SoftTeiler = CPU_Clock div (Baud * 22); // Bitzeitzähler

  procedure UARTSoftSendByte(c: byte);
  const
    Baud = 9600;
  var
    i, Data: int16;
    j: Int8;
  begin
    asm
             Cli end;
    Data := (c shl 1) or $FE00;
    for j := 1 to 10 do begin
      if (Data and 1) = 1 then begin
        PORTD := PORTD or TXpin;
      end else begin
        PORTD := PORTD and not TXpin;
      end;
      Data := Data shr 1;
      for i := 0 to SoftTeiler do begin
      end;
    end;
    asm
             Sei end;
  end;

  function UARTSoftReadByte: byte;
  var
    i: Int16;
    j: Int8;
  begin
    asm
             Cli end;
    Result := 0;
    while PIND and RXpin > 0 do begin
    end;
    for i := 0 to SoftTeiler div 2 do begin
    end;
    for j := 1 to 8 do begin
      for i := 0 to SoftTeiler do begin
      end;
      Result := Result shr 1;
      if PIND and RXpin <> 0 then begin
        Inc(Result, $80);
      end;
    end;
    for i := 0 to SoftTeiler do begin
    end;
    asm
             Sei end;
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: integer;
  begin
    for i := 1 to length(s) do begin
      UARTSoftSendByte(byte(s[i]));
    end;
  end;

var
  ch: byte;

begin
  DDRD := DDRD or TXpin;
  UCSR0B := 0;

  repeat
    ch := UARTSoftReadByte;
    if ch = 32 then begin
      UARTSendString('Hello World !' + #13#10);
    end;
    UARTSoftSendByte(byte(upCase(char(ch))));
  until 1 = 2;
end.
