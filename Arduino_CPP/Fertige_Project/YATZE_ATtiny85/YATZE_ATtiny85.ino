#include <Arduino.h>

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

#define clockPin 0
#define latchPin 1
#define dataOutPin 4
#define dataInPin 3

void dw(unsigned char port, bool on) {
	if (on) {
		PORTB |= (1 << port);
	} else {
		PORTB &= ~(1 << port);
	}
}

bool dr(unsigned char bit) {
	return ((PINB & (0B00000001 << bit)) > 0);
}

char ShiftIn74HC165() {
	char data = 0;
	for (char i = 0; i < 8; i++) {
		data = (data << 1) | dr(dataInPin);
		dw(clockPin, true);
//		delayMicroseconds(20);
		dw(clockPin, false);
	}
	return data;
}

void shiftOut595(unsigned char val) {
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

//=====================================

const unsigned char maxDigit = 6;
const unsigned char maxSegment = 16;
const unsigned char digits[8] = { 0B00000000,  // = 0
		0B00001000,  // = 1
		0B01000001,  // = 2
		0B00011100,  // = 3
		0B01010101,  // = 4
		0B01011101,  // = 5
		0B01110111,  // = 6
		0B01111111,  // = 7
		};

signed char anzWurf = 3;

unsigned char zahl[16];
unsigned char tasten;
unsigned char akttasten;

bool fixiert[5];

struct wurfel {
	char wert;
	char col;
} wurfelArr[5];

void mwrite(char ziffer, char wert, char col) {
	char ofs = ziffer * 3;

	for (char i = 0; i < 3; i++) {
		if ((1 << i) & col) {
			zahl[ofs + i] = wert;
		} else {
			zahl[ofs + i] = 0;
		}
	}
}

void msetZiffer(char nr, char w) {
	wurfelArr[nr % 5].wert = w;
	mwrite(nr, w, wurfelArr[nr % 5].col);
}

void msetColor(char nr, char col) {
	wurfelArr[nr % 5].col = col;
	mwrite(nr, wurfelArr[nr % 5].wert, col);
}

bool mgetTaste(unsigned char nr) {
	if ((tasten & (0B00000001 << nr)) && (!(akttasten & (0B00000001 << nr)))) {
		akttasten = akttasten | (0B00000001 << nr);
		return true;
	} else {
		return false;
	}
}

ISR(TIM1_COMPA_vect){ // timer interrupt
	TCNT1 = 0;

	unsigned char d;
	static signed char multi_z = 0;

	d = digits[zahl[multi_z]];
	if (multi_z < anzWurf) {
		d = d | 0B10000000;
	}

	dw(latchPin, false);
	shiftOut595(~d);

	if (multi_z >= 8) {
		shiftOut595(1 << (multi_z - 8));
		shiftOut595(0);
	} else {
		shiftOut595(0);
		shiftOut595(1 << multi_z);
	}
	dw(latchPin, true);

	multi_z ++;
	if (multi_z >= maxSegment) {
		multi_z = 0;
	};

	tasten = (~ShiftIn74HC165()) & 0B01111111;

	for (char nr = 0; nr < 8; nr++) {
		if ((!(tasten & (0B00000001 << nr)))
				&& (akttasten & (0B00000001 << nr))) {
			akttasten = akttasten & (0B11111110 << nr);
		}
	}

}

//====================

void InitTimer() {
	//DDRA  = 0xDF;
	//PORTA = 0x20;
	//DDRB  = 0xFF;
	//PORTB = 0xFF;

//	noInterrupts();
//	TCCR1A = 0;
//	TCCR1B = 0;
//	TCNT1 = 0;
//	OCR1A = 31250 / 650;
//	TCCR1B |= (1 << WGM12);
//	TCCR1B |= (1 << CS12);
//	TIMSK1 |= (1 << OCIE1A);
//	interrupts();

	noInterrupts();
//	TCCR0A = 0;
//	TCCR0B = 0;
//	TCNT1 = 0;
//	OCR0A = 31250 / 650;
//	TCCR0B |= (1 << WGM01);
//	TCCR0B |= (1 << CS12);
//	TIMSK |= (1 << OCIE1A);

	TCCR1 |= (1 << CTC1);  // clear timer on compare match
	TCCR1 |= (1 << CS12); //clock prescaler 8192
	//	  TCCR1 |= (1 << CS13) | (1 << CS12) | (1 << CS11); //clock prescaler 8192
	OCR1C = 50; // compare match value
	TIMSK |= (1 << OCIE1A); // enable compare match interrupt
	interrupts();
}


//signed char anzWurf;

void setup() {
	InitTimer();
	randomSeed(52);

	DDRB |= (1 << latchPin) | (1 << clockPin) | (1 << dataOutPin);

	for (unsigned char i = 0; i <= 4; i++) {
		msetColor(i, random(6) + 1);
	}
}

void loop() {
	// Rückstellen, start

	if (mgetTaste(6)) {
		anzWurf = 3;
		for (unsigned char i = 0; i <= 4; i++) {
			fixiert[i] = false;
			msetZiffer(i, 0);
			msetColor(i, random(6) + 1);
		}
	}

	// Würfeln

	if (mgetTaste(5)) {
		if (anzWurf > 0) {
			anzWurf --;
			if (anzWurf < 0) {
				anzWurf = 3;
			};
			for (char j = 0; j < 20; j++) {
				delay(8 * j);
				for (unsigned char i = 0; i <= 4; i++) {
					if (!fixiert[i]) {
						msetZiffer(i, random(6) + 1);
						msetColor(i, random(6) + 1);
					}
				}
			}
		}
	}

	for (unsigned char i = 0; i <= 4; i++) {
		if ((mgetTaste(i)) && (anzWurf < 3)) {
			fixiert[i] = !fixiert[i];
			if (fixiert[i]) {
				msetColor(i, 7);
			} else {
				msetColor(i, random(6) + 1);
			}
		}
	}

}
