#include <Arduino.h>
#include <avr/io.h>
#include <avr/interrupt.h>

ISR(TIMER2_OVF_vect) {
  static int z = 0;
  z += 1;
  if (z == 500) {
    digitalWrite(13, HIGH);  // turn the LED on (HIGH is the voltage level)
  }
  if (z >= 1000) {
    digitalWrite(13, LOW);   // turn the LED on (HIGH is the voltage level)
    z = 0;
  }
}

void setup() {
	pinMode(13, OUTPUT);  // Pin 13 Output

	TCCR2A = 0;           // set timer2 normal mode
	TCCR2B |= (1 << CS20);  // timer2 clock = system clock
	TIMSK2 |= (1 << TOIE2); // enable timer2 overflow interrupt

	sei();          	  // enable interrupts
}

void loop() {
	//delay(1000);          // wait for a second
}


