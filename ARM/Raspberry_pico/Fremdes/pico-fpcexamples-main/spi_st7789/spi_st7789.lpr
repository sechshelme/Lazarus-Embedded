program spi_st7789;
{$MODE OBJFPC}
{$H+}
{$MEMORY 20000,20000}
uses
  pico_spi_c,
  st7789_spi_c,
  CustomDisplay,
  pico_gpio_c,
  pico_timer_c,
  pico_c,
  Images.Paw,
  Fonts.BitstreamVeraSansMono13x24;

var
  st7789 : Tst7789_SPI;
begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  spi_init(spi,20000000);
  gpio_set_function(TPicoPin.SPI_CS,  TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_SCK, TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_TX,  TGPIOFunction.GPIO_FUNC_SPI);

  st7789.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,st7789.ScreenSize240x135x16);
  //st7789.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,st7789.ScreenSize240x240x16);
  //st7789.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,st7789.ScreenSize320x240x16);
  st7789.setFontInfo(BitstreamVeraSansMono13x24);

  repeat
    gpio_put(TPicoPin.LED,true);
    st7789.ForegroundColor := clWhite;
    st7789.BackgroundColor := clRed;
    st7789.SetRotation(TDisplayRotation.None);
    st7789.ClearScreen;
    st7789.drawText('Red',2,2);
    st7789.drawRect(0,0,st7789.ScreenWidth,st7789.ScreenHeight);
    st7789.drawCircle(st7789.ScreenWidth div 2,st7789.ScreenHeight div 2,25);
    busy_wait_us_32(1500000);

    gpio_put(TPicoPin.LED,false);
    st7789.ForegroundColor := clWhite;
    st7789.BackgroundColor := clLime;
    st7789.SetRotation(TDisplayRotation.Right);
    st7789.ClearScreen;
    st7789.drawText('Lime',2,2);
    st7789.drawRect(0,0,st7789.ScreenWidth,st7789.ScreenHeight);
    st7789.FillCircle(st7789.ScreenWidth div 2,st7789.ScreenHeight div 2,25);
    busy_wait_us_32(1500000);

    gpio_put(TPicoPin.LED,true);
    st7789.ForegroundColor := clWhite;
    st7789.BackgroundColor := clBlue;
    st7789.SetRotation(TDisplayRotation.UpsideDown);
    st7789.ClearScreen;
    st7789.drawText('Blue',5,5);
    st7789.drawRoundRect(0,0,st7789.ScreenWidth,st7789.ScreenHeight,15);
    st7789.drawLine(25,25,st7789.ScreenWidth-25,st7789.ScreenHeight-25);
    st7789.drawLine(25,st7789.ScreenHeight-25,st7789.ScreenWidth-25,25);
    busy_wait_us_32(1500000);

    gpio_put(TPicoPin.LED,false);
    st7789.ForegroundColor := clBlack;
    st7789.BackgroundColor := clWhite;
    st7789.SetRotation(TDisplayRotation.Left);
    st7789.ClearScreen;
    st7789.drawText('Hello',2,2,clBlack);
    st7789.drawText('FreePascal',2,st7789.ScreenHeight-2-st7789.FontInfo.Height,clBlack);
    st7789.drawImage(st7789.ScreenWidth div 2 - 32, st7789.ScreenHeight div 2 - 32,paw64x64x4);
    busy_wait_us_32(1500000);
  until 1=0;
end.
