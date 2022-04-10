# Flashing a firmware on esp32 chips to enable http/https for Pico Boards

This directory contains images for esp-at firmware

To be able to do rest calls with pico there are several options:

* flash a special-build image that uses gpio1 and gpio3 (Standard UART Pins on esp32) instead of default pins configured in esp-at project:
  
  ```esptool.py --port /dev/cu.usbserial-DN009KE0 write_flash 0x0 factory_WROOM-32-V2.1.0_tx_gpio1_rx_gpio3.bin```

  this allows you to use boards like the very cheap esp32-cam that do not make the default pins for esp-at serial comunication available

* For esp-32 (wroom or wrover) or esp32-s2 modules or dev-boards that break out the required pins for the default firmware you may download latest builds for esp-at from espressif:

    https://docs.espressif.com/projects/esp-at/en/latest/AT_Binary_Lists/ESP32_AT_binaries.html

  unzip the downloaded file and flash the image found in the factory directory to your device:

  * esp32 wroom:

    ```esptool.py --port /dev/cu.usbserial-DN009KE0 write_flash 0x0 ESP32-WROOM-32_AT_Bin_V2.1.0.0/ESP32-WROOM-32_AT_Bin_V2.1/factory/factory_WROOM-32.bin```

  * esp32 wrover:

    ```esptool.py --port /dev/cu.usbserial-DN009KE0 write_flash 0x0 ESP32-WROVER_AT_Bin_V2.1.0.0/ESP32-WROVER_AT_Bin_V2.1/factory/factory_WROVER-32.bin```

  * esp32s2:

    ```esptool.py --port /dev/cu.usbserial-DN009KE0 write_flash 0x0 ESP32-S2-WROOM_AT_Bin_V2.1.0.0/ESP32-S2-WROOM_AT_Bin_V2.1.0.0/factory/factory_WROOM-32.bin```

I cannot recommend using a esp8266 image, for http transport it may be ok, but images build with https support often fail with even small result sets
