#include <TimerOne.h>

#define firstLEDPin 2
#define maxSegment 3

const byte digits[] = {
  0B00111111, // = 0
  0B00000110, // = 1
  0B01011011, // = 2
  0B01001111, // = 3
  0B01100110, // = 4
  0B01101101, // = 5
  0B01111101, // = 6
  0B00000111, // = 7
  0B01111111, // = 8
  0B01100111, // = 9

/*  0B01110111, // = a
  0B01111100, // = b
  0B00111001, // = c
  0B01011110, // = d
  0B01111001, // = e
  0B01110001  // = f */
};

byte seg[maxSegment] = { 12, 11, 10 };
byte zahl[3];

byte c = 0;
void multiplex()
{
  for (byte i = 0; i < maxSegment; i++) {
    digitalWrite(seg[i], LOW);
  }
  for (byte i = 0; i < 8; ++i) {
    digitalWrite(i + firstLEDPin, digits[zahl[c]] & (B00000001 << i));
  }
  digitalWrite(seg[c], HIGH);

  c += 1;
  if (c == maxSegment) {
    c = 0;
  };
}

void setup() {
  Timer1.initialize(2000);
  Timer1.attachInterrupt(multiplex);
  Serial.begin(9600);

  for (byte i = 0; i < 8; i++) {
    pinMode(i + firstLEDPin, OUTPUT);
  };
  for (byte i = 0; i < maxSegment; i++) {
    pinMode(seg[i], OUTPUT);
  }
}

void loop() {
  int i = analogRead(A0);
  delay(100);
  //    i=347;
  zahl[0] = i % 10;
  zahl[1] = i % 100 / 10;
  zahl[2] = i / 100;

  Serial.println(i);

  //  while (Serial.available() > 0) {
  //    zahl[2] = Serial.parseInt();
  //  }
}
