#include <Arduino.h>
#include <avr/io.h>
#include <avr/interrupt.h>

#define blank 16
#define minus 17

// PortB
#define dataInPin PINB0
#define carryPin PINB1
#define negPin PINB2
#define hexPin PINB3

// PortD
#define dataOutPin PIND0
#define latchPin PIND1
#define clockPin PIND2

// Achtung, 7-Segment Bausteine sind 180Grad verdreht verbaut !
const unsigned char digits[] = { 
        0B00111111, // = 0
		0B00110000, // = 1
		0B10011011, // = 2
		0B10111001, // = 3
		0B10110100, // = 4
		0B10101101, // = 5
		0B10101111, // = 6
		0B00111000, // = 7
		0B10111111, // = 8
		0B10111101, // = 9

		0B10110111, // = a
		0B10111100, // = b
		0B10111001, // = c
		0B10011110, // = d
		0B10111001, // = e
		0B10110001, // = f
		0B00000000, // = blank
		0B10000000  // = -
		};

void dw(unsigned char port, bool on) {
	if (on) {
		PORTD |= (1 << port);
	} else {
		PORTD &= ~(1 << port);
	}
}

bool drB(unsigned char bit) {
	return ((PINB & (0B00000001 << bit)) > 0);
}

unsigned char ShiftIn74HC165(char daPin, char clPin) {
	unsigned char data = 0;
	delayMicroseconds(20);
	for (signed char i = 0; i < 8; i++) {

		data = (data << 1) | drB(daPin);

		dw(clPin, true);
		delayMicroseconds(20);
		dw(clPin, false);
		delayMicroseconds(20);
	}
	return data;
}

void inline shiftOut595(unsigned char val) {

	for (char i = 7; i >= 0; i--) {

		if (val & (1 << i)) {
			dw(dataOutPin, true);
		} else {
			dw(dataOutPin, false);
		}
		dw(clockPin, true);
		dw(clockPin, false);
	}
}

unsigned char zahl[4];

ISR(TIMER0_COMPA_vect) {

	static unsigned char p;
	p = p + 1;
	if (p > 3) {
		p = 0;
	}

	signed int d;

	dw(latchPin, false);
	dw(latchPin, true);

	d = ShiftIn74HC165(dataInPin, clockPin);
	if (drB(negPin)) {
		if (!drB(carryPin)) {
			d -= 256;
			d = abs(d);
			zahl[0] = minus;
		} else {
			zahl[0] = blank;
		}
	} else {
		zahl[0] = blank;
		if (drB(carryPin)) {
			d += 256;
		}
	}

	zahl[1] = d / 100;
	zahl[2] = d % 100 / 10;
	zahl[3] = d % 10;

	shiftOut595(digits[zahl[p]]);
	shiftOut595(1 << p);
}

void setup() {

	DDRB = 0;
	DDRD = (1 << dataOutPin) | (1 << latchPin) | (1 << clockPin);

	zahl[0] = blank;

	// -- Timer initialisieren
	TCCR0A = (1 << WGM01);
	TCCR0B |= (1 << CS01);
	OCR0A = 90; // Speed
	TIMSK |= (1 << OCIE0A);
	sei();
	// --- Ende timer

}

void loop() {
	//delay(100);
}

