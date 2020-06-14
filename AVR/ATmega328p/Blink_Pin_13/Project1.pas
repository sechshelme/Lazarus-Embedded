program Project1;
const
  BP5 = 5; // Pin 13 des Arduino
  sl = 21000;

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
  DDRB := DDRB or (1 shl BP5);
  repeat
    PORTB := PORTB or (1 shl BP5);
    mysleep(sl);

    PORTB := PORTB and not (1 shl BP5);
    mysleep(sl);
  until 1 = 2;
end.
