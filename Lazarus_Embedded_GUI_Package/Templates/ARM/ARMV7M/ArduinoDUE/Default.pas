// Default

program Project1;

{$H-,J-,O-}

uses
  cortexm3;

begin
  // Setup

  WDT.MR := 1 shl 15;  // Watchdog deaktivieren

  repeat
    // Loop;

  until false;
end.
