program Project1;

const
  WGM01 = 1;
  CS01 = 1;

  procedure mysleep(t: int32);
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      asm
               Nop;
      end;
    end;
  end;

  procedure sei; assembler;
  asm
           Sei
  end;

  procedure cli; assembler;
  asm
           Cli
  end;

const
  blank = 16;
  minus = 17;

  // PortB
  dataInPin = 0;
  carryPin = 1;
  negPin = 2;
  hexPin = 3;

  // PortD
  dataOutPin = 0;
  latchPin = 1;
  clockPin = 2;

// Achtung, 7-Segment Bausteine sind 180Grad verdreht verbaut !
const
  digits: packed array[0..17] of byte = (
    %00111111, // = 0
    %00110000, // = 1
    %10011011, // = 2
    %10111001, // = 3
    %10110100, // = 4
    %10101101, // = 5
    %10101111, // = 6
    %00111000, // = 7
    %10111111, // = 8
    %10111101, // = 9

    %10110111, // = a
    %10111100, // = b
    %10111001, // = c
    %10011110, // = d
    %10111001, // = e
    %10110001, // = f
    %00000000, // = blank
    %10000000  // = -
    );

  procedure ModePortD(Pin: Byte; Value: Boolean);
  begin
    if Value then begin
      DDRD := DDRD or (1 shl Pin);
    end else begin
      DDRD := DDRD and not (1 shl Pin);
    end;
  end;

  procedure WritePortD(Pin: Byte; Value: Boolean);
  begin
    if Value then begin
      PORTD := PORTD or (1 shl Pin);
    end else begin
      PORTD := PORTD and not (1 shl Pin);
    end;
  end;

  function ReadPortB(bit: Byte): Boolean;
  begin
    Result := PINB and (1 shl bit) <> 0;
  end;


  function ShiftIn74HC165: Byte;
  var
    i: Byte;
  begin
    Result := 0;
    for i := 0 to 7 do begin
      Result := (Result shl 1) or Byte(ReadPortB(dataInPin));
      WritePortD(clockPin, True);
      WritePortD(clockPin, False);
    end;
  end;

  procedure shiftOut595(val: Byte);
  var
    i: Byte;
  begin
    for i := 7 downto 0 do begin
      if (val and (1 shl i)) <> 0 then begin
        WritePortD(dataOutPin, True);
      end else begin
        WritePortD(dataOutPin, False);
      end;
      WritePortD(clockPin, True);
      WritePortD(clockPin, False);
    end;
  end;

var
  zahl: array[0..3] of byte;

  procedure disp_valnnnnn(vval: uint16);
  var
    achr: uint8;
    leer: boolean;
  begin
    achr := 0;
    leer := True;
    while (vval >= 100) do begin
      Dec(vval, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    zahl[1] := achr;

    achr := 0;
    while (vval >= 10) do begin
      Dec(vval, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 16;
    end;
    zahl[2] := achr;

    achr := 0;
    while (vval >= 1) do begin
      Dec(vval);
      Inc(achr);
    end;
    zahl[3] := achr;
  end;

  procedure Timer0_Interrupt; public Name 'TIMER0_COMPA_ISR'; interrupt;
  var
    d: integer;
  const
    p: byte = 0;
  begin
    p := p + 1;
    if (p > 3) then begin
      p := 0;
    end;

    WritePortD(latchPin, False);
    WritePortD(latchPin, True);

    d := ShiftIn74HC165;
    if ReadPortB(negPin) then begin
      if not ReadPortB(carryPin) then begin
        Dec(d, 256);
        d := abs(d);
        zahl[0] := minus;
      end else begin
        zahl[0] := blank;
      end;

    end else begin
      zahl[0] := blank;
      if ReadPortB(carryPin) then begin
        Inc(d, 256);
      end;
    end;

    disp_valnnnnn(d);

    //    zahl[1] := d div 100;
    //    zahl[2] := d mod 100 div 10;
    //    zahl[3] := d mod 10;

    shiftOut595(digits[zahl[p]]);
    shiftOut595(1 shl p);
  end;

begin
  cli();
  DDRB := 0;
  ModePortD(dataOutPin, True);
  ModePortD(latchPin, True);
  ModePortD(clockPin, True);

  zahl[0] := blank;

  // -- Timer initialisieren
  TCCR0A := (1 shl WGM01);
  TCCR0B := TCCR0B or %101;
  TIMSK := TIMSK or (1 shl OCIE0A);
  sei();
  // --- Ende timer
  repeat
  until 1 = 2;
end.
