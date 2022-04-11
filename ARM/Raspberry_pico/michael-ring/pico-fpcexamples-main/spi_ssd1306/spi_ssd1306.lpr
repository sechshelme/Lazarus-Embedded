program spi_ssd1306;
{$MODE OBJFPC}
{$H+}
{$MEMORY 10000,10000}
uses
  pico_spi_c,
  CustomDisplay,
  ssd1306_spi_c,
  pico_gpio_c,
  pico_timer_c,
  pico_c,
  Fonts.BitstreamVeraSansMono8x16,
  Images.Paw;

var
  ssd1306 : TSSD1306_SPI;

begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  spi_init(spi,20000000);
  gpio_set_function(TPicoPin.SPI_CS, TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_SCK, TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_TX, TGPIOFunction.GPIO_FUNC_SPI);

  ssd1306.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,ScreenSize128x64x1);
  ssd1306.setFontInfo(BitstreamVeraSansMono8x16);

  repeat
    gpio_put(TPicoPin.LED,true);
    ssd1306.ForegroundColor := clWhite;
    ssd1306.BackgroundColor := clBlack;
    ssd1306.setRotation(TDisplayRotation.None);
    ssd1306.ClearScreen;
    ssd1306.drawText('Hello',0,0);
    ssd1306.drawText('FreePascal',0,ssd1306.ScreenHeight-ssd1306.FontInfo.Height);
    ssd1306.drawImage(ssd1306.ScreenWidth - 33, ssd1306.ScreenHeight div 2 - 16,paw32x32x1);
    ssd1306.updateScreen;
    busy_wait_us_32(2000000);

    gpio_put(TPicoPin.LED,false);
    ssd1306.ForegroundColor := clBlack;
    ssd1306.BackgroundColor := clWhite;
    ssd1306.setRotation(TDisplayRotation.UpsideDown);
    ssd1306.ClearScreen;
    ssd1306.drawText('Hello',0,0);
    ssd1306.drawText('FreePascal',0,ssd1306.ScreenHeight-ssd1306.FontInfo.Height);
    ssd1306.drawImage(ssd1306.ScreenWidth - 33, ssd1306.ScreenHeight div 2 - 16,paw32x32x1);
    ssd1306.updateScreen;
    busy_wait_us_32(2000000);
  until 1=0;
end.
