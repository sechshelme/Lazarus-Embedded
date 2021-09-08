program Project1;

{$H-}
{$O-}

uses
  intrinsics;

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

  procedure Calc(b0, b1: Byte);
  var
    b2: Byte;
  begin
    b2 := b1 + b0;
    if avr_save and %00000001 > 0 then begin
//    if SREG and %00000001 > 0 then begin
      UARTSendString('Überlauf');
    end else begin
      UARTSendString('Kein Überlauf');
    end;
    UARTSendString(#13#10);
  end;

begin
  UARTInit;
  UARTSendString(#13#10);
  Calc(1, 1);
  Calc(128, 128);
  Calc(255, 255);
  Calc(127, 128);
  Calc(1, 1);

  repeat
  until 1 = 2;
end.
