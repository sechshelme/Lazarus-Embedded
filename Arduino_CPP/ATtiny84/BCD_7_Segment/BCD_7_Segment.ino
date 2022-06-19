#include <Arduino.h>

#define ledPin 7

#define dataOutPin 0
#define dataInPin 1
#define latchPin 2
#define clockPin 3

const unsigned char digits[] = { 
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

		0B01110111, // = a
		0B01111100, // = b
		0B00111001, // = c
		0B01011110, // = d
		0B01111001, // = e
		0B01110001  // = f
		};

void InitTimer() {

	noInterrupts();
	TCCR1A = 0;
	TCNT1 = 0;
	TCCR1B = (1 << WGM12) | (1 << CS12);
	TIMSK1 |= (1 << OCIE1A);
	interrupts();
}

void dw(unsigned char port, bool on) {
	if (on) {
		PORTA |= (1 << port);
	} else {
		PORTA &= ~(1 << port);
	}
}

bool drB(unsigned char bit) {
	return ((PINA & (0B00000001 << bit)) > 0);
}

unsigned char ShiftIn74HC165(char daPin, char clPin) {
	unsigned char data = 0;
	for (signed char i = 0; i < 8; i++) {

		data = (data << 1) | drB(daPin);

		dw(clPin, true);
		dw(clPin, false);
	}
	return data;
}

void inline shiftOut595(unsigned char val) {

	for (char i = 7; i >= 0; i--) {

		if (!!(val & (1 << i))) {
			dw(dataOutPin, true);
		} else {
			dw(dataOutPin, false);
		}
		dw(clockPin, true);
		dw(clockPin, false);
	}
}

unsigned char zahl[4];

ISR(TIM1_COMPA_vect) // timer interrupt
{
	static int b;
	static char p;
	b = b + 1;
	dw(ledPin, (b > 50));

	if (b > 100)
		b = 0;
	p = p + 1;
	if (p > 3)
		p = 0;

	unsigned int d;

	dw(latchPin, false);
	delayMicroseconds(20);
	dw(latchPin, true);
	delayMicroseconds(20);

	d = ShiftIn74HC165(dataInPin, clockPin);
//	d*=10;

	zahl[0] = 0;
	zahl[1] = d / 100;
	zahl[2] = d % 100 / 10;
	zahl[3] = d % 10;

	shiftOut595(digits[zahl[p]]);
	shiftOut595(1 << p);

}

void setup() {
	InitTimer();
	DDRA = 0;
	DDRA = DDRA | (1 << ledPin) | (1 << dataOutPin) | (1 << latchPin)
			| (1 << clockPin);
}

void loop() {
	unsigned int d;

	delay(d);
	delay(d);
}
