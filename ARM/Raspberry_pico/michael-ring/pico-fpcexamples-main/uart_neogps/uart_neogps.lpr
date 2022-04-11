program uart_neogps;
{
  This file is part of pico-fpcsamples
  Copyright (c) 2021 -  Michael Ring

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}

{$MODE OBJFPC}
{$H+}
{$MEMORY 10000,10000}

uses
  pico_c,
  pico_gpio_c,
  pico_uart_c,
  neogps;
const
  BAUDRATE=115200;
  GPS_BAUDRATE=9600;
var
  gps : TNeoGPS;

begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  // we use UART0 for debug output
  uart_init(uart0, BAUDRATE);
  gpio_set_function(TPicoPin.GP0_UART0_TX, TGPIOFunction.GPIO_FUNC_UART);
  gpio_set_function(TPicoPin.GP1_UART0_RX, TGPIOFunction.GPIO_FUNC_UART);

  // the gps is connected to UART1
  uart_init(uart1, GPS_BAUDRATE);
  gpio_set_function(TPicoPin.GP4_UART1_TX, TGPIOFunction.GPIO_FUNC_UART);
  gpio_set_function(TPicoPin.GP5_UART1_RX, TGPIOFunction.GPIO_FUNC_UART);

  gps.init(uart1,GPS_BAUDRATE);

  repeat
    gpio_put(TPicoPin.LED,true);
    gps.poll;
    // We need to make sure that we do not spend too much time in the code below the gps.poll command
    // so that we are sure that we catch the next update of the GPS. Usually GPS data is updated once per second
    // which gives you 300-500ms of time to do other things before the next GPS data is ready.
    // when the LED indicator looks like it really blinks instead of going dark for only a brief moment then you know
    // your processing after the poll is likely getting too long.

    gpio_put(TPicoPin.LED,false);
    if (gps.status = TGPSStatusCode.INITIALIZING) then
      uart_puts(uart0,'Initializing connection to GPS'+#13#10);
    if (gps.status = TGPSStatusCode.SERIALDETECTED) then
      uart_puts(uart0,'Found Serial Device'+#13#10);
    if (gps.status = TGPSStatusCode.GPSDETECTED) then
      uart_puts(uart0,'Found GPS Device, waiting for position fix'+#13#10);
    if (gps.status = TGPSStatusCode.POSITIONFIX) then
    begin
      uart_puts(uart0,'Time: '+gps.GPRMC[TGPSGPRMCField.UTCTime]+' Date: '+gps.GPRMC[TGPSGPRMCField.UTCDate]+' ');
      uart_puts(uart0,'Position: '+gps.GPRMC[TGPSGPRMCField.Lattitude]+gps.GPRMC[TGPSGPRMCField.LattitudeIndicator]+' ');
      uart_puts(uart0,gps.GPRMC[TGPSGPRMCField.Longgitude]+gps.GPRMC[TGPSGPRMCField.LongitudeIndicator]+' ');
      uart_puts(uart0,'Satellites: '+gps.GPGGA[TGPSGPGGAField.SatellitesUsed]+' Altitude: '+gps.GPGGA[TGPSGPGGAField.MSLAttitude]+' m ');
      uart_puts(uart0,'Speed: '+gps.GPRMC[TGPSGPRMCField.Speed]+' km/h Course: '+gps.GPRMC[TGPSGPRMCField.Course]+' Degrees'+#13#10);
    end;
  until 1=0;
end.
