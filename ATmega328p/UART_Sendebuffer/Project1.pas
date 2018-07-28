program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  //  Baud = 230400;          // Baudrate
//       Baud = 1000000;          // Baudrate
//    Baud = 115200;          // Baudrate
//  Baud = 57600;          // Baudrate
  Baud = 9600;          // Baudrate
  teiler = CPU_Clock div (16 * Baud) - 1;
  sl = 25000;

  CTXlen = 16;


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

var
  TXBuf: array[0..CTXlen - 1] of byte;
  TXread: byte = 0;
  TXwrite: byte = 0;


  procedure UARTInit;
  begin
    UBRR0 := teiler;
    UCSR0A := (0 shl U2X0);
    //    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0) or (1 shl TXCIE0);
//    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0) or (1 shl UDRIE0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
    UCSR0C := %011 shl UCSZ0;
  end;

  function UARTReadChar: char;
  begin
    while UCSR0A and (1 shl RXC0) = 0 do begin
    end;
    Result := char(UDR0);
  end;

  procedure UART_UDRE_Senden; public Name 'USART__UDRE_ISR'; interrupt;
  begin
    UDR0 := TXBuf[TXread];

    Inc(TXread);
    if TXread >= CTXlen then begin
      TXread := 0;
    end;
    if TXread = TXwrite then begin
      UCSR0B := UCSR0B and not (1 shl UDRIE0);
    end;
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: byte;
  begin
    for i := 1 to Length(s) do begin
      TXBuf[TXwrite] := byte(s[i]);
      Inc(TXwrite);
      if TXwrite >= CTXlen then begin
        TXwrite := 0;
      end;
    end;
    UCSR0B := UCSR0B or (1 shl UDRIE0);
  end;

var
  z: byte;
  s: ShortString;

begin
  DDRB := DDRB or (1 shl 5);
  // UART inizialisieren, die Interrupt gesteuert.
  UARTInit;

  // Interrupt aktivieren.
  asm
           Sei end;

  // Hauptschleife.

  repeat

    UARTSendString('Hello World');
    UARTSendString(' !'#13#10);

    PORTB := PORTB or (1 shl 5);
    mysleep(sl);

    Str(z: 3, s);
    UARTSendString(s + '. ');
    Inc(z);

    PORTB := PORTB and not (1 shl 5);
    mysleep(sl);

  until 1 = 2;
end.
