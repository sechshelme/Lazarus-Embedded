#include <Arduino.h>

const int led0 = A0;
const int led1 = A1;
const int led2 = A2;

char buff[255];

void setup() {
	pinMode(led0, OUTPUT);
	pinMode(led1, OUTPUT);
	pinMode(led2, OUTPUT);

	Serial.begin(9600);
	int i;
	int level;

	NVIC_SetPriority((IRQn_Type) SysTick_IRQn, 0);

	NVIC_SetPriority((IRQn_Type) TC3_IRQn, 1);
	NVIC_SetPriority((IRQn_Type) TC4_IRQn, 2);
	NVIC_SetPriority((IRQn_Type) TC5_IRQn, 3);

	startTimer(TC1, 0, TC3_IRQn, 20000);
	startTimer(TC1, 1, TC4_IRQn, 120000);
	startTimer(TC1, 2, TC5_IRQn, 800000);
}

void loop() {
}

void startTimer(Tc *tc, uint32_t channel, IRQn_Type irq, uint32_t microSec) {
	pmc_enable_periph_clk((uint32_t) irq);
	TC_Configure(tc, channel,
	TC_CMR_WAVE | TC_CMR_WAVSEL_UP_RC | TC_CMR_TCCLKS_TIMER_CLOCK1);
	uint32_t rc = (VARIANT_MCK / 2 / 1000) * (microSec / 1000);
	TC_SetRC(tc, channel, rc);
	TC_Start(tc, channel);
	tc->TC_CHANNEL[channel].TC_IER = TC_IER_CPCS;
	tc->TC_CHANNEL[channel].TC_IDR = ~TC_IER_CPCS;
	NVIC_EnableIRQ(irq);
}

void TC3_Handler() {
	TC_GetStatus(TC1, 0);
	digitalWrite(led0, !digitalRead(led0));
}

void TC4_Handler() {
	TC_GetStatus(TC1, 1);
	digitalWrite(led1, !digitalRead(led1));
}

void TC5_Handler() {
	TC_GetStatus(TC1, 2);
	for (int i = 0; i < 10; i++) {
		delay(60);
		Serial.println(i);
	}
	digitalWrite(led2, !digitalRead(led2));
}
