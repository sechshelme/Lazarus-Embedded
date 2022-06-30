// Multi Function Shield - 7-Segment

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

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

const
  dataOutPin = 0;
  clockPin = 7;
  latchPin = 4;

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do begin
      asm
          Nop;
      end;
    end;
  end;

  procedure ModePortB(Pin: byte; Value: boolean);
  begin
    if Value then begin
      DDRB := DDRB or (1 shl Pin);
    end else begin
      DDRB := DDRB and not (1 shl Pin);
    end;
  end;

  procedure WritePortB(Pin: byte; Value: boolean);
  begin
    if Value then begin
      PORTB := PORTB or (1 shl Pin);
    end else begin
      PORTB := PORTB and not (1 shl Pin);
    end;
  end;

  procedure ModePortD(Pin: byte; Value: boolean);
  begin
    if Value then begin
      DDRD := DDRD or (1 shl Pin);
    end else begin
      DDRD := DDRD and not (1 shl Pin);
    end;
  end;

  procedure WritePortD(Pin: byte; Value: boolean);
  begin
    if Value then begin
      PORTD := PORTD or (1 shl Pin);
    end else begin
      PORTD := PORTD and not (1 shl Pin);
    end;
  end;

  procedure shiftOut595(val: byte);
  var
    i: byte;
  begin
    for i := 7 downto 0 do begin
      if (val and (1 shl i)) <> 0 then begin
        WritePortB(dataOutPin, True);
      end else begin
        WritePortB(dataOutPin, False);
      end;
      WritePortD(clockPin, True);
      WritePortD(clockPin, False);
    end;
  end;

var
  zahl: array[0..3] of byte;

  procedure disp_valnnnn(vval: uint16);
  var
    achr: uint8;
    leer: boolean;
    oldvval: uint16;
  begin
    oldvval := vval;
    achr := 0;
    leer := True;
    while (vval >= 1000) do begin
      Dec(vval, 1000);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if (oldvval >= 1000) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Zahl[0] := achr;

    achr := 0;
    leer := True;
    while (vval >= 100) do begin
      Dec(vval, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if (oldvval >= 100) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Zahl[1] := achr;

    achr := 0;
    leer := True;
    while (vval >= 10) do begin
      Dec(vval, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if (oldvval >= 10) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Zahl[2] := achr;

    achr := 0;
    leer := True;
    while (vval >= 1) do begin
      Dec(vval);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      if (oldvval >= 1) then begin
        achr := 0;
      end else begin
        achr := 16;
      end;
    end;
    Zahl[3] := achr;
  end;

var
  d: integer=0;
  p: byte = 0;

begin
  // LED schalten inventiert, da Anode an VCC !

  ModePortB(dataOutPin, True);
  ModePortD(latchPin, True);
  ModePortD(clockPin, True);

  repeat
    p := p + 1;
    if (p > 3) then begin
      p := 0;
    end;

    WritePortD(latchPin, False);
    WritePortD(latchPin, True);

    Inc(d);
    if d > 9999 then begin
      d := 0;
    end;
    disp_valnnnn(d);

    //    zahl[1] := d div 100;
    //    zahl[2] := d mod 100 div 10;
    //    zahl[3] := d mod 10;

    shiftOut595(not digits[zahl[p]]);
    shiftOut595(1 shl p);
  until False;
end.
