

// avr-gcc -mmcu=atmega2560 -DF_CPU=16000000UL -Os -o main.elf main.c
// avr-objcopy -O ihex -R .eeprom main.elf main.hex
// avrdude -C/etc/avrdude.conf -patmega2560 -cwiring -P/dev/ttyUSB0 -b115200 -D -Uflash:w:main.hex:i



#define F_CPU 16000000UL  // Taktfrequenz des Arduino Mega, 16 MHz

#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // Pin 13 (Port B, Pin 7) als Ausgang setzen (Arduino Mega: Onboard LED)
    DDRB |= (1 << DDB7);

    while(1) {
        // LED an
        PORTB |= (1 << PORTB7);
        _delay_ms(500);

        // LED aus
        PORTB &= ~(1 << PORTB7);
        _delay_ms(500);
    }
    return 0;
}
