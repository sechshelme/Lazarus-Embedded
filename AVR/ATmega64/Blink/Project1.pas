// Blink Pin 13

program Project1;

{$H-,J-,O-}

const
  sl = 2001;

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do
    begin
      asm
               NOP;
      end;
    end;
  end;

var
  Pin: bitpacked array  [0..7] of boolean absolute PORTA;

begin
  //  DDRB := DDRB or (1 shl BP5);
  //  ddra:=$FF;
  //  ddrb:=$FF;
  //  ddrc:=$FF;
  DDRA := $11;
  repeat
    //    PORTB := PORTB or (1 shl BP5);
    //    porta:=$FF;
    //    portb:=$FF;
    //    portc:=$FF;
//        PORTA := %11;
    Pin[0] := True;
    Pin[1] := False;
    mysleep(sl);

    //    PORTB := PORTB and not (1 shl BP5);
    //    porta:=$00;
    //    portb:=$00;
    //    portc:=$00;
    Pin[0] := False;
    Pin[1] := True;
//      PORTA := %01010101;
    mysleep(sl);
  until False;
end.
