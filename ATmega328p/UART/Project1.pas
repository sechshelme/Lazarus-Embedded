program Project1;

{$H-}
{$O-}


const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  //  Baud = 230400;          // Baudrate
  Baud = 9600;          // Baudrate
  UCSZ01 = 2;           // Gibt es nicht in der Unit Atmega328p.
  teiler = CPU_Clock div (16 * Baud) - 1;

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

var
  i: UInt16;
  b: UInt8;
  s: string;
  a:array[0..7] of Char;
begin
  UARTInit;

  for i:=0 to 7 do UARTSendChar(a[i]);


  b := 8;
  i := 1 shl b;
  str(i: 8, s);          // '1' ist 8Bit
  UARTSendString(s);
  i := UInt16(1) shl b;  // '1' ist 16Bit
  str(i: 8, s);
  UARTSendString(s);


  repeat
    if UARTReadChar = #32 then begin
      UARTSendString('Hello World !'#13#10);
    end;
  until 1 = 2;
end.
