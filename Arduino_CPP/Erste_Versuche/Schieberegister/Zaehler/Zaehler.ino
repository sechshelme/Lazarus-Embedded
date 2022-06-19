
byte latchPin = 9;
byte clockPin = 8;
byte dataPin = 10;

void setup() {
  pinMode( latchPin, OUTPUT);
  pinMode( clockPin, OUTPUT);
  pinMode( dataPin, OUTPUT);
}

unsigned long wert = 0;

void loop() {

digitalWrite(latchPin, LOW);

wert=0xF0FFFFFF;

shiftOut(dataPin, clockPin, MSBFIRST, wert >> 24);
shiftOut(dataPin, clockPin, MSBFIRST, wert >> 16);
shiftOut(dataPin, clockPin, MSBFIRST, wert >> 8);
shiftOut(dataPin, clockPin, MSBFIRST, wert );


//shiftOut(dataPin, clockPin, MSBFIRST, 2 );


digitalWrite(latchPin, HIGH);


  wert += 6500;

//  delay(30);
}
