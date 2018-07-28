program Project1;

  procedure nop; assembler;
  asm
           Nop
  end;


const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  //  Baud = 230400;          // Baudrate
//     Baud = 1000000;          // Baudrate
//  Baud = 115200;          // Baudrate
//  Baud = 57600;          // Baudrate
  Baud = 9600;          // Baudrate
  teiler = CPU_Clock div (16 * Baud) - 1;

  Crxlen = 16;

var
  RxBuf: array[0..Crxlen - 1] of byte;
  rxread: byte = 0;
  rxwrite: byte = 0;


  procedure UARTInit;
  begin
    UBRR0 := teiler;

    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0) or (1 shl RXCIE0);
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

  procedure UART_RX_Empfang; public Name 'USART__RX_ISR'; interrupt;
  var
    tchr: byte;
  begin
    tchr := UDR0;
    if tchr <> 0 then begin
      RxBuf[rxwrite] := tchr;
      Inc(rxwrite);
      if rxwrite >= Crxlen then begin
        rxwrite := 0;
      end;
    end;
  end;

var
  ch: byte;

begin
  // UART inizialisieren, die Interrupt gesteuert.
  UARTInit;

  // Interrupt aktivieren.
  asm sei end;

  // Hauptschleife.
  repeat
    while rxwrite <> rxread do begin
      asm cli end;
      ch := RxBuf[rxread];
      Inc(rxread);
      if rxread >= Crxlen then begin
        rxread := 0;
      end;
      asm sei end;
      if ch in [$61..$7A] then begin
        Dec(ch, 32);
      end;
      UARTSendChar(char(ch));
    end;
  until 1 = 2;
end.
