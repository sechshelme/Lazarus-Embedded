@echo on
set IDF_PATH=D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK
cd D:\data\lazdev\xtensa\projects\blink
D:\data\lazdev\xtensa\fpc\bin\i386-win32\ppcrossxtensa -sh -Furtl/units/xtensa-freertos/ -Tfreertos -XPxtensa-lx106-elf- -O- -Wpesp8266 -WP3.4 blink -FlD:\data\msys32\home\andi\esp\xtensa-lx106-elf-libs -FlD:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK\components\esp8266\lib -FED:\data\lazdev\xtensa\projects\blink -FlD:\data\xtensa-lx106-elf\xtensa-lx106-elf\lib
pause
