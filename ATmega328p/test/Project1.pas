program Project1;
const
  BP5 = 5; // Pin 13 des Arduino
  sl = 250000;

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

var
  r:record
  a, b: int32;
  end;

begin
  DDRB := DDRB or (1 shl BP5);
  repeat
    PORTB := PORTB or (1 shl BP5);
    mysleep(r.a);

    PORTB := PORTB and not (1 shl BP5);
    mysleep(r.b);
  until 1 = 2;
end.
