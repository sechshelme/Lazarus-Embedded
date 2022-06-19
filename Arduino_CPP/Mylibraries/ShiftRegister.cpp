/*
 * ShiftRegister.cpp
 *
 *  Created on: 27.04.2016
 *      Author: tux
 */

#include "ShiftRegister.h"

#include "Arduino.h"

ShiftRegister::ShiftRegister() {
	shiftCount = 0;
	dataPin = 0;
	clockPin = 0;
	latchPin = 0;
	ShiftRegister(0, 0, 0, 0);
}

ShiftRegister::ShiftRegister(char data, char clock, char latch, char count) {
	shiftCount = count;
	reg = new bool[shiftCount];
	for (int i = 0; i < shiftCount; i++) {
		reg[i] = false;
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

void ShiftRegister::setPin(char pos, bool st) {
	reg[pos] = st;
}

void ShiftRegister::setPin(char pos, char len, bool st) {
	for (int i = pos; i < pos + len; i++) {
		reg[i] = st;
	}
}

void ShiftRegister::clear() {
	for (int i = 0; i < shiftCount; i++) {
		reg[i] = false;
	}
}

void dw(char Pin, bool val) {
	if (val) {
		PORTD |= (1 << Pin);
	} else {
		PORTD &= ~(1 << Pin);
	}
}


void ShiftRegister::update() {
	PORTD &= ~(1 << latchPin);
	for (int i = shiftCount - 1; i >= 0; i--) {


		if (reg[i]) {
			PORTD |= (1 << dataPin);
		} else {
			PORTD &= ~(1 << dataPin);
		}

		PORTD |= (1 << clockPin);
		PORTD &= ~(1 << clockPin);
	}
	PORTD |= (1 << latchPin);

//	digitalWrite(latchPin, LOW);
//	for (int i = shiftCount - 1; i >= 0; i--) {
//
//		digitalWrite(dataPin, reg[i]);
//
//		digitalWrite(clockPin, HIGH);
//		digitalWrite(clockPin, LOW);
//	}
//	digitalWrite(latchPin, HIGH);
}
