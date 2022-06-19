#ifdef __IN_ECLIPSE__
//This is a automatic generated file
//Please do not modify this file
//If you touch this file your change will be overwritten during the next build
//This file has been generated on 2017-09-16 17:27:06

#include "Arduino.h"
#include <Arduino.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
void dw(unsigned char port, bool on) ;
bool dr(unsigned char bit) ;
char ShiftIn74HC165() ;
void shiftOut595(unsigned char val) ;
void mwrite(char ziffer, char wert, char col) ;
void msetZiffer(char nr, char w) ;
void msetColor(char nr, char col) ;
bool mgetTaste(unsigned char nr) ;
ISR(TIM1_COMPA_vect);
void InitTimer() ;
void setup() ;
void loop() ;


#include "YATZE_ATtiny85.ino"

#endif
