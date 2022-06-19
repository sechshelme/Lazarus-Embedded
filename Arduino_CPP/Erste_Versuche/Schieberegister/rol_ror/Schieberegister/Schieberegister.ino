byte latchPin = 3;
byte clockPin = 2;
byte dataPin = 4;



void setup() {
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
//  Serial.begin(9600);
}

byte wert1 = 0b01010101;
byte wert2 = 0b01010101;

void loop() {
  asm("lds r24, (wert1) \n\t"
      "mov r0, r24 \n\t"
      "lsl r0 \n\t"
      "rol r24 \n\t"
      "sts (wert1), r24 \n\t"
      );
  digitalWrite(latchPin, LOW);
  shiftOut(dataPin, clockPin, MSBFIRST, wert1);
//  shiftOut(dataPin, clockPin, MSBFIRST, wert2);
  //    wert = (wert << 1) | (wert >> 7);  // rot l
  //  wert = (wert >> 1) | (wert << 7);   // rot r

  digitalWrite(latchPin, HIGH);
//  Serial.println(wert1);

  delay(500);
}
