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
  a: array[0..7] of char;


var
  Digit: string[4];

  procedure IntToDigit(val: UInt16);
  var
    achr: byte;
    leer: boolean;
  begin
    Digit[0] := #4; // Der String ist 4 Zeichen lang, inklusive Dezimalpunkt.

    // Zehner
    achr := 0;
    while (val >= 100) do begin
      Dec(val, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Digit[1] := char(achr + 48);

    // Einer
    achr := 0;
    while (val >= 10) do begin
      Dec(val, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Digit[2] := char(achr + 48);

    // Dezimalpunkt
    Digit[3] := '.';

    // Zehntel
    achr := 0;
    while (val >= 1) do begin
      Dec(val);
      Inc(achr);
    end;
    Digit[4] := char(achr + 48);
  end;

const
  z: Int16 = 94;


begin
  UARTInit;

  b := 8;
  i := 1 shl b;
  str(i: 8, s);          // '1' ist 8Bit
  UARTSendString(s);
  i := UInt16(1) shl b;  // '1' ist 16Bit
  str(i: 8, s);
  UARTSendString(s);
  UARTSendString(#13#10);

  repeat
    Inc(z);
    if z > 999 then begin
      z := 0;
    end;
    IntToDigit(z);

    UARTSendString(Digit);
    UARTSendString(#13#10);

    //if UARTReadChar = #32 then begin
    //  UARTSendString('Hello Welt !'#13#10);
    //
    //  IntToDigit(z);
    //
    //  UARTSendString(Digit);
    //end else begin
    //  UARTSendString('none');
    //end;

  until 1 = 2;
end.
