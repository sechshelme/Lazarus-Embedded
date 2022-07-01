// Blink Pin A0/A1

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  sl = 20000;

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

var
  Pin: bitpacked array [0..7] of boolean absolute PORTA;

begin
  DDRA := %11;
  repeat
    Pin[0] := True;
    Pin[1] := False;
    mysleep(sl);

    Pin[0] := False;
    Pin[1] := True;
    mysleep(sl);
  until False;
end.
