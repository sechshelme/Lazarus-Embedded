#include <Arduino.h>
#include <avr/io.h>
#include <avr/interrupt.h>

#define OutputPinSchneeKanone PD0
#define OutputPinSchneeKanoneLED PD1
#define OutputPinStrassenLampe PD2
#define OutputPinStationLicht PD3

#define OutputPinSesselLift PD4
#define OutputPinLEDBandung PD5
#define OutputPinHelli PD6
#define OutputPinReserve PD7

#define JpPinTest PB0
#define JpPinTurbo PB1
#define JpPinReserve0 PB2
#define JpPinReserve1 PB3
#define JpPinReserve2 PB4

#define KanoneSwitch PC0


struct status {
	int start;
	int stop;
};

// 2400 entspricht 24h ( 15min Nacht, 15min Tag-Modus )

// == Nacht
status SchneeKanoneTime[] = { 1800, 600 };
status SchneeKanoneLEDTime[] = { 1750, 650 };
status StrassenLampeTime[] = { 1700, 700 };
status StationLichtTime[] = { 1750, 650 };  // Beispiel: 17:30 - 06:50
status ReserveTime[] = { { 1800, 2000 }, { 2300, 100 }, { 400, 600 } };  // Kanone provesorisch

// == Tag
status SesselLiftTime[] = { 600, 1800 };
status LEDBandungTime[] = { 555, 1805 };
status HelliTime[] = { { 700, 850 }, { 1000, 1150 }, { 1300, 1400 }, { 1550, 1700 }, { 1850, 2000 } };

// status ReserveTime[] = { 1200, 0000 };

// == Pin schreiben
void dw(unsigned char pin, bool value) {
	if (value) {
		PORTD |= (1 << pin);
	} else {
		PORTD &= ~(1 << pin);
	}
}

// == Pin lesen
bool drB(unsigned char pin) {
	return ((PINB & (1 << pin)) > 0);
}

bool drC(unsigned char pin) {
	return ((PINC & (1 << pin)) > 0);
}

void setup() {
	DDRB = 0b00000000;  // Port auf Eingang  (D12 - D16)
	DDRC = 0b00000000;  // Port auf Eingang  (A0 - A5)
	DDRD = 0b11111111;  // Port auf Ausgang   (D0 - D7)

	PORTB = 0b00011111; // PullUp Pin (D12 - D16)
	PORTC = 0b00000011; // PullUp Pin (A0 + A1)
}

int counter = 500; // Steuerung beginnt um 5:00Uhr Morgens.

void checkCounter(struct status value[], int len, unsigned char pin) {
	len /= sizeof(status);

	for (int i = 0; i < len; i++) {
		if (value[i].start == counter) {
			dw(pin, true);
			return;
		}
		if (value[i].stop == counter) {
			dw(pin, false);
			return;
		}
	}
}

void checkCounterKanone(struct status value[], int len, unsigned char pin) {
	static bool on = true;

	len /= sizeof(status);

	for (int i = 0; i < len; i++) {
		if (value[i].start == counter) {
			on = true;
		}
		if (value[i].stop == counter) {
			on = false;
		}
	}
      dw(pin, ((on) && (!drC(KanoneSwitch))));
}

void loop() {
	if (drB(JpPinTest)) {

		checkCounterKanone(SchneeKanoneTime, sizeof(SchneeKanoneTime), OutputPinSchneeKanone);
		checkCounter(SchneeKanoneLEDTime, sizeof(SchneeKanoneLEDTime), OutputPinSchneeKanoneLED);
		checkCounter(StrassenLampeTime, sizeof(StrassenLampeTime), OutputPinStrassenLampe);
		checkCounter(StationLichtTime, sizeof(StationLichtTime), OutputPinStationLicht);

		checkCounter(SesselLiftTime, sizeof(SesselLiftTime), OutputPinSesselLift);
		checkCounter(LEDBandungTime, sizeof(LEDBandungTime), OutputPinLEDBandung);
		checkCounter(HelliTime, sizeof(HelliTime), OutputPinHelli);
		checkCounter(ReserveTime, sizeof(ReserveTime), OutputPinReserve);
	} else {
		if (600 == counter) {
			PORTD = 0b10101010;
		}
		if (1800 == counter) {
			PORTD = 0b01010101;
		}
	}

	if (drB(JpPinTurbo)) {
		delay(750); // 1/2h = 1800s.
	} else {
		delay(12);  // 60ig fache Beschleunigung
	}

	counter += 1;
	if (counter >= 2400) {
		counter = 0;
	}
}
