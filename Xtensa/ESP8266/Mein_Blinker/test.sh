/bin/esptool -cesp8266 -p /dev/ttyUSB0 -b115200 --before default_reset --after hard_reset write_flash 0x0 bootloader.bin 0x10000 Project1.bin 0x8000 partitions_singleapp.bin

