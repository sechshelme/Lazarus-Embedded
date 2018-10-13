program Project1;


  procedure sleep;
  var
    i: Int16;
  begin
    for i := 0 to 1999 do begin
      asm
               Nop;
      end;
    end;
  end;

var
  i: integer;

begin
  // PD6 und PD7 auf Ausgang
  DDRD := %01100000;

  // PD6 und PD7 als PWM
  TCCR0A := (%10 shl COM0A) or (%10 shl COM0B) or (%01 shl WGM0);

  // Timer 0 aktivieren, Clock / 1024
  TCCR0B := TCCR0B or %101;

  // Hauptschleife, welche die LEDs kontunierlich heller und dunkler macht.
  repeat
    for i := 0 to 255 do begin
      OCR0A := i;
      OCR0B := 255 - i;
      sleep;
    end;
    for i := 0 to 255 do begin
      OCR0A := 255 - i;
      OCR0B := i;
      sleep;
    end;
  until 1 = 2;
end.
