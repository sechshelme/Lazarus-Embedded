#include "Arduino.h"
//#include <avr/io.h>
//#include <avr/interrupt.h>

#define ledPin 1

void dw(unsigned char port, bool on) {
	if (on) {
		PORTD |= (1 << port);
	} else {
		PORTD &= ~(1 << port);
	}
}

ISR (TIMER0_COMPA_vect) {
	int t = 50;
	static int b;
	b = b + 1;
	dw(ledPin, (b > t));

	if (b > t * 2)
		b = 0;
}

void setup() {
	DDRD = DDRD | (1 << ledPin);

	TCCR0A = (1 << WGM01); // CTC Modus
	TCCR0B |= (1 << CS01); // Prescaler 8
	OCR0A = 5;

	TIMSK |= (1 << OCIE0A);

	sei();
}

// The loop function is called in an endless loop
void loop() {
}
