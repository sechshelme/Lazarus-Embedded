@echo on
set IDF_PATH=D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK
cd D:\data\lazdev\xtensa\projects\blink
python.exe D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK/tools/idf_monitor.py --baud 74880 --port COM3 blink.elf
pause
