program Project1;

{$H-,$O-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
  teiler = CPU_Clock div (16 * Baud) - 1;

  procedure Delay;
  var
    i: Int32;
  begin
    for i := 0 to 300000 do begin
    end;
  end;

  procedure UARTInit;
  begin
    UBRR0 := teiler;

    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
    UCSR0C := %011 shl UCSZ0;
  end;

  procedure UARTSendChar(c: char);
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do begin
    end;
    UDR0 := byte(c);
  end;

  function UARTReadChar: char;
  begin
    while UCSR0A and (1 shl RXC0) = 0 do begin
    end;
    Result := char(UDR0);
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: integer;
  begin
    for i := 1 to length(s) do begin
      UARTSendChar(s[i]);
    end;
  end;

begin
  UARTInit;

  repeat
    UARTSendString('Hello Welt !'#13#10);
    Delay;
  until False;
end.
