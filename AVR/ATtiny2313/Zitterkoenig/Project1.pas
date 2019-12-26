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
    %10000000  // = -
    );
type
  TSPIGPIO = bitpacked record
    p0, p1, p2, p3, SlaveSelect, DataInt, DataOut, Clock: boolean;
  end;

var
  SPI_PORT: TSPIGPIO absolute PORTB;
  SPI_DDR: TSPIGPIO absolute DDRB;

  z: Int16 = 0;
  Data: array[0..3, 0..2] of byte;


  //procedure disp_valnnnnn(vval: uint16);
  //var
  //  achr: uint8;
  //  leer: boolean;
  //begin
  //  achr := 0;
  //  leer := True;
  //  while (vval >= 1000) do begin
  //    Dec(vval, 1000);
  //    Inc(achr);
  //    leer := False;
  //  end;
  //  if leer then begin
  //    achr := 16;
  //  end;
  //  Data[1] := achr;
  //
  //  achr := 0;
  //  while (vval >= 100) do begin
  //    Dec(vval, 100);
  //    Inc(achr);
  //    leer := False;
  //  end;
  //  if leer then begin
  //    achr := 16;
  //  end;
  //  Data[1] := achr;
  //
  //  achr := 0;
  //  while (vval >= 10) do begin
  //    Dec(vval, 10);
  //    Inc(achr);
  //    leer := False;
  //  end;
  //  if leer then begin
  //    achr := 16;
  //  end;
  //  Data[2] := achr;
  //
  //  achr := 0;
  //  while (vval >= 1) do begin
  //    Dec(vval);
  //    Inc(achr);
  //  end;
  //  Data[3] := achr;
  //end;


  procedure SPIWriteData(p: PByte; len: byte);
  var
    i: byte;
  begin
    SPI_PORT.SlaveSelect := False;
    for i := len - 1 downto 0 do begin
      USIDR := p[i];
      USISR := 1 shl USIOIF;

      repeat
        USICR := (%01 shl USIWM) or (%10 shl USICS) or (1 shl USICLK) or (1 shl USITC);
      until (USISR and (1 shl USIOIF)) <> 0;

    end;
    SPI_PORT.SlaveSelect := True;
  end;

  procedure Timer0_Interrupt; public Name 'TIMER0_COMPA_ISR'; interrupt;
  const
    p: byte = 0;
  begin
    p := p + 1;
    if (p > 3) then begin
      p := 0;
    end;

    PORTB := PORTB and %11110000;
    SPIWriteData(@Data[p], 3);
    PORTB := PORTB or (1 shl p);
  end;

begin
  avr_cli();
  SPI_DDR.DataOut := True;
  SPI_DDR.Clock := True;
  SPI_DDR.SlaveSelect := True;

  DDRB := DDRB or %00001111;

  // -- Timer initialisieren
  TCCR0A := (1 shl WGM01);
  TCCR0B := TCCR0B or %101;
  TIMSK := TIMSK or (1 shl OCIE0A);
  avr_sei();
  // --- Ende Timer

  repeat
    //    disp_valnnnnn(z);

    //    zahl[1] := d div 100;
    //    zahl[2] := d mod 100 div 10;
    //    zahl[3] := d mod 10;

    //    Inc(z);
    Data[0, 0] := digits[1];
    Data[1, 0] := digits[2];
    Data[2, 0] := digits[3];
    Data[3, 0] := digits[4];

    Data[0, 1] := digits[3];
    Data[1, 1] := digits[4];
    Data[2, 1] := digits[5];
    Data[3, 1] := digits[6];

    Data[0, 2] := digits[8];
    Data[1, 2] := digits[7];
    Data[2, 2] := digits[6];
    Data[3, 2] := digits[5];
  until 1 = 2;
end.
