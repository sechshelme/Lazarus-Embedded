program Project1;

{$H-}

uses
  twi,
  lcd;

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate

  procedure Sleep;
  var
    i: integer;
  begin
    for i := 1 to 30000 do begin
      asm
               Nop end;
    end;
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

var
  MyLcd2,
  Mylcd4: TLCD;
  p: byte;
const
  herz: TCharMap = (%00000, %01010, %11111, %11111, %01110, %00100, %00000, %00000);


begin
  UARTInit;
  TWIInit;
  asm
           Sei
  end;
  Mylcd2.Create($3F);
  Mylcd2.Clear;

  Mylcd2.setCursor(0, 0);
  Mylcd2.Write('Hello LCD klein ! ');
  Mylcd2.setCursor(0, 1);
  Mylcd2.Write('Hello World !');


  Mylcd4.Create($27);
  Mylcd4.Clear;
  Mylcd4.createChar(3, herz);

  Mylcd4.cursor(True);
  Mylcd4.blink(True);

  Mylcd4.setCursor(0, 0);
  Mylcd4.Write(#3 + ' Hello LCD gross ! ' + #3);
  Mylcd4.setCursor(0, 1);
  Mylcd4.Write('Hello World !');
  Mylcd4.setCursor(0, 2);
  Mylcd4.Write('Hello Lazarus !');
  Mylcd4.setCursor(0, 3);
  Mylcd4.Write('Hello AVR !');

  repeat
    Inc(p);
    if p > 16 then begin
      p := 0;
    end;
    //    Mylcd4.setCursor(p, 1);
    Sleep;
    Sleep;
    //    UARTSendChar('A');
  until 1 = 2;
end.
