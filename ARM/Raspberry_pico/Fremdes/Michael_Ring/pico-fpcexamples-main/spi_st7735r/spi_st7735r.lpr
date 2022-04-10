program spi_st7735r;
{$MODE OBJFPC}
{$H+}
{$MEMORY 20000,20000}
uses
  pico_spi_c,
  st7735r_spi_c,
  CustomDisplay,
  pico_gpio_c,
  pico_timer_c,
  pico_c,
  Images.Paw,
  Fonts.BitstreamVeraSansMono8x16;

var
  st7735 : Tst7735r_SPI;
begin
  gpio_init(TPicoPin.LED);
  gpio_set_dir(TPicoPin.LED,TGPIODirection.GPIO_OUT);

  spi_init(spi,20000000);
  gpio_set_function(TPicoPin.SPI_CS,  TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_SCK, TGPIOFunction.GPIO_FUNC_SPI);
  gpio_set_function(TPicoPin.SPI_TX,  TGPIOFunction.GPIO_FUNC_SPI);

  //st7735.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,st7735.ScreenSize128x160x16RGB);
  st7735.Initialize(spi,TPicoPin.GP16,TPicoPin.GP14,st7735.ScreenSize128x128x16);
  st7735.setFontInfo(BitstreamVeraSansMono8x16);

  repeat
    gpio_put(TPicoPin.LED,true);
    st7735.ForegroundColor := clWhite;
    st7735.BackgroundColor := clRed;
    st7735.SetRotation(TDisplayRotation.None);
    st7735.ClearScreen;
    st7735.drawText('Red',2,2);
    st7735.drawRect(0,0,st7735.ScreenWidth,st7735.ScreenHeight);
    st7735.drawCircle(st7735.ScreenWidth div 2,st7735.ScreenHeight div 2,25);
    busy_wait_us_32(1500000);

    gpio_put(TPicoPin.LED,false);
    st7735.ForegroundColor := clWhite;
    st7735.BackgroundColor := clLime;
    st7735.SetRotation(TDisplayRotation.Right);
    st7735.ClearScreen;
    st7735.drawText('Lime',2,2);
    st7735.drawRect(0,0,st7735.ScreenWidth,st7735.ScreenHeight);
    st7735.FillCircle(st7735.ScreenWidth div 2,st7735.ScreenHeight div 2,25);
    busy_wait_us_32(1500000);

    gpio_put(TPicoPin.LED,true);
    st7735.ForegroundColor := clWhite;
    st7735.BackgroundColor := clBlue;
    st7735.SetRotation(TDisplayRotation.UpsideDown);
    st7735.ClearScreen;
    st7735.drawText('Blue',5,5);
    st7735.drawRoundRect(0,0,st7735.ScreenWidth,st7735.ScreenHeight,15);
    st7735.drawLine(25,25,st7735.ScreenWidth-25,st7735.ScreenHeight-25);
    st7735.drawLine(25,st7735.ScreenHeight-25,st7735.ScreenWidth-25,25);
    busy_wait_us_32(1500000);

    gpio_put(TPicoPin.LED,false);
    st7735.ForegroundColor := clBlack;
    st7735.BackgroundColor := clWhite;
    st7735.SetRotation(TDisplayRotation.Left);
    st7735.ClearScreen;
    st7735.drawText('Hello',2,2,clBlack);
    st7735.drawText('FreePascal',2,st7735.ScreenHeight-2-st7735.FontInfo.Height,clBlack);
    st7735.drawImage(st7735.ScreenWidth div 2 - 32, st7735.ScreenHeight div 2 - 32,paw64x64x4);
    busy_wait_us_32(1500000);
  until 1=0;
end.
