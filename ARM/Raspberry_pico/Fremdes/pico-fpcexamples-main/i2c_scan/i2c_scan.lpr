program i2c_scan;
{$MODE OBJFPC}
{$H+}
{$MEMORY 10000,10000}

uses
  pico_gpio_c,
  pico_uart_c,
  pico_i2c_c,
  pico_timer_c,
  pico_c;

const
  BAUD_RATE=115200;
var
  addr : byte;
  ret : longInt;
  rxData : array[0..0] of byte;
  tmpStr : String;
begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  uart_init(uart, BAUD_RATE);
  gpio_set_function(TPicoPin.UART_TX, TGPIOFunction.GPIO_FUNC_UART);
  gpio_set_function(TPicoPin.UART_RX, TGPIOFunction.GPIO_FUNC_UART);
  
  i2c_init(i2cInst, 100000);
  gpio_set_function(TPicoPin.I2C_SDA, TGPIOFunction.GPIO_FUNC_I2C);
  gpio_set_function(TPicoPin.I2C_SCL, TGPIOFunction.GPIO_FUNC_I2C);
  gpio_pull_up(TPicoPin.I2C_SDA);
  gpio_pull_up(TPicoPin.I2C_SCL);

  repeat
    uart_puts(uart,'I2C Bus Scan'+#13#10);
    uart_puts(uart,'     0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F'+#13#10);

    for addr := 0 to 127 do
    begin
      if (addr mod 16) = 0 then
      begin
        str(addr div 16,tmpStr);
        uart_puts(uart,'$'+tmpStr+'0 ');
      end;
      ret := i2c_read_blocking(i2cInst, addr, rxdata, 1, false);
      if ret < 0 then
        uart_puts(uart,' . ')
      else
        uart_puts(uart,' X ');
      if addr mod 16 = 15 then
        uart_puts(uart,#13#10);
    end;
    uart_puts(uart,#13#10);
    busy_wait_us_32(2000000);
  until 1=0;
end.
