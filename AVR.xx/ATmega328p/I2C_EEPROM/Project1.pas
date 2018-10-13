program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
  I2Caddr = $54;
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

procedure delay_ms(time : uint8);
const
  fcpu = 16000000;
  fmul = 1 * fcpu div 1000000;
label
  loop1, loop2, loop3;
begin
  asm
    ldd r20, time
    loop1:
      ldi r21, fmul
      loop2:  // 1000 * fmul = 1000 * 1 * 8 = 8000 cycles / 8MHz
        ldi r22, 250
        loop3:  // 4 * 250 = 1000 cycles
          nop
          dec r22
          brne loop3
        dec r21
        brne loop2
      dec r20
      brne loop1
  end['r20','r21','r22'];
end;

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

  // === Ende I2C

procedure I2C_EEPROM_Write(addr, pos: Int16; b:Byte);
begin
  TWIStart((addr shl 1) or TWI_Write);
  TWIWrite(pos shr 8);
  TWIWrite(pos and $FF);
  TWIWrite(b);
  TWIStop;
  delay_ms(10);
end;


procedure I2C_EEPROM_WriteString(addr, pos: Int16; s:ShortString);
var
  i:Byte;
begin
  for i := 0 to Length(s) do begin
    I2C_EEPROM_Write(addr, pos + i, Byte(s[i]));
  end;
end;


function I2C_EEPROM_Read(addr, pos: Int16):Byte;
begin
  TWIStart((addr shl 1) or TWI_Write);
  TWIWrite(pos shr 8);
  TWIWrite(pos and $FF);
  TWIStop;

  TWIStart((addr shl 1) or TWI_Read);
  Result := TWIReadNACK;
  TWIStop;
end;


function I2C_EEPROM_ReadString(addr, pos: Int16):ShortString;
var
  i, l:Byte;
begin
  l := I2C_EEPROM_Read(addr, pos);
  SetLength(Result, l);
  for i := 1 to l do begin
    Result[i] := Char(I2C_EEPROM_Read(addr, pos + i));
  end;
end;



const
  s1 = 'Hello World !';
  s2 = 'AVR mit Lazarus ist so schön';

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

// I2C_EEPROM_WriteString(I2Caddr, 0, s1);
// I2C_EEPROM_WriteString(I2Caddr, $100, s2);

  repeat
s := I2C_EEPROM_ReadString(I2Caddr, 0);
UARTSendString('s1: ');
UARTSendString(s + #13#10);

s := I2C_EEPROM_ReadString(I2Caddr, $100);
UARTSendString('s2: ');
UARTSendString(s + #13#10);
  until 1 = 2;
end.
