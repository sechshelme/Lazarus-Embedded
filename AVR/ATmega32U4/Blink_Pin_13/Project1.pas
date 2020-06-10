program Project1;

const
  BP5 = 5; // Pin 13 des Arduino
  PC7 = 7;
  sl = 25000;

  procedure mysleep(t: int32);
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      asm
               Nop;
      end;
    end;
  end;

begin
//  DDRB := DDRB or (1 shl BP5);
  DDRC := DDRC or (1 shl PC7);
  repeat
    PORTC := PORTC or (1 shl PC7);
    mysleep(sl);

    PORTC := PORTC and not (1 shl PC7);
    mysleep(sl);
  until 1 = 2;
end.
