program Project1;
const
  BP7 = 7; // Pin 13 des Arduino
  sl = 300000;

  procedure mysleep(t: int32);
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      asm
               NOP;
      end;
    end;
  end;

begin
  DDRB := DDRB or (1 shl BP7);
  repeat
    PORTB := PORTB or (1 shl BP7);
    mysleep(sl);

    PORTB := PORTB and not (1 shl BP7);
    mysleep(sl);
  until 1 = 2;
end.
