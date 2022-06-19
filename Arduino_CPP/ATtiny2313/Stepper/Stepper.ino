//#include "Arduino.h"

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

void Step(unsigned char Nr) {

	switch (Nr) {
	case 0:  // 1010
		PORTD |= (1 << PB2) | (1 << PB4);
		PORTD &= ~(1 << PB3) & ~(1 << PB5);
		break;
	case 1:  // 0110
		PORTD |= (1 << PB3) | (1 << PB4);
		PORTD &= ~(1 << PB2) & ~(1 << PB5);
		break;
	case 2:  //0101
		PORTD |= (1 << PB3) | (1 << PB5);
		PORTD &= ~(1 << PB2) & ~(1 << PB4);
		break;
	case 3:  //1001
		PORTD |= (1 << PB2) | (1 << PB5);
		PORTD &= ~(1 << PB3) & ~(1 << PB4);
		break;
	}
}

signed int speed = 200;
signed char p = 0;
bool stop = false;

ISR(PCINT_vect) {

	// schneller
	if (!(PINB & (1 << PB0))) {
		stop = false;
		if (speed > 0) {
			speed++;
			if (speed > 32000) {
				speed = 32000;
			}
		} else {
			speed--;
			if (speed < -32000) {
				speed = -32000;
			}
		}
	}

	// langsamer
	if (!(PINB & (1 << PB1))) {
		stop = false;
		if (speed > 0) {
			speed--;
			if (speed < 1) {
				speed = 1;
			}
		} else {
			speed++;
			if (speed > -1) {
				speed = -1;
			}
		}
	}

	// links
	if (!(PINB & (1 << PB2))) {
		stop = false;
		speed = -abs(speed);
	}

	// stop
	if (!(PINB & (1 << PB3))) {
		stop = true;
	}

	// rechts
	if (!(PINB & (1 << PB4))) {
		stop = false;
		speed = abs(speed);
	}
}

void setup() {

	PCMSK |= (1 << PCINT0) | (1 << PCINT1) | (1 << PCINT2) | (1 << PCINT3)
			| (1 << PCINT4);
	GIMSK |= (1 << PCIE);

	// Stepper Ausgang
	DDRD |= (1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2);
	// Pull-Up
	PORTB |= (1 << PB4) | (1 << PB3) | (1 << PB2) | (1 << PB1) | (1 << PB0);
}

void loop() {
	if (!stop) {

		if (speed > 0) {
			p++;
			if (p > 3) {
				p = 0;
			}
		} else {
			p--;
			if (p < 0) {
				p = 3;
			}
		}
		Step(p);
	}

	delayMicroseconds(abs(speed * 100));
}
