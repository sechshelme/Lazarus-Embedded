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
  const
    Port = 0;
  begin
    ADMUX := (1 shl REFS) or (Port and $0F);
    ADCSRA := %111 or (1 shl ADEN) or (1 shl ADSC) or (1 shl ADIE);
  end;

  procedure ADC_Ready public Name 'ADC_ISR'; interrupt;
  var
    Data: integer;
    s: string[10];
  begin
    Data := ADC;
    ADCSRA := ADCSRA or (1 shl ADSC);
    str(Data: 6, s);
    UARTSendString(s);
  end;

begin

  // UART inizialisieren
  UARTInit;

  // ADC
  ADC_Init;

  asm Sei end;
  repeat
  until 1 = 2;
end.
