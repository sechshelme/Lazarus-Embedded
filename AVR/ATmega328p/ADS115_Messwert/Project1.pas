program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  //  Baud = 9600;          // Baudrate
  Baud = 1000000;          // Baudrate
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

var
  buf: array[0..3] of byte;
  p: byte;

  procedure UARTInit;
  const
    teiler = CPU_Clock div (16 * Baud) - 1;
  begin
    UBRR0 := teiler;

    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0) or (1 shl RXCIE0);
    UCSR0C := %011 shl UCSZ0;
  end;

  procedure UARTSendByte(c: byte);
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do begin
    end;
    UDR0 := c;
  end;

  procedure UART_RX_Empfang; public Name 'USART__RX_ISR'; interrupt;
  begin
    buf[p] := UDR0;
    if p < 4 then begin
      Inc(p);
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

  // Parameter an ADS1115 schicken und Messen einleiten
  procedure WriteADS1115(addr: UInt16; dataLo, dataHi: byte);
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(1);
    TWIWrite(dataHi);
    TWIWrite(dataLo);
//    TWIWrite(%11000011);
//    TWIWrite(%11100011);
    TWIStop;
  end;

  // Messung von ADS1115 auslesen.
  function ReadADS1115(addr: UInt16): UInt16;
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite(0);
    TWIStop;

    TWIStart((addr shl 1) or TWI_Read);
    Result := TWIReadACK * $100 + TWIReadNACK;
    TWIStop;
  end;

var
  Data0, Data1: integer;

begin
  p := 0;
  Data0 := 0;
  Data1 := 0;
  asm
           Cli
  end;
  UARTInit;
  TWIInit;
  asm
           Sei
  end;

  repeat
    repeat
    until p = 4;
    p := 0;

    UARTSendByte(Data0);
    UARTSendByte(Data0 shr 8);
    UARTSendByte(Data1);
    UARTSendByte(Data1 shr 8);

    WriteADS1115(ADSaddr0, buf[0], buf[1]);
    Data0 := ReadADS1115(ADSaddr0);

    WriteADS1115(ADSaddr1, buf[2], buf[3]);
    Data1 := ReadADS1115(ADSaddr1);
  until 1 = 2;
end.
