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

type
  TPara = record
    start, stop: Int16;
  end;

var
  ar1: array[0..2] of TPara = ((start: 10; stop: 20), (start: 20; stop: 30), (start: 40; stop: 50));
  ar2: array[0..0] of TPara = ((start: 111; stop: 222));
  ar3: array[0..1] of TPara = ((start: 3333; stop: 4444), (start: 5555; stop: 6666));

  procedure Test(const p: array of TPara);
  var
    i: Int16;
    s: ShortString = '';
  begin
    for i := 0 to Length(p) - 1 do begin
      str(p[i].start: 6, s);
      UARTSendString(s);
      str(p[i].stop: 6, s);
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
  Test(ar3);
  UARTSendString('Ende' + #13#10);

  repeat
  until 1 = 2;
end.
