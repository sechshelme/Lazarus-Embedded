//#include "Arduino.h"
#include <avr/io.h>

#define TAKT 16000000UL

void Init_UART(unsigned long baud){
	unsigned int teiler;
	teiler = TAKT / (2UL * baud) - 1;

	UBRR0L = teiler;
	UBRR0H = (teiler >> 8);

	UCSR0C |= (1 << UMSEL00) | (1 << UCSZ01) | (1 << UCSZ00);
	UCSR0B |= (1 << TXEN0);
	DDRD |= (1 << PD4);

	UCSR0B |= (1 << RXEN0);                        // UART RX einschalten
}

void setup() {
	Init_UART(115200);
	//Serial.begin(9600);
}

char hello[] = "Hello World !  \n\0";

unsigned char getch(void) {
	while (!(UCSR0A & (1 << RXC0))){}
	return UDR0;
}

void uart_putc(unsigned char c) {
	while (!(UCSR0A & (1 << UDRE0))){}
	UDR0 = c; /* sende Zeichen */
}

/* puts ist unabhaengig vom Controllertyp */
void uart_puts(char *s) {
	while (*s) { /* so lange *s != '\0' also ungleich dem "String-Endezeichen(Terminator)" */
		uart_putc(*s);
		s++;
	}
}

// The loop function is called in an endless loop
unsigned char i = 65;

void loop() {
	unsigned char c;
	c = getch();

	if (c == 'c') {
		uart_puts(hello);
	}
}
