/bin/esptool -cesp8266 -p /dev/ttyUSB0 -b115200 --before default_reset --after hard_reset write_flash 0x0 bootloader.bin 0x10000 Project1.bin 0x8000 partitions_singleapp.bin


/bin/esptool --chip esp8266 --port "/dev/ttyUSB0" --baud 921600 --before "default_reset" --after "hard_reset" write_flash -z --flash_mode "dio" --flash_freq "40m" --flash_size "2MB"   0x0 bootloader.bin 0x10000 Project1.bin 0x8000 partitions_singleapp.bin


