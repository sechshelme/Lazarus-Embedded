program Project1;

{$O-}

uses
  intrinsics;

// --- Ringbuffer
const
  // Buffergrösse
  SPI_Buf_Len = 255;

var
  // Pufferezeiger unf Puffer
  SPI_Buf_FirstOut: byte = 0;
  SPI_Buf_LastIn: byte = 0;
  SPI_Buf_Data: array[0..SPI_Buf_Len - 1] of byte;

  // --- GPIOs für SPI
type
  TSPI_GPIO = bitpacked record
    p0, p1, SlaveSelect, MOSI, MISO, Clock, p6, p7: boolean;
  end;

var
  SPI_Port: TSPI_GPIO absolute PORTB;
  SPI_DDR: TSPI_GPIO absolute DDRB;



  procedure UARTInit;
  const
    CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
    Baud = 9600;
    teiler = CPU_Clock div (16 * Baud) - 1;
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

procedure SPI_Int_Send; public Name 'SPI__STC_ISR'; interrupt;
var
  tchr: byte;
begin
  tchr := SPDR;
  if tchr <> 0 then begin
    SPI_Buf_Data[SPI_Buf_LastIn] := tchr;
    Inc(SPI_Buf_LastIn);
    if SPI_Buf_LastIn >= SPI_Buf_Len then begin
      SPI_Buf_LastIn := 0;
    end;
  end;
end;

var
  ch: byte;

begin
  // UART auf inizialisieren.
  UARTInit;

  // SPI als Slave, Interrupt gesteuert.
  SPCR := (1 shl SPE) or (1 shl SPIE);

  // Interrupt aktivieren.
  avr_sei;

  // SendePin
  SPI_DDR.MISO := True; // Nur nötig, wen der Slave auch sendet.

  repeat
    while SPI_Buf_LastIn <> SPI_Buf_FirstOut do begin
      ch := SPI_Buf_Data[SPI_Buf_FirstOut];
      Inc(SPI_Buf_FirstOut);
      if SPI_Buf_FirstOut >= SPI_Buf_Len then begin
        SPI_Buf_FirstOut := 0;
      end;
      UARTSendChar(char(ch));
    end;
  until 1 = 2;
end.
