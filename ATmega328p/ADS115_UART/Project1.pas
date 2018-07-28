program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
  ADSaddr0 = $48;
  ADSaddr1 = $49;
  TWI_Write = 0;
  TWI_Read = 1;

  (*
   Parameter ADS1115
   =================

   Low:  11100011  (default 860SPS)

   ???00011: SPS

   000 : 8SPS
   001 : 16SPS
   010 : 32SPS
   011 : 64SPS
   100 : 128SPS (default)
   101 : 250SPS
   110 : 475SPS
   111 : 860SPS


   High: 11000011  (default 2,048V )

   1???0011: Kanal (Multiplex)
   1100???1: Gain  Bit [11:9]  (Volt)

   000 : FS = ±6.144V
   001 : FS = ±4.096V
   010 : FS = ±2.048V (default)
   011 : FS = ±1.024V
   100 : FS = ±0.512V
   101 : FS = ±0.256V
   110 : FS = ±0.256V
   111 : FS = ±0.256V

   *)

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

function TWIReadACK: byte;
begin
  TWCR := (1 shl TWINT) or (1 shl TWEN) or (1 shl TWEA);
  while (TWCR and (1 shl TWINT)) = 0 do begin
  end;
  Result := TWDR;
end;

function TWIReadNACK: byte;
begin
  TWCR := (1 shl TWINT) or (1 shl TWEN);
  while (TWCR and (1 shl TWINT)) = 0 do begin
  end;
  Result := TWDR;
end;

function TWIReadACK_Error: byte;
var
  err:byte;
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
  err:byte;
begin
  TWCR := (1 shl TWINT) or (1 shl TWEN);
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

  // Parameter an ADS1115 schicken und Messen einleiten
  procedure WriteADS1115(addr: UInt16);
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(1);
    TWIWrite(%11000011);
    TWIWrite(%11100011);
    TWIStop;
  end;

  // Messung von ADS1115 auslesen.
  function ReadADS1115(addr: UInt16): UInt16;
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(0);
    TWIStop;

    TWIStart((addr shl 1) or TWI_Read);
    Result := TWIReadACK_Error * $100 + TWIReadNACK_Error;
    TWIStop;
  end;

var
  Data: integer;
  s: string;

begin
  asm
           Cli
  end;
  UARTInit;
  TWIInit;
  asm
           Sei
  end;

  repeat
    WriteADS1115(ADSaddr0);
    Data := ReadADS1115(ADSaddr0);

    str(Data: 6, s);
    UARTSendString('Kanal 0: ');
    UARTSendString(s);

    WriteADS1115(ADSaddr1);
    Data := ReadADS1115(ADSaddr1);

    str(Data: 6, s);
    UARTSendString(' Kanal 1: ');
    UARTSendString(s + #13#10);
    //    UARTSendString(#13#10);
  until 1 = 2;
end.
