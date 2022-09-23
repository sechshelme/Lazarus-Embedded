unit pico_gpio_c;
(*
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *)

{$mode objfpc}
{$H+}
{$modeswitch advancedrecords}
{$SCOPEDENUMS ON}

interface
uses
  pico_c;
{$IF DEFINED(DEBUG) or DEFINED(DEBUG_GPIO)}
{$L gpio.c-debug.obj}
{$ELSE}
{$L gpio.c.obj}
{$ENDIF}

type
  TPinIdentifier=-1..28;
  {$IF DEFINED(FPC_MCU_TINY_2040)}
  TPicoPin = record
  const
    None=-1;
    GP0=   0;  GP0_SPI0_RX=    0;  GP0_I2C0_SDA=  0;  GP0_UART0_TX=   0;                UART_TX = 0;
    GP1=   1;  GP1_SPI0_CS=    1;  GP1_I2C0_SCL=  1;  GP1_UART0_RX=   1;                UART_RX = 1;
    GP2=   2;  GP2_SPI0_SCK=   2;  GP2_I2C1_SDA=  2;  GP2_UART0_CTS=  2;                I2C_SDA = 2;
    GP3=   3;  GP3_SPI0_TX=    3;  GP3_I2C1_SCL=  3;  GP3_UART0_RTS=  3;                I2C_SCL = 3;
    GP4=   4;  GP4_SPI0_RX=    4;  GP4_I2C0_SDA=  4;  GP4_UART1_TX=   4;                SPI_RX  = 4;
    GP5=   5;  GP5_SPI0_CS=    5;  GP5_I2C0_SCL=  5;  GP5_UART1_RX=   5;                SPI_CS  = 5;
    GP6=   6;  GP6_SPI0_SCK=   6;  GP6_I2C1_SDA=  6;  GP6_UART1_CTS=  6;                SPI_SCK = 6;
    GP7=   7;  GP7_SPI0_TX=    7;  GP7_I2C1_SDL=  7;  GP7_UART1_RTS=  7;                SPI_TX  = 7;

    GP18= 18;  GP18_LED_R=    18;                                                       LED_R=   18;
    GP19= 19;  GP19_LED_G=    19; LED_G=        19;                                     LED=     19;
    GP20= 20;  GP20_LED_B=    20;                                                       LED_B=   20;
    GP23= 23;  GP23_USER_SW=  23;                                                       USER_SW= 23;
    GP26= 26;  GP26_SPI1_SCK= 26; GP26_I2C1_SDA= 26; GP26_UART1_CTS= 26; GP26_ADC0= 26; ADC0=    26;
    GP27= 27;  GP27_SPI1_TX=  27; GP27_I2C1_SCL= 27; GP27_UART1_RTS= 27; GP27_ADC1= 27; ADC1=    27;
    GP28= 28;  GP28_SPI1_RX=  28; GP28_I2C0_ADA= 28; GP28_UART0_TX=  28; GP28_ADC2= 28; ADC2=    28;
    GP29= 29;  GP29_SPI1_CS=  29; GP29_I2C0_SCL= 29; GP29_UART0_RX=  29; GP29_ADC3= 29; ADC3=    29;
  end;
  {$ELSEIF DEFINED(FPC_MCU_QTPY_RP2040)}
  TPicoPin = record
  const
    None=-1;
    GP3=   3;  GP3_SPI0_TX=    3;  GP3_I2C1_SCL=  3;  GP3_UART0_RTS=  3;                SPI_TX=   3;
    GP4=   4;  GP4_SPI0_RX=    4;  GP4_I2C0_SDA=  4;  GP4_UART1_TX=   4;                SPI_RX=   4;
    GP6=   6;  GP6_SPI0_SCK=   6;  GP6_I2C1_SDA=  6;  GP6_UART1_CTS=  6;                SPI_SCK=  6;
    GP9=   9;  GP9_SPI1_CS=    9;  GP9_I2C0_SCL=  9;  GP9_UART1_RX=   9;                UART_RX = 9;
    //There is no single LED on QTPY RP2040, so define an unused pin so that code compiles
                                                                                             LED=10;
    GP11= 11;                                                                       NEOPIXEL_PWR=11;
    GP12= 12;                                                                           NEOPIXEL=12;
    GP20= 20;  GP20_SPI0_RX=  20; GP20_I2C0_SDA= 20; GP20_UART1_TX=  20;                UART_TX= 20;
    GP24= 24;  GP24_SPI1_RX=  24; GP24_I2C0_SDA= 24; GP24_UART1_TX=  24;                I2C_SDA= 24;
    GP25= 25;  GP25_SPI1_CS=  25; GP25_I2C0_SCL= 25; GP25_UART1_RX=  25;                I2C_SCL= 25;
    GP26= 26;  GP26_SPI1_SCK= 26; GP26_I2C1_SDA= 26; GP26_UART1_CTS= 26; GP26_ADC0= 26; ADC0=    26;
    GP27= 27;  GP27_SPI1_TX=  27; GP27_I2C1_SCL= 27; GP27_UART1_RTS= 27; GP27_ADC1= 27; ADC1=    27;
    GP28= 28;  GP28_SPI1_RX=  28; GP28_I2C0_ADA= 28; GP28_UART0_TX=  28; GP28_ADC2= 28; ADC2=    28;
    GP29= 29;  GP29_SPI1_CS=  29; GP29_I2C0_SCL= 29; GP29_UART0_RX=  29; GP29_ADC3= 29; ADC3=    29;
  end;
  {$ELSEIF DEFINED(FPC_MCU_FEATHER_RP2040)}
  TPicoPin = record
const
    None=-1;
    GP0=   0;  GP0_SPI0_RX=    0;  GP0_I2C0_SDA=  0;  GP0_UART0_TX=   0;                 UART_TX= 0;
    GP1=   1;  GP1_SPI0_CS=    1;  GP1_I2C0_SCL=  1;  GP1_UART0_RX=   1;                 UART_RX= 1;
    GP2=   2;  GP2_SPI0_SCK=   2;  GP2_I2C1_SDA=  2;  GP2_UART0_CTS=  2;                 I2C_SDA= 2;
    GP3=   3;  GP3_SPI0_TX=    3;  GP3_I2C1_SCL=  3;  GP3_UART0_RTS=  3;                 I2C_SCL= 3;

    GP6=   6;  GP6_SPI0_SCK=   6;  GP6_I2C1_SDA=  6;  GP6_UART1_CTS=  6; 
    GP7=   7;  GP7_SPI0_TX=    7;  GP7_I2C1_SDL=  7;  GP7_UART1_RTS=  7;
    GP8=   8;  GP8_SPI1_RX=    8;  GP8_I2C0_SDA=  8;  GP8_UART1_TX=   8;
    GP9=   9;  GP9_SPI1_CS=    9;  GP9_I2C0_SCL=  9;  GP9_UART1_RX=   9;

    GP10= 10;  GP10_SPI1_SCK= 10; GP10_I2C1_SDA= 10; GP10_UART1_CTS= 10; 
    GP11= 11;  GP11_SPI1_TX=  11; GP11_I2C1_SDL= 11; GP11_UART1_RTS= 11;
    GP12= 12;  GP12_SPI1_RX=  12; GP12_I2C0_SDA= 12; GP12_UART0_TX=  12;
    GP13= 13;  GP13_LED=      13;                                                       LED=     13;
    GP16= 16;  GP16_NEOPIXEL= 16;                                                       NEOPIXEL=16;
    GP18= 18;  GP18_SPI0_SCK= 18; GP18_I2C1_SDA= 18; GP18_UART0_CTS= 18;                SPI_SCK= 18;
    GP19= 19;  GP19_SPI0_TX=  19; GP19_I2C1_SCL= 19; GP19_UART0_RTS= 19;                SPI_TX=  19;
    GP20= 20;  GP20_SPI0_RX=  20; GP20_I2C0_SDA= 20; GP20_UART1_TX=  20;                SPI_RX=  20;
    GP26= 26;  GP26_SPI1_SCK= 26; GP26_I2C1_SDA= 26; GP26_UART1_CTS= 26; GP26_ADC0= 26; ADC0=    26;
    GP27= 27;  GP27_SPI1_TX=  27; GP27_I2C1_SCL= 27; GP27_UART1_RTS= 27; GP27_ADC1= 27; ADC1=    27;
    GP28= 28;  GP28_SPI1_RX=  28; GP28_I2C0_ADA= 28; GP28_UART0_TX=  28; GP28_ADC2= 28; ADC2=    28;
    GP29= 29;  GP29_SPI1_CS=  29; GP29_I2C0_SCL= 29; GP29_UART0_RX=  29; GP29_ADC3= 29; ADC3=    29;
  end;
  {$ELSEIF DEFINED(FPC_MCU_ITSYBITSY_RP2040)}
  TPicoPin = record
const
    None=-1;
    GP0=   0;  GP0_SPI0_RX=    0;  GP0_I2C0_SDA=  0;  GP0_UART0_TX=   0;                UART_TX = 0;
    GP1=   1;  GP1_SPI0_CS=    1;  GP1_I2C0_SCL=  1;  GP1_UART0_RX=   1;                UART_RX = 1;

    GP2=   2;  GP2_SPI0_SCK=   2;  GP2_I2C1_SDA=  2;  GP2_UART0_CTS=  2;                I2C_SDA = 2;
    GP3=   3;  GP3_SPI0_TX=    3;  GP3_I2C1_SCL=  3;  GP3_UART0_RTS=  3;                I2C_SCL = 3;
    GP4=   4;  GP4_SPI0_RX=    4;  GP4_I2C0_SDA=  4;  GP4_UART1_TX=   4; 
    GP5=   5;  GP5_SPI0_CS=    5;  GP5_I2C0_SCL=  5;  GP5_UART1_RX=   5; 

    GP6=   6;  GP6_SPI0_SCK=   6;  GP6_I2C1_SDA=  6;  GP6_UART1_CTS=  6;
    GP7=   7;  GP7_SPI0_TX=    7;  GP7_I2C1_SDL=  7;  GP7_UART1_RTS=  7;
    GP8=   8;  GP8_SPI1_RX=    8;  GP8_I2C0_SDA=  8;  GP8_UART1_TX=   8;
    GP9=   9;  GP9_SPI1_CS=    9;  GP9_I2C0_SCL=  9;  GP9_UART1_RX=   9;

    GP10= 10;  GP10_SPI1_SCK= 10; GP10_I2C1_SDA= 10; GP10_UART1_CTS= 10;
    GP11= 11;  GP11_LED=      11;                                                       LED    = 11; 
    GP12= 12;  GP12_SPI1_RX=  12; GP12_I2C0_SDA= 12; GP12_UART0_TX=  12;
    GP13= 13;  GP13_SPI1_CS=  13; GP13_I2C0_SCL= 13; GP13_UART0_RX=  13;

    GP14= 14;  GP14_SPI1_SCK= 14; GP14_I2C1_SDA= 14; GP14_UART0_CTS= 14;
    GP15= 15;  GP15_SPI1_TX=  15; GP15_I2C1_SDL= 15; GP15_UART0_RTS= 15; 
    GP16= 16;  GP16_SPI1_RX=  16; GP16_I2C0_SDA= 16; GP16_UART0_TX=  16;                
    GP17= 17;  GP17_SPI1_CS=  17; GP17_I2C0_SCL= 17; GP17_UART0_RX=  17;                

    GP18= 18;  GP18_SPI0_SCK= 18; GP18_I2C1_SDA= 18; GP18_UART0_CTS= 18;                SPI_SCK= 18;
    GP19= 19;  GP19_SPI0_TX=  19; GP19_I2C1_SCL= 19; GP19_UART0_RTS= 19;                SPI_TX=  19;

    GP20= 20;  GP20_SPI0_RX=  20; GP20_I2C0_SDA= 20; GP20_UART1_TX=  20;                SPI_RX=  20;
    GP21= 21;  GP21_SPI0_CS=  21; GP21_I2C0_SCL= 21; GP21_UART1_RX=  21;                SPI_CS=  21; 
    GP22= 22;  GP22_SPI0_SCK= 22; GP22_I2C1_SDA= 22; GP22_UART1_CTS= 22;
    GP25= 25;  GP25_LED=      25;                                                       LED=     25;
    GP26= 26;  GP26_SPI1_SCK= 26; GP26_I2C1_SDA= 26; GP26_UART1_CTS= 26; GP26_ADC0= 26; ADC0=    26;
    GP27= 27;  GP27_SPI1_TX=  27; GP27_I2C1_SCL= 27; GP27_UART1_RTS= 27; GP27_ADC1= 27; ADC1=    27;
    GP28= 28;  GP28_SPI1_RX=  28; GP28_I2C0_ADA= 28; GP28_UART0_TX=  28; GP28_ADC2= 28; ADC2=    28;
  end;
  {$ELSE}
  TPicoPin = record
  const
    None=-1;
    GP0=   0;  GP0_SPI0_RX=    0;  GP0_I2C0_SDA=  0;  GP0_UART0_TX=   0;                UART_TX = 0;
    GP1=   1;  GP1_SPI0_CS=    1;  GP1_I2C0_SCL=  1;  GP1_UART0_RX=   1;                UART_RX = 1;

    GP2=   2;  GP2_SPI0_SCK=   2;  GP2_I2C1_SDA=  2;  GP2_UART0_CTS=  2;
    GP3=   3;  GP3_SPI0_TX=    3;  GP3_I2C1_SCL=  3;  GP3_UART0_RTS=  3;
    GP4=   4;  GP4_SPI0_RX=    4;  GP4_I2C0_SDA=  4;  GP4_UART1_TX=   4;                I2C_SDA = 4;
    GP5=   5;  GP5_SPI0_CS=    5;  GP5_I2C0_SCL=  5;  GP5_UART1_RX=   5;                I2C_SCL = 5;

    GP6=   6;  GP6_SPI0_SCK=   6;  GP6_I2C1_SDA=  6;  GP6_UART1_CTS=  6;
    GP7=   7;  GP7_SPI0_TX=    7;  GP7_I2C1_SDL=  7;  GP7_UART1_RTS=  7;
    GP8=   8;  GP8_SPI1_RX=    8;  GP8_I2C0_SDA=  8;   GP8_UART1_TX=  8;
    GP9=   9;  GP9_SPI1_CS=    9;  GP9_I2C0_SCL=  9;   GP9_UART1_RX=  9;

    GP10= 10;  GP10_SPI1_SCK= 10; GP10_I2C1_SDA= 10; GP10_UART1_CTS= 10;
    GP11= 11;  GP11_SPI1_TX=  11; GP11_I2C1_SDL= 11; GP11_UART1_RTS= 11;
    GP12= 12;  GP12_SPI1_RX=  12; GP12_I2C0_SDA= 12;  GP12_UART0_TX= 12;
    GP13= 13;  GP13_SPI1_CS=  13; GP13_I2C0_SCL= 13;  GP13_UART0_RX= 13;

    GP14= 14;  GP14_SPI1_SCK= 14; GP14_I2C1_SDA= 14; GP14_UART0_CTS= 14;
    GP15= 15;  GP15_SPI1_TX=  15; GP15_I2C1_SDL= 15; GP15_UART0_RTS= 15;
    GP16= 16;  GP16_SPI1_RX=  16; GP16_I2C0_SDA= 16; GP16_UART0_TX=  16;                SPI_RX= 16;
    GP17= 17;  GP17_SPI1_CS=  17; GP17_I2C0_SCL= 17; GP17_UART0_RX=  17;                SPI_CS= 17;

    GP18= 18;  GP18_SPI0_SCK= 18; GP18_I2C1_SDA= 18; GP18_UART0_CTS= 18;                SPI_SCK= 18;
    GP19= 19;  GP19_SPI0_TX=  19; GP19_I2C1_SCL= 19; GP19_UART0_RTS= 19;                SPI_TX=  19;

    GP20= 20;  GP20_SPI0_RX=  20; GP20_I2C0_SDA= 20; GP20_UART1_TX=  20;
    GP21= 21;  GP21_SPI0_CS=  21; GP21_I2C0_SCL= 21; GP21_UART1_RX=  21;
    GP22= 22;  GP22_SPI0_SCK= 22; GP22_I2C1_SDA= 22; GP22_UART1_CTS= 22;
    GP25= 25;  GP25_LED=      25;                                                       LED=     25;
    GP26= 26;  GP26_SPI1_SCK= 26; GP26_I2C1_SDA= 26; GP26_UART1_CTS= 26; GP26_ADC0= 26; ADC0=    26;
    GP27= 27;  GP27_SPI1_TX=  27; GP27_I2C1_SCL= 27; GP27_UART1_RTS= 27; GP27_ADC1= 27; ADC1=    27;
    GP28= 28;  GP28_SPI1_RX=  28; GP28_I2C0_ADA= 28; GP28_UART0_TX=  28; GP28_ADC2= 28; ADC2=    28;
  end;
  {$ENDIF}

//  var
  {$IF DEFINED(FPC_MCU_TINY_2040)}
    uart : TUART_Registers absolute UART0_BASE;
    spi  : TSPI_Registers absolute SPI0_BASE;
    i2c  : TI2C_Registers absolute I2C0_BASE;
  {$ELSEIF DEFINED(FPC_MCU_QTPY_RP2040)}
    uart : TUART_Registers absolute UART1_BASE;
    spi  : TSPI_Registers absolute SPI0_BASE;
    i2c  : TI2C_Registers absolute I2C0_BASE;
  {$ELSEIF DEFINED(FPC_MCU_FEATHER_RP2040)}
    uart : TUART_Registers absolute UART1_BASE;
    spi  : TSPI_Registers absolute SPI0_BASE;
    i2c  : TI2C_Registers absolute I2C1_BASE;
  {$ELSEIF DEFINED(FPC_MCU_ITZYBITZY_RP2040)}
    uart : TUART_Registers absolute UART1_BASE;
    spi  : TSPI_Registers absolute SPI0_BASE;
    i2c  : TI2C_Registers absolute I2C1_BASE;
  {$ELSEIF DEFINED(FPC_MCU_RASPI_PICO)}
    uart : TUART_Registers absolute UART0_BASE;
    spi  : TSPI_Registers absolute SPI0_BASE;
    i2c  : TI2C_Registers absolute I2C0_BASE;
  {$ENDIF}
    
type
  TGPIODirection = (
    GPIO_IN=0,
    GPIO_OUT=1
  );

  TGPIOFunction = (
    GPIO_FUNC_XIP = 0,
    GPIO_FUNC_SPI = 1,
    GPIO_FUNC_UART = 2,
    GPIO_FUNC_I2C = 3,
    GPIO_FUNC_PWM = 4,
    GPIO_FUNC_SIO = 5,
    GPIO_FUNC_PIO0 = 6,
    GPIO_FUNC_PIO1 = 7,
    GPIO_FUNC_GPCK = 8,
    GPIO_FUNC_USB = 9,
    GPIO_FUNC_NULL = $0f
  );

  TGPIOIRQ_level = (
    GPIO_IRQ_LEVEL_LOW = $1,
    GPIO_IRQ_LEVEL_HIGH = $2,
    GPIO_IRQ_EDGE_FALL = $4,
    GPIO_IRQ_EDGE_RISE = $8
  );

  TGPIOIrq_callback = procedure (gpio:TPinIdentifier; events:longWord);

  TGPIOOverride = (
    GPIO_OVERRIDE_NORMAL = 0,
    GPIO_OVERRIDE_INVERT = 1,
    GPIO_OVERRIDE_LOW = 2,
    GPIO_OVERRIDE_HIGH = 3
  );

(*
  Select GPIO function
param:
  gpio GPIO number
  fn Which GPIO function select to use from list \ref gpio_function
*)
procedure gpio_set_function(gpio:TPinIdentifier; fn:TGPIOFunction); cdecl; external;

(*
  Get GPIO function
param:
  gpio GPIO number
*)
function gpio_get_function(gpio:TPinIdentifier):TGPIOFunction; cdecl; external;

(*
  Select up and down pulls on specific GPIO
param:
  gpio GPIO number
  up If true set a pull up on the GPIO
  down If true set a pull down on the GPIO
note:
  On the RP2040, setting both pulls enables a "bus keep" function,
  i.e. a weak pull to whatever is current high/low state of GPIO.
*)
procedure gpio_set_pulls(gpio:TPinIdentifier;const up,down:boolean); cdecl; external;

(*
  Set specified GPIO to be pulled up.
param:
  gpio GPIO number
*)
procedure gpio_pull_up(gpio:TPinIdentifier);

(*
  Determine if the specified GPIO is pulled up.
param:
  gpio GPIO number
return:
  return true if the GPIO is pulled up
*)
function gpio_is_pulled_up(gpio:TPinIdentifier):boolean;

(*
  Set specified GPIO to be pulled down.
param:
  gpio GPIO number
*)
procedure gpio_pull_down(gpio:TPinIdentifier);

(*
  Determine if the specified GPIO is pulled down.
param:
  gpio GPIO number
return:
  return true if the GPIO is pulled down
*)
function gpio_is_pulled_down(gpio:TPinIdentifier):boolean;

(*
  Disable pulls on specified GPIO
param:
  gpio GPIO number
*)
procedure gpio_disable_pulls(gpio:TPinIdentifier);

(*
  Set GPIO output override
param:
  gpio GPIO number
  value See gpio_override
*)
procedure gpio_set_outover(gpio:TPinIdentifier; value : longWord);cdecl; external;

(*
  Select GPIO input override
param:
  gpio GPIO number
  value See gpio_override
*)
procedure gpio_set_inover(gpio:TPinIdentifier; value : longWord);cdecl; external;

(*
  Select GPIO output enable override
param:
  gpio GPIO number
  value See gpio_override
*)
procedure gpio_set_oeover(gpio:TPinIdentifier; value : longWord);cdecl; external;

(*
  Enable GPIO input
param:
  gpio GPIO number
  enabled true to enable input on specified GPIO
*)
procedure gpio_set_input_enabled(gpio:TPinIdentifier; enabled:boolean);cdecl; external;

(*
  Enable or disable interrupts for specified GPIO
note:
  The IO IRQs are independent per-processor. This configures IRQs for
  the processor that calls the function.
param:
  gpio GPIO number
  events Which events will cause an interrupt
  enabled Enable or disable flag

  Events is a bitmask of the following:
  bit | interrupt
  ----|----------
    0 | Low level
    1 | High level
    2 | Edge low
    3 | Edge high
*)
procedure gpio_set_irq_enabled(gpio:TPinIdentifier; events : longWord; enabled:boolean);cdecl; external;

(*
  Enable interrupts for specified GPIO
note:
  The IO IRQs are independent per-processor. This configures IRQs for
  the processor that calls the function.
param:
  gpio GPIO number
  events Which events will cause an interrupt See \ref gpio_set_irq_enabled for details.
  enabled Enable or disable flag
  callback user function to call on GPIO irq. Note only one of these can be set per processor.
note:
  Currently the GPIO parameter is ignored, and this callback will be called for any enabled GPIO IRQ on any pin.
*)
procedure gpio_set_irq_enabled_with_callback(gpio:TPinIdentifier; events:longWord; enabled:boolean; callback : TGPIOIrq_callback);cdecl; external;

(*
  Enable dormant wake up interrupt for specified GPIO
  This configures IRQs to restart the XOSC or ROSC when they are
  disabled in dormant mode
param:
  gpio GPIO number
  events Which events will cause an interrupt. See \ref gpio_set_irq_enabled for details.
  enabled Enable/disable flag
 *)
procedure gpio_set_dormant_irq_enabled(gpio:TPinIdentifier; events:longWord;enabled:boolean);cdecl; external;

(*
  Acknowledge a GPIO interrupt
param:
  gpio GPIO number
  events Bitmask of events to clear. See \ref gpio_set_irq_enabled for details.
*)
procedure gpio_acknowledge_irq(gpio:TPinIdentifier;events:longWord);cdecl; external;

(*
  Initialise a GPIO for (enabled I/O and set func to GPIO_FUNC_SIO)
  Clear the output enable (i.e. set to input)
  Clear any output value.
param:
  gpio GPIO number
*)
procedure gpio_init(gpio:TPinIdentifier{GPIO number});cdecl; external;

(*
  Initialise multiple GPIOs (enabled I/O and set func to GPIO_FUNC_SIO)
  Clear the output enable (i.e. set to input)
  Clear any output value.
param:
  gpio_mask Mask with 1 bit per GPIO number to initialize
*)
procedure gpio_init_mask(gpio_mask : longWord);cdecl; external;

(*
  Get state of a single specified GPIO
param:
  gpio GPIO number
return:
  Current state of the GPIO. 0 for low, non-zero for high
*)
function gpio_get(gpio:TPinIdentifier):boolean;

(*
  Get raw value of all GPIOs
return:
  Bitmask of raw GPIO values, as bits 0-29
*)
function gpio_get_all():longWord;

(*
  Drive high every GPIO appearing in mask
param:
  mask Bitmask of GPIO values to set, as bits 0-29
*)
procedure gpio_set_mask(mask:longWord);

(*
  Drive low every GPIO appearing in mask
param:
  mask Bitmask of GPIO values to clear, as bits 0-29
*)
procedure gpio_clr_mask(mask : longWord);

(*
  Toggle every GPIO appearing in mask
param:
  mask Bitmask of GPIO values to toggle, as bits 0-29
*)
procedure gpio_xor_mask(mask:longWord);

(*
  Drive GPIO high/low depending on parameters
param:
  mask Bitmask of GPIO values to change, as bits 0-29
  value Value to set
note:
  For each 1 bit in \p mask, drive that pin to the value given by
  corresponding bit in \p value, leaving other pins unchanged.
  Since this uses the TOGL alias, it is concurrency-safe with e.g. an IRQ
  bashing different pins from the same core.
*)
procedure gpio_put_masked(mask:longWord; value:longWord);

(*
  Drive all pins simultaneously
param:
  value Bitmask of GPIO values to change, as bits 0-29
*)
procedure gpio_put_all(value:longWord);

(*
  Drive a single GPIO high/low
param:
  gpio GPIO number
  value If false clear the GPIO, otherwise set it.
*)
procedure gpio_put(gpio:TPinIdentifier; value:boolean);

(*
  Set a number of GPIOs to output
  Switch all GPIOs in "mask" to output
param:
  mask Bitmask of GPIO to set to output, as bits 0-29
*)
procedure gpio_set_dir_out_masked(mask:longWord);

(*
  Set a number of GPIOs to input
param:
  mask Bitmask of GPIO to set to input, as bits 0-29
*)
procedure gpio_set_dir_in_masked(mask:longWord);

(*
  Set multiple GPIO directions
param:
  mask Bitmask of GPIO to set to input, as bits 0-29
  value Values to set
note:
  For each 1 bit in "mask", switch that pin to the direction given by
  corresponding bit in "value", leaving other pins unchanged.
  E.g. gpio_set_dir_masked(0x3, 0x2); -> set pin 0 to input, pin 1 to output,
  simultaneously.
*)
procedure gpio_set_dir_masked(mask:longWord; value:longWord);

(*
  Set direction of all pins simultaneously.
param:
  values individual settings for each gpio; for GPIO N, bit N is 1 for out, 0 for in
*)
procedure gpio_set_dir_all_bits(values:longWord);

(*
  Set a single GPIO direction
param:
  gpio GPIO number
  out true for out, false for in
*)
procedure gpio_set_dir(gpio:TPinIdentifier; &out:TGPIODirection);

(*
  Check if a specific GPIO direction is OUT
param:
  gpio GPIO number
return:
  return true if the direction for the pin is OUT
*)
function gpio_is_dir_out(gpio:TPinIdentifier):boolean;

(*
  Get a specific GPIO direction
param:
gpio GPIO number
return:
  return 1 for out, 0 for in
*)
function gpio_get_dir(gpio:TPinIdentifier):TGPIODirection;

procedure gpio_debug_pins_init(); cdecl; external;

implementation

procedure gpio_pull_up(gpio:TPinIdentifier);
begin
  gpio_set_pulls(gpio, true, false);
end;

function gpio_is_pulled_up(gpio:TPinIdentifier):boolean;
begin
  result := (padsbank0.io[gpio]) and $08 <> 0;
end;

procedure gpio_pull_down(gpio:TPinIdentifier);
begin
  gpio_set_pulls(gpio, false, true);
end;

function gpio_is_pulled_down(gpio:TPinIdentifier):boolean;
begin
  result := (padsbank0.io[gpio]) and $04 <> 0;
end;

procedure gpio_disable_pulls(gpio:TPinIdentifier);
begin
  gpio_set_pulls(gpio, false, false);
end;

function gpio_get(gpio:TPinIdentifier):boolean;
begin
  result := (sio.gpio_in and (1 shl gpio)) <> 0;
end;

function gpio_get_all():longWord;
begin
  result := sio.gpio_in;
end;

procedure gpio_set_mask(mask:longWord);
begin
  sio.gpio_set := mask;
end;

procedure gpio_clr_mask(mask:longWord);
begin
  sio.gpio_clr := mask;
end;

procedure gpio_xor_mask(mask:longWord);
begin
  sio.gpio_togl := mask;
end;

procedure gpio_put_masked(mask:longWord; value:longWord);
begin
  sio.gpio_togl := (sio.gpio_out xor value) and mask;
end;

procedure gpio_put_all(value:longWord);
begin
  sio.gpio_out := value;
end;

procedure gpio_put(gpio:TPinIdentifier; value:boolean);
begin
  if value = true then
    gpio_set_mask(1 shl gpio)
  else
    gpio_clr_mask(1 shl gpio);
end;

procedure gpio_set_dir_out_masked(mask:longWord);
begin
  sio.gpio_oe_set := mask;
end;

procedure gpio_set_dir_in_masked(mask:longWord);
begin
  sio.gpio_oe_clr := mask;
end;

procedure gpio_set_dir_masked(mask:longWord; value:longWord);
begin
  sio.gpio_oe_togl := (sio.gpio_oe xor value) and mask;
end;

procedure gpio_set_dir_all_bits(values:longWord);
begin
  sio.gpio_oe := values;
end;

procedure gpio_set_dir(gpio:TPinIdentifier; &out:TGPIODirection);
begin
  if &out = TGPIODirection.GPIO_OUT then
    gpio_set_dir_out_masked(1 shl gpio)
  else
    gpio_set_dir_in_masked(1 shl gpio);
end;

function gpio_is_dir_out(gpio:TPinIdentifier):boolean;
begin
  result := sio.gpio_oe and (1 shl gpio) <> 0;
end;

function gpio_get_dir(gpio:TPinIdentifier):TGPIODirection;
begin
  result := TGPIODirection(gpio_is_dir_out(gpio));
end;

end.
