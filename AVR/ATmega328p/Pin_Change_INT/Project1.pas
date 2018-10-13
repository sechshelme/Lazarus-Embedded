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

  procedure WritePort(p: byte);
  begin
    UARTSendString('PB' + char(p + 48) + ' : ');
    if PinB and (1 shl p) = (1 shl p) then begin
      UARTSendString('HIGH   ');
    end else begin
      UARTSendString('LOW    ');
    end;
  end;

procedure PC_Int0_Interrupt; public Name 'PCINT0_ISR'; interrupt;
var
  i: byte;
begin
  UARTSendString(#27'[0;0H'); // Cursor home
  for i := 0 to 3 do begin
    WritePort(i);
  end;
end;

procedure PC_Int1_Interrupt; public Name 'PCINT1_ISR'; interrupt;
var
  i: byte;
begin
  UARTSendString('PortC');
end;

const
  inPortsB = %00001111;
  inPortsC = %00000001;

begin
  PORTB := inPortsB; // PullUp
  PORTC := inPortsC; // PullUp

  // UART inizialisieren
  UARTInit;

  // PC_INT0 aktivieren
  PCICR := %011;
  PCMSK0 := inPortsB;
  PCMSK1 := inPortsC;

  // Interrupt aktivieren
  asm
           Sei end;
  repeat
  until 1 = 2;
end.
