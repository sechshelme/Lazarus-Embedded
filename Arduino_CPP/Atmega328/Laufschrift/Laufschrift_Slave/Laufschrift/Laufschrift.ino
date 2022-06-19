/*
 Blink  Turns on an LED on for one second, then off for one second, repeatedly.

 Most Arduinos have an on-board LED you can control. On the Uno and
 Leonardo, it is attached to digital pin 13. If you're unsure what
 pin the on-board LED is connected to on your Arduino model, check
 the documentation at http://www.arduino.cc

 This example code is in the public domain.

 modified 8 May 2014
 by Scott Fitzgerald
 */

#include <Arduino.h>
//#include <avr/iom328p.h>

#include <avr/io.h>

#include <TimerOne.h>
#include  <Wire.h>
//#include <avr/delay.h>

char max = 64;

bool I2C_aktiv = false;

unsigned char vram[64];

const unsigned char clockPin = 0;
const unsigned char latchPin = 1;
const unsigned char dataPin = 2;

void myDelay() {
	for (unsigned char i = 0; i <= 200; i++) {
		delay(1);
		if (I2C_aktiv) {
			return;
		}
	}
}

void TestBild() {
	for (unsigned char i = 0; i <= 3; i++) {
		if (I2C_aktiv) {
			return;
		}
		switch (i) {
		case 0:
			for (signed char i = 0; i <= max - 1; i++) {
				vram[i] = 0B10101010;
			}
			break;
		case 1:
			for (signed char i = 0; i <= max - 1; i++) {
				vram[i] = 0B01010101;
			}
			break;
		case 2:
			for (signed char i = 0; i <= (max - 1) / 2; i++) {
				vram[i * 2 + 0] = 0B00000000;
				vram[i * 2 + 1] = 0B11111111;
			}
			break;
		case 3:
			for (signed char i = 0; i <= 31; i++) {
				vram[i * 2 + 0] = 0B11111111;
				vram[i * 2 + 1] = 0B00000000;
			}
			break;
		}
		myDelay();
	}
}

unsigned char p;

void multiplex()
{
	p = (p << 1) | (p >> 7);

	PORTB &= ~(1 << latchPin);
	for (signed char i = 63; i >= 0; i--) {

		bool b;

		b = (p & vram[i]);

		if (b > 0) {
			PORTB &= ~(1 << dataPin);
		} else {
			PORTB |= (1 << dataPin);
		}

		PORTB |= (1 << clockPin);
		PORTB &= ~(1 << clockPin);
	}
	PORTD = 0b00000000;
	PORTB |= (1 << latchPin);
	PORTD = p;
}

void receiveEvent(int data) {
	char ch;
	I2C_aktiv = true;

	int bSize = Wire.available();
	bSize -= 1;

	char b = Wire.read();
	if (b > 3)
		return;

	for (signed char i = 0; i <= bSize - 1; i++) {
		ch = Wire.read();
		vram[i + b * 16] = ch;
	}
}

// ========== Setup ============

void setup() {
	p = 0B00000001;

	for (char i = 63; i >= 0; i--) {
		vram[i] = 0b11111111;
	}

	DDRD = 255;
	DDRB = 255;

//	Timer1.initialize(3000);
	Timer1.initialize(90);
//	Timer1.initialize(900);
	Timer1.attachInterrupt(multiplex);

	delay(2000);

	Wire.begin(0x04);
	Wire.onReceive(receiveEvent);
//	Wire.onRequest(requestEvent);

}

void loop() {
	TestBild();

	delay(100);
}
