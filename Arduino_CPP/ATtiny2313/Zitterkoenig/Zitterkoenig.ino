const unsigned char digits[] = {
        0B00111111, // = 0
		0B00000110, // = 1
		0B01011011, // = 2
		0B01001111, // = 3
		0B01100110, // = 4
		0B01101101, // = 5
		0B01111101, // = 6
		0B00000111, // = 7
		0B01111111, // = 8
		0B01100111, // = 9

		0B01110111, // = a
		0B01111100, // = b
		0B00111001, // = c
		0B01011110, // = d
		0B01111001, // = e
		0B01110001  // = f
		};

short int ledPin = 10;

//Pin verbunden mit ST_CP des 74HC595
int latchPin = 13;
//Pin verbunden mit SH_CP des 74HC595
int clockPin = 16;
////Pin verbunden mit DS des 74HC595
int dataPin = 15;

// the setup function runs once when you press reset or power the board
void setup() {
	// initialize digital pin 13 as an output.
	pinMode(ledPin, OUTPUT);

	pinMode(latchPin, OUTPUT);
	pinMode(clockPin, OUTPUT);
	pinMode(dataPin, OUTPUT);
}

short unsigned int z = 0;

// the loop function runs over and over again forever
void loop() {
	z++;
	if (z > 9) {
		z = 0;
	}
	digitalWrite(latchPin, false);
	shiftOut(dataPin, clockPin, MSBFIRST, digits[z]);
	digitalWrite(latchPin, true);

	digitalWrite(ledPin, HIGH);   // turn the LED on (HIGH is the voltage level)
	delay(600);              // wait for a second
	digitalWrite(ledPin, LOW);    // turn the LED off by making the voltage LOW
	delay(270);              // wait for a second
}
