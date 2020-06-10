program Project1;
var
//  s: String[50] = 'Ich liebe Lazarus  !'; section '.eeprom';
//  s: String[50] = 'Ich liebe Lazarus !';
//  s: ShortString = 'Ich liebe Lazarus  !'; section '.test';
  s: ShortString = 'Ich liebe Lazarus  !';

begin
  repeat
    PORTB := byte(s[2]);
//    PORTB:=123;
  until False;
end.

