program Project1;

uses
  intrinsics;

const
  sl = 50000;  // Verzögerung

  procedure mysleep(t: int32); // Ein einfaches Delay.
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

var
  LED_PORT: Byte absolute $38;
  LED_DDR: Byte absolute $37;

begin
  LED_DDR := $FF;
  repeat
    LED_PORT := $FF;
    mysleep(sl);

    LED_PORT := $00;
    mysleep(sl);
  until 1 = 2;
end.
