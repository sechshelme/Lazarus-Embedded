// Multi Function Shield - 7-Segment

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  digits: packed array[0..9] of byte = (
    %00111111, // = 0
    %00000110, // = 1
    %01011011, // = 2
    %01001111, // = 3
    %01100110, // = 4
    %01101101, // = 5
    %01111101, // = 6
    %00000111, // = 7
    %01111111, // = 8
    %01100111  // = 9
    );

const
  dataOutPin = 0;
  clockPin = 7;
  latchPin = 4;

type
  TPin = bitpacked array[0..7] of boolean;

var
  ModePinB: TPin absolute DDRB;
  ModePinD: TPin absolute DDRD;
  OutPinB: TPin absolute PORTB;
  OutPinD: TPin absolute PORTD;

  procedure shiftOut595(val: byte);
  var
    i: byte;
  begin
    for i := 7 downto 0 do begin
      if (val and (1 shl i)) <> 0 then begin
        OutPinB[dataOutPin] := True;
      end else begin
        OutPinB[dataOutPin] := False;
      end;
      OutPinD[clockPin] := True;
      OutPinD[clockPin] := False;
    end;
  end;

var
  n: byte;
  c: integer = 99;
  p: byte = 0;
  d: byte = 0;

begin
  // Anzeige ist auf gemeinsamer Anode !

  ModePinB[dataOutPin] := True;
  ModePinD[latchPin] := True;
  ModePinD[clockPin] := True;

  repeat
    Inc(d);
    if d > 100 then begin
      d := 0;
      Inc(c);
      if c > 9999 then begin
        c := 0;
      end;
    end;

    Inc(p);
    if (p > 3) then begin
      p := 0;
    end;

    //if p = 0 then begin
    //  n := c div 1000;
    //end else if p = 1 then begin
    //  n := c div 100 mod 10;
    //end else if p = 2 then begin
    //  n := c div 10 mod 10;
    //end else if p = 3 then begin
    //  n := c mod 10;
    //end;

    case p of
      0: begin
        n := c div 1000;
      end;
      1: begin
        n := c div 100 mod 10;
      end;
      2: begin
        n := c div 10 mod 10;
      end;
      3: begin
        n := c mod 10;
      end;
    end;

    OutPinD[latchPin] := False;
    OutPinD[latchPin] := True;
    shiftOut595(not digits[n]);
    shiftOut595(1 shl p);
  until False;
end.
