program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
//  Baud = 230400;          // Baudrate
  Baud = 9600;          // Baudrate
  teiler = CPU_Clock div (16 * Baud) - 1;

  procedure UARTInit;
  begin
    UBRR0 := teiler;

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
  sekTakt:Boolean;

  procedure Timer0_Interrupt; public Name 'TIMER0_OVF_ISR'; interrupt;
  const
    zaehler: UInt16 = 0;

    cl=4194304 shr 8 shr 1;

  begin
//    TCNT0 := 245;

    Inc(zaehler);
    if zaehler = cl then begin
      PORTB := PORTB or (1 shl 5);
    end;
    if zaehler >= cl * 2 then begin
      PORTB := PORTB and not (1 shl 5);
      zaehler := 0;
      sekTakt:=True;
    end;
  end;

var
  zeit: Integer;
  s : String[10];


begin
  DDRB := DDRB or (1 shl 5); // Pin 13 Output

  TCCR0A := %00;               // Normaler Timer
  TCCR0B := %111;              // Clock / Externer Pin TO, steigende Flanke
  TIMSK0 := (1 shl TOIE0);     // enable timer2 overflow interrupt.

  UARTInit;
  sekTakt:=False;

  asm sei end;                       // Interrupts einschalten.

  repeat
     if sekTakt then begin
       sekTakt:=False;
       Inc(Zeit);
       str(zeit div 60:6, s);
       UARTSendString('Min: ' + s);
       str(zeit mod 60:6, s);
       UARTSendString('  Sek: ' + s + #13#10);
     end;
  until 1 = 2;
end.
