program Project1;

uses
  intrinsics;

{$O-}

const
  WGM01 = 1;
  CS01 = 1;

const
  digits: packed array[0..17] of byte = (
    %00111111, // = 0
    %00000110, // = 1
    %01011011, // = 2
    %01001111, // = 3
    %01100110, // = 4
    %01101101, // = 5
    %01111101, // = 6
    %00000111, // = 7
    %01111111, // = 8
    %01100111, // = 9

    %01110111, // = a
    %01111100, // = b
    %00111001, // = c
    %01011110, // = d
    %01111001, // = e
    %01110001, // = f
    %00000000, // = blank
    %10000000  // = .
    );
type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataInt, DataOut, Clock: boolean;
  end;

  TGPIOD = bitpacked record
    Draht, Start, m0, m1, m2, m3, Ende: boolean;
  end;

  TLCD = array[0..3] of byte;

var
  SPI_DDR: TSPIGPIO absolute DDRB;
  SPI_PORT: TSPIGPIO absolute PORTB;

  GPIOD_IN: TGPIOD absolute PIND;
  GPIOD_DRR: TGPIOD absolute DDRD;
  GPIOD_PORT: TGPIOD absolute PORTD;

  z: Int16 = 0;
  Data: array[0..3, 0..2] of byte;

var
  Counter: record
    contact, timer, score: Int16;
    run: boolean;
  end;


  function disp_valnnnnn(vval: uint16): TLCD;
  var
    achr: uint8;
    leer: boolean;
  begin
    achr := 0;
    leer := True;
    while (vval >= 1000) do begin
      Dec(vval, 1000);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Result[0] := achr;

    achr := 0;
    while (vval >= 100) do begin
      Dec(vval, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Result[1] := achr;

    achr := 0;
    while (vval >= 10) do begin
      Dec(vval, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    Result[2] := achr;

    achr := 0;
    while (vval >= 1) do begin
      Dec(vval);
      Inc(achr);
    end;
    Result[3] := achr;
  end;


  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    for i := len - 1 downto 0 do begin
      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%10 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

    end;
    SPI_PORT.SlaveSelect := False;
    SPI_PORT.SlaveSelect := True;
  end;

  procedure Timer0_Interrupt; public Name 'TIMER0_COMPA_ISR'; interrupt;
  const
    p: byte = 0;
    z: int16 = 0;
  var
    temp_LCD: TLCD;

  begin
    Inc(z);
    if z = 300 then begin
      if Counter.timer < 9999 then begin
        if Counter.run then begin
          Inc(Counter.timer);
        end;
        z := 0;
      end;
    end;

    with Counter do begin
      score:=9999-(contact+timer)shl 4;

      if score < 0 then score:=0;

    end;

    //  inc(  Counter.timer);

    temp_LCD := disp_valnnnnn(Counter.contact);

    Data[0, 0] := digits[temp_LCD[0]];
    Data[1, 0] := digits[temp_LCD[1]];
    Data[2, 0] := digits[temp_LCD[2]];
    Data[3, 0] := digits[temp_LCD[3]];

    temp_LCD := disp_valnnnnn(Counter.timer);

    Data[0, 1] := digits[temp_LCD[0]];
    Data[1, 1] := digits[temp_LCD[1]];
    Data[2, 1] := digits[temp_LCD[2]] or %10000000;
    Data[3, 1] := digits[temp_LCD[3]];

    temp_LCD := disp_valnnnnn(Counter.score);

    Data[0, 2] := digits[temp_LCD[0]];
    Data[1, 2] := digits[temp_LCD[1]] or %10000000;
    Data[2, 2] := digits[temp_LCD[2]];
    Data[3, 2] := digits[temp_LCD[3]];

    p := p + 1;
    if (p > 3) then begin
      p := 0;
    end;

    PORTD := PORTD and %11000011;
    SPIWriteData(@Data[p], 3);
    PORTD := PORTD or (%00100000 shr p);
  end;

var
  i: UInt16;

begin
  Counter.contact := 0;
  Counter.timer := 0;
  Counter.score := 0;
  Counter.run := True;

  avr_cli();
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  DDRD := %00111100;
  GPIOD_PORT.Start := True;
  GPIOD_PORT.Draht := True;
  GPIOD_PORT.Ende := True;

  // -- Timer initialisieren
  TCCR0A := (1 shl WGM01);
  //  TCCR0B := TCCR0B or %101;
  TCCR0B := TCCR0B or %101;
  TIMSK := TIMSK or (1 shl OCIE0A);
  avr_sei();
  // --- Ende Timer

  repeat
    if not GPIOD_IN.Start then begin
      Counter.contact := 0;
      Counter.timer := 0;
      Counter.score := 0;
    end else if not GPIOD_IN.Draht then begin
      if Counter.contact < 9999 then begin
        Inc(Counter.contact);
        for i := 0 to 10 do begin
        end;
      end;
    end;
    if not GPIOD_IN.Ende then begin
      Counter.run := False;
      repeat
      until not GPIOD_IN.Start;
      Counter.run := True;
    end;


  until 1 = 2;
end.
