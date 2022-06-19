#include "Arduino.h"

#define pinA0 PIO_PA16
#define pinA1 PIO_PA24
#define pinA2 PIO_PA23
//#define pin0 0 << 24
//#define pin1 0xFFFFFFFF;
//#define pin0 0x00000000;

void setup() {
//		PIOA->PIO_PER = pinA0 | pinA1 | pinA2;
//		PIOA->PIO_OER = pinA0 | pinA1 | pinA2;

//	REG_PIOA_PER= pinA0 | pinA1 | pinA2;
//	REG_PIOA_OER= pinA0 | pinA1 | pinA2;
//
//	REG_PIOA_ODR=pinA1;

//	PIOA->PIO_PER = pinA0;
	//PIOA->PIO_OER = pinA0;

//	PIOA->PIO_PER = pinA1;
	//PIOA->PIO_OER = pinA1;

//	PIOA->PIO_PER = pinA2;
//	PIOA->PIO_OER = pinA2;

//	PIO_Configure(PIOA, PIO_OUTPUT_1, PIO_PA24, PIO_DEFAULT);
//	PIO_Configure(PIOA, PIO_OUTPUT_1, PIO_PA23, PIO_DEFAULT);

//PIOA->PIO_CODR = PIO_PA23;  // aus
//	PIOA->PIO_SODR = PIO_PA23;  // ein

//	REG_PIOA_ODSR = pinA2;

}

void loop() {
//	PIOA->PIO_CODR = PIO_PA24;
//	REG_PIOA_ODSR |= pinA0;
//	REG_PIOA_ODSR &= ~pinA1;
	delay(200);
//	REG_PIOA_ODSR |= pinA1;
//	REG_PIOA_ODSR &= ~pinA0;
//	PIOA->PIO_SODR = PIO_PA24;
	delay(200);
}
