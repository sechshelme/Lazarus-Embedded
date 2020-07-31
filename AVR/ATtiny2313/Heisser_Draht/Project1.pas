program Project1;

uses
  intrinsics;

{$O+}

const
  WGM01 = 1;

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

  Data: array[0..3, 0..2] of byte;

var
  Counter: record
    contact, timer, score: Int16;
    run: boolean;
  end;
         type
TZeroMask=array[0..3] of Boolean;


  function disp_valnnnnn(vval: uint16; zeroMask:TZeroMask): TLCD;
  var
    achr: uint8;
    leer: boolean;
    oldvval:UInt16;
  begin
    oldvval:=vval;
    achr := 0;
    leer := True;
    while (vval >= 1000) do begin
      Dec(vval, 1000);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if zeroMask[0] or (oldvval >= 1000) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Result[0] := achr;

    achr := 0;
    leer := True;
    while (vval >= 100) do begin
      Dec(vval, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if zeroMask[1] or (oldvval >= 100) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Result[1] := achr;

    achr := 0;
    leer := True;
    while (vval >= 10) do begin
      Dec(vval, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if zeroMask[2] or (oldvval >= 10)  then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Result[2] := achr;

    achr := 0;
    leer := True;
    while (vval >= 1) do begin
      Dec(vval);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if zeroMask[3] or (oldvval >= 1) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
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
  end;

  procedure UpDateData;
  const
    zm0:TZeroMask=(False,False,False,True);
    zm1:TZeroMask=(False,False,True,True);
    zm2:TZeroMask=(False,True,True,True);
    zm3:TZeroMask=(True,True,True,True);
  var
    temp_LCD: TLCD;
    c: Int32;
  begin
    with Counter do begin
      c := contact + timer;
      c := c shl 2;
      if c > 9999 then begin
        score := 0;
      end else begin
        score := 9999 - c;
        if score < 0 then begin
          score := 0;
        end;
      end;
    end;

    temp_LCD := disp_valnnnnn(Counter.contact, zm0);

    Data[0, 0] := digits[temp_LCD[0]];
    Data[1, 0] := digits[temp_LCD[1]];
    Data[2, 0] := digits[temp_LCD[2]];
    Data[3, 0] := digits[temp_LCD[3]];

    temp_LCD := disp_valnnnnn(Counter.timer, zm1);

    Data[0, 1] := digits[temp_LCD[0]];
    Data[1, 1] := digits[temp_LCD[1]];
    Data[2, 1] := digits[temp_LCD[2]] or %10000000;
    Data[3, 1] := digits[temp_LCD[3]];

    temp_LCD := disp_valnnnnn(Counter.score, zm2);

    Data[0, 2] := digits[temp_LCD[0]];
    Data[1, 2] := digits[temp_LCD[1]] or %10000000;
    Data[2, 2] := digits[temp_LCD[2]];
    Data[3, 2] := digits[temp_LCD[3]];

  end;

  procedure Timer0_Interrupt; public Name 'TIMER0_COMPA_ISR'; interrupt;
  const
    p: byte = 0;
    z: int16 = 0;
    i: int16 = 0;

  begin
    Inc(z);
    if z = 800 then begin
      if Counter.timer < 9999 then begin
        if Counter.run then begin
          Inc(Counter.timer);
        end;
        z := 0;
      end;
    end;

    Inc(i);
    if i > 10 then begin
      i := 0;

      p := p + 1;
      if (p > 3) then begin
        p := 0;
      end;

      SPIWriteData(@Data[p], 3);
      PORTD := PORTD and %11000011;
      SPI_PORT.SlaveSelect := False;
      SPI_PORT.SlaveSelect := True;
      PORTD := PORTD or (%00100000 shr p);
    end;
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
        for i := 0 to 500 do begin
        end;
      end;
    end;
    UpDateData;

    if not GPIOD_IN.Ende then begin
      Counter.run := False;
      repeat
      until not GPIOD_IN.Start;
      Counter.run := True;
    end;

  until False;
end.
