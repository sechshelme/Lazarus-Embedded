#include "Arduino.h"
#include <TimerOne.h>
#include <Wire.h>

unsigned char Ledgreen = 8;
unsigned char Ledred = 9;
unsigned char fotoPin = 5;

int ledState = false;
long z = 0;

bool fotoState;

int Hi_To_Low, Low_To_Hi;


void blinkLED(void) {
  z++;
  if (z > 50000) {
    z = 0;
  }
  if (z > 25000) {
    PORTB = PORTB | 0B00100000;
  } else {
    PORTB = PORTB & 0B11011111;
  }

  if  (PINC & 0B01000000) {
    if (!fotoState) {
      fotoState = true;
      Low_To_Hi += 1;
    }
  } else {
    if (fotoState) {
      fotoState = false;
      Hi_To_Low += 1;
    }
  }
}

void setup(void) {
  pinMode(Ledgreen, OUTPUT);
  pinMode(Ledred, OUTPUT);
  pinMode(fotoPin, INPUT);

  Serial.begin(9600);
  Wire.begin();
  Wire.setClock(400000);

  Timer1.initialize(20);
  Timer1.attachInterrupt(blinkLED);
}

void loop()

{
  bool b;
  int val;

  b = PINC & 0B01000000;

  //  Serial.println(fotoState);
  Serial.println((Low_To_Hi + Hi_To_Low) * 60 / 12);
  //Serial.println(Hi_To_Low);

  Low_To_Hi = 0; 
  Hi_To_Low = 0;
  delay(1000);

}

