#include "Arduino.h"

#define rot A0
#define gelb A1
#define gruen A2
#define relais A4
#define foto A5

#define timeSwitch 0B00011100
#define YellowTimeSwitch 0B00100000
#define YellowRedTimeSwitch 0B01000000

const char PAUSE_TIME[8] = { 10, 12, 15, 18, 22, 28, 38, 50 };

void SetAmpel(bool Agruen, bool Agelb, bool Arot) {
	digitalWrite(gruen, Agruen);
	digitalWrite(gelb, Agelb);
	digitalWrite(rot, Arot);
}

void SetRelais(bool on) {
	digitalWrite(relais, on);
}

int getTime() {
	int sw = (PIND & timeSwitch) >> 2;
	return PAUSE_TIME[sw];
}

int getYellowTime() {
	bool sw = (PIND & YellowTimeSwitch) == YellowTimeSwitch;
	Serial.println("yellow");
	Serial.println(sw);
	if (sw) {
		return 5;
	} else {
		return 3;
	}
}

int getYellowRedTime() {
	bool sw = (PIND & YellowRedTimeSwitch) == YellowRedTimeSwitch;
	Serial.println("yellowred");
	Serial.println(sw);
	if (sw) {
		return 5;
	} else {
		return 3;
	}
}

void setup() {
	pinMode(rot, OUTPUT);
	pinMode(gelb, OUTPUT);
	pinMode(gruen, OUTPUT);
	pinMode(relais, OUTPUT);
	pinMode(foto, INPUT);
	Serial.begin(9600);
	Serial.println("start");
}

void loop() {
	SetAmpel(true, false, false);  // Grün

	int z = 0;
	while (z < 3000) {             // Schranke zu ? -> weiter
		if (digitalRead(foto)) {
			z += 1;
		} else {
			z = 0;
		}
		delay(1);
	}

	SetAmpel(false, true, false);  // Orange
	delay(getYellowTime() * 1000L);
	SetRelais(true);               // Sauger ein

	SetAmpel(false, false, true);  // Rot

	int t = getTime();
	Serial.println("red");
	Serial.println(t * 1000L);

	delay(t * 1000L);

	SetAmpel(false, true, true);  // Orange/Rot
	SetRelais(false);             // Sauger Aus
	delay(getYellowRedTime() * 1000L);
}
