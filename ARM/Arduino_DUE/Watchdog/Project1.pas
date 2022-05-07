program Project1;

{$H-,J-,O-}

uses
  cortexm3;

  procedure Delay;
  var
    i: uint32;
  begin
    for i := 0 to 10001 do begin
      asm
               Nop // Leerbefehl
      end;
    end;
  end;

  procedure watchdogRestart;
  begin
    WDT.CR := $A5000001; // WDT_Restart
  end;

  procedure watchdogDisabled;
  begin
    WDT.MR := 1 shl 15;    // (WDT_MR) Watchdog Disable
  end;

  procedure watchdogEnable(timeout: UInt32);
  const
      WDT_MR_WDRSTEN = 1 shl 13;  // (WDT_MR) Watchdog Reset Enable
  begin
    timeout := timeout * 256 div 1000;
    if timeout = 0 then begin
      timeout := 1;
    end else if timeout > $FFF then begin
      timeout := $FFF;
    end;
    timeout := WDT_MR_WDRSTEN or ($FFF and timeout) or (($FFF shl 16) and (timeout shl 16));
    WDT.MR := timeout;
  end;

const
  led = 1 shl 27;

begin
  PIOB.PER := led;
  PIOB.OER := led;

  //  watchdogDisabled; // Watchdog deaktivieren
  watchdogEnable(3000);

  repeat
    // Pin13 -- High
//    watchdogRestart;

    PIOB.SODR := led;
    Delay;

    // Pin13 -- Low
    PIOB.CODR := led;
    Delay;
  until False;
end.
