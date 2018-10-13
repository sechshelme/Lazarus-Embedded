program Project1;

{$H-}


const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
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
    while UCSR0A and (1 shl UDRE0) = 0 do
    begin
    end;
    UDR0 := byte(c);
  end;

  function UARTReadChar: char;
  begin
    while UCSR0A and (1 shl RXC0) = 0 do
    begin
    end;
    Result := char(UDR0);
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: integer;
  begin
    for i := 1 to length(s) do
    begin
      UARTSendChar(s[i]);
    end;
  end;


const
  anzWuerfel = 1;
var
  Random: array[0..anzWuerfel - 1] of byte;

  procedure Timer0_Interrupt; public Name 'TIMER0_OVF_ISR'; interrupt;
  const
    RandomCount = 6;
  var
    i: integer;
    rnd: array [0..anzWuerfel - 1] of byte;
  begin

    for i := 0 to anzWuerfel - 1 do
    begin
      Inc(rnd[i]);
      if rnd[i] > i then
      begin
        rnd[i] := 0;
        Inc(Random[i]);
        if Random[i] >= RandomCount then
          Random[i] := 0;
      end;
    end;
  end;


var
  s: ShortString;
  i: integer;

begin
  // Timer 0
  TCCR0A := %00;               // Normaler Timer
  TCCR0B := %011;              // Clock / CPU
  TIMSK0 := (1 shl TOIE0);     // Enable Timer0 Interrupt.

  UARTInit;
  asm
           SEI end;                 // Interrupts einschalten.
  repeat
    UARTReadChar;
    for i := 0 to anzWuerfel - 1 do
    begin
      Str(Random[i] + 1: 4, s);
      UARTSendString(s);
    end;
    UARTSendString(#13#10);
  until 1 = 2;
end.
