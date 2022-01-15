@echo off
SET THEFILE=blink
echo Assembling %THEFILE%
D:\data\xtensa-lx106-elf\bin\xtensa-lx106-elf-as.exe -o D:\data\lazdev\xtensa\projects\blink\blink.o  D:\data\lazdev\xtensa\projects\blink\blink.s --longcalls
if errorlevel 1 goto asmend
SET THEFILE=D:\data\lazdev\xtensa\projects\blink\blink
echo Linking %THEFILE%
D:\data\xtensa-lx106-elf\bin\xtensa-lx106-elf-ld.exe -g     --gc-sections   -L. -o D:\data\lazdev\xtensa\projects\blink\blink.elf -T D:\data\lazdev\xtensa\projects\blink\link5832.res -u call_user_start -u g_esp_sys_info -u _printf_float -u _scanf_float -L D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK/components/esp8266/ld -T esp8266.peripherals.ld -T esp8266.rom.ld -T D:\data\msys32\home\andi\esp\xtensa-lx106-elf-libs\esp8266_out.ld -T D:\data\msys32\home\andi\esp\xtensa-lx106-elf-libs\esp8266.project.ld
if errorlevel 1 goto linkend
SET THEFILE=D:\data\lazdev\xtensa\projects\blink\blink
echo Linking %THEFILE%
python.exe D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py --chip esp8266 elf2image --flash_mode dout --flash_freq 40m --flash_size 1MB --version=3 -o D:\data\lazdev\xtensa\projects\blink\blink.bin D:\data\lazdev\xtensa\projects\blink\blink.elf
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
pause
