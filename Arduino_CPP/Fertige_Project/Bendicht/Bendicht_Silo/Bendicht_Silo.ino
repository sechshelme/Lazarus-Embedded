#define servoPin A1
#define band1Pin 5
#define band2Pin 4
#define band3Pin 3
#define zetterPin 2
#define Endschalter A3

#define minValue 0
#define maxValue 180

signed int posAlt = 1400;

void MyDelay(long t) {
	for (int i = 0; i <= t; i++) {
		if (Endschalter) // Wen nicht im Endschalter, schnell ans Ende
		{
			delay(1);
		}
	}
}

// Servo Steuerung
void setServo(int pos) {
	digitalWrite(servoPin, true);
	delayMicroseconds(pos);
	digitalWrite(servoPin, false);
	delay(19);
}

// Langsame Servo Steuerung
void setSlowServo(int pos) {
	signed int puls = map(pos, minValue, maxValue, 400, 2400);
	signed int step = 25;

	if (puls > posAlt) {
		for (int i = posAlt; i <= puls; i += step) {
			setServo(i);
		}
	} else {
		for (int i = posAlt; i >= puls; i -= step) {
			setServo(i);
		}
	}
	setServo(puls);
	posAlt = puls;
}

// Mistzetter öffnen
void KlappeAuf() {
	setSlowServo(50);
}

// Mistzetter schliessen
void KlappeZu() {
	setSlowServo(150);
}

// Inizialiesieren
void setup() {
	pinMode(servoPin, OUTPUT);
	pinMode(band1Pin, OUTPUT);
	pinMode(band2Pin, OUTPUT);
	pinMode(band3Pin, OUTPUT);
	pinMode(zetterPin, OUTPUT);
	setSlowServo(150); // Klappe zu.
}

void loop() {
	while (not Endschalter); // Warten bis Traktor im Endschalter
	KlappeAuf();
	digitalWrite(zetterPin,true);
	MyDelay(200);
	digitalWrite(band3Pin,true);
	MyDelay(1000);
	digitalWrite(band2Pin,true);
	MyDelay(1000);
	digitalWrite(band1Pin,true);
	MyDelay(5000);

	digitalWrite(band1Pin,false);
	MyDelay(1000);
	digitalWrite(band2Pin,false);
	MyDelay(1000);
	digitalWrite(band3Pin,false);
	MyDelay(200);
	digitalWrite(zetterPin,false);
	KlappeZu();
}
