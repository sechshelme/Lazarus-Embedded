program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
    Baud = 9600;          // Baudrate
  TWI_Write = 0;
  TWI_Read = 1;

  // === UART-Schnittstelle

var
  buf: array[0..3] of byte;
  i: byte;

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
    buf[i] := UDR0;
    if i < 4 then begin
      Inc(i);
    end;
  end;


  // === I2C Bus

  procedure TWIInit;
  const
    F_SCL = 100000;                                // SCL Frequenz (400KHz)
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

const
  addr = $3C;

  LCD_DISP_OFF = $AE;
  LCD_DISP_ON = $AF;

  WHITE = $01;
  BLACK = $00;

  DISPLAY_WIDTH = 128;
  DISPLAY_HEIGHT = 32;

  //const
  //  init_sequence: array [0..26] of byte = (  // Initialization Sequence
  //    LCD_DISP_OFF,  // Display OFF (sleep mode)
  //    $20, %00,    // Set Memory Addressing Mode
  //    // 00=Horizontal Addressing Mode; 01=Vertical Addressing Mode;
  //    // 10=Page Addressing Mode (RESET); 11=Invalid
  //    $B0,      // Set Page Start Address for Page Addressing Mode, 0-7
  //    $C8,      // Set COM Output Scan Direction
  //    $00,      // --set low column address
  //    $10,      // --set high column address
  //    $40,      // --set start line address
  //    $81, $3F,    // Set contrast control register
  //    $A1,      // Set Segment Re-map. A0=address mapped; A1=address 127 mapped.
  //    $A6,      // Set display mode. A6=Normal; A7=Inverse
  //    $A8, $3F,    // Set multiplex ratio(1 to 64)
  //    $A4,      // Output RAM to Display
  //    // $A4=Output follows RAM content; $A5,Output ignores RAM content
  //    $D3, $00,    // Set display offset. 00 = no offset
  //    $D5,      // --set display clock divide ratio/oscillator frequency
  //    $F0,      // --set divide ratio
  //    $D9, $22,    // Set pre-charge period
  //    $DA, $12,    // Set com pins hardware configuration
  //    $DB,      // --set vcomh
  //    $20,      // $20,0.77xVcc
  //    $8D, $14);    // Set DC-DC enable

const
  init_sequence: array [0..26] of byte = (  // Initialization Sequence
    LCD_DISP_OFF,  // Display OFF (sleep mode)
    $20, %00,    // Set Memory Addressing Mode
    // 00=Horizontal Addressing Mode; 01=Vertical Addressing Mode;
    // 10=Page Addressing Mode (RESET); 11=Invalid
    $B0,      // Set Page Start Address for Page Addressing Mode, 0-7
    $C8,      // Set COM Output Scan Direction
    $00,      // --set low column address
    127,      // --set high column address
    $40,      // --set start line address
    $81, $3F,    // Set contrast control register
    $A1,      // Set Segment Re-map. A0=address mapped; A1=address 127 mapped.
    $A6,      // Set display mode. A6=Normal; A7=Inverse
    $A8, $3F,    // Set multiplex ratio(1 to 64)
    $A4,      // Output RAM to Display
    // $A4=Output follows RAM content; $A5,Output ignores RAM content
    $D3, $00,    // Set display offset. 00 = no offset
    $D5,      // --set display clock divide ratio/oscillator frequency
    $F0,      // --set divide ratio
    $D9, $22,    // Set pre-charge period
    $DA, $12,    // Set com pins hardware configuration
    $DB,      // --set vcomh
    $20,      // $20,0.77xVcc
    $8D, $14);    // Set DC-DC enable

const
  init_sequence2: array [0..37] of byte = (
    $FF, $D0,
    $FF, $E0,
    $FF, $C0 or (1 and $0f),
    $FF, $D0 or (1 and $0f),

    $AE,
    $D5, $80,
    $A8, $1F,

    $D3, $00,

    $40,

    $8D, $14,

    $20, $02,
    $A1,
    $C8,

    $D4, $02,
    $81, $CF,
    $D9, $F1,
    $DB, $40,

    $2E, $A4, $A6, $AF,

    $FF, $D0,
    255, 254);


var
  displayBuffer: array [0..511] of byte;

  procedure lcd_command(p: PByte; len: byte);
  var
    i: Int8;
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite($00);
    for i := 0 to len - 1 do begin
      TWIWrite(p[i]);
    end;
    TWIStop;
  end;

  procedure lcd_data(p: PByte; len: UInt16);
  var
    i: UInt16;
  begin
    TWIStart((addr shl 1) or TWI_Write);
    TWIWrite($40);
    for i := 0 to len - 1 do begin
      TWIWrite(p[i]);
    end;
    TWIStop;
  end;

  procedure ClrScr;
  begin

  end;

  procedure GotoXY(x, y: byte);
  var
    cs: array[0..3] of byte;
  begin
    cs[0] := $B0 + y;
    cs[1] := $21;
    cs[2] := x;
    cs[3] := $7F;

  end;

  procedure firstPage;
  begin

  end;

  procedure lcd_Init;
  begin
    lcd_command(@init_sequence2, SizeOf(init_sequence2));
  end;


const
  invert: array[0..0] of byte = ($a7);

begin
  i := 0;
  asm
           Cli
  end;
  UARTInit;
  TWIInit;
  asm
           Sei
  end;

  lcd_Init;

//lcd_command(@invert, 1);
  GotoXY(1, 1);




  repeat
    //FillChar(displayBuffer, SizeOf(displayBuffer), %01010101);

    for i := 0 to 255 do begin
      displayBuffer[i] := 3;
    end;
    //lcd_data(@displayBuffer, SizeOf(displayBuffer));
    lcd_data(@displayBuffer, 512);
    //UARTSendByte(Data0);
    //UARTSendByte(Data0 shr 8);
    //UARTSendByte(Data1);
    //UARTSendByte(Data1 shr 8);

    //WriteADS1115(ADSaddr0, buf[0], buf[1]);
    //Data0 := ReadADS1115(ADSaddr0);

    //WriteADS1115(ADSaddr1, buf[2], buf[3]);
    //Data1 := ReadADS1115(ADSaddr1);
  until 1 = 2;
end.
