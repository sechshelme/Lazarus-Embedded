program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate

  // === UART-Schnittstelle

  procedure UARTInit;
  const
    teiler = CPU_Clock div (16 * Baud) - 1;
  begin
    UBRR0 := Teiler;
    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0){ or (1 shl RXCIE0)};
    UCSR0C := %011 shl UCSZ0;
  end;

  procedure UARTSendChar(c: char);
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do begin
    end;
    UDR0 := byte(c);
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: integer;
  begin
    for i := 1 to length(s) do begin
      UARTSendChar(s[i]);
    end;
  end;

var
  ar1: array[10..13] of Byte = (1,2,3,4);
  ar2: array[3..7] of Byte = (5,6,7,8,9);

  procedure Test(var p: array of Byte);
  var
    i: Int16;
    s: ShortString = '';
  begin
    for i := 0 to Length(p) - 1 do begin
      str(p[i]: 6, s);
      UARTSendString(s);
    end;
    UARTSendChar(#13);
    UARTSendChar(#10);
  end;

begin
  UARTInit;

  UARTSendString('Anfang' + #13#10);
  Test(ar1);
  Test(ar2);
  UARTSendString('Ende' + #13#10);

  repeat
  until 1 = 2;
end.
