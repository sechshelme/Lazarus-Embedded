program i2c_ds3231;
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
  sysutils,
  pico_c,
  pico_timer_c,
  pico_gpio_c,
  pico_uart_c,
  pico_i2c_c,
  ds3231_c;

const
  BAUD_RATE=115200;

var
  ds3231 : TDS3231;
  currentPicoDateTime : TPicoDateTime;
  currentDateTime : TDateTime;

begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  uart_init(uart, BAUD_RATE);
  gpio_set_function(TPicoPin.UART_TX, TGPIOFunction.GPIO_FUNC_UART);
  gpio_set_function(TPicoPin.UART_RX, TGPIOFunction.GPIO_FUNC_UART);

  i2c_init(i2cInst, 400000);
  gpio_set_function(TPicoPin.I2C_SDA, TGPIOFunction.GPIO_FUNC_I2C);
  gpio_set_function(TPicoPin.I2C_SCL, TGPIOFunction.GPIO_FUNC_I2C);
  gpio_pull_up(TPicoPin.I2C_SDA);
  gpio_pull_up(TPicoPin.I2C_SCL);

  ds3231.initialize(i2cInst,$68);

  currentPicoDateTime.year := 2021;
  currentPicoDateTime.month := 5;
  currentPicoDateTime.day := 12;
  currentPicoDateTime.dotw := 3; //Pico Time starts with Sunday as 0
  currentPicoDateTime.hour := 01;
  currentPicoDateTime.min := 02;
  currentPicoDateTime.sec := 30;
  //Comment the following line if your RTC is already set
  ds3231.setDateTime(currentPicoDateTime);

  repeat
    gpio_put(TPicoPin.LED,true);
    currentDateTime := ds3231.getDateTime;
    uart_puts(uart,'ds3231 says that Date/Time is '+FormatDateTime('c',currentDateTime)+#13#10);
    busy_wait_us_32(500000);
    gpio_put(TPicoPin.LED,false);
    busy_wait_us_32(500000);
  until 1=0;
end.
