program Project1;
var
  es: ShortString = 'Ich liebe Lazarus !!'; section '.eeprom';
//  es: ShortString = 'Ich liebe Lazarus !!';

begin
  repeat
    PORTB := byte(es[2]);
  until False;
end.

