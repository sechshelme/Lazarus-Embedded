// Multi Function Shield - PIN Change Interrupt

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

type
  TPin = bitpacked record
    P0, P1, P2, P3, P4, P5, P6, P7: boolean;
  end;

var
  LED_ddr:     TPin absolute DDRB;
  LED_port:    TPin absolute PORTB;
  Button_port: TPin absolute PINC;

// Der Interrupt, welcher ausgelöst wird, sobald eine Änderung bei den vorgebenen Tasten vorgenommen wird.
// Überprüfen muss man selbst, was geändert wurde.

procedure PC_Int1_Interrupt; public Name 'PCINT1_ISR'; interrupt;
begin
  LED_port.P2 := Button_port.P1;
  LED_port.P3 := Button_port.P2;
  LED_port.P4 := Button_port.P3;
end;


begin
  // BP2 = D4, BP3 = D3, BP4 = D2
  // LED schalten inventiert, da Anode an VCC !

  // Interrupt für PortC aktivieren.
  PCICR  := %010;

  // Port CP1, CP2, CP3 für Interrupt aktivieren.
  PCMSK1 := %00001110;

  // Interrupt aktivieren
  avr_sei;

  // LED-Port auf Output
  LED_ddr.P2 := True;
  LED_ddr.P3 := True;
  LED_ddr.P4 := True;

  // Alle LED aus
  LED_port.P2 := True;
  LED_port.P3 := True;
  LED_port.P4 := True;

  repeat
    // Mache irgend etwas
  until False;
end.
