#include "Arduino.h"

class ShiftRegister
{
  public:
    ShiftRegister(byte data, byte clock, byte latch, byte count = 1);
    ~ShiftRegister() ;
    void setreg(byte r, byte regNr = 0);
    void pinHigh(byte pin, byte regNr = 0);
    void pinLow(byte pin, byte regNr = 0);
    void update();
  private:
    byte latchPin;
    byte clockPin;
    byte dataPin;

    byte shiftCount;
    byte *reg = 0;
};

ShiftRegister::ShiftRegister(byte data, byte clock, byte latch, byte count) {
  shiftCount = count;
  reg = new byte[shiftCount];
  for (int i = 0; i < shiftCount; i++) {
    reg[i] = 0b00000000;
  }
  dataPin = data;
  clockPin = clock;
  latchPin = latch;
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
}

ShiftRegister::~ShiftRegister() {
  delete[] reg;
  reg = 0;
}

void ShiftRegister::setreg(byte r, byte regNr) {
  reg[regNr] = r;
}

void ShiftRegister::pinHigh(byte pin, byte regNr) {
  reg[regNr] = reg[regNr] | (1 << pin);
}

void ShiftRegister::pinLow(byte pin, byte regNr) {
  reg[regNr] = reg[regNr] & ~ (1 << pin);
}

void ShiftRegister::update() {
  digitalWrite(latchPin, LOW);
  //  for (int i = 0; i < shiftCount; i++) {
  for (int i = shiftCount - 1; i >= 0; i--) {
    shiftOut(dataPin, clockPin, MSBFIRST, reg[i]);
  }
  digitalWrite(latchPin, HIGH);
}

// --- End ShiftRegister ---

byte latchPin = 9;
byte clockPin = 8;
byte dataPin = 10;

ShiftRegister shift(dataPin, clockPin, latchPin, 9);

void setup() {
  //  Serial.begin(9600);
  shift.setreg(0b10101010, 2);
  shift.setreg(0b11110000, 3);
  shift.setreg(0b00110011, 4);
  shift.setreg(0b11111111, 5);
}

byte wert1 = 0;
byte wert2 = 0;

byte z = 0;

void loop() {
  for (int i=0; i <= 8; i++) {
    shift.setreg(random(256),i);
  };
  z += 1;
  if (z >= 2) {
    z = 0;
  };

  //  shift.setreg(wert1, 0);
  //  shift.setreg(wert2, 1);
  //  shift.pinHigh(1, 1);
  //  shift.pinHigh(3, 1);
  //  shift.pinLow(3);
  //  shift.setreg(random(0x100), 6);
  //  shift.setreg(255, 7);
  //  shift.setreg(255, 8);
  //  wert1 += 1;
  shift.update();

  delay(100);
}
