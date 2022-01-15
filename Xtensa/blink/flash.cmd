@echo on
set IDF_PATH=D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK
cd D:\data\lazdev\xtensa\projects\blink
python.exe D:\data\msys32\home\andi\esp\ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py --chip esp8266 --port "COM3" --baud 921600 --before "default_reset" --after "hard_reset" write_flash -z --flash_mode "dio" --flash_freq "40m" --flash_size "2MB"   0x0 bootloader.bin 0x10000 blink.bin 0x8000 partitions_singleapp.bin
pause
