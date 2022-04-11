program uartdemo;
{$MODE OBJFPC}
{$H+}
{$MEMORY 10000,10000}

uses
  pico_uart_c,
  pico_gpio_c,
  pico_timer_c;
const
  BAUD_RATE=9600;
begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);
  uart_init(uart, BAUD_RATE);
  gpio_set_function(TPicoPin.UART_TX, TGPIOFunction.GPIO_FUNC_UART);
  gpio_set_function(TPicoPin.UART_RX, TGPIOFunction.GPIO_FUNC_UART);
  repeat
    gpio_put(TPicoPin.LED,true);
    uart_puts(uart, 'Hello, UART!'+#13+#10);
    busy_wait_us_32(500000);
    gpio_put(TPicoPin.LED,false);
    busy_wait_us_32(500000);
  until 1=0;
end.
