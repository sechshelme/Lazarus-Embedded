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

procedure Int0_Interrupt; public Name 'INT0_ISR'; interrupt;
var
  i: integer;
begin
  UARTSendString('INT0'); // Cursor home
end;

begin
  PORTD := %00001100; // PullUp Pin 2 + 3

  // UART inizialisieren
  UARTInit;

  // INT0 aktivieren
  EICRA := %11;    // set INT0 to trigger on ANY logic change
  EIMSK := %01;     // Turns on INT0
  // Interrupt aktivieren
  asm           Sei end;
  repeat
  until 1 = 2;
end.



ISC11 o. ISC01	ISC10 o. ISC00	Beschreibung
0	0	Low-Level am Pin löst den Interrupt aus
0	1	Jede Änderung am Pin löst den Interrupt aus
1	0	Eine fallende Flanke löst den Interrupt aus
1	1	Eine steigende Flanke löst den Interrupt aus

