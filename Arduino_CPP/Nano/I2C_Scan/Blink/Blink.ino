#include "Arduino.h"
#include "Wire.h"

// #include "LiquidCrystal_I2C.h"

// LiquidCrystal_I2C lcd(0x3F, 16,2);

void setup() {
	Serial.begin(9600);
	Wire.begin();

//	lcd.begin(16, 2, 4);
//	lcd.backlight();
//	lcd.print("Hello World");

}

void test(long speed) {
	Serial.print("\nTest ");
	Serial.print(speed / 1000);
	Serial.println(" KHz");

	Wire.setClock(speed);
	Serial.print("Adr:");
	for (byte i = 1; i < 128; i++) {
		Wire.beginTransmission(i);
		byte er = Wire.endTransmission();
		if (er == 0) {
			Serial.print("  0x");
			Serial.print(i, HEX);
		}
	}
	Serial.println("-");
}

void loop() {

	test(100000);
//	test(200000);
//	test(400000);
//	test(800000);
//	test(1000000);
//	test(3400000);
//	test(5000000);
	Serial.println("\nEnde");
	delay(3000);
}
