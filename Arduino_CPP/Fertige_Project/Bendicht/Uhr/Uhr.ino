#include "Arduino.h"
#include "TimerOne.h"

// Alle Schalter und Taster sind offen = HIGH

const unsigned char tasteMin = A0;
const unsigned char tasteSec = A1;
const unsigned char tasteStart = A2;

const unsigned char dataPin = 2;
const unsigned char clockPin = 3;
const unsigned char latchPin = 4;
const unsigned char RelaisPin = 5;

const unsigned char DIP_Switch_1 = 8;
const unsigned char DIP_Switch_2 = 9;
const unsigned char DIP_Switch_3 = 10;
const unsigned char DIP_Switch_4 = 11;
const unsigned char DIP_Switch_5 = 12;
const unsigned char DIP_Switch_6 = 13;
const unsigned char Jumper = A5;

const unsigned char prellDelay = 100;
long StartTime;
long PauseTime;
long showTime;
bool run;
bool RelaisEnabled;
bool autoRun;

const unsigned char digits[] = { 0B00111111,  // = 0
		0B00000110,  // = 1
		0B01011011,  // = 2
		0B01001111,  // = 3
		0B01100110,  // = 4
		0B01101101,  // = 5
		0B01111101,  // = 6
		0B00000111,  // = 7
		0B01111111,  // = 8
		0B01100111,  // = 9
		};

void readJumper() {
	if (digitalRead(Jumper)) {
		autoRun = false;
		StartTime = 1000l * 60 * 3;
	} else {
		autoRun = true;

		char PA[] = { 2, 3, 4, 6 };
		char ST[] = { 1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 30 };
		StartTime = 1000l * 60l * ST[((PINB & 0B00111100) >> 2)];
		PauseTime = 1000l * PA[PINB & 0B00000011];
	}
}

inline void out74HC595(unsigned char data) {
	shiftOut(dataPin, clockPin, MSBFIRST, data);
}

inline boolean getButton(char button) {
	return !digitalRead(button);
}

inline void switchRelais(bool value) {
	digitalWrite(RelaisPin, value);
}

void WriteTime(long time)

{
	char c[4];
	long t = time / 1000;
	unsigned char min = (t / 60) % 60;
	unsigned char sec = t % 60;

	c[0] = (min / 10) % 10;
	c[1] = min % 10;
	c[2] = (sec / 10) % 10;
	c[3] = sec % 10;

	digitalWrite(latchPin, LOW);
	for (char i = 0; i < 4; i++) {

		unsigned char d = digits[c[i]];
		if (run) {
			if ((i == 2) && ((time / 500) % 2 == 1)) {
				d |= 0B10000000;
			}
		} else {
			d |= 0B10000000;
		}
		if (RelaisEnabled) {
			if ((millis() / 500) % 2 == 0) {
				d = 0;
			}
		}

		out74HC595(d);
	}
	digitalWrite(latchPin, HIGH);
}

void callTimer() {
	if (run) {
		showTime -= 100;
//		showTime -= 3900;  // Für Test
		if (showTime <= 1000) {
			run = false;
			RelaisEnabled = true;
			switchRelais(RelaisEnabled);
			showTime = 0;
		}
	}
	WriteTime(showTime);
}

void setup() {
	pinMode(tasteMin, INPUT);
	pinMode(tasteSec, INPUT);
	pinMode(tasteStart, INPUT);

	pinMode(Jumper, INPUT_PULLUP);

	pinMode(latchPin, OUTPUT);
	pinMode(clockPin, OUTPUT);
	pinMode(dataPin, OUTPUT);
	pinMode(RelaisPin, OUTPUT);

	DDRB = 0B00000000;
	PORTB = 0B11111111;

	Serial.begin(9600);

	readJumper();

	showTime = StartTime;
	run = false;
	RelaisEnabled = false;

	Timer1.initialize(100000);
	Timer1.attachInterrupt(callTimer);
}

void loop() {
	readJumper();
	if (autoRun) {
		showTime = StartTime;
		run = true;
		while (run) {
//		delay(200);
			Serial.println(); // geht nicht ohne
		}
		delay(PauseTime);
		RelaisEnabled = false;
		switchRelais(RelaisEnabled);
		run = true;

	} else {

		if (showTime > 1000l * 60 * 60) { // Anzeige > 1h
			showTime -= 1000l * 60 * 60;
		}
		if (RelaisEnabled) {
			if (getButton(tasteStart)) {
				run = false;
				RelaisEnabled = false;
				switchRelais(RelaisEnabled);
				delay(prellDelay);
				while (getButton(tasteStart)) {
				}
				delay(prellDelay);
				showTime = StartTime;
			}
		} else {
			if (run) {
				if (getButton(tasteStart)) {
					run = false;
					delay(prellDelay);
					while (getButton(tasteStart)) {
					}
					delay(prellDelay);
				}

			} else {
				if (getButton(tasteStart)) {
					if (showTime <= 0) {
						showTime = StartTime;
					}
					run = true;
					delay(prellDelay);
					while (getButton(tasteStart)) {
					}
					delay(prellDelay);
				}

				if (getButton(tasteSec)) {
					showTime += 1000l;  // + 1s
					StartTime = showTime;
					delay(prellDelay);
					int z = 0;
					while (getButton(tasteSec)) {
						if (z < 20) {
							z += 1;
						} else {
							showTime += 1000l;  // + 1s
						}

						if (getButton(tasteMin)) {
							showTime = 0;
							StartTime = showTime;
							delay(prellDelay);
							while (getButton(tasteMin)) {
							}
						}
						delay(prellDelay);
					}
				}

				if (getButton(tasteMin)) {
					showTime += 1000l * 60l;  // + 1min
					StartTime = showTime;
					delay(prellDelay);
					int z = 0;
					while (getButton(tasteMin)) {
						if (z < 20) {
							z += 1;
						} else {
							showTime += 1000l * 60l;  // + 1s
						}

						if (getButton(tasteSec)) {
							showTime = 0;
							StartTime = showTime;
							delay(prellDelay);
							while (getButton(tasteSec)) {
							}
						}
						delay(prellDelay);
					}
				}
			}
		}
	}
}
