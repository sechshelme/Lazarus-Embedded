// Multi Function Shield - 3 Button

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

procedure PC_Int1_Interrupt; public Name 'PCINT1_ISR'; interrupt;
begin
  // mache Irgendwas
  LED_port.P2 := Button_port.P1;
  LED_port.P3 := Button_port.P2;
  LED_port.P4 := Button_port.P3;
end;


begin
  // BP2 = D4, BP3 = D3, BP4 = D2
  // LED schalten inventiert, da Anode an VCC !

  PCICR:=%010;
  PCMSK1:=%00001010;

  avr_sei;


  LED_ddr.P2 := True;
  LED_ddr.P3 := True;
  LED_ddr.P4 := True;

  LED_port.P2 := True;
  LED_port.P3 := True;
  LED_port.P4 := True;

  repeat
    // Mache irgend etwas
  until False;
end.
