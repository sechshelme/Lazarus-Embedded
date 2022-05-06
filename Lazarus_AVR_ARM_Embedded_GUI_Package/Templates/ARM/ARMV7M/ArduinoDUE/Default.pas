// Default

program Project1;

{$H-,J-,O-}

uses
  cortexm3;

begin
  // Setup

  WDT.CR := 0; // Watchdog deaktivieren

  repeat
    // Loop;

  until false;
end.
