// Blink Pin 13

program Project1;

{$H-,J-,O-}

const
  BP5 = 5; // Pin 13 des Arduino
  sl = 20001;

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
//  DDRB := DDRB or (1 shl BP5);
//  ddra:=$FF;
//  ddrb:=$FF;
//  ddrc:=$FF;
  ddra:=$FF;
  repeat
//    PORTB := PORTB or (1 shl BP5);
//    porta:=$FF;
//    portb:=$FF;
//    portc:=$FF;
    porta:=%10101010;
    mysleep(sl);

//    PORTB := PORTB and not (1 shl BP5);
//    porta:=$00;
//    portb:=$00;
//    portc:=$00;
porta:=%01010101;
    mysleep(sl);
  until False;
end.
