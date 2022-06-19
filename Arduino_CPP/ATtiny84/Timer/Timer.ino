//#include <TimerOne.h>


#include <avr/io.h>
#include <string.h>
#include <util/delay.h>
#include <avr/interrupt.h>

byte clockPin = 0;
byte latchPin = 1;
byte dataPin = 2;
byte lightPin = 3;


void InitTimer()
{
 DDRA  = 0xDF;
 PORTA = 0x20;
 DDRB  = 0xFF;
 PORTB = 0xFF;

 noInterrupts();         
 TCCR1A = 0;
 TCCR1B = 0;
 TCNT1  = 0;
 OCR1A = 31250 / 4;            
 TCCR1B |= (1 << WGM12);   
 TCCR1B |= (1 << CS12);   
 TIMSK1 |= (1 << OCIE1A);  
 interrupts();
}

ISR(TIM1_COMPA_vect) // timer interrupt 
{
 digitalWrite(7, !digitalRead(7));
}



void setup() {
InitTimer();
  
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  pinMode(lightPin, OUTPUT);
  
  pinMode(7, OUTPUT);
digitalWrite(7, HIGH);
digitalWrite(lightPin, LOW);

}

byte wert = 0b01111;

void loop() {
  digitalWrite(latchPin, LOW);
  shiftOut(dataPin, clockPin, MSBFIRST, wert);
      wert = (wert << 1) | (wert >> 7);  // rot l
  //  wert = (wert >> 1) | (wert << 7);   // rot r

  digitalWrite(latchPin, HIGH);

  delay(50);
}
