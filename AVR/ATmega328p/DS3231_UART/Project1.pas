program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
  I2CAddr = $68;
  TWI_Write = 0;
  TWI_Read = 1;

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

  // === I2C Bus

  procedure TWIInit;
  const
    F_SCL = 400000;                                // SCL Frequenz (400KHz)
    TWBR_val = byte((CPU_Clock div F_SCL) - 16) div 2;
  begin
    TWSR := 0;
    TWBR := byte(TWBR_val);
  end;

  procedure TWIStart(addr: byte);
  begin
    // Senden einleiten
    TWCR := 0;
    TWCR := (1 shl TWINT) or (1 shl TWSTA) or (1 shl TWEN);
    while ((TWCR and (1 shl TWINT)) = 0) do begin
    end;

    // Adresse des Endgerätes senden
    TWDR := addr;
    TWCR := (1 shl TWINT) or (1 shl TWEN);
    while ((TWCR and (1 shl TWINT)) = 0) do begin
    end;
  end;

  procedure TWIStop;
  begin
    TWCR := (1 shl TWINT) or (1 shl TWSTO) or (1 shl TWEN);
  end;

  procedure TWIWrite(u8data: byte);
  begin
    TWDR := u8data;
    TWCR := (1 shl TWINT) or (1 shl TWEN);
    while ((TWCR and (1 shl TWINT)) = 0) do begin
    end;
  end;

  function TWIReadACK_Error: byte;
  var
    err: byte;
  begin
    err := 0;
    TWCR := (1 shl TWINT) or (1 shl TWEN) or (1 shl TWEA);
    while ((TWCR and (1 shl TWINT)) = 0) and (err < 255) do begin
      Inc(err);
    end;
    if err = 255 then begin
      UARTSendString('I²C-Timeout');
      Result := 0;
    end else begin
      Result := TWDR;
    end;
  end;

  function TWIReadNACK_Error: byte;
  var
    err: byte;
  begin
    TWCR := (1 shl TWINT) or (1 shl TWEN);
    err := 0;
    while ((TWCR and (1 shl TWINT)) = 0) and (err < 255) do begin
      Inc(err);
    end;
    if err = 255 then begin
      UARTSendString('I²C-Timeout');
      Result := 0;
    end else begin
      Result := TWDR;
    end;
  end;

  // === Ende I2C

  function bcd2bin(val: uint8): uint8;
  begin
    Result := val - 6 * (val shr 4);
  end;

  function bin2bcd(val: uint8): uint8;
  begin
    Result := val + 6 * (val div 10);
  end;

type
  TDate = record
    year: uint16;
    month, day, hour, minute, second, dayOfTheWeek: uint8;
  end;

var
  Date: TDate;

  // Parameter an DS3231 schicken.
  procedure WriteDS3231(addr: UInt16);
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(0);
    TWIWrite(bin2bcd(Date.second));
    TWIWrite(bin2bcd(Date.minute));
    TWIWrite(bin2bcd(Date.hour));
    TWIWrite(bin2bcd(0));
    TWIWrite(bin2bcd(Date.day));
    TWIWrite(bin2bcd(Date.month));
    TWIWrite(bin2bcd(Date.year - 2000));
    TWIStop;
  end;

  // Zeit vom DS3231 auslesen.
  procedure ReadDS3231(addr: UInt16);
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(0);
    TWIStop;

    TWIStart((addr shl 1) or TWI_Read);
    Date.second := bcd2bin(TWIReadACK_Error and $7F);
    Date.minute := bcd2bin(TWIReadACK_Error);
    Date.hour := bcd2bin(TWIReadACK_Error);

    TWIReadACK_Error;

    Date.day := bcd2bin(TWIReadACK_Error);
    Date.month := bcd2bin(TWIReadACK_Error);
    Date.year := bcd2bin(TWIReadNACK_Error) + 2000;

    TWIStop;
  end;

  procedure ReadDS3231neu(addr: UInt16);
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(0);
    TWIStop;

    TWIStart((addr shl 1) or TWI_Read);
    Date.second := TWIReadACK_Error and $7F;
    Date.minute := TWIReadACK_Error;
    Date.hour := TWIReadACK_Error;

    TWIReadACK_Error;

    Date.day := TWIReadACK_Error;
    Date.month := TWIReadACK_Error;
    Date.year := TWIReadNACK_Error + 2000;

    TWIStop;
  end;

var
  s: ShortString;

begin
  asm
           Cli
  end;
  UARTInit;
  TWIInit;
  asm
           Sei
  end;
  Date.second := 33;
  Date.minute := 22;
  Date.hour := 11;
  WriteDS3231(I2CAddr);

  repeat
    ReadDS3231(I2CAddr);
    str(Date.second: 6, s);
    UARTSendString('Sec: ' + s);
    str(Date.minute: 6, s);
    UARTSendString(' Minute: ' + s);
    str(Date.hour: 6, s);
    UARTSendString(' Stunden: ' + s);

    UARTSendString(#13#10);

    ReadDS3231neu(I2CAddr);
    UARTSendString('Sec: ');
    UARTSendChar(char((Date.second shr 4) + 48));
    UARTSendChar(char((Date.second and $0F) + 48));

    UARTSendString(#13#10#13#10);

  until 1 = 2;
end.
