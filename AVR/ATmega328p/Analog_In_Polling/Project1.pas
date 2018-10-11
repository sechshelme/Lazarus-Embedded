program Project1;

{$H-}

  procedure UARTInit;
  const
    CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
    Baud = 9600;          // Baudrate
    teiler = CPU_Clock div (16 * Baud) - 1;
  begin
    UBRR0 := teiler;

    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
    UCSR0C := %011 shl UCSZ0;
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: integer;
  begin
    for i := 1 to length(s) do begin
      while UCSR0A and (1 shl UDRE0) = 0 do begin
      end;
      UDR0 := byte(s[i]);
    end;
  end;

  procedure ADC_Init;
  begin
    ADMUX := (1 shl REFS);
    ADCSRA := %111 or (1 shl ADEN);
  end;

  function ADC_Read(Port: byte): integer;
  begin
    ADMUX := (1 shl REFS) or (Port and $0F);
    ADCSRA := ADCSRA or (1 shl ADSC);
    while (ADCSRA and (1 shl ADSC)) <> 0 do begin
    end;

    Result := ADC;
  end;

var
  Data: integer;
  s: string[10];

begin

  // UART inizialisieren
  UARTInit;

  // ADC
  ADC_Init;

  asm
           Sei end;
  repeat
    Data := ADC_Read(0);
    str(Data: 6, s);
    UARTSendString(s);
  until 1 = 2;
end.

