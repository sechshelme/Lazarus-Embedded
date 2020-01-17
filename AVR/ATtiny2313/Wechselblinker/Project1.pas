program Project1;
uses
  intrinsics;

const
  DP0 = 0;      // Pin0 PortD
  DP1 = 1;      // Pin1 PortD
  DP2 = 2;      // Pin1 PortD
  DP3 = 3;      // Pin1 PortD
  sl = 50000;  // Verzögerung

  procedure mysleep(t: int32); // Ein einfaches Delay.
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      avr_nop;
    end;
  end;

type
  TLed = bitpacked record
    green, yellow, red, blue: boolean;
  end;


var
  LedPORT: TLed absolute PORTD;
  LedDDR: TLed absolute DDRD;

  LEDPortA: bitpacked array [0..7] of boolean absolute PORTD;
  LEDPortS: set of (green, yellow, red, blue) absolute PORTD;


begin

  {$IFDEF CPUAVR}
  LedDDR.green := True;
  {$ENDIF}

  {$IFDEF CPUAVRTINY2313}
  LedDDR.green := True;
  {$ENDIF}


  LedDDR.green := True;
  LedDDR.yellow := True;
  LedDDR.red := True;
  LedDDR.blue := True;

  //  LedPORT.blue:=True;
  //  LedPORT.red:=True;
  //  LEDPortS := [yellow, red];

  repeat

    LedPORT.green := True;
    LedPORT.red := False;
    mysleep(sl);

    LedPORT.green := False;
    LedPORT.red := True;
    mysleep(sl);
  until 1 = 2;
end.
