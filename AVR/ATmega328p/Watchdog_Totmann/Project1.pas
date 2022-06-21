// Multi Function Shield - Watchdog Totmann

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

type
  TPin = bitpacked record
    P0, P1, P2, P3, P4, P5, P6, P7: boolean;
  end;

var
  LED_DDR: TPin absolute DDRB;
  LED_port: TPin absolute PORTB;
  BeeperDDR: TPin absolute DDRD;
  BeeperPort: TPin absolute PORTD;
  Buttonport: TPin absolute PINC;

const
  WDP0 = 0;
  WDP1 = 1;
  WDP2 = 2;
  WDP3 = 5;


  // Der Interrupt, welcher ausgelöst wird, sobald eine Änderung bei den vorgebenen Tasten vorgenommen wird.
  // Überprüfen muss man selbst, was geändert wurde.
  // Auch wird der Watchdog zurückgesetzt wen eine Taste betätigt wird.

  procedure PC_Int1_Interrupt; public Name 'PCINT1_ISR'; interrupt;
  begin
    LED_port.P2 := Buttonport.P1;
    LED_port.P3 := Buttonport.P2;
    LED_port.P4 := Buttonport.P3;
    avr_wdr;
    BeeperPort.P3 := True;
  end;

  // Beeper gibt Alarm, wen keine Aktion an den Tasten vorliegt.

  procedure WDT_ISR_Interrupt; public Name 'WDT_ISR'; interrupt;
  begin
    BeeperPort.P3 := False;
  end;


begin
  // BP2 = D4, BP3 = D3, BP4 = D2
  // LED und Beeper schalten inventiert, da Rückleitung an VCC !

  // Interrupt aus
  avr_cli;

  // Interrupt für PortC aktivieren.
  PCICR := %010;

  // Port CP1, CP2, CP3 für Interrupt aktivieren.
  PCMSK1 := %00001110;

  // Watchdog aktivieren.
  WDTCSR := WDTCSR or (1 shl WDCE) or (1 shl WDE);
  WDTCSR := (1 shl WDIE) or (1 shl WDP3); // 4s / interrupt

  // Interrupt ein
  avr_sei;

  // LED-Port auf Output
  LED_DDR.P2 := True;
  LED_DDR.P3 := True;
  LED_DDR.P4 := True;

  // LED-Port auf Output
  BeeperDDR.P3 := True;

  // Beeper aus
  BeeperPort.P3 := True;

  // Alle LED aus
  LED_port.P2 := True;
  LED_port.P3 := True;
  LED_port.P4 := True;

  repeat
    // Mache irgend etwas
  until False;
end.
