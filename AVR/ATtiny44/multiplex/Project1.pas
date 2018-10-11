program Project1;

  //   {$O-}

var
  shiftPORT: byte absolute PORTA;
  shiftDDR: byte absolute DDRA;
  shiftPIN: byte absolute PINA;
const
  dataOutPin = 0;
  dataInPin = 1;
  latchPin = 2;
  clockPin = 3;

  LedPin = 7;

const
  digits: packed array[0..15] of byte = (
    %00111111,  // = 0
    %00000110,  // = 1
    %01011011,  // = 2
    %01001111,  // = 3
    %01100110,  // = 4
    %01101101,  // = 5
    %01111101,  // = 6
    %00000111,  // = 7
    %01111111,  // = 8
    %01100111,  // = 9
    %01110111,  // = a
    %01111100,  // = b
    %00111001,  // = c
    %01011110,  // = d
    %01111001,  // = e
    %01110001); // = f


  function ShiftIn74HC165: byte;
  var
    i: byte;
  begin
    Result := 0;
    for i := 0 to 7 do begin
      Result := (Result shl 1) or ((shiftPIN and (1 shl dataInPin)) shr dataInPin);

      shiftPORT := shiftPORT or (1 shl clockPin);
      shiftPORT := shiftPORT and not (1 shl clockPin);
    end;
  end;

  procedure shiftOut595(val: byte);
  var
    i: byte;
  begin
    for i := 7 downto 0 do begin
      if (val and (1 shl i)) <> 0 then begin
        shiftPORT := shiftPORT or (1 shl dataOutPin);
      end else begin
        shiftPORT := shiftPORT and not (1 shl dataOutPin);
      end;
      shiftPORT := shiftPORT or (1 shl clockPin);
      shiftPORT := shiftPORT and not (1 shl clockPin);
    end;
  end;

var
  zahl: array[0..3] of byte;

  procedure disp_val(val: byte);
  var
    achr: byte;
    leer: boolean;
  begin
    achr := 0;
    leer := True;
    while (val >= 100) do begin
      Dec(val, 100);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 0;
    end;
    zahl[1] := achr;

    achr := 0;
    while (val >= 10) do begin
      Dec(val, 10);
      Inc(achr);
      leer := False;
    end;
    if leer then begin
      achr := 0;
    end;
    zahl[2] := achr;

    achr := 0;
    while (val >= 1) do begin
      Dec(val);
      Inc(achr);
    end;
    zahl[3] := achr;
  end;


  procedure Timer0_Interrupt; public Name 'TIM0_COMPA_ISR'; interrupt;
  const
    b: integer = 0;
    segPos: byte = 0;
  var
    Data: byte;
  begin
    Inc(b);
    if b > 500 then begin
      PORTA := PORTA or (1 shl LedPin);
    end else begin
      PORTA := PORTA and not (1 shl LedPin);
    end;
    if b > 1000 then begin
      b := 0;
    end;

    Inc(segPos);
    if (segPos > 3) then begin
      segPos := 0;
    end;

    shiftPORT := shiftPORT and not (1 shl latchPin);
    shiftPORT := shiftPORT or (1 shl latchPin);

    Data := ShiftIn74HC165;

    disp_val(Data);
    zahl[0] := 0;

    shiftOut595(digits[zahl[segPos]]);
    shiftOut595(1 shl segPos);
  end;


  procedure delay;
  var
    i: integer;
  begin
    for i := 0 to 200 do begin
      asm
               Nop end;
    end;
  end;


begin
  asm
           Cli end;
  DDRA := (1 shl dataOutPin) or (1 shl latchPin) or (1 shl clockPin) or (1 shl LedPin);

  //// -- Timer initialisieren
  TCCR0A := (1 shl 1);
  TCCR0B := TCCR0B or %101;
  TIMSK0 := TIMSK0 or (1 shl OCIE0A);

  asm
           Sei end;
  // --- Ende timer
  repeat
    //zahl[0] := 1;
    //zahl[1] := 2;
    //zahl[2] := 3;
    //zahl[3] := 4;
    //delay;

    //zahl[0] := 5;
    //zahl[1] := 6;
    //zahl[2] := 7;
    //zahl[3] := 8;
    delay;
  until 1 = 2;
end.
