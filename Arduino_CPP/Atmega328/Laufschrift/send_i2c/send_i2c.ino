#include <Arduino.h>
#include <Wire.h>

#include "cgafont.h"

#define LS_Adr 0x04

const int max = 64;
unsigned char vram[max];

void OutCharXY(int x, int y, char ch) {
	for (int i = 0; i <= 7; i++) {
		int p = i + (max - x);
		if ((p >= 0) && (p < max)) {
			vram[p] = cgafont[ch][7 - i];

			if (y > 0) {
				vram[p] = vram[p] << y;
			} else {
				if (y < 0) {
					vram[p] = vram[p] >> -y;
				}
			}
		}
	}
}

void Clear() {
	for (signed char i = 0; i < max - 1; i++) {
		vram[i] = 0;
	}
}

char herz[] = { 3 };
//String text = " Hello World ";
char text[] = "\3 Hello World \3";

void setup()
{
	//text+="abc";
	Wire.begin();

	Serial.begin(9600);
	Serial.println("Start");
	Serial.println("Bitte ein Buchstaben drücken !");

	for (signed char i = 0; i < max - 1; i++) {
		vram[i] = i + 32;
	}

}

void WriteVRAM() {
	for (signed char b = 0; b <= 3; b++) {
		Wire.beginTransmission(LS_Adr);
		Wire.write(b);
		for (signed char i = 0; i <= 16 - 1; i++) {
			Wire.write(vram[i + b * 16]);
		}
		Wire.endTransmission();
		//delay(1000);
	}
}

void loop()
{
	Clear();
	WriteVRAM();
	int si = sizeof(text);
	Serial.println(si);
	for (int p = 64; p > -si * 8 + 64; p--) {

		for (int i = 0; i < sizeof(text); i++) {
			OutCharXY(i * 8 + p, 0, text[i]);
		}

		WriteVRAM();
		delay(50);
	}

	while (Serial.available() > 0) {
		//ch = Serial.read();
	}

}
