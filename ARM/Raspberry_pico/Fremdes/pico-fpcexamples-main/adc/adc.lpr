program adc;
{$MODE OBJFPC}
{$H+}
{$MEMORY 10000,10000}

uses
  pico_gpio_c,
  pico_uart_c,
  pico_adc_c,
  pico_timer_c,
  pico_c;

const
  BAUD_RATE=115200;
var
  milliVolts,milliCelsius : longWord;
  strValue : string;
begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  uart_init(uart, BAUD_RATE);
  gpio_set_function(TPicoPin.UART_TX, TGPIOFunction.GPIO_FUNC_UART);
  gpio_set_function(TPicoPin.UART_RX, TGPIOFunction.GPIO_FUNC_UART);

  adc_init;
  // Make sure GPIO is high-impedance, no pullups etc
  adc_gpio_init(TPicoPin.ADC0);
  // Turn on the Temperature sensor
  adc_set_temp_sensor_enabled(true);
  strValue := '';
  repeat
    gpio_put(TPicoPin.LED,true);
    // Select ADC input 0 (GPIO26)
    adc_select_input(0);
    // Avoiding floating point math as it currently seems to be in no good shape (on Cortex-M0, not only pico)
    milliVolts := (adc_read * 3300) div 4096;
    uart_puts(uart, 'GPIO26 voltage is ');
    str(milliVolts,strValue);
    uart_puts(uart,strValue);
    uart_puts(uart,' mV ');

    // Select internal temperature sensor
    adc_select_input(4);
    milliVolts := (adc_read * 3300) div 4096;
    uart_puts(uart, 'Temperature sensor voltage is ');
    str(milliVolts,strValue);
    uart_puts(uart,strValue);
    uart_puts(uart,' mV ');

    //Temperature formula is : T = 27 - (ADC_voltage - 0.706)/0.001721
    milliCelsius := 27000-(milliVolts-706)*581;

    uart_puts(uart, 'Temperature is ');
    str(milliCelsius div 1000,strValue);
    uart_puts(uart,strValue);
    uart_puts(uart,' °C'+#13#10);

    busy_wait_us_32(500000);
    gpio_put(TPicoPin.LED,false);
    busy_wait_us_32(500000);
  until 1=0;
end.

