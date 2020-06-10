program Project1;

{$H-}

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

  procedure EEPROM_write(uiAddress: int16; ucData: byte);
  begin
    while (EECR and (1 shl EEPE)) <> 0 do begin
    end;
    EEAR := uiAddress;
    EEDR := ucData;
    EECR := EECR or (1 shl EEMPE);
    EECR := EECR or (1 shl EEPE);
  end;

  function EEPROM_read(uiAddress: int16): byte;
  begin
    while (EECR and (1 shl EEPE)) <> 0 do begin
    end;
    EEAR := uiAddress;
    EECR := EECR or (1 shl EERE);
    Result := EEDR;
  end;

const
  sc = 'Hello  World !';

var
  i: integer;
  s: shortstring;

begin
  UARTInit;

  // String schreiben, inklusive Längenbyte.
  for i := 0 to Length(sc) do begin
    EEPROM_write(i, byte(sc[i]));
  end;

  // String lesen, inklusive Längenbyte.
  SetLength(s, EEPROM_read(0)); // Länge auslesen.
  for i := 1 to Length(s) do begin
    s[i] := char(EEPROM_read(i));
  end;

  repeat
    UARTSendString(s);
    UARTSendString(#13#10);
  until 1 = 2;
end.

