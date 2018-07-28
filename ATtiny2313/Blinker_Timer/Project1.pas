program Project1;

uses
  intrinsics;

  //procedure cli; assembler; inline; // Interrupt aus
  //asm
  //         Cli
  //end;
  //
  //procedure sei; assembler; inline; // Interrupt ein
  //asm
  //         Sei
  //end;

  procedure Timer0_Interrupt; public Name 'TIMER0_COMPA_ISR'; interrupt;
  const
    t = 10;         // LED sollte nur bei jedem 10. Durchlauf umschalten.
    z: integer = 0; // Zähler für Leerdurchläufe.
  begin
    TCNT0 := 128;                       // Speed halbieren  0 = langsm (default)
    Inc(z);
    if (z = t) then begin
      PORTD := PORTD or (1 shl 0);      // LED Pin0 ein
    end;
    if (z = t * 2) then begin
      PORTD := PORTD and not (1 shl 0); // LED Pin0 aus
      z := 0;
    end;
  end;

  procedure Timer1_Interrupt; public Name 'TIMER1_COMPA_ISR'; interrupt;
  const
    t = 500;        // LED sollte nur bei jedem 500. Durchlauf umschalten.
    z: integer = 0; // Zähler für Leerdurchläufe.
  begin
    Inc(z);
    if (z = t) then begin
      PORTD := PORTD or (1 shl 1);      // LED Pin1 ein
    end;
    if (z = t * 2) then begin
      PORTD := PORTD and not (1 shl 1); // LED Pin1 aus
      z := 0;
    end;
  end;

begin
  // -- Interupt unterbinden.
  avr_cli;

  // -- Bit 0 und 1 von PortD auf Ausgabe stellen.
  DDRD := DDRD or (1 shl 0) or (1 shl 1);

  // -- Timer0 initialisieren.
  TCCR0A := 0;
  TCCR0B := %101;                   // CPU-Takt / 1024
  TIMSK := TIMSK or (1 shl OCIE0A); // Timer0 soll Interrupt auslösen.

  // -- Timer1 initialisieren.
  TCCR1A := 1;                      // CTC-Modus
  TCCR1B := %010;                   // CPU-Takt / 8
  TIMSK := TIMSK or (1 shl OCIE1A); // Timer1 soll Interrupt auslösen.

  // -- Interrupt aktivieren.
  avr_sei;
  repeat
    // Mache Irgendwas.
  until 1 = 2;
end.
