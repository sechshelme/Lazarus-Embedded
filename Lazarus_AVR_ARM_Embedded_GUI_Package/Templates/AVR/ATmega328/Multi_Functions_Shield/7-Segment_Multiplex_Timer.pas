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
  clockPin   = 7;
  latchPin   = 4;

type
  TPin = bitpacked array[0..7] of boolean;

var
  ModePinB: TPin absolute DDRB;
  ModePinD: TPin absolute DDRD;
  OutPinB:  TPin absolute PORTB;
  OutPinD:  TPin absolute PORTD;

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

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
  c: integer = 9900;
  p: byte = 0;
  n: byte;

  procedure Timer0_Interrupt; public Name 'TIMER0_OVF_ISR'; interrupt;
  begin

    Inc(p);
    if (p > 3) then begin
      p := 0;
    end;
    if p = 0 then begin
      n := c div 1000;
    end else if p = 1 then begin
      n := c div 100 mod 10;
    end else if p = 2 then begin
      n := c div 10 mod 10;
    end else if p = 3 then begin
      n := c mod 10;
    end;

    OutPinD[latchPin] := False;
    OutPinD[latchPin] := True;
    shiftOut595(not digits[n]);
    shiftOut595(1 shl p);
  end;

begin
  // Anzeige ist auf gemeinsamer Anode !

  ModePinB[dataOutPin] := True;
  ModePinD[latchPin]   := True;
  ModePinD[clockPin]   := True;

  // Timer 0
  TCCR0A := %00;               // Normaler Timer
  TCCR0B := %100;              // Clock / 256
  TIMSK0 := (1 shl TOIE0);     // Enable Timer0 Interrupt.

  avr_sei;

  repeat
    Inc(c);
    if c > 9999 then begin
      c := 0;
    end;
    mysleep(40000);
  until False;
end.
