{Unit converted from unit stm32f10x.h}
unit STM32F10x_BitDefs;
interface

// {$DEFINE STM32F10X_LD}      // Low density devices
// {$DEFINE STM32F10X_LD_VL}   // Low density Value Line devices
 {$DEFINE STM32F10X_MD}      // Medium density devices
// {$DEFINE STM32F10X_MD_VL}   // Medium density Value Line devices
// {$DEFINE STM32F10X_HD}      // High density devices
// {$DEFINE STM32F10X_HD_VL}   // High density value line devices
// {$DEFINE STM32F10X_XL}      // XL-density devices
// {$DEFINE STM32F10X_CL}      // Connectivity line devices

CONST

{*
  ******************************************************************************
  * @file    stm32f10x.h
  * @author  MCD Application Team
  * @version V3.5.0
  * @date    11-March-2011
  * @brief   CMSIS Cortex-M3 Device Peripheral Access Layer Header File.
  *          This file contains all the peripheral register's definitions, bits
  *          definitions and memory mapping for STM32F10x Connectivity line,
  *          High density, High density value line, Medium density,
  *          Medium density Value line, Low density, Low density Value line
  *          and XL-density devices.
  *
  *          The file is the unique include file that the application programmer
  *          is using in the C source code, usually in main.c. This file contains:
  *           - Configuration section that allows to select:
  *              - The device used in the target application
  *              - To use or not the peripheral’s drivers in application code(i.e.
  *                code will be based on direct access to peripheral’s registers
  *                rather than drivers API), this option is controlled by
  *  = ;
  *              - To change few application-specific parameters such as the HSE
  *                crystal frequency
  *           - Data structures and the address mapping for all peripherals
  *           - Peripheral's registers declarations and bits definition
  *           - Macros to access peripheral’s registers hardware
  *
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  }


{****************************************************************************}
{                       Cortex-M3 Processor Exceptions Numbers               }
{****************************************************************************}

    NonMaskableInt_IRQn         = -14;    // 2 Non Maskable Interrupt
    MemoryManagement_IRQn       = -12;    // 4 Cortex-M3 Memory Management Interrupt
    BusFault_IRQn               = -11;    // 5 Cortex-M3 Bus Fault Interrupt
    UsageFault_IRQn             = -10;    // 6 Cortex-M3 Usage Fault Interrupt
    SVCall_IRQn                 = -5;     // 11 Cortex-M3 SV Call Interrupt
    DebugMonitor_IRQn           = -4;     // 12 Cortex-M3 Debug Monitor Interrupt
    PendSV_IRQn                 = -2;     // 14 Cortex-M3 Pend SV Interrupt
    SysTick_IRQn                = -1;     // 15 Cortex-M3 System Tick Interrupt

{****************************************************************************}
{                         STM32 specific Interrupt Numbers                   }
{****************************************************************************}

    WWDG_IRQn                   = 0;      // Window WatchDog Interrupt
    PVD_IRQn                    = 1;      // PVD through EXTI Line detection Interrupt
    TAMPER_IRQn                 = 2;      // Tamper Interrupt
    RTC_IRQn                    = 3;      // RTC global Interrupt
    FLASH_IRQn                  = 4;      // FLASH global Interrupt
    RCC_IRQn                    = 5;      // RCC global Interrupt
    EXTI0_IRQn                  = 6;      // EXTI Line0 Interrupt
    EXTI1_IRQn                  = 7;      // EXTI Line1 Interrupt
    EXTI2_IRQn                  = 8;      // EXTI Line2 Interrupt
    EXTI3_IRQn                  = 9;      // EXTI Line3 Interrupt
    EXTI4_IRQn                  = 10;     // EXTI Line4 Interrupt
    DMA1_Channel1_IRQn          = 11;     // DMA1 Channel 1 global Interrupt
    DMA1_Channel2_IRQn          = 12;     // DMA1 Channel 2 global Interrupt
    DMA1_Channel3_IRQn          = 13;     // DMA1 Channel 3 global Interrupt
    DMA1_Channel4_IRQn          = 14;     // DMA1 Channel 4 global Interrupt
    DMA1_Channel5_IRQn          = 15;     // DMA1 Channel 5 global Interrupt
    DMA1_Channel6_IRQn          = 16;     // DMA1 Channel 6 global Interrupt
    DMA1_Channel7_IRQn          = 17;     // DMA1 Channel 7 global Interrupt

  {$IFDEF STM32F10X_LD}
    ADC1_2_IRQn                 = 18;     // ADC1 and ADC2 global Interrupt
    USB_HP_CAN1_TX_IRQn         = 19;     // USB Device High Priority or CAN1 TX Interrupts
    USB_LP_CAN1_RX0_IRQn        = 20;     // USB Device Low Priority or CAN1 RX0 Interrupts
    CAN1_RX1_IRQn               = 21;     // CAN1 RX1 Interrupt
    CAN1_SCE_IRQn               = 22;     // CAN1 SCE Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_IRQn               = 24;     // TIM1 Break Interrupt
    TIM1_UP_IRQn                = 25;     // TIM1 Update Interrupt
    TIM1_TRG_COM_IRQn           = 26;     // TIM1 Trigger and Commutation Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    USBWakeUp_IRQn              = 42;     // USB Device WakeUp from suspend through EXTI Line Interrupt
  {$ENDIF} { STM32F10X_LD }

  {$IFDEF STM32F10X_LD_VL}
    ADC1_IRQn                   = 18;     // ADC1 global Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_TIM15_IRQn         = 24;     // TIM1 Break and TIM15 Interrupts
    TIM1_UP_TIM16_IRQn          = 25;     // TIM1 Update and TIM16 Interrupts
    TIM1_TRG_COM_TIM17_IRQn     = 26;     // TIM1 Trigger and Commutation and TIM17 Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    CEC_IRQn                    = 42;     // HDMI-CEC Interrupt
    TIM6_DAC_IRQn               = 54;     // TIM6 and DAC underrun Interrupt
    TIM7_IRQn                   = 55;     // TIM7 Interrupt
  {$ENDIF} { STM32F10X_LD_VL }

  {$IFDEF STM32F10X_MD}
    ADC1_2_IRQn                 = 18;     // ADC1 and ADC2 global Interrupt
    USB_HP_CAN1_TX_IRQn         = 19;     // USB Device High Priority or CAN1 TX Interrupts
    USB_LP_CAN1_RX0_IRQn        = 20;     // USB Device Low Priority or CAN1 RX0 Interrupts
    CAN1_RX1_IRQn               = 21;     // CAN1 RX1 Interrupt
    CAN1_SCE_IRQn               = 22;     // CAN1 SCE Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_IRQn               = 24;     // TIM1 Break Interrupt
    TIM1_UP_IRQn                = 25;     // TIM1 Update Interrupt
    TIM1_TRG_COM_IRQn           = 26;     // TIM1 Trigger and Commutation Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    TIM4_IRQn                   = 30;     // TIM4 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    I2C2_EV_IRQn                = 33;     // I2C2 Event Interrupt
    I2C2_ER_IRQn                = 34;     // I2C2 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    SPI2_IRQn                   = 36;     // SPI2 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    USART3_IRQn                 = 39;     // USART3 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    USBWakeUp_IRQn              = 42;     // USB Device WakeUp from suspend through EXTI Line Interrupt
  {$ENDIF} { STM32F10X_MD }

  {$IFDEF STM32F10X_MD_VL}
    ADC1_IRQn                   = 18;     // ADC1 global Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_TIM15_IRQn         = 24;     // TIM1 Break and TIM15 Interrupts
    TIM1_UP_TIM16_IRQn          = 25;     // TIM1 Update and TIM16 Interrupts
    TIM1_TRG_COM_TIM17_IRQn     = 26;     // TIM1 Trigger and Commutation and TIM17 Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    TIM4_IRQn                   = 30;     // TIM4 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    I2C2_EV_IRQn                = 33;     // I2C2 Event Interrupt
    I2C2_ER_IRQn                = 34;     // I2C2 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    SPI2_IRQn                   = 36;     // SPI2 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    USART3_IRQn                 = 39;     // USART3 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    CEC_IRQn                    = 42;     // HDMI-CEC Interrupt
    TIM6_DAC_IRQn               = 54;     // TIM6 and DAC underrun Interrupt
    TIM7_IRQn                   = 55;     // TIM7 Interrupt
  {$ENDIF} { STM32F10X_MD_VL }

  {$IFDEF STM32F10X_HD}
    ADC1_2_IRQn                 = 18;     // ADC1 and ADC2 global Interrupt
    USB_HP_CAN1_TX_IRQn         = 19;     // USB Device High Priority or CAN1 TX Interrupts
    USB_LP_CAN1_RX0_IRQn        = 20;     // USB Device Low Priority or CAN1 RX0 Interrupts
    CAN1_RX1_IRQn               = 21;     // CAN1 RX1 Interrupt
    CAN1_SCE_IRQn               = 22;     // CAN1 SCE Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_IRQn               = 24;     // TIM1 Break Interrupt
    TIM1_UP_IRQn                = 25;     // TIM1 Update Interrupt
    TIM1_TRG_COM_IRQn           = 26;     // TIM1 Trigger and Commutation Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    TIM4_IRQn                   = 30;     // TIM4 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    I2C2_EV_IRQn                = 33;     // I2C2 Event Interrupt
    I2C2_ER_IRQn                = 34;     // I2C2 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    SPI2_IRQn                   = 36;     // SPI2 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    USART3_IRQn                 = 39;     // USART3 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    USBWakeUp_IRQn              = 42;     // USB Device WakeUp from suspend through EXTI Line Interrupt
    TIM8_BRK_IRQn               = 43;     // TIM8 Break Interrupt
    TIM8_UP_IRQn                = 44;     // TIM8 Update Interrupt
    TIM8_TRG_COM_IRQn           = 45;     // TIM8 Trigger and Commutation Interrupt
    TIM8_CC_IRQn                = 46;     // TIM8 Capture Compare Interrupt
    ADC3_IRQn                   = 47;     // ADC3 global Interrupt
    FSMC_IRQn                   = 48;     // FSMC global Interrupt
    SDIO_IRQn                   = 49;     // SDIO global Interrupt
    TIM5_IRQn                   = 50;     // TIM5 global Interrupt
    SPI3_IRQn                   = 51;     // SPI3 global Interrupt
    UART4_IRQn                  = 52;     // UART4 global Interrupt
    UART5_IRQn                  = 53;     // UART5 global Interrupt
    TIM6_IRQn                   = 54;     // TIM6 global Interrupt
    TIM7_IRQn                   = 55;     // TIM7 global Interrupt
    DMA2_Channel1_IRQn          = 56;     // DMA2 Channel 1 global Interrupt
    DMA2_Channel2_IRQn          = 57;     // DMA2 Channel 2 global Interrupt
    DMA2_Channel3_IRQn          = 58;     // DMA2 Channel 3 global Interrupt
    DMA2_Channel4_5_IRQn        = 59;     // DMA2 Channel 4 and Channel 5 global Interrupt
  {$ENDIF} { STM32F10X_HD }

  {$IFDEF STM32F10X_HD_VL}
    ADC1_IRQn                   = 18;     // ADC1 global Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_TIM15_IRQn         = 24;     // TIM1 Break and TIM15 Interrupts
    TIM1_UP_TIM16_IRQn          = 25;     // TIM1 Update and TIM16 Interrupts
    TIM1_TRG_COM_TIM17_IRQn     = 26;     // TIM1 Trigger and Commutation and TIM17 Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    TIM4_IRQn                   = 30;     // TIM4 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    I2C2_EV_IRQn                = 33;     // I2C2 Event Interrupt
    I2C2_ER_IRQn                = 34;     // I2C2 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    SPI2_IRQn                   = 36;     // SPI2 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    USART3_IRQn                 = 39;     // USART3 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    CEC_IRQn                    = 42;     // HDMI-CEC Interrupt
    TIM12_IRQn                  = 43;     // TIM12 global Interrupt
    TIM13_IRQn                  = 44;     // TIM13 global Interrupt
    TIM14_IRQn                  = 45;     // TIM14 global Interrupt
    TIM5_IRQn                   = 50;     // TIM5 global Interrupt
    SPI3_IRQn                   = 51;     // SPI3 global Interrupt
    UART4_IRQn                  = 52;     // UART4 global Interrupt
    UART5_IRQn                  = 53;     // UART5 global Interrupt
    TIM6_DAC_IRQn               = 54;     // TIM6 and DAC underrun Interrupt
    TIM7_IRQn                   = 55;     // TIM7 Interrupt
    DMA2_Channel1_IRQn          = 56;     // DMA2 Channel 1 global Interrupt
    DMA2_Channel2_IRQn          = 57;     // DMA2 Channel 2 global Interrupt
    DMA2_Channel3_IRQn          = 58;     // DMA2 Channel 3 global Interrupt
    DMA2_Channel4_5_IRQn        = 59;     // DMA2 Channel 4 and Channel 5 global Interrupt
    DMA2_Channel5_IRQn          = 60;     // DMA2 Channel 5 global Interrupt (DMA2 Channel 5 is
                                               mapped at position 60 only if the MISC_REMAP bit in
                                               the AFIO_MAPR2 register is set)
  {$ENDIF} { STM32F10X_HD_VL }

  {$IFDEF STM32F10X_XL}
    ADC1_2_IRQn                 = 18;     // ADC1 and ADC2 global Interrupt
    USB_HP_CAN1_TX_IRQn         = 19;     // USB Device High Priority or CAN1 TX Interrupts
    USB_LP_CAN1_RX0_IRQn        = 20;     // USB Device Low Priority or CAN1 RX0 Interrupts
    CAN1_RX1_IRQn               = 21;     // CAN1 RX1 Interrupt
    CAN1_SCE_IRQn               = 22;     // CAN1 SCE Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_TIM9_IRQn          = 24;     // TIM1 Break Interrupt and TIM9 global Interrupt
    TIM1_UP_TIM10_IRQn          = 25;     // TIM1 Update Interrupt and TIM10 global Interrupt
    TIM1_TRG_COM_TIM11_IRQn     = 26;     // TIM1 Trigger and Commutation Interrupt and TIM11 global interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    TIM4_IRQn                   = 30;     // TIM4 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    I2C2_EV_IRQn                = 33;     // I2C2 Event Interrupt
    I2C2_ER_IRQn                = 34;     // I2C2 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    SPI2_IRQn                   = 36;     // SPI2 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    USART3_IRQn                 = 39;     // USART3 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    USBWakeUp_IRQn              = 42;     // USB Device WakeUp from suspend through EXTI Line Interrupt
    TIM8_BRK_TIM12_IRQn         = 43;     // TIM8 Break Interrupt and TIM12 global Interrupt
    TIM8_UP_TIM13_IRQn          = 44;     // TIM8 Update Interrupt and TIM13 global Interrupt
    TIM8_TRG_COM_TIM14_IRQn     = 45;     // TIM8 Trigger and Commutation Interrupt and TIM14 global interrupt
    TIM8_CC_IRQn                = 46;     // TIM8 Capture Compare Interrupt
    ADC3_IRQn                   = 47;     // ADC3 global Interrupt
    FSMC_IRQn                   = 48;     // FSMC global Interrupt
    SDIO_IRQn                   = 49;     // SDIO global Interrupt
    TIM5_IRQn                   = 50;     // TIM5 global Interrupt
    SPI3_IRQn                   = 51;     // SPI3 global Interrupt
    UART4_IRQn                  = 52;     // UART4 global Interrupt
    UART5_IRQn                  = 53;     // UART5 global Interrupt
    TIM6_IRQn                   = 54;     // TIM6 global Interrupt
    TIM7_IRQn                   = 55;     // TIM7 global Interrupt
    DMA2_Channel1_IRQn          = 56;     // DMA2 Channel 1 global Interrupt
    DMA2_Channel2_IRQn          = 57;     // DMA2 Channel 2 global Interrupt
    DMA2_Channel3_IRQn          = 58;     // DMA2 Channel 3 global Interrupt
    DMA2_Channel4_5_IRQn        = 59;     // DMA2 Channel 4 and Channel 5 global Interrupt
  {$ENDIF} { STM32F10X_XL }

  {$IFDEF STM32F10X_CL}
    ADC1_2_IRQn                 = 18;     // ADC1 and ADC2 global Interrupt
    CAN1_TX_IRQn                = 19;     // USB Device High Priority or CAN1 TX Interrupts
    CAN1_RX0_IRQn               = 20;     // USB Device Low Priority or CAN1 RX0 Interrupts
    CAN1_RX1_IRQn               = 21;     // CAN1 RX1 Interrupt
    CAN1_SCE_IRQn               = 22;     // CAN1 SCE Interrupt
    EXTI9_5_IRQn                = 23;     // External Line[9:5] Interrupts
    TIM1_BRK_IRQn               = 24;     // TIM1 Break Interrupt
    TIM1_UP_IRQn                = 25;     // TIM1 Update Interrupt
    TIM1_TRG_COM_IRQn           = 26;     // TIM1 Trigger and Commutation Interrupt
    TIM1_CC_IRQn                = 27;     // TIM1 Capture Compare Interrupt
    TIM2_IRQn                   = 28;     // TIM2 global Interrupt
    TIM3_IRQn                   = 29;     // TIM3 global Interrupt
    TIM4_IRQn                   = 30;     // TIM4 global Interrupt
    I2C1_EV_IRQn                = 31;     // I2C1 Event Interrupt
    I2C1_ER_IRQn                = 32;     // I2C1 Error Interrupt
    I2C2_EV_IRQn                = 33;     // I2C2 Event Interrupt
    I2C2_ER_IRQn                = 34;     // I2C2 Error Interrupt
    SPI1_IRQn                   = 35;     // SPI1 global Interrupt
    SPI2_IRQn                   = 36;     // SPI2 global Interrupt
    USART1_IRQn                 = 37;     // USART1 global Interrupt
    USART2_IRQn                 = 38;     // USART2 global Interrupt
    USART3_IRQn                 = 39;     // USART3 global Interrupt
    EXTI15_10_IRQn              = 40;     // External Line[15:10] Interrupts
    RTCAlarm_IRQn               = 41;     // RTC Alarm through EXTI Line Interrupt
    OTG_FS_WKUP_IRQn            = 42;     // USB OTG FS WakeUp from suspend through EXTI Line Interrupt
    TIM5_IRQn                   = 50;     // TIM5 global Interrupt
    SPI3_IRQn                   = 51;     // SPI3 global Interrupt
    UART4_IRQn                  = 52;     // UART4 global Interrupt
    UART5_IRQn                  = 53;     // UART5 global Interrupt
    TIM6_IRQn                   = 54;     // TIM6 global Interrupt
    TIM7_IRQn                   = 55;     // TIM7 global Interrupt
    DMA2_Channel1_IRQn          = 56;     // DMA2 Channel 1 global Interrupt
    DMA2_Channel2_IRQn          = 57;     // DMA2 Channel 2 global Interrupt
    DMA2_Channel3_IRQn          = 58;     // DMA2 Channel 3 global Interrupt
    DMA2_Channel4_IRQn          = 59;     // DMA2 Channel 4 global Interrupt
    DMA2_Channel5_IRQn          = 60;     // DMA2 Channel 5 global Interrupt
    ETH_IRQn                    = 61;     // Ethernet global Interrupt
    ETH_WKUP_IRQn               = 62;     // Ethernet Wakeup through EXTI line Interrupt
    CAN2_TX_IRQn                = 63;     // CAN2 TX Interrupt
    CAN2_RX0_IRQn               = 64;     // CAN2 RX0 Interrupt
    CAN2_RX1_IRQn               = 65;     // CAN2 RX1 Interrupt
    CAN2_SCE_IRQn               = 66;     // CAN2 SCE Interrupt
    OTG_FS_IRQn                 = 67;     // USB OTG FS global Interrupt
  {$ENDIF} { STM32F10X_CL }


{****************************************************************************}
{                         Peripheral Registers_Bits_Definition               }
{****************************************************************************}

{****************************************************************************}
{                                                                            }
{                          CRC calculation unit                              }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for CRC_DR register  ********************}
  CRC_DR_DR: uInt32  = $FFFFFFFF;  // Data register bits 


{******************  Bit definition for CRC_IDR register  *******************}
  CRC_IDR_IDR: uInt8  = $FF;  // General-purpose 8-bit data register bits 


{*******************  Bit definition for CRC_CR register  *******************}
  CRC_CR_RESET: uInt8  = $01;  // RESET bit 

{****************************************************************************}
{                                                                            }
{                             Power Control                                  }
{                                                                            }
{****************************************************************************}

{*******************  Bit definition for PWR_CR register  *******************}
  PWR_CR_LPDS: uInt16  = $0001;  // Low-Power Deepsleep 
  PWR_CR_PDDS: uInt16  = $0002;  // Power Down Deepsleep 
  PWR_CR_CWUF: uInt16  = $0004;  // Clear Wakeup Flag 
  PWR_CR_CSBF: uInt16  = $0008;  // Clear Standby Flag 
  PWR_CR_PVDE: uInt16  = $0010;  // Power Voltage Detector Enable 

  PWR_CR_PLS: uInt16  = $00E0;  // PLS[2:0] bits (PVD Level Selection) 
  PWR_CR_PLS_0: uInt16  = $0020;  // Bit 0 
  PWR_CR_PLS_1: uInt16  = $0040;  // Bit 1 
  PWR_CR_PLS_2: uInt16  = $0080;  // Bit 2 

{ PVD level configuration }
  PWR_CR_PLS_2V2: uInt16  = $0000;  // PVD level 2.2V 
  PWR_CR_PLS_2V3: uInt16  = $0020;  // PVD level 2.3V 
  PWR_CR_PLS_2V4: uInt16  = $0040;  // PVD level 2.4V 
  PWR_CR_PLS_2V5: uInt16  = $0060;  // PVD level 2.5V 
  PWR_CR_PLS_2V6: uInt16  = $0080;  // PVD level 2.6V 
  PWR_CR_PLS_2V7: uInt16  = $00A0;  // PVD level 2.7V 
  PWR_CR_PLS_2V8: uInt16  = $00C0;  // PVD level 2.8V 
  PWR_CR_PLS_2V9: uInt16  = $00E0;  // PVD level 2.9V 

  PWR_CR_DBP: uInt16  = $0100;  // Disable Backup Domain write protection 


{******************  Bit definition for PWR_CSR register  *******************}
  PWR_CSR_WUF: uInt16  = $0001;  // Wakeup Flag 
  PWR_CSR_SBF: uInt16  = $0002;  // Standby Flag 
  PWR_CSR_PVDO: uInt16  = $0004;  // PVD Output 
  PWR_CSR_EWUP: uInt16  = $0100;  // Enable WKUP pin 

{****************************************************************************}
{                                                                            }
{                            Backup registers                                }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for BKP_DR1 register  *******************}
  BKP_DR1_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR2 register  *******************}
  BKP_DR2_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR3 register  *******************}
  BKP_DR3_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR4 register  *******************}
  BKP_DR4_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR5 register  *******************}
  BKP_DR5_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR6 register  *******************}
  BKP_DR6_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR7 register  *******************}
  BKP_DR7_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR8 register  *******************}
  BKP_DR8_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR9 register  *******************}
  BKP_DR9_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR10 register  ******************}
  BKP_DR10_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR11 register  ******************}
  BKP_DR11_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR12 register  ******************}
  BKP_DR12_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR13 register  ******************}
  BKP_DR13_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR14 register  ******************}
  BKP_DR14_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR15 register  ******************}
  BKP_DR15_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR16 register  ******************}
  BKP_DR16_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR17 register  ******************}
  BKP_DR17_D: uInt16  = $FFFF;  // Backup data 

{*****************  Bit definition for BKP_DR18 register  *******************}
  BKP_DR18_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR19 register  ******************}
  BKP_DR19_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR20 register  ******************}
  BKP_DR20_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR21 register  ******************}
  BKP_DR21_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR22 register  ******************}
  BKP_DR22_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR23 register  ******************}
  BKP_DR23_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR24 register  ******************}
  BKP_DR24_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR25 register  ******************}
  BKP_DR25_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR26 register  ******************}
  BKP_DR26_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR27 register  ******************}
  BKP_DR27_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR28 register  ******************}
  BKP_DR28_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR29 register  ******************}
  BKP_DR29_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR30 register  ******************}
  BKP_DR30_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR31 register  ******************}
  BKP_DR31_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR32 register  ******************}
  BKP_DR32_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR33 register  ******************}
  BKP_DR33_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR34 register  ******************}
  BKP_DR34_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR35 register  ******************}
  BKP_DR35_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR36 register  ******************}
  BKP_DR36_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR37 register  ******************}
  BKP_DR37_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR38 register  ******************}
  BKP_DR38_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR39 register  ******************}
  BKP_DR39_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR40 register  ******************}
  BKP_DR40_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR41 register  ******************}
  BKP_DR41_D: uInt16  = $FFFF;  // Backup data 

{******************  Bit definition for BKP_DR42 register  ******************}
  BKP_DR42_D: uInt16  = $FFFF;  // Backup data 

{*****************  Bit definition for BKP_RTCCR register  ******************}
  BKP_RTCCR_CAL: uInt16  = $007F;  // Calibration value 
  BKP_RTCCR_CCO: uInt16  = $0080;  // Calibration Clock Output 
  BKP_RTCCR_ASOE: uInt16  = $0100;  // Alarm or Second Output Enable 
  BKP_RTCCR_ASOS: uInt16  = $0200;  // Alarm or Second Output Selection 

{*******************  Bit definition for BKP_CR register  *******************}
  BKP_CR_TPE: uInt8  = $01;  // TAMPER pin enable 
  BKP_CR_TPAL: uInt8  = $02;  // TAMPER pin active level 

{******************  Bit definition for BKP_CSR register  *******************}
  BKP_CSR_CTE: uInt16  = $0001;  // Clear Tamper event 
  BKP_CSR_CTI: uInt16  = $0002;  // Clear Tamper Interrupt 
  BKP_CSR_TPIE: uInt16  = $0004;  // TAMPER Pin interrupt enable 
  BKP_CSR_TEF: uInt16  = $0100;  // Tamper Event Flag 
  BKP_CSR_TIF: uInt16  = $0200;  // Tamper Interrupt Flag 

{****************************************************************************}
{                                                                            }
{                         Reset and Clock Control                            }
{                                                                            }
{****************************************************************************}

{*******************  Bit definition for RCC_CR register  *******************}
  RCC_CR_HSION: uInt32  = $00000001;  // Internal High Speed clock enable 
  RCC_CR_HSIRDY: uInt32  = $00000002;  // Internal High Speed clock ready flag 
  RCC_CR_HSITRIM: uInt32  = $000000F8;  // Internal High Speed clock trimming 
  RCC_CR_HSICAL: uInt32  = $0000FF00;  // Internal High Speed clock Calibration 
  RCC_CR_HSEON: uInt32  = $00010000;  // External High Speed clock enable 
  RCC_CR_HSERDY: uInt32  = $00020000;  // External High Speed clock ready flag 
  RCC_CR_HSEBYP: uInt32  = $00040000;  // External High Speed clock Bypass 
  RCC_CR_CSSON: uInt32  = $00080000;  // Clock Security System enable 
  RCC_CR_PLLON: uInt32  = $01000000;  // PLL enable 
  RCC_CR_PLLRDY: uInt32  = $02000000;  // PLL clock ready flag 

//{$IFDEF} STM32F10X_CL
  RCC_CR_PLL2ON: uInt32  = $04000000;  // PLL2 enable 
  RCC_CR_PLL2RDY: uInt32  = $08000000;  // PLL2 clock ready flag 
  RCC_CR_PLL3ON: uInt32  = $10000000;  // PLL3 enable 
  RCC_CR_PLL3RDY: uInt32  = $20000000;  // PLL3 clock ready flag 
//{$ENDIF} { STM32F10X_CL }

{******************  Bit definition for RCC_CFGR register  ******************}
{ SW configuration }
  RCC_CFGR_SW: uInt32  = $00000003;  // SW[1:0] bits (System clock Switch) 
  RCC_CFGR_SW_0: uInt32  = $00000001;  // Bit 0 
  RCC_CFGR_SW_1: uInt32  = $00000002;  // Bit 1 

  RCC_CFGR_SW_HSI: uInt32  = $00000000;  // HSI selected as system clock 
  RCC_CFGR_SW_HSE: uInt32  = $00000001;  // HSE selected as system clock 
  RCC_CFGR_SW_PLL: uInt32  = $00000002;  // PLL selected as system clock 

{ SWS configuration }
  RCC_CFGR_SWS: uInt32  = $0000000C;  // SWS[1:0] bits (System Clock Switch Status) 
  RCC_CFGR_SWS_0: uInt32  = $00000004;  // Bit 0 
  RCC_CFGR_SWS_1: uInt32  = $00000008;  // Bit 1 

  RCC_CFGR_SWS_HSI: uInt32  = $00000000;  // HSI oscillator used as system clock 
  RCC_CFGR_SWS_HSE: uInt32  = $00000004;  // HSE oscillator used as system clock 
  RCC_CFGR_SWS_PLL: uInt32  = $00000008;  // PLL used as system clock 

{ HPRE configuration }
  RCC_CFGR_HPRE: uInt32  = $000000F0;  // HPRE[3:0] bits (AHB prescaler) 
  RCC_CFGR_HPRE_0: uInt32  = $00000010;  // Bit 0 
  RCC_CFGR_HPRE_1: uInt32  = $00000020;  // Bit 1 
  RCC_CFGR_HPRE_2: uInt32  = $00000040;  // Bit 2 
  RCC_CFGR_HPRE_3: uInt32  = $00000080;  // Bit 3 

  RCC_CFGR_HPRE_DIV1: uInt32  = $00000000;  // SYSCLK not divided 
  RCC_CFGR_HPRE_DIV2: uInt32  = $00000080;  // SYSCLK divided by 2 
  RCC_CFGR_HPRE_DIV4: uInt32  = $00000090;  // SYSCLK divided by 4 
  RCC_CFGR_HPRE_DIV8: uInt32  = $000000A0;  // SYSCLK divided by 8 
  RCC_CFGR_HPRE_DIV16: uInt32  = $000000B0;  // SYSCLK divided by 16 
  RCC_CFGR_HPRE_DIV64: uInt32  = $000000C0;  // SYSCLK divided by 64 
  RCC_CFGR_HPRE_DIV128: uInt32  = $000000D0;  // SYSCLK divided by 128 
  RCC_CFGR_HPRE_DIV256: uInt32  = $000000E0;  // SYSCLK divided by 256 
  RCC_CFGR_HPRE_DIV512: uInt32  = $000000F0;  // SYSCLK divided by 512 

{ PPRE1 configuration }
  RCC_CFGR_PPRE1: uInt32  = $00000700;  // PRE1[2:0] bits (APB1 prescaler) 
  RCC_CFGR_PPRE1_0: uInt32  = $00000100;  // Bit 0 
  RCC_CFGR_PPRE1_1: uInt32  = $00000200;  // Bit 1 
  RCC_CFGR_PPRE1_2: uInt32  = $00000400;  // Bit 2 

  RCC_CFGR_PPRE1_DIV1: uInt32  = $00000000;  // HCLK not divided 
  RCC_CFGR_PPRE1_DIV2: uInt32  = $00000400;  // HCLK divided by 2 
  RCC_CFGR_PPRE1_DIV4: uInt32  = $00000500;  // HCLK divided by 4 
  RCC_CFGR_PPRE1_DIV8: uInt32  = $00000600;  // HCLK divided by 8 
  RCC_CFGR_PPRE1_DIV16: uInt32  = $00000700;  // HCLK divided by 16 

{ PPRE2 configuration }
  RCC_CFGR_PPRE2: uInt32  = $00003800;  // PRE2[2:0] bits (APB2 prescaler) 
  RCC_CFGR_PPRE2_0: uInt32  = $00000800;  // Bit 0 
  RCC_CFGR_PPRE2_1: uInt32  = $00001000;  // Bit 1 
  RCC_CFGR_PPRE2_2: uInt32  = $00002000;  // Bit 2 

  RCC_CFGR_PPRE2_DIV1: uInt32  = $00000000;  // HCLK not divided 
  RCC_CFGR_PPRE2_DIV2: uInt32  = $00002000;  // HCLK divided by 2 
  RCC_CFGR_PPRE2_DIV4: uInt32  = $00002800;  // HCLK divided by 4 
  RCC_CFGR_PPRE2_DIV8: uInt32  = $00003000;  // HCLK divided by 8 
  RCC_CFGR_PPRE2_DIV16: uInt32  = $00003800;  // HCLK divided by 16 

{ ADCPPRE configuration }
  RCC_CFGR_ADCPRE: uInt32  = $0000C000;  // ADCPRE[1:0] bits (ADC prescaler) 
  RCC_CFGR_ADCPRE_0: uInt32  = $00004000;  // Bit 0 
  RCC_CFGR_ADCPRE_1: uInt32  = $00008000;  // Bit 1 

  RCC_CFGR_ADCPRE_DIV2: uInt32  = $00000000;  // PCLK2 divided by 2 
  RCC_CFGR_ADCPRE_DIV4: uInt32  = $00004000;  // PCLK2 divided by 4 
  RCC_CFGR_ADCPRE_DIV6: uInt32  = $00008000;  // PCLK2 divided by 6 
  RCC_CFGR_ADCPRE_DIV8: uInt32  = $0000C000;  // PCLK2 divided by 8 

  RCC_CFGR_PLLSRC: uInt32  = $00010000;  // PLL entry clock source 

  RCC_CFGR_PLLXTPRE: uInt32  = $00020000;  // HSE divider for PLL entry 

{ PLLMUL configuration }
  RCC_CFGR_PLLMULL: uInt32  = $003C0000;  // PLLMUL[3:0] bits (PLL multiplication factor) 
  RCC_CFGR_PLLMULL_0: uInt32  = $00040000;  // Bit 0 
  RCC_CFGR_PLLMULL_1: uInt32  = $00080000;  // Bit 1 
  RCC_CFGR_PLLMULL_2: uInt32  = $00100000;  // Bit 2 
  RCC_CFGR_PLLMULL_3: uInt32  = $00200000;  // Bit 3 

{$IF defined(STM32F10X_CL)}
  RCC_CFGR_PLLSRC_HSI_Div2: uInt32  = $00000000;  // HSI clock divided by 2 selected as PLL entry clock source 
  RCC_CFGR_PLLSRC_PREDIV1: uInt32  = $00010000;  // PREDIV1 clock selected as PLL entry clock source 

  RCC_CFGR_PLLXTPRE_PREDIV1: uInt32  = $00000000;  // PREDIV1 clock not divided for PLL entry 
  RCC_CFGR_PLLXTPRE_PREDIV1_Div2: uInt32  = $00020000;  // PREDIV1 clock divided by 2 for PLL entry 

  RCC_CFGR_PLLMULL4: uInt32  = $00080000;  // PLL input clock * 4 
  RCC_CFGR_PLLMULL5: uInt32  = $000C0000;  // PLL input clock * 5 
  RCC_CFGR_PLLMULL6: uInt32  = $00100000;  // PLL input clock * 6 
  RCC_CFGR_PLLMULL7: uInt32  = $00140000;  // PLL input clock * 7 
  RCC_CFGR_PLLMULL8: uInt32  = $00180000;  // PLL input clock * 8 
  RCC_CFGR_PLLMULL9: uInt32  = $001C0000;  // PLL input clock * 9 
  RCC_CFGR_PLLMULL6_5: uInt32  = $00340000;  // PLL input clock * 6.5 

  RCC_CFGR_OTGFSPRE: uInt32  = $00400000;  // USB OTG FS prescaler 

{ MCO configuration }
  RCC_CFGR_MCO: uInt32  = $0F000000;  // MCO[3:0] bits (Microcontroller Clock Output) 
  RCC_CFGR_MCO_0: uInt32  = $01000000;  // Bit 0 
  RCC_CFGR_MCO_1: uInt32  = $02000000;  // Bit 1 
  RCC_CFGR_MCO_2: uInt32  = $04000000;  // Bit 2 
  RCC_CFGR_MCO_3: uInt32  = $08000000;  // Bit 3 

  RCC_CFGR_MCO_NOCLOCK: uInt32  = $00000000;  // No clock 
  RCC_CFGR_MCO_SYSCLK: uInt32  = $04000000;  // System clock selected as MCO source 
  RCC_CFGR_MCO_HSI: uInt32  = $05000000;  // HSI clock selected as MCO source 
  RCC_CFGR_MCO_HSE: uInt32  = $06000000;  // HSE clock selected as MCO source 
  RCC_CFGR_MCO_PLLCLK_Div2: uInt32  = $07000000;  // PLL clock divided by 2 selected as MCO source 
  RCC_CFGR_MCO_PLL2CLK: uInt32  = $08000000;  // PLL2 clock selected as MCO source
  RCC_CFGR_MCO_PLL3CLK_Div2: uInt32  = $09000000;  // PLL3 clock divided by 2 selected as MCO source
  RCC_CFGR_MCO_Ext_HSE: uInt32  = $0A000000;  // XT1 external 3-25 MHz oscillator clock selected as MCO source 
  RCC_CFGR_MCO_PLL3CLK: uInt32  = $0B000000;  // PLL3 clock selected as MCO source 
{$ELSEIF defined(STM32F10X_LD_VL) or defined(STM32F10X_MD_VL) or defined(STM32F10X_HD_VL)}
  RCC_CFGR_PLLSRC_HSI_Div2: uInt32  = $00000000;  // HSI clock divided by 2 selected as PLL entry clock source
  RCC_CFGR_PLLSRC_PREDIV1: uInt32  = $00010000;  // PREDIV1 clock selected as PLL entry clock source 

  RCC_CFGR_PLLXTPRE_PREDIV1: uInt32  = $00000000;  // PREDIV1 clock not divided for PLL entry 
  RCC_CFGR_PLLXTPRE_PREDIV1_Div2: uInt32  = $00020000;  // PREDIV1 clock divided by 2 for PLL entry 

  RCC_CFGR_PLLMULL2: uInt32  = $00000000;  // PLL input clock*2 
  RCC_CFGR_PLLMULL3: uInt32  = $00040000;  // PLL input clock*3 
  RCC_CFGR_PLLMULL4: uInt32  = $00080000;  // PLL input clock*4 
  RCC_CFGR_PLLMULL5: uInt32  = $000C0000;  // PLL input clock*5 
  RCC_CFGR_PLLMULL6: uInt32  = $00100000;  // PLL input clock*6 
  RCC_CFGR_PLLMULL7: uInt32  = $00140000;  // PLL input clock*7 
  RCC_CFGR_PLLMULL8: uInt32  = $00180000;  // PLL input clock*8 
  RCC_CFGR_PLLMULL9: uInt32  = $001C0000;  // PLL input clock*9 
  RCC_CFGR_PLLMULL10: uInt32  = $00200000;  // PLL input clock10 
  RCC_CFGR_PLLMULL11: uInt32  = $00240000;  // PLL input clock*11 
  RCC_CFGR_PLLMULL12: uInt32  = $00280000;  // PLL input clock*12 
  RCC_CFGR_PLLMULL13: uInt32  = $002C0000;  // PLL input clock*13 
  RCC_CFGR_PLLMULL14: uInt32  = $00300000;  // PLL input clock*14 
  RCC_CFGR_PLLMULL15: uInt32  = $00340000;  // PLL input clock*15 
  RCC_CFGR_PLLMULL16: uInt32  = $00380000;  // PLL input clock*16 

{ MCO configuration }
  RCC_CFGR_MCO: uInt32  = $07000000;  // MCO[2:0] bits (Microcontroller Clock Output) 
  RCC_CFGR_MCO_0: uInt32  = $01000000;  // Bit 0 
  RCC_CFGR_MCO_1: uInt32  = $02000000;  // Bit 1 
  RCC_CFGR_MCO_2: uInt32  = $04000000;  // Bit 2 

  RCC_CFGR_MCO_NOCLOCK: uInt32  = $00000000;  // No clock 
  RCC_CFGR_MCO_SYSCLK: uInt32  = $04000000;  // System clock selected as MCO source 
  RCC_CFGR_MCO_HSI: uInt32  = $05000000;  // HSI clock selected as MCO source 
  RCC_CFGR_MCO_HSE: uInt32  = $06000000;  // HSE clock selected as MCO source  
  RCC_CFGR_MCO_PLL: uInt32  = $07000000;  // PLL clock divided by 2 selected as MCO source 
{$ELSE}
  RCC_CFGR_PLLSRC_HSI_Div2: uInt32  = $00000000;  // HSI clock divided by 2 selected as PLL entry clock source 
  RCC_CFGR_PLLSRC_HSE: uInt32  = $00010000;  // HSE clock selected as PLL entry clock source 

  RCC_CFGR_PLLXTPRE_HSE: uInt32  = $00000000;  // HSE clock not divided for PLL entry 
  RCC_CFGR_PLLXTPRE_HSE_Div2: uInt32  = $00020000;  // HSE clock divided by 2 for PLL entry 

  RCC_CFGR_PLLMULL2: uInt32  = $00000000;  // PLL input clock*2 
  RCC_CFGR_PLLMULL3: uInt32  = $00040000;  // PLL input clock*3 
  RCC_CFGR_PLLMULL4: uInt32  = $00080000;  // PLL input clock*4 
  RCC_CFGR_PLLMULL5: uInt32  = $000C0000;  // PLL input clock*5 
  RCC_CFGR_PLLMULL6: uInt32  = $00100000;  // PLL input clock*6 
  RCC_CFGR_PLLMULL7: uInt32  = $00140000;  // PLL input clock*7 
  RCC_CFGR_PLLMULL8: uInt32  = $00180000;  // PLL input clock*8 
  RCC_CFGR_PLLMULL9: uInt32  = $001C0000;  // PLL input clock*9 
  RCC_CFGR_PLLMULL10: uInt32  = $00200000;  // PLL input clock10 
  RCC_CFGR_PLLMULL11: uInt32  = $00240000;  // PLL input clock*11 
  RCC_CFGR_PLLMULL12: uInt32  = $00280000;  // PLL input clock*12 
  RCC_CFGR_PLLMULL13: uInt32  = $002C0000;  // PLL input clock*13 
  RCC_CFGR_PLLMULL14: uInt32  = $00300000;  // PLL input clock*14 
  RCC_CFGR_PLLMULL15: uInt32  = $00340000;  // PLL input clock*15 
  RCC_CFGR_PLLMULL16: uInt32  = $00380000;  // PLL input clock*16 
  RCC_CFGR_USBPRE: uInt32  = $00400000;  // USB Device prescaler 

{ MCO configuration }
  RCC_CFGR_MCO: uInt32  = $07000000;  // MCO[2:0] bits (Microcontroller Clock Output) 
  RCC_CFGR_MCO_0: uInt32  = $01000000;  // Bit 0 
  RCC_CFGR_MCO_1: uInt32  = $02000000;  // Bit 1 
  RCC_CFGR_MCO_2: uInt32  = $04000000;  // Bit 2 

  RCC_CFGR_MCO_NOCLOCK: uInt32  = $00000000;  // No clock 
  RCC_CFGR_MCO_SYSCLK: uInt32  = $04000000;  // System clock selected as MCO source 
  RCC_CFGR_MCO_HSI: uInt32  = $05000000;  // HSI clock selected as MCO source 
  RCC_CFGR_MCO_HSE: uInt32  = $06000000;  // HSE clock selected as MCO source  
  RCC_CFGR_MCO_PLL: uInt32  = $07000000;  // PLL clock divided by 2 selected as MCO source 
{$ENDIF} { STM32F10X_CL }

{******************  Bit definition for RCC_CIR register  *******************}
  RCC_CIR_LSIRDYF: uInt32  = $00000001;  // LSI Ready Interrupt flag 
  RCC_CIR_LSERDYF: uInt32  = $00000002;  // LSE Ready Interrupt flag 
  RCC_CIR_HSIRDYF: uInt32  = $00000004;  // HSI Ready Interrupt flag 
  RCC_CIR_HSERDYF: uInt32  = $00000008;  // HSE Ready Interrupt flag 
  RCC_CIR_PLLRDYF: uInt32  = $00000010;  // PLL Ready Interrupt flag 
  RCC_CIR_CSSF: uInt32  = $00000080;  // Clock Security System Interrupt flag 
  RCC_CIR_LSIRDYIE: uInt32  = $00000100;  // LSI Ready Interrupt Enable 
  RCC_CIR_LSERDYIE: uInt32  = $00000200;  // LSE Ready Interrupt Enable 
  RCC_CIR_HSIRDYIE: uInt32  = $00000400;  // HSI Ready Interrupt Enable 
  RCC_CIR_HSERDYIE: uInt32  = $00000800;  // HSE Ready Interrupt Enable 
  RCC_CIR_PLLRDYIE: uInt32  = $00001000;  // PLL Ready Interrupt Enable 
  RCC_CIR_LSIRDYC: uInt32  = $00010000;  // LSI Ready Interrupt Clear 
  RCC_CIR_LSERDYC: uInt32  = $00020000;  // LSE Ready Interrupt Clear 
  RCC_CIR_HSIRDYC: uInt32  = $00040000;  // HSI Ready Interrupt Clear 
  RCC_CIR_HSERDYC: uInt32  = $00080000;  // HSE Ready Interrupt Clear 
  RCC_CIR_PLLRDYC: uInt32  = $00100000;  // PLL Ready Interrupt Clear 
  RCC_CIR_CSSC: uInt32  = $00800000;  // Clock Security System Interrupt Clear 

{$IFDEF STM32F10X_CL}
  RCC_CIR_PLL2RDYF: uInt32  = $00000020;  // PLL2 Ready Interrupt flag 
  RCC_CIR_PLL3RDYF: uInt32  = $00000040;  // PLL3 Ready Interrupt flag 
  RCC_CIR_PLL2RDYIE: uInt32  = $00002000;  // PLL2 Ready Interrupt Enable 
  RCC_CIR_PLL3RDYIE: uInt32  = $00004000;  // PLL3 Ready Interrupt Enable 
  RCC_CIR_PLL2RDYC: uInt32  = $00200000;  // PLL2 Ready Interrupt Clear 
  RCC_CIR_PLL3RDYC: uInt32  = $00400000;  // PLL3 Ready Interrupt Clear 
{$ENDIF} { STM32F10X_CL }

{****************  Bit definition for RCC_APB2RSTR register  ****************}
  RCC_APB2RSTR_AFIORST: uInt32  = $00000001;  // Alternate Function I/O reset 
  RCC_APB2RSTR_IOPARST: uInt32  = $00000004;  // I/O port A reset 
  RCC_APB2RSTR_IOPBRST: uInt32  = $00000008;  // I/O port B reset 
  RCC_APB2RSTR_IOPCRST: uInt32  = $00000010;  // I/O port C reset 
  RCC_APB2RSTR_IOPDRST: uInt32  = $00000020;  // I/O port D reset 
  RCC_APB2RSTR_ADC1RST: uInt32  = $00000200;  // ADC 1 interface reset 

{$IF not defined(STM32F10X_LD_VL) and not defined(STM32F10X_MD_VL) and not defined(STM32F10X_HD_VL)}
  RCC_APB2RSTR_ADC2RST: uInt32  = $00000400;  // ADC 2 interface reset 
{$ENDIF}

  RCC_APB2RSTR_TIM1RST: uInt32  = $00000800;  // TIM1 Timer reset 
  RCC_APB2RSTR_SPI1RST: uInt32  = $00001000;  // SPI 1 reset 
  RCC_APB2RSTR_USART1RST: uInt32  = $00004000;  // USART1 reset 

{$IF defined(STM32F10X_LD_VL) or defined(STM32F10X_MD_VL) or defined(STM32F10X_HD_VL)}
  RCC_APB2RSTR_TIM15RST: uInt32  = $00010000;  // TIM15 Timer reset 
  RCC_APB2RSTR_TIM16RST: uInt32  = $00020000;  // TIM16 Timer reset 
  RCC_APB2RSTR_TIM17RST: uInt32  = $00040000;  // TIM17 Timer reset 
{$ENDIF}

{$IF not defined (STM32F10X_LD) and not defined(STM32F10X_LD_VL)}
  RCC_APB2RSTR_IOPERST: uInt32  = $00000040;  // I/O port E reset 
{$ENDIF} { STM32F10X_LD && STM32F10X_LD_VL }

{$IF defined(STM32F10X_HD) or defined(STM32F10X_XL)}
  RCC_APB2RSTR_IOPFRST: uInt32  = $00000080;  // I/O port F reset 
  RCC_APB2RSTR_IOPGRST: uInt32  = $00000100;  // I/O port G reset 
  RCC_APB2RSTR_TIM8RST: uInt32  = $00002000;  // TIM8 Timer reset 
  RCC_APB2RSTR_ADC3RST: uInt32  = $00008000;  // ADC3 interface reset 
{$ENDIF}

{$IF defined(STM32F10X_HD_VL)}
  RCC_APB2RSTR_IOPFRST: uInt32  = $00000080;  // I/O port F reset 
  RCC_APB2RSTR_IOPGRST: uInt32  = $00000100;  // I/O port G reset 
{$ENDIF}

{$IFDEF STM32F10X_XL}
  RCC_APB2RSTR_TIM9RST: uInt32  = $00080000;  // TIM9 Timer reset 
  RCC_APB2RSTR_TIM10RST: uInt32  = $00100000;  // TIM10 Timer reset 
  RCC_APB2RSTR_TIM11RST: uInt32  = $00200000;  // TIM11 Timer reset 
{$ENDIF} { STM32F10X_XL }

{****************  Bit definition for RCC_APB1RSTR register  ****************}
  RCC_APB1RSTR_TIM2RST: uInt32  = $00000001;  // Timer 2 reset 
  RCC_APB1RSTR_TIM3RST: uInt32  = $00000002;  // Timer 3 reset 
  RCC_APB1RSTR_WWDGRST: uInt32  = $00000800;  // Window Watchdog reset 
  RCC_APB1RSTR_USART2RST: uInt32  = $00020000;  // USART 2 reset 
  RCC_APB1RSTR_I2C1RST: uInt32  = $00200000;  // I2C 1 reset 

{$IF not defined(STM32F10X_LD_VL) and not defined(STM32F10X_MD_VL) and not defined(STM32F10X_HD_VL)}
  RCC_APB1RSTR_CAN1RST: uInt32  = $02000000;  // CAN1 reset 
{$ENDIF}

  RCC_APB1RSTR_BKPRST: uInt32  = $08000000;  // Backup interface reset 
  RCC_APB1RSTR_PWRRST: uInt32  = $10000000;  // Power interface reset 

{$IF not defined(STM32F10X_LD) and not defined(STM32F10X_LD_VL)}
  RCC_APB1RSTR_TIM4RST: uInt32  = $00000004;  // Timer 4 reset 
  RCC_APB1RSTR_SPI2RST: uInt32  = $00004000;  // SPI 2 reset 
  RCC_APB1RSTR_USART3RST: uInt32  = $00040000;  // USART 3 reset 
  RCC_APB1RSTR_I2C2RST: uInt32  = $00400000;  // I2C 2 reset 
{$ENDIF} { STM32F10X_LD && STM32F10X_LD_VL }

{$IF defined (STM32F10X_HD) or defined (STM32F10X_MD) or defined (STM32F10X_LD) or defined  (STM32F10X_XL)}
  RCC_APB1RSTR_USBRST: uInt32  = $00800000;  // USB Device reset 
{$ENDIF}

{$IF defined (STM32F10X_HD) or defined  (STM32F10X_CL) or defined  (STM32F10X_XL)}
  RCC_APB1RSTR_TIM5RST: uInt32  = $00000008;  // Timer 5 reset 
  RCC_APB1RSTR_TIM6RST: uInt32  = $00000010;  // Timer 6 reset 
  RCC_APB1RSTR_TIM7RST: uInt32  = $00000020;  // Timer 7 reset 
  RCC_APB1RSTR_SPI3RST: uInt32  = $00008000;  // SPI 3 reset 
  RCC_APB1RSTR_UART4RST: uInt32  = $00080000;  // UART 4 reset 
  RCC_APB1RSTR_UART5RST: uInt32  = $00100000;  // UART 5 reset 
  RCC_APB1RSTR_DACRST: uInt32  = $20000000;  // DAC interface reset 
{$ENDIF}

{$IF defined (STM32F10X_LD_VL) or defined  (STM32F10X_MD_VL) or defined (STM32F10X_HD_VL)}
  RCC_APB1RSTR_TIM6RST: uInt32  = $00000010;  // Timer 6 reset 
  RCC_APB1RSTR_TIM7RST: uInt32  = $00000020;  // Timer 7 reset 
  RCC_APB1RSTR_DACRST: uInt32  = $20000000;  // DAC interface reset 
  RCC_APB1RSTR_CECRST: uInt32  = $40000000;  // CEC interface reset 
{$ENDIF}

{$IF defined (STM32F10X_HD_VL)}
  RCC_APB1RSTR_TIM5RST: uInt32  = $00000008;  // Timer 5 reset 
  RCC_APB1RSTR_TIM12RST: uInt32  = $00000040;  // TIM12 Timer reset 
  RCC_APB1RSTR_TIM13RST: uInt32  = $00000080;  // TIM13 Timer reset 
  RCC_APB1RSTR_TIM14RST: uInt32  = $00000100;  // TIM14 Timer reset 
  RCC_APB1RSTR_SPI3RST: uInt32  = $00008000;  // SPI 3 reset 
  RCC_APB1RSTR_UART4RST: uInt32  = $00080000;  // UART 4 reset 
  RCC_APB1RSTR_UART5RST: uInt32  = $00100000;  // UART 5 reset 
{$ENDIF}

{$IFDEF STM32F10X_CL}
  RCC_APB1RSTR_CAN2RST: uInt32  = $04000000;  // CAN2 reset 
{$ENDIF} { STM32F10X_CL }

{$IFDEF STM32F10X_XL}
  RCC_APB1RSTR_TIM12RST: uInt32  = $00000040;  // TIM12 Timer reset 
  RCC_APB1RSTR_TIM13RST: uInt32  = $00000080;  // TIM13 Timer reset 
  RCC_APB1RSTR_TIM14RST: uInt32  = $00000100;  // TIM14 Timer reset 
{$ENDIF} { STM32F10X_XL }

{*****************  Bit definition for RCC_AHBENR register  *****************}
  RCC_AHBENR_DMA1EN: uInt16  = $0001;  // DMA1 clock enable 
  RCC_AHBENR_SRAMEN: uInt16  = $0004;  // SRAM interface clock enable 
  RCC_AHBENR_FLITFEN: uInt16  = $0010;  // FLITF clock enable 
  RCC_AHBENR_CRCEN: uInt16  = $0040;  // CRC clock enable 

{$IF defined (STM32F10X_HD) or defined  (STM32F10X_CL) or defined  (STM32F10X_HD_VL)}
  RCC_AHBENR_DMA2EN: uInt16  = $0002;  // DMA2 clock enable 
{$ENDIF}

{$IF defined (STM32F10X_HD) or defined (STM32F10X_XL)}
  RCC_AHBENR_FSMCEN: uInt16  = $0100;  // FSMC clock enable 
  RCC_AHBENR_SDIOEN: uInt16  = $0400;  // SDIO clock enable 
{$ENDIF}

{$IF defined (STM32F10X_HD_VL)}
  RCC_AHBENR_FSMCEN: uInt16  = $0100;  // FSMC clock enable 
{$ENDIF}

{$IFDEF STM32F10X_CL}
  RCC_AHBENR_OTGFSEN: uInt32  = $00001000;  // USB OTG FS clock enable 
  RCC_AHBENR_ETHMACEN: uInt32  = $00004000;  // ETHERNET MAC clock enable 
  RCC_AHBENR_ETHMACTXEN: uInt32  = $00008000;  // ETHERNET MAC Tx clock enable 
  RCC_AHBENR_ETHMACRXEN: uInt32  = $00010000;  // ETHERNET MAC Rx clock enable 
{$ENDIF} { STM32F10X_CL }

{*****************  Bit definition for RCC_APB2ENR register  ****************}
  RCC_APB2ENR_AFIOEN: uInt32  = $00000001;  // Alternate Function I/O clock enable 
  RCC_APB2ENR_GPIOAEN: uInt32  = $00000004;  // I/O port A clock enable
  RCC_APB2ENR_GPIOBEN: uInt32  = $00000008;  // I/O port B clock enable
  RCC_APB2ENR_GPIOCEN: uInt32  = $00000010;  // I/O port C clock enable
  RCC_APB2ENR_GPIODEN: uInt32  = $00000020;  // I/O port D clock enable
  RCC_APB2ENR_ADC1EN: uInt32  = $00000200;  // ADC 1 interface clock enable 

{$IF not defined (STM32F10X_LD_VL) and not defined (STM32F10X_MD_VL) and not defined (STM32F10X_HD_VL)}
  RCC_APB2ENR_ADC2EN: uInt32  = $00000400;  // ADC 2 interface clock enable 
{$ENDIF}

  RCC_APB2ENR_TIM1EN: uInt32  = $00000800;  // TIM1 Timer clock enable 
  RCC_APB2ENR_SPI1EN: uInt32  = $00001000;  // SPI 1 clock enable 
  RCC_APB2ENR_USART1EN: uInt32  = $00004000;  // USART1 clock enable 

{$IF defined (STM32F10X_LD_VL) or defined (STM32F10X_MD_VL) or defined (STM32F10X_HD_VL)}
  RCC_APB2ENR_TIM15EN: uInt32  = $00010000;  // TIM15 Timer clock enable 
  RCC_APB2ENR_TIM16EN: uInt32  = $00020000;  // TIM16 Timer clock enable 
  RCC_APB2ENR_TIM17EN: uInt32  = $00040000;  // TIM17 Timer clock enable 
{$ENDIF}

{$IF not defined (STM32F10X_LD) and not defined (STM32F10X_LD_VL)}
  RCC_APB2ENR_IOPEEN: uInt32  = $00000040;  // I/O port E clock enable 
{$ENDIF} { STM32F10X_LD && STM32F10X_LD_VL }

{$IF defined (STM32F10X_HD) or defined (STM32F10X_XL)}
  RCC_APB2ENR_IOPFEN: uInt32  = $00000080;  // I/O port F clock enable 
  RCC_APB2ENR_IOPGEN: uInt32  = $00000100;  // I/O port G clock enable 
  RCC_APB2ENR_TIM8EN: uInt32  = $00002000;  // TIM8 Timer clock enable 
  RCC_APB2ENR_ADC3EN: uInt32  = $00008000;  // DMA1 clock enable 
{$ENDIF}

{$IF defined (STM32F10X_HD_VL)}
  RCC_APB2ENR_IOPFEN: uInt32  = $00000080;  // I/O port F clock enable 
  RCC_APB2ENR_IOPGEN: uInt32  = $00000100;  // I/O port G clock enable 
{$ENDIF}

{$IFDEF STM32F10X_XL}
  RCC_APB2ENR_TIM9EN: uInt32  = $00080000;  // TIM9 Timer clock enable  
  RCC_APB2ENR_TIM10EN: uInt32  = $00100000;  // TIM10 Timer clock enable  
  RCC_APB2ENR_TIM11EN: uInt32  = $00200000;  // TIM11 Timer clock enable 
{$ENDIF}

{****************  Bit definition for RCC_APB1ENR register  *****************}
  RCC_APB1ENR_TIM2EN: uInt32  = $00000001;  // Timer 2 clock enable
  RCC_APB1ENR_TIM3EN: uInt32  = $00000002;  // Timer 3 clock enable 
  RCC_APB1ENR_WWDGEN: uInt32  = $00000800;  // Window Watchdog clock enable 
  RCC_APB1ENR_USART2EN: uInt32  = $00020000;  // USART 2 clock enable 
  RCC_APB1ENR_I2C1EN: uInt32  = $00200000;  // I2C 1 clock enable 

{$IF not defined (STM32F10X_LD_VL) and not defined (STM32F10X_MD_VL) and not defined (STM32F10X_HD_VL)}
  RCC_APB1ENR_CAN1EN: uInt32  = $02000000;  // CAN1 clock enable 
{$ENDIF}

  RCC_APB1ENR_BKPEN: uInt32  = $08000000;  // Backup interface clock enable 
  RCC_APB1ENR_PWREN: uInt32  = $10000000;  // Power interface clock enable 

{$IF not defined (STM32F10X_LD) and not defined (STM32F10X_LD_VL)}
  RCC_APB1ENR_TIM4EN: uInt32  = $00000004;  // Timer 4 clock enable 
  RCC_APB1ENR_SPI2EN: uInt32  = $00004000;  // SPI 2 clock enable 
  RCC_APB1ENR_USART3EN: uInt32  = $00040000;  // USART 3 clock enable 
  RCC_APB1ENR_I2C2EN: uInt32  = $00400000;  // I2C 2 clock enable 
{$ENDIF} { STM32F10X_LD && STM32F10X_LD_VL }

{$IF defined (STM32F10X_HD) or defined (STM32F10X_MD) or defined  (STM32F10X_LD)}
  RCC_APB1ENR_USBEN: uInt32  = $00800000;  // USB Device clock enable 
{$ENDIF}

{$IF defined (STM32F10X_HD) or defined  (STM32F10X_CL)}
  RCC_APB1ENR_TIM5EN: uInt32  = $00000008;  // Timer 5 clock enable 
  RCC_APB1ENR_TIM6EN: uInt32  = $00000010;  // Timer 6 clock enable 
  RCC_APB1ENR_TIM7EN: uInt32  = $00000020;  // Timer 7 clock enable 
  RCC_APB1ENR_SPI3EN: uInt32  = $00008000;  // SPI 3 clock enable 
  RCC_APB1ENR_UART4EN: uInt32  = $00080000;  // UART 4 clock enable 
  RCC_APB1ENR_UART5EN: uInt32  = $00100000;  // UART 5 clock enable 
  RCC_APB1ENR_DACEN: uInt32  = $20000000;  // DAC interface clock enable 
{$ENDIF}

{$IF defined (STM32F10X_LD_VL) or defined  (STM32F10X_MD_VL) or defined  (STM32F10X_HD_VL)}
  RCC_APB1ENR_TIM6EN: uInt32  = $00000010;  // Timer 6 clock enable 
  RCC_APB1ENR_TIM7EN: uInt32  = $00000020;  // Timer 7 clock enable 
  RCC_APB1ENR_DACEN: uInt32  = $20000000;  // DAC interface clock enable 
  RCC_APB1ENR_CECEN: uInt32  = $40000000;  // CEC interface clock enable 
{$ENDIF}

{$IFDEF STM32F10X_HD_VL}
  RCC_APB1ENR_TIM5EN: uInt32  = $00000008;  // Timer 5 clock enable 
  RCC_APB1ENR_TIM12EN: uInt32  = $00000040;  // TIM12 Timer clock enable  
  RCC_APB1ENR_TIM13EN: uInt32  = $00000080;  // TIM13 Timer clock enable  
  RCC_APB1ENR_TIM14EN: uInt32  = $00000100;  // TIM14 Timer clock enable 
  RCC_APB1ENR_SPI3EN: uInt32  = $00008000;  // SPI 3 clock enable 
  RCC_APB1ENR_UART4EN: uInt32  = $00080000;  // UART 4 clock enable 
  RCC_APB1ENR_UART5EN: uInt32  = $00100000;  // UART 5 clock enable 
{$ENDIF} { STM32F10X_HD_VL }

{$IFDEF STM32F10X_CL}
  RCC_APB1ENR_CAN2EN: uInt32  = $04000000;  // CAN2 clock enable 
{$ENDIF} { STM32F10X_CL }

{$IFDEF STM32F10X_XL}
  RCC_APB1ENR_TIM12EN: uInt32  = $00000040;  // TIM12 Timer clock enable  
  RCC_APB1ENR_TIM13EN: uInt32  = $00000080;  // TIM13 Timer clock enable  
  RCC_APB1ENR_TIM14EN: uInt32  = $00000100;  // TIM14 Timer clock enable 
{$ENDIF} { STM32F10X_XL }

{******************  Bit definition for RCC_BDCR register  ******************}
  RCC_BDCR_LSEON: uInt32  = $00000001;  // External Low Speed oscillator enable 
  RCC_BDCR_LSERDY: uInt32  = $00000002;  // External Low Speed oscillator Ready 
  RCC_BDCR_LSEBYP: uInt32  = $00000004;  // External Low Speed oscillator Bypass 

  RCC_BDCR_RTCSEL: uInt32  = $00000300;  // RTCSEL[1:0] bits (RTC clock source selection) 
  RCC_BDCR_RTCSEL_0: uInt32  = $00000100;  // Bit 0 
  RCC_BDCR_RTCSEL_1: uInt32  = $00000200;  // Bit 1 

{ RTC congiguration }
  RCC_BDCR_RTCSEL_NOCLOCK: uInt32  = $00000000;  // No clock 
  RCC_BDCR_RTCSEL_LSE: uInt32  = $00000100;  // LSE oscillator clock used as RTC clock 
  RCC_BDCR_RTCSEL_LSI: uInt32  = $00000200;  // LSI oscillator clock used as RTC clock 
  RCC_BDCR_RTCSEL_HSE: uInt32  = $00000300;  // HSE oscillator clock divided by 128 used as RTC clock 

  RCC_BDCR_RTCEN: uInt32  = $00008000;  // RTC clock enable 
  RCC_BDCR_BDRST: uInt32  = $00010000;  // Backup domain software reset  

{******************  Bit definition for RCC_CSR register  *******************}
  RCC_CSR_LSION: uInt32  = $00000001;  // Internal Low Speed oscillator enable 
  RCC_CSR_LSIRDY: uInt32  = $00000002;  // Internal Low Speed oscillator Ready 
  RCC_CSR_RMVF: uInt32  = $01000000;  // Remove reset flag 
  RCC_CSR_PINRSTF: uInt32  = $04000000;  // PIN reset flag 
  RCC_CSR_PORRSTF: uInt32  = $08000000;  // POR/PDR reset flag 
  RCC_CSR_SFTRSTF: uInt32  = $10000000;  // Software Reset flag 
  RCC_CSR_IWDGRSTF: uInt32  = $20000000;  // Independent Watchdog reset flag 
  RCC_CSR_WWDGRSTF: uInt32  = $40000000;  // Window watchdog reset flag 
  RCC_CSR_LPWRRSTF: uInt32  = $80000000;  // Low-Power reset flag 

{$IFDEF STM32F10X_CL}
{******************  Bit definition for RCC_AHBRSTR register  ***************}
  RCC_AHBRSTR_OTGFSRST: uInt32  = $00001000;  // USB OTG FS reset 
  RCC_AHBRSTR_ETHMACRST: uInt32  = $00004000;  // ETHERNET MAC reset 

{******************  Bit definition for RCC_CFGR2 register  *****************}
{ PREDIV1 configuration }
  RCC_CFGR2_PREDIV1: uInt32  = $0000000F;  // PREDIV1[3:0] bits 
  RCC_CFGR2_PREDIV1_0: uInt32  = $00000001;  // Bit 0 
  RCC_CFGR2_PREDIV1_1: uInt32  = $00000002;  // Bit 1 
  RCC_CFGR2_PREDIV1_2: uInt32  = $00000004;  // Bit 2 
  RCC_CFGR2_PREDIV1_3: uInt32  = $00000008;  // Bit 3 

  RCC_CFGR2_PREDIV1_DIV1: uInt32  = $00000000;  // PREDIV1 input clock not divided 
  RCC_CFGR2_PREDIV1_DIV2: uInt32  = $00000001;  // PREDIV1 input clock divided by 2 
  RCC_CFGR2_PREDIV1_DIV3: uInt32  = $00000002;  // PREDIV1 input clock divided by 3 
  RCC_CFGR2_PREDIV1_DIV4: uInt32  = $00000003;  // PREDIV1 input clock divided by 4 
  RCC_CFGR2_PREDIV1_DIV5: uInt32  = $00000004;  // PREDIV1 input clock divided by 5 
  RCC_CFGR2_PREDIV1_DIV6: uInt32  = $00000005;  // PREDIV1 input clock divided by 6 
  RCC_CFGR2_PREDIV1_DIV7: uInt32  = $00000006;  // PREDIV1 input clock divided by 7 
  RCC_CFGR2_PREDIV1_DIV8: uInt32  = $00000007;  // PREDIV1 input clock divided by 8 
  RCC_CFGR2_PREDIV1_DIV9: uInt32  = $00000008;  // PREDIV1 input clock divided by 9 
  RCC_CFGR2_PREDIV1_DIV10: uInt32  = $00000009;  // PREDIV1 input clock divided by 10 
  RCC_CFGR2_PREDIV1_DIV11: uInt32  = $0000000A;  // PREDIV1 input clock divided by 11 
  RCC_CFGR2_PREDIV1_DIV12: uInt32  = $0000000B;  // PREDIV1 input clock divided by 12 
  RCC_CFGR2_PREDIV1_DIV13: uInt32  = $0000000C;  // PREDIV1 input clock divided by 13 
  RCC_CFGR2_PREDIV1_DIV14: uInt32  = $0000000D;  // PREDIV1 input clock divided by 14 
  RCC_CFGR2_PREDIV1_DIV15: uInt32  = $0000000E;  // PREDIV1 input clock divided by 15 
  RCC_CFGR2_PREDIV1_DIV16: uInt32  = $0000000F;  // PREDIV1 input clock divided by 16 

{ PREDIV2 configuration }
  RCC_CFGR2_PREDIV2: uInt32  = $000000F0;  // PREDIV2[3:0] bits 
  RCC_CFGR2_PREDIV2_0: uInt32  = $00000010;  // Bit 0 
  RCC_CFGR2_PREDIV2_1: uInt32  = $00000020;  // Bit 1 
  RCC_CFGR2_PREDIV2_2: uInt32  = $00000040;  // Bit 2 
  RCC_CFGR2_PREDIV2_3: uInt32  = $00000080;  // Bit 3 

  RCC_CFGR2_PREDIV2_DIV1: uInt32  = $00000000;  // PREDIV2 input clock not divided 
  RCC_CFGR2_PREDIV2_DIV2: uInt32  = $00000010;  // PREDIV2 input clock divided by 2 
  RCC_CFGR2_PREDIV2_DIV3: uInt32  = $00000020;  // PREDIV2 input clock divided by 3 
  RCC_CFGR2_PREDIV2_DIV4: uInt32  = $00000030;  // PREDIV2 input clock divided by 4 
  RCC_CFGR2_PREDIV2_DIV5: uInt32  = $00000040;  // PREDIV2 input clock divided by 5 
  RCC_CFGR2_PREDIV2_DIV6: uInt32  = $00000050;  // PREDIV2 input clock divided by 6 
  RCC_CFGR2_PREDIV2_DIV7: uInt32  = $00000060;  // PREDIV2 input clock divided by 7 
  RCC_CFGR2_PREDIV2_DIV8: uInt32  = $00000070;  // PREDIV2 input clock divided by 8 
  RCC_CFGR2_PREDIV2_DIV9: uInt32  = $00000080;  // PREDIV2 input clock divided by 9 
  RCC_CFGR2_PREDIV2_DIV10: uInt32  = $00000090;  // PREDIV2 input clock divided by 10 
  RCC_CFGR2_PREDIV2_DIV11: uInt32  = $000000A0;  // PREDIV2 input clock divided by 11 
  RCC_CFGR2_PREDIV2_DIV12: uInt32  = $000000B0;  // PREDIV2 input clock divided by 12 
  RCC_CFGR2_PREDIV2_DIV13: uInt32  = $000000C0;  // PREDIV2 input clock divided by 13 
  RCC_CFGR2_PREDIV2_DIV14: uInt32  = $000000D0;  // PREDIV2 input clock divided by 14 
  RCC_CFGR2_PREDIV2_DIV15: uInt32  = $000000E0;  // PREDIV2 input clock divided by 15 
  RCC_CFGR2_PREDIV2_DIV16: uInt32  = $000000F0;  // PREDIV2 input clock divided by 16 

{ PLL2MUL configuration }
  RCC_CFGR2_PLL2MUL: uInt32  = $00000F00;  // PLL2MUL[3:0] bits 
  RCC_CFGR2_PLL2MUL_0: uInt32  = $00000100;  // Bit 0 
  RCC_CFGR2_PLL2MUL_1: uInt32  = $00000200;  // Bit 1 
  RCC_CFGR2_PLL2MUL_2: uInt32  = $00000400;  // Bit 2 
  RCC_CFGR2_PLL2MUL_3: uInt32  = $00000800;  // Bit 3 

  RCC_CFGR2_PLL2MUL8: uInt32  = $00000600;  // PLL2 input clock * 8 
  RCC_CFGR2_PLL2MUL9: uInt32  = $00000700;  // PLL2 input clock * 9 
  RCC_CFGR2_PLL2MUL10: uInt32  = $00000800;  // PLL2 input clock * 10 
  RCC_CFGR2_PLL2MUL11: uInt32  = $00000900;  // PLL2 input clock * 11 
  RCC_CFGR2_PLL2MUL12: uInt32  = $00000A00;  // PLL2 input clock * 12 
  RCC_CFGR2_PLL2MUL13: uInt32  = $00000B00;  // PLL2 input clock * 13 
  RCC_CFGR2_PLL2MUL14: uInt32  = $00000C00;  // PLL2 input clock * 14 
  RCC_CFGR2_PLL2MUL16: uInt32  = $00000E00;  // PLL2 input clock * 16 
  RCC_CFGR2_PLL2MUL20: uInt32  = $00000F00;  // PLL2 input clock * 20 

{ PLL3MUL configuration }
  RCC_CFGR2_PLL3MUL: uInt32  = $0000F000;  // PLL3MUL[3:0] bits 
  RCC_CFGR2_PLL3MUL_0: uInt32  = $00001000;  // Bit 0 
  RCC_CFGR2_PLL3MUL_1: uInt32  = $00002000;  // Bit 1 
  RCC_CFGR2_PLL3MUL_2: uInt32  = $00004000;  // Bit 2 
  RCC_CFGR2_PLL3MUL_3: uInt32  = $00008000;  // Bit 3 

  RCC_CFGR2_PLL3MUL8: uInt32  = $00006000;  // PLL3 input clock * 8 
  RCC_CFGR2_PLL3MUL9: uInt32  = $00007000;  // PLL3 input clock * 9 
  RCC_CFGR2_PLL3MUL10: uInt32  = $00008000;  // PLL3 input clock * 10 
  RCC_CFGR2_PLL3MUL11: uInt32  = $00009000;  // PLL3 input clock * 11 
  RCC_CFGR2_PLL3MUL12: uInt32  = $0000A000;  // PLL3 input clock * 12 
  RCC_CFGR2_PLL3MUL13: uInt32  = $0000B000;  // PLL3 input clock * 13 
  RCC_CFGR2_PLL3MUL14: uInt32  = $0000C000;  // PLL3 input clock * 14 
  RCC_CFGR2_PLL3MUL16: uInt32  = $0000E000;  // PLL3 input clock * 16 
  RCC_CFGR2_PLL3MUL20: uInt32  = $0000F000;  // PLL3 input clock * 20 

  RCC_CFGR2_PREDIV1SRC: uInt32  = $00010000;  // PREDIV1 entry clock source 
  RCC_CFGR2_PREDIV1SRC_PLL2: uInt32  = $00010000;  // PLL2 selected as PREDIV1 entry clock source 
  RCC_CFGR2_PREDIV1SRC_HSE: uInt32  = $00000000;  // HSE selected as PREDIV1 entry clock source 
  RCC_CFGR2_I2S2SRC: uInt32  = $00020000;  // I2S2 entry clock source 
  RCC_CFGR2_I2S3SRC: uInt32  = $00040000;  // I2S3 clock source 
{$ENDIF} { STM32F10X_CL }

{$IF defined (STM32F10X_LD_VL) or defined (STM32F10X_MD_VL) or defined (STM32F10X_HD_VL)}
{******************  Bit definition for RCC_CFGR2 register  *****************}
{ PREDIV1 configuration }
  RCC_CFGR2_PREDIV1: uInt32  = $0000000F;  // PREDIV1[3:0] bits 
  RCC_CFGR2_PREDIV1_0: uInt32  = $00000001;  // Bit 0 
  RCC_CFGR2_PREDIV1_1: uInt32  = $00000002;  // Bit 1 
  RCC_CFGR2_PREDIV1_2: uInt32  = $00000004;  // Bit 2 
  RCC_CFGR2_PREDIV1_3: uInt32  = $00000008;  // Bit 3 

  RCC_CFGR2_PREDIV1_DIV1: uInt32  = $00000000;  // PREDIV1 input clock not divided 
  RCC_CFGR2_PREDIV1_DIV2: uInt32  = $00000001;  // PREDIV1 input clock divided by 2 
  RCC_CFGR2_PREDIV1_DIV3: uInt32  = $00000002;  // PREDIV1 input clock divided by 3 
  RCC_CFGR2_PREDIV1_DIV4: uInt32  = $00000003;  // PREDIV1 input clock divided by 4 
  RCC_CFGR2_PREDIV1_DIV5: uInt32  = $00000004;  // PREDIV1 input clock divided by 5 
  RCC_CFGR2_PREDIV1_DIV6: uInt32  = $00000005;  // PREDIV1 input clock divided by 6 
  RCC_CFGR2_PREDIV1_DIV7: uInt32  = $00000006;  // PREDIV1 input clock divided by 7 
  RCC_CFGR2_PREDIV1_DIV8: uInt32  = $00000007;  // PREDIV1 input clock divided by 8 
  RCC_CFGR2_PREDIV1_DIV9: uInt32  = $00000008;  // PREDIV1 input clock divided by 9 
  RCC_CFGR2_PREDIV1_DIV10: uInt32  = $00000009;  // PREDIV1 input clock divided by 10 
  RCC_CFGR2_PREDIV1_DIV11: uInt32  = $0000000A;  // PREDIV1 input clock divided by 11 
  RCC_CFGR2_PREDIV1_DIV12: uInt32  = $0000000B;  // PREDIV1 input clock divided by 12 
  RCC_CFGR2_PREDIV1_DIV13: uInt32  = $0000000C;  // PREDIV1 input clock divided by 13 
  RCC_CFGR2_PREDIV1_DIV14: uInt32  = $0000000D;  // PREDIV1 input clock divided by 14 
  RCC_CFGR2_PREDIV1_DIV15: uInt32  = $0000000E;  // PREDIV1 input clock divided by 15 
  RCC_CFGR2_PREDIV1_DIV16: uInt32  = $0000000F;  // PREDIV1 input clock divided by 16 
{$ENDIF}

{****************************************************************************}
{                                                                            }
{                General Purpose and Alternate Function I/O                  }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for GPIO_CRL register  ******************}
  GPIO_CRL_MODE: uInt32  = $33333333;  // Port x mode bits 

  GPIO_CRL_MODE0: uInt32  = $00000003;  // MODE0[1:0] bits (Port x mode bits, pin 0) 
  GPIO_CRL_MODE0_0: uInt32  = $00000001;  // Bit 0 
  GPIO_CRL_MODE0_1: uInt32  = $00000002;  // Bit 1 

  GPIO_CRL_MODE1: uInt32  = $00000030;  // MODE1[1:0] bits (Port x mode bits, pin 1) 
  GPIO_CRL_MODE1_0: uInt32  = $00000010;  // Bit 0 
  GPIO_CRL_MODE1_1: uInt32  = $00000020;  // Bit 1 

  GPIO_CRL_MODE2: uInt32  = $00000300;  // MODE2[1:0] bits (Port x mode bits, pin 2) 
  GPIO_CRL_MODE2_0: uInt32  = $00000100;  // Bit 0 
  GPIO_CRL_MODE2_1: uInt32  = $00000200;  // Bit 1 

  GPIO_CRL_MODE3: uInt32  = $00003000;  // MODE3[1:0] bits (Port x mode bits, pin 3) 
  GPIO_CRL_MODE3_0: uInt32  = $00001000;  // Bit 0 
  GPIO_CRL_MODE3_1: uInt32  = $00002000;  // Bit 1 

  GPIO_CRL_MODE4: uInt32  = $00030000;  // MODE4[1:0] bits (Port x mode bits, pin 4) 
  GPIO_CRL_MODE4_0: uInt32  = $00010000;  // Bit 0 
  GPIO_CRL_MODE4_1: uInt32  = $00020000;  // Bit 1 

  GPIO_CRL_MODE5: uInt32  = $00300000;  // MODE5[1:0] bits (Port x mode bits, pin 5) 
  GPIO_CRL_MODE5_0: uInt32  = $00100000;  // Bit 0 
  GPIO_CRL_MODE5_1: uInt32  = $00200000;  // Bit 1 

  GPIO_CRL_MODE6: uInt32  = $03000000;  // MODE6[1:0] bits (Port x mode bits, pin 6) 
  GPIO_CRL_MODE6_0: uInt32  = $01000000;  // Bit 0 
  GPIO_CRL_MODE6_1: uInt32  = $02000000;  // Bit 1 

  GPIO_CRL_MODE7: uInt32  = $30000000;  // MODE7[1:0] bits (Port x mode bits, pin 7) 
  GPIO_CRL_MODE7_0: uInt32  = $10000000;  // Bit 0 
  GPIO_CRL_MODE7_1: uInt32  = $20000000;  // Bit 1 

  GPIO_CRL_CNF: uInt32  = $CCCCCCCC;  // Port x configuration bits 

  GPIO_CRL_CNF0: uInt32  = $0000000C;  // CNF0[1:0] bits (Port x configuration bits, pin 0) 
  GPIO_CRL_CNF0_0: uInt32  = $00000004;  // Bit 0 
  GPIO_CRL_CNF0_1: uInt32  = $00000008;  // Bit 1 

  GPIO_CRL_CNF1: uInt32  = $000000C0;  // CNF1[1:0] bits (Port x configuration bits, pin 1) 
  GPIO_CRL_CNF1_0: uInt32  = $00000040;  // Bit 0 
  GPIO_CRL_CNF1_1: uInt32  = $00000080;  // Bit 1 

  GPIO_CRL_CNF2: uInt32  = $00000C00;  // CNF2[1:0] bits (Port x configuration bits, pin 2) 
  GPIO_CRL_CNF2_0: uInt32  = $00000400;  // Bit 0 
  GPIO_CRL_CNF2_1: uInt32  = $00000800;  // Bit 1 

  GPIO_CRL_CNF3: uInt32  = $0000C000;  // CNF3[1:0] bits (Port x configuration bits, pin 3) 
  GPIO_CRL_CNF3_0: uInt32  = $00004000;  // Bit 0 
  GPIO_CRL_CNF3_1: uInt32  = $00008000;  // Bit 1 

  GPIO_CRL_CNF4: uInt32  = $000C0000;  // CNF4[1:0] bits (Port x configuration bits, pin 4) 
  GPIO_CRL_CNF4_0: uInt32  = $00040000;  // Bit 0 
  GPIO_CRL_CNF4_1: uInt32  = $00080000;  // Bit 1 

  GPIO_CRL_CNF5: uInt32  = $00C00000;  // CNF5[1:0] bits (Port x configuration bits, pin 5) 
  GPIO_CRL_CNF5_0: uInt32  = $00400000;  // Bit 0 
  GPIO_CRL_CNF5_1: uInt32  = $00800000;  // Bit 1 

  GPIO_CRL_CNF6: uInt32  = $0C000000;  // CNF6[1:0] bits (Port x configuration bits, pin 6) 
  GPIO_CRL_CNF6_0: uInt32  = $04000000;  // Bit 0 
  GPIO_CRL_CNF6_1: uInt32  = $08000000;  // Bit 1 

  GPIO_CRL_CNF7: uInt32  = $C0000000;  // CNF7[1:0] bits (Port x configuration bits, pin 7) 
  GPIO_CRL_CNF7_0: uInt32  = $40000000;  // Bit 0 
  GPIO_CRL_CNF7_1: uInt32  = $80000000;  // Bit 1 

{******************  Bit definition for GPIO_CRH register  ******************}
  GPIO_CRH_MODE: uInt32  = $33333333;  // Port x mode bits 

  GPIO_CRH_MODE8: uInt32  = $00000003;  // MODE8[1:0] bits (Port x mode bits, pin 8) 
  GPIO_CRH_MODE8_0: uInt32  = $00000001;  // Bit 0 
  GPIO_CRH_MODE8_1: uInt32  = $00000002;  // Bit 1 

  GPIO_CRH_MODE9: uInt32  = $00000030;  // MODE9[1:0] bits (Port x mode bits, pin 9) 
  GPIO_CRH_MODE9_0: uInt32  = $00000010;  // Bit 0 
  GPIO_CRH_MODE9_1: uInt32  = $00000020;  // Bit 1 

  GPIO_CRH_MODE10: uInt32  = $00000300;  // MODE10[1:0] bits (Port x mode bits, pin 10) 
  GPIO_CRH_MODE10_0: uInt32  = $00000100;  // Bit 0 
  GPIO_CRH_MODE10_1: uInt32  = $00000200;  // Bit 1 

  GPIO_CRH_MODE11: uInt32  = $00003000;  // MODE11[1:0] bits (Port x mode bits, pin 11) 
  GPIO_CRH_MODE11_0: uInt32  = $00001000;  // Bit 0 
  GPIO_CRH_MODE11_1: uInt32  = $00002000;  // Bit 1 

  GPIO_CRH_MODE12: uInt32  = $00030000;  // MODE12[1:0] bits (Port x mode bits, pin 12) 
  GPIO_CRH_MODE12_0: uInt32  = $00010000;  // Bit 0 
  GPIO_CRH_MODE12_1: uInt32  = $00020000;  // Bit 1 

  GPIO_CRH_MODE13: uInt32  = $00300000;  // MODE13[1:0] bits (Port x mode bits, pin 13) 
  GPIO_CRH_MODE13_0: uInt32  = $00100000;  // Bit 0 
  GPIO_CRH_MODE13_1: uInt32  = $00200000;  // Bit 1 

  GPIO_CRH_MODE14: uInt32  = $03000000;  // MODE14[1:0] bits (Port x mode bits, pin 14) 
  GPIO_CRH_MODE14_0: uInt32  = $01000000;  // Bit 0 
  GPIO_CRH_MODE14_1: uInt32  = $02000000;  // Bit 1 

  GPIO_CRH_MODE15: uInt32  = $30000000;  // MODE15[1:0] bits (Port x mode bits, pin 15) 
  GPIO_CRH_MODE15_0: uInt32  = $10000000;  // Bit 0 
  GPIO_CRH_MODE15_1: uInt32  = $20000000;  // Bit 1 

  GPIO_CRH_CNF: uInt32  = $CCCCCCCC;  // Port x configuration bits 

  GPIO_CRH_CNF8: uInt32  = $0000000C;  // CNF8[1:0] bits (Port x configuration bits, pin 8) 
  GPIO_CRH_CNF8_0: uInt32  = $00000004;  // Bit 0 
  GPIO_CRH_CNF8_1: uInt32  = $00000008;  // Bit 1 

  GPIO_CRH_CNF9: uInt32  = $000000C0;  // CNF9[1:0] bits (Port x configuration bits, pin 9) 
  GPIO_CRH_CNF9_0: uInt32  = $00000040;  // Bit 0 
  GPIO_CRH_CNF9_1: uInt32  = $00000080;  // Bit 1 

  GPIO_CRH_CNF10: uInt32  = $00000C00;  // CNF10[1:0] bits (Port x configuration bits, pin 10) 
  GPIO_CRH_CNF10_0: uInt32  = $00000400;  // Bit 0 
  GPIO_CRH_CNF10_1: uInt32  = $00000800;  // Bit 1 

  GPIO_CRH_CNF11: uInt32  = $0000C000;  // CNF11[1:0] bits (Port x configuration bits, pin 11) 
  GPIO_CRH_CNF11_0: uInt32  = $00004000;  // Bit 0 
  GPIO_CRH_CNF11_1: uInt32  = $00008000;  // Bit 1 

  GPIO_CRH_CNF12: uInt32  = $000C0000;  // CNF12[1:0] bits (Port x configuration bits, pin 12) 
  GPIO_CRH_CNF12_0: uInt32  = $00040000;  // Bit 0 
  GPIO_CRH_CNF12_1: uInt32  = $00080000;  // Bit 1 

  GPIO_CRH_CNF13: uInt32  = $00C00000;  // CNF13[1:0] bits (Port x configuration bits, pin 13) 
  GPIO_CRH_CNF13_0: uInt32  = $00400000;  // Bit 0 
  GPIO_CRH_CNF13_1: uInt32  = $00800000;  // Bit 1 

  GPIO_CRH_CNF14: uInt32  = $0C000000;  // CNF14[1:0] bits (Port x configuration bits, pin 14) 
  GPIO_CRH_CNF14_0: uInt32  = $04000000;  // Bit 0 
  GPIO_CRH_CNF14_1: uInt32  = $08000000;  // Bit 1 

  GPIO_CRH_CNF15: uInt32  = $C0000000;  // CNF15[1:0] bits (Port x configuration bits, pin 15) 
  GPIO_CRH_CNF15_0: uInt32  = $40000000;  // Bit 0 
  GPIO_CRH_CNF15_1: uInt32  = $80000000;  // Bit 1 

{******************  Bit definition for GPIO_IDR register  ******************}
  GPIO_IDR_IDR0: uInt16  = $0001;  // Port input data, bit 0 
  GPIO_IDR_IDR1: uInt16  = $0002;  // Port input data, bit 1 
  GPIO_IDR_IDR2: uInt16  = $0004;  // Port input data, bit 2 
  GPIO_IDR_IDR3: uInt16  = $0008;  // Port input data, bit 3 
  GPIO_IDR_IDR4: uInt16  = $0010;  // Port input data, bit 4 
  GPIO_IDR_IDR5: uInt16  = $0020;  // Port input data, bit 5 
  GPIO_IDR_IDR6: uInt16  = $0040;  // Port input data, bit 6 
  GPIO_IDR_IDR7: uInt16  = $0080;  // Port input data, bit 7 
  GPIO_IDR_IDR8: uInt16  = $0100;  // Port input data, bit 8 
  GPIO_IDR_IDR9: uInt16  = $0200;  // Port input data, bit 9 
  GPIO_IDR_IDR10: uInt16  = $0400;  // Port input data, bit 10 
  GPIO_IDR_IDR11: uInt16  = $0800;  // Port input data, bit 11 
  GPIO_IDR_IDR12: uInt16  = $1000;  // Port input data, bit 12 
  GPIO_IDR_IDR13: uInt16  = $2000;  // Port input data, bit 13 
  GPIO_IDR_IDR14: uInt16  = $4000;  // Port input data, bit 14 
  GPIO_IDR_IDR15: uInt16  = $8000;  // Port input data, bit 15 

{******************  Bit definition for GPIO_ODR register  ******************}
  GPIO_ODR_ODR0: uInt16  = $0001;  // Port output data, bit 0 
  GPIO_ODR_ODR1: uInt16  = $0002;  // Port output data, bit 1 
  GPIO_ODR_ODR2: uInt16  = $0004;  // Port output data, bit 2 
  GPIO_ODR_ODR3: uInt16  = $0008;  // Port output data, bit 3 
  GPIO_ODR_ODR4: uInt16  = $0010;  // Port output data, bit 4 
  GPIO_ODR_ODR5: uInt16  = $0020;  // Port output data, bit 5 
  GPIO_ODR_ODR6: uInt16  = $0040;  // Port output data, bit 6 
  GPIO_ODR_ODR7: uInt16  = $0080;  // Port output data, bit 7 
  GPIO_ODR_ODR8: uInt16  = $0100;  // Port output data, bit 8 
  GPIO_ODR_ODR9: uInt16  = $0200;  // Port output data, bit 9 
  GPIO_ODR_ODR10: uInt16  = $0400;  // Port output data, bit 10 
  GPIO_ODR_ODR11: uInt16  = $0800;  // Port output data, bit 11 
  GPIO_ODR_ODR12: uInt16  = $1000;  // Port output data, bit 12 
  GPIO_ODR_ODR13: uInt16  = $2000;  // Port output data, bit 13 
  GPIO_ODR_ODR14: uInt16  = $4000;  // Port output data, bit 14 
  GPIO_ODR_ODR15: uInt16  = $8000;  // Port output data, bit 15 

{*****************  Bit definition for GPIO_BSRR register  ******************}
  GPIO_BSRR_BS0: uInt32  = $00000001;  // Port x Set bit 0 
  GPIO_BSRR_BS1: uInt32  = $00000002;  // Port x Set bit 1 
  GPIO_BSRR_BS2: uInt32  = $00000004;  // Port x Set bit 2 
  GPIO_BSRR_BS3: uInt32  = $00000008;  // Port x Set bit 3 
  GPIO_BSRR_BS4: uInt32  = $00000010;  // Port x Set bit 4 
  GPIO_BSRR_BS5: uInt32  = $00000020;  // Port x Set bit 5 
  GPIO_BSRR_BS6: uInt32  = $00000040;  // Port x Set bit 6 
  GPIO_BSRR_BS7: uInt32  = $00000080;  // Port x Set bit 7 
  GPIO_BSRR_BS8: uInt32  = $00000100;  // Port x Set bit 8 
  GPIO_BSRR_BS9: uInt32  = $00000200;  // Port x Set bit 9 
  GPIO_BSRR_BS10: uInt32  = $00000400;  // Port x Set bit 10 
  GPIO_BSRR_BS11: uInt32  = $00000800;  // Port x Set bit 11 
  GPIO_BSRR_BS12: uInt32  = $00001000;  // Port x Set bit 12 
  GPIO_BSRR_BS13: uInt32  = $00002000;  // Port x Set bit 13 
  GPIO_BSRR_BS14: uInt32  = $00004000;  // Port x Set bit 14 
  GPIO_BSRR_BS15: uInt32  = $00008000;  // Port x Set bit 15 

  GPIO_BSRR_BR0: uInt32  = $00010000;  // Port x Reset bit 0 
  GPIO_BSRR_BR1: uInt32  = $00020000;  // Port x Reset bit 1 
  GPIO_BSRR_BR2: uInt32  = $00040000;  // Port x Reset bit 2 
  GPIO_BSRR_BR3: uInt32  = $00080000;  // Port x Reset bit 3 
  GPIO_BSRR_BR4: uInt32  = $00100000;  // Port x Reset bit 4 
  GPIO_BSRR_BR5: uInt32  = $00200000;  // Port x Reset bit 5 
  GPIO_BSRR_BR6: uInt32  = $00400000;  // Port x Reset bit 6 
  GPIO_BSRR_BR7: uInt32  = $00800000;  // Port x Reset bit 7 
  GPIO_BSRR_BR8: uInt32  = $01000000;  // Port x Reset bit 8 
  GPIO_BSRR_BR9: uInt32  = $02000000;  // Port x Reset bit 9 
  GPIO_BSRR_BR10: uInt32  = $04000000;  // Port x Reset bit 10 
  GPIO_BSRR_BR11: uInt32  = $08000000;  // Port x Reset bit 11 
  GPIO_BSRR_BR12: uInt32  = $10000000;  // Port x Reset bit 12 
  GPIO_BSRR_BR13: uInt32  = $20000000;  // Port x Reset bit 13 
  GPIO_BSRR_BR14: uInt32  = $40000000;  // Port x Reset bit 14 
  GPIO_BSRR_BR15: uInt32  = $80000000;  // Port x Reset bit 15 

{******************  Bit definition for GPIO_BRR register  ******************}
  GPIO_BRR_BR0: uInt16  = $0001;  // Port x Reset bit 0 
  GPIO_BRR_BR1: uInt16  = $0002;  // Port x Reset bit 1 
  GPIO_BRR_BR2: uInt16  = $0004;  // Port x Reset bit 2 
  GPIO_BRR_BR3: uInt16  = $0008;  // Port x Reset bit 3 
  GPIO_BRR_BR4: uInt16  = $0010;  // Port x Reset bit 4 
  GPIO_BRR_BR5: uInt16  = $0020;  // Port x Reset bit 5 
  GPIO_BRR_BR6: uInt16  = $0040;  // Port x Reset bit 6 
  GPIO_BRR_BR7: uInt16  = $0080;  // Port x Reset bit 7 
  GPIO_BRR_BR8: uInt16  = $0100;  // Port x Reset bit 8 
  GPIO_BRR_BR9: uInt16  = $0200;  // Port x Reset bit 9 
  GPIO_BRR_BR10: uInt16  = $0400;  // Port x Reset bit 10 
  GPIO_BRR_BR11: uInt16  = $0800;  // Port x Reset bit 11 
  GPIO_BRR_BR12: uInt16  = $1000;  // Port x Reset bit 12 
  GPIO_BRR_BR13: uInt16  = $2000;  // Port x Reset bit 13 
  GPIO_BRR_BR14: uInt16  = $4000;  // Port x Reset bit 14 
  GPIO_BRR_BR15: uInt16  = $8000;  // Port x Reset bit 15 

{*****************  Bit definition for GPIO_LCKR register  ******************}
  GPIO_LCKR_LCK0: uInt32  = $00000001;  // Port x Lock bit 0 
  GPIO_LCKR_LCK1: uInt32  = $00000002;  // Port x Lock bit 1 
  GPIO_LCKR_LCK2: uInt32  = $00000004;  // Port x Lock bit 2 
  GPIO_LCKR_LCK3: uInt32  = $00000008;  // Port x Lock bit 3 
  GPIO_LCKR_LCK4: uInt32  = $00000010;  // Port x Lock bit 4 
  GPIO_LCKR_LCK5: uInt32  = $00000020;  // Port x Lock bit 5 
  GPIO_LCKR_LCK6: uInt32  = $00000040;  // Port x Lock bit 6 
  GPIO_LCKR_LCK7: uInt32  = $00000080;  // Port x Lock bit 7 
  GPIO_LCKR_LCK8: uInt32  = $00000100;  // Port x Lock bit 8 
  GPIO_LCKR_LCK9: uInt32  = $00000200;  // Port x Lock bit 9 
  GPIO_LCKR_LCK10: uInt32  = $00000400;  // Port x Lock bit 10 
  GPIO_LCKR_LCK11: uInt32  = $00000800;  // Port x Lock bit 11 
  GPIO_LCKR_LCK12: uInt32  = $00001000;  // Port x Lock bit 12 
  GPIO_LCKR_LCK13: uInt32  = $00002000;  // Port x Lock bit 13 
  GPIO_LCKR_LCK14: uInt32  = $00004000;  // Port x Lock bit 14 
  GPIO_LCKR_LCK15: uInt32  = $00008000;  // Port x Lock bit 15 
  GPIO_LCKR_LCKK: uInt32  = $00010000;  // Lock key 

{----------------------------------------------------------------------------}

{*****************  Bit definition for AFIO_EVCR register  ******************}
  AFIO_EVCR_PIN: uInt8  = $0F;  // PIN[3:0] bits (Pin selection) 
  AFIO_EVCR_PIN_0: uInt8  = $01;  // Bit 0 
  AFIO_EVCR_PIN_1: uInt8  = $02;  // Bit 1 
  AFIO_EVCR_PIN_2: uInt8  = $04;  // Bit 2 
  AFIO_EVCR_PIN_3: uInt8  = $08;  // Bit 3 

{ PIN configuration }
  AFIO_EVCR_PIN_PX0: uInt8  = $00;  // Pin 0 selected 
  AFIO_EVCR_PIN_PX1: uInt8  = $01;  // Pin 1 selected 
  AFIO_EVCR_PIN_PX2: uInt8  = $02;  // Pin 2 selected 
  AFIO_EVCR_PIN_PX3: uInt8  = $03;  // Pin 3 selected 
  AFIO_EVCR_PIN_PX4: uInt8  = $04;  // Pin 4 selected 
  AFIO_EVCR_PIN_PX5: uInt8  = $05;  // Pin 5 selected 
  AFIO_EVCR_PIN_PX6: uInt8  = $06;  // Pin 6 selected 
  AFIO_EVCR_PIN_PX7: uInt8  = $07;  // Pin 7 selected 
  AFIO_EVCR_PIN_PX8: uInt8  = $08;  // Pin 8 selected 
  AFIO_EVCR_PIN_PX9: uInt8  = $09;  // Pin 9 selected 
  AFIO_EVCR_PIN_PX10: uInt8  = $0A;  // Pin 10 selected 
  AFIO_EVCR_PIN_PX11: uInt8  = $0B;  // Pin 11 selected 
  AFIO_EVCR_PIN_PX12: uInt8  = $0C;  // Pin 12 selected 
  AFIO_EVCR_PIN_PX13: uInt8  = $0D;  // Pin 13 selected 
  AFIO_EVCR_PIN_PX14: uInt8  = $0E;  // Pin 14 selected 
  AFIO_EVCR_PIN_PX15: uInt8  = $0F;  // Pin 15 selected 

  AFIO_EVCR_PORT: uInt8  = $70;  // PORT[2:0] bits (Port selection) 
  AFIO_EVCR_PORT_0: uInt8  = $10;  // Bit 0 
  AFIO_EVCR_PORT_1: uInt8  = $20;  // Bit 1 
  AFIO_EVCR_PORT_2: uInt8  = $40;  // Bit 2 

{ PORT configuration }
  AFIO_EVCR_PORT_PA: uInt8  = $00;  // Port A selected 
  AFIO_EVCR_PORT_PB: uInt8  = $10;  // Port B selected 
  AFIO_EVCR_PORT_PC: uInt8  = $20;  // Port C selected 
  AFIO_EVCR_PORT_PD: uInt8  = $30;  // Port D selected 
  AFIO_EVCR_PORT_PE: uInt8  = $40;  // Port E selected 

  AFIO_EVCR_EVOE: uInt8  = $80;  // Event Output Enable 

{*****************  Bit definition for AFIO_MAPR register  ******************}
  AFIO_MAPR_SPI1_REMAP: uInt32  = $00000001;  // SPI1 remapping 
  AFIO_MAPR_I2C1_REMAP: uInt32  = $00000002;  // I2C1 remapping 
  AFIO_MAPR_USART1_REMAP: uInt32  = $00000004;  // USART1 remapping 
  AFIO_MAPR_USART2_REMAP: uInt32  = $00000008;  // USART2 remapping 

  AFIO_MAPR_USART3_REMAP: uInt32  = $00000030;  // USART3_REMAP[1:0] bits (USART3 remapping) 
  AFIO_MAPR_USART3_REMAP_0: uInt32  = $00000010;  // Bit 0 
  AFIO_MAPR_USART3_REMAP_1: uInt32  = $00000020;  // Bit 1 

{ USART3_REMAP configuration }
  AFIO_MAPR_USART3_REMAP_NOREMAP: uInt32  = $00000000;  // No remap (TX/PB10, RX/PB11, CK/PB12, CTS/PB13, RTS/PB14) 
  AFIO_MAPR_USART3_REMAP_PARTIALREMAP: uInt32  = $00000010;  // Partial remap (TX/PC10, RX/PC11, CK/PC12, CTS/PB13, RTS/PB14) 
  AFIO_MAPR_USART3_REMAP_FULLREMAP: uInt32  = $00000030;  // Full remap (TX/PD8, RX/PD9, CK/PD10, CTS/PD11, RTS/PD12) 

  AFIO_MAPR_TIM1_REMAP: uInt32  = $000000C0;  // TIM1_REMAP[1:0] bits (TIM1 remapping) 
  AFIO_MAPR_TIM1_REMAP_0: uInt32  = $00000040;  // Bit 0 
  AFIO_MAPR_TIM1_REMAP_1: uInt32  = $00000080;  // Bit 1 

{ TIM1_REMAP configuration }
  AFIO_MAPR_TIM1_REMAP_NOREMAP: uInt32  = $00000000;  // No remap (ETR/PA12, CH1/PA8, CH2/PA9, CH3/PA10, CH4/PA11, BKIN/PB12, CH1N/PB13, CH2N/PB14, CH3N/PB15) 
  AFIO_MAPR_TIM1_REMAP_PARTIALREMAP: uInt32  = $00000040;  // Partial remap (ETR/PA12, CH1/PA8, CH2/PA9, CH3/PA10, CH4/PA11, BKIN/PA6, CH1N/PA7, CH2N/PB0, CH3N/PB1) 
  AFIO_MAPR_TIM1_REMAP_FULLREMAP: uInt32  = $000000C0;  // Full remap (ETR/PE7, CH1/PE9, CH2/PE11, CH3/PE13, CH4/PE14, BKIN/PE15, CH1N/PE8, CH2N/PE10, CH3N/PE12) 

  AFIO_MAPR_TIM2_REMAP: uInt32  = $00000300;  // TIM2_REMAP[1:0] bits (TIM2 remapping) 
  AFIO_MAPR_TIM2_REMAP_0: uInt32  = $00000100;  // Bit 0 
  AFIO_MAPR_TIM2_REMAP_1: uInt32  = $00000200;  // Bit 1 

{ TIM2_REMAP configuration }
  AFIO_MAPR_TIM2_REMAP_NOREMAP: uInt32  = $00000000;  // No remap (CH1/ETR/PA0, CH2/PA1, CH3/PA2, CH4/PA3) 
  AFIO_MAPR_TIM2_REMAP_PARTIALREMAP1: uInt32  = $00000100;  // Partial remap (CH1/ETR/PA15, CH2/PB3, CH3/PA2, CH4/PA3) 
  AFIO_MAPR_TIM2_REMAP_PARTIALREMAP2: uInt32  = $00000200;  // Partial remap (CH1/ETR/PA0, CH2/PA1, CH3/PB10, CH4/PB11) 
  AFIO_MAPR_TIM2_REMAP_FULLREMAP: uInt32  = $00000300;  // Full remap (CH1/ETR/PA15, CH2/PB3, CH3/PB10, CH4/PB11) 

  AFIO_MAPR_TIM3_REMAP: uInt32  = $00000C00;  // TIM3_REMAP[1:0] bits (TIM3 remapping) 
  AFIO_MAPR_TIM3_REMAP_0: uInt32  = $00000400;  // Bit 0 
  AFIO_MAPR_TIM3_REMAP_1: uInt32  = $00000800;  // Bit 1 

{ TIM3_REMAP configuration }
  AFIO_MAPR_TIM3_REMAP_NOREMAP: uInt32  = $00000000;  // No remap (CH1/PA6, CH2/PA7, CH3/PB0, CH4/PB1) 
  AFIO_MAPR_TIM3_REMAP_PARTIALREMAP: uInt32  = $00000800;  // Partial remap (CH1/PB4, CH2/PB5, CH3/PB0, CH4/PB1) 
  AFIO_MAPR_TIM3_REMAP_FULLREMAP: uInt32  = $00000C00;  // Full remap (CH1/PC6, CH2/PC7, CH3/PC8, CH4/PC9) 

  AFIO_MAPR_TIM4_REMAP: uInt32  = $00001000;  // TIM4_REMAP bit (TIM4 remapping) 

  AFIO_MAPR_CAN_REMAP: uInt32  = $00006000;  // CAN_REMAP[1:0] bits (CAN Alternate function remapping) 
  AFIO_MAPR_CAN_REMAP_0: uInt32  = $00002000;  // Bit 0 
  AFIO_MAPR_CAN_REMAP_1: uInt32  = $00004000;  // Bit 1 

{ CAN_REMAP configuration }
  AFIO_MAPR_CAN_REMAP_REMAP1: uInt32  = $00000000;  // CANRX mapped to PA11, CANTX mapped to PA12 
  AFIO_MAPR_CAN_REMAP_REMAP2: uInt32  = $00004000;  // CANRX mapped to PB8, CANTX mapped to PB9 
  AFIO_MAPR_CAN_REMAP_REMAP3: uInt32  = $00006000;  // CANRX mapped to PD0, CANTX mapped to PD1 

  AFIO_MAPR_PD01_REMAP: uInt32  = $00008000;  // Port D0/Port D1 mapping on OSC_IN/OSC_OUT 
  AFIO_MAPR_TIM5CH4_IREMAP: uInt32  = $00010000;  // TIM5 Channel4 Internal Remap 
  AFIO_MAPR_ADC1_ETRGINJ_REMAP: uInt32  = $00020000;  // ADC 1 External Trigger Injected Conversion remapping 
  AFIO_MAPR_ADC1_ETRGREG_REMAP: uInt32  = $00040000;  // ADC 1 External Trigger Regular Conversion remapping 
  AFIO_MAPR_ADC2_ETRGINJ_REMAP: uInt32  = $00080000;  // ADC 2 External Trigger Injected Conversion remapping 
  AFIO_MAPR_ADC2_ETRGREG_REMAP: uInt32  = $00100000;  // ADC 2 External Trigger Regular Conversion remapping 

{ SWJ_CFG configuration }
  AFIO_MAPR_SWJ_CFG: uInt32  = $07000000;  // SWJ_CFG[2:0] bits (Serial Wire JTAG configuration) 
  AFIO_MAPR_SWJ_CFG_0: uInt32  = $01000000;  // Bit 0 
  AFIO_MAPR_SWJ_CFG_1: uInt32  = $02000000;  // Bit 1 
  AFIO_MAPR_SWJ_CFG_2: uInt32  = $04000000;  // Bit 2 

  AFIO_MAPR_SWJ_CFG_RESET: uInt32  = $00000000;  // Full SWJ (JTAG-DP + SW-DP) : Reset State 
  AFIO_MAPR_SWJ_CFG_NOJNTRST: uInt32  = $01000000;  // Full SWJ (JTAG-DP + SW-DP) but without JNTRST 
  AFIO_MAPR_SWJ_CFG_JTAGDISABLE: uInt32  = $02000000;  // JTAG-DP Disabled and SW-DP Enabled 
  AFIO_MAPR_SWJ_CFG_DISABLE: uInt32  = $04000000;  // JTAG-DP Disabled and SW-DP Disabled 

{$IFDEF STM32F10X_CL}
{ ETH_REMAP configuration }
  AFIO_MAPR_ETH_REMAP: uInt32  = $00200000;  // SPI3_REMAP bit (Ethernet MAC I/O remapping) 

{ CAN2_REMAP configuration }
  AFIO_MAPR_CAN2_REMAP: uInt32  = $00400000;  // CAN2_REMAP bit (CAN2 I/O remapping) 

{ MII_RMII_SEL configuration }
  AFIO_MAPR_MII_RMII_SEL: uInt32  = $00800000;  // MII_RMII_SEL bit (Ethernet MII or RMII selection) 

{ SPI3_REMAP configuration }
  AFIO_MAPR_SPI3_REMAP: uInt32  = $10000000;  // SPI3_REMAP bit (SPI3 remapping) 

{ TIM2ITR1_IREMAP configuration }
  AFIO_MAPR_TIM2ITR1_IREMAP: uInt32  = $20000000;  // TIM2ITR1_IREMAP bit (TIM2 internal trigger 1 remapping) 

{ PTP_PPS_REMAP configuration }
  AFIO_MAPR_PTP_PPS_REMAP: uInt32  = $40000000;  // PTP_PPS_REMAP bit (Ethernet PTP PPS remapping) 
{$ENDIF}

{****************  Bit definition for AFIO_EXTICR1 register  ****************}
  AFIO_EXTICR1_EXTI0: uInt16  = $000F;  // EXTI 0 configuration 
  AFIO_EXTICR1_EXTI1: uInt16  = $00F0;  // EXTI 1 configuration 
  AFIO_EXTICR1_EXTI2: uInt16  = $0F00;  // EXTI 2 configuration 
  AFIO_EXTICR1_EXTI3: uInt16  = $F000;  // EXTI 3 configuration 

{ EXTI0 configuration }
  AFIO_EXTICR1_EXTI0_PA: uInt16  = $0000;  // PA[0] pin 
  AFIO_EXTICR1_EXTI0_PB: uInt16  = $0001;  // PB[0] pin 
  AFIO_EXTICR1_EXTI0_PC: uInt16  = $0002;  // PC[0] pin 
  AFIO_EXTICR1_EXTI0_PD: uInt16  = $0003;  // PD[0] pin 
  AFIO_EXTICR1_EXTI0_PE: uInt16  = $0004;  // PE[0] pin 
  AFIO_EXTICR1_EXTI0_PF: uInt16  = $0005;  // PF[0] pin 
  AFIO_EXTICR1_EXTI0_PG: uInt16  = $0006;  // PG[0] pin 

{ EXTI1 configuration }
  AFIO_EXTICR1_EXTI1_PA: uInt16  = $0000;  // PA[1] pin 
  AFIO_EXTICR1_EXTI1_PB: uInt16  = $0010;  // PB[1] pin 
  AFIO_EXTICR1_EXTI1_PC: uInt16  = $0020;  // PC[1] pin 
  AFIO_EXTICR1_EXTI1_PD: uInt16  = $0030;  // PD[1] pin 
  AFIO_EXTICR1_EXTI1_PE: uInt16  = $0040;  // PE[1] pin 
  AFIO_EXTICR1_EXTI1_PF: uInt16  = $0050;  // PF[1] pin 
  AFIO_EXTICR1_EXTI1_PG: uInt16  = $0060;  // PG[1] pin 

{ EXTI2 configuration }
  AFIO_EXTICR1_EXTI2_PA: uInt16  = $0000;  // PA[2] pin 
  AFIO_EXTICR1_EXTI2_PB: uInt16  = $0100;  // PB[2] pin 
  AFIO_EXTICR1_EXTI2_PC: uInt16  = $0200;  // PC[2] pin 
  AFIO_EXTICR1_EXTI2_PD: uInt16  = $0300;  // PD[2] pin 
  AFIO_EXTICR1_EXTI2_PE: uInt16  = $0400;  // PE[2] pin 
  AFIO_EXTICR1_EXTI2_PF: uInt16  = $0500;  // PF[2] pin 
  AFIO_EXTICR1_EXTI2_PG: uInt16  = $0600;  // PG[2] pin 

{ EXTI3 configuration }
  AFIO_EXTICR1_EXTI3_PA: uInt16  = $0000;  // PA[3] pin 
  AFIO_EXTICR1_EXTI3_PB: uInt16  = $1000;  // PB[3] pin 
  AFIO_EXTICR1_EXTI3_PC: uInt16  = $2000;  // PC[3] pin 
  AFIO_EXTICR1_EXTI3_PD: uInt16  = $3000;  // PD[3] pin 
  AFIO_EXTICR1_EXTI3_PE: uInt16  = $4000;  // PE[3] pin 
  AFIO_EXTICR1_EXTI3_PF: uInt16  = $5000;  // PF[3] pin 
  AFIO_EXTICR1_EXTI3_PG: uInt16  = $6000;  // PG[3] pin 

{****************  Bit definition for AFIO_EXTICR2 register  ****************}
  AFIO_EXTICR2_EXTI4: uInt16  = $000F;  // EXTI 4 configuration 
  AFIO_EXTICR2_EXTI5: uInt16  = $00F0;  // EXTI 5 configuration 
  AFIO_EXTICR2_EXTI6: uInt16  = $0F00;  // EXTI 6 configuration 
  AFIO_EXTICR2_EXTI7: uInt16  = $F000;  // EXTI 7 configuration 

{ EXTI4 configuration }
  AFIO_EXTICR2_EXTI4_PA: uInt16  = $0000;  // PA[4] pin 
  AFIO_EXTICR2_EXTI4_PB: uInt16  = $0001;  // PB[4] pin 
  AFIO_EXTICR2_EXTI4_PC: uInt16  = $0002;  // PC[4] pin 
  AFIO_EXTICR2_EXTI4_PD: uInt16  = $0003;  // PD[4] pin 
  AFIO_EXTICR2_EXTI4_PE: uInt16  = $0004;  // PE[4] pin 
  AFIO_EXTICR2_EXTI4_PF: uInt16  = $0005;  // PF[4] pin 
  AFIO_EXTICR2_EXTI4_PG: uInt16  = $0006;  // PG[4] pin 

{ EXTI5 configuration }
  AFIO_EXTICR2_EXTI5_PA: uInt16  = $0000;  // PA[5] pin 
  AFIO_EXTICR2_EXTI5_PB: uInt16  = $0010;  // PB[5] pin 
  AFIO_EXTICR2_EXTI5_PC: uInt16  = $0020;  // PC[5] pin 
  AFIO_EXTICR2_EXTI5_PD: uInt16  = $0030;  // PD[5] pin 
  AFIO_EXTICR2_EXTI5_PE: uInt16  = $0040;  // PE[5] pin 
  AFIO_EXTICR2_EXTI5_PF: uInt16  = $0050;  // PF[5] pin 
  AFIO_EXTICR2_EXTI5_PG: uInt16  = $0060;  // PG[5] pin 

{ EXTI6 configuration }
  AFIO_EXTICR2_EXTI6_PA: uInt16  = $0000;  // PA[6] pin 
  AFIO_EXTICR2_EXTI6_PB: uInt16  = $0100;  // PB[6] pin 
  AFIO_EXTICR2_EXTI6_PC: uInt16  = $0200;  // PC[6] pin 
  AFIO_EXTICR2_EXTI6_PD: uInt16  = $0300;  // PD[6] pin 
  AFIO_EXTICR2_EXTI6_PE: uInt16  = $0400;  // PE[6] pin 
  AFIO_EXTICR2_EXTI6_PF: uInt16  = $0500;  // PF[6] pin 
  AFIO_EXTICR2_EXTI6_PG: uInt16  = $0600;  // PG[6] pin 

{ EXTI7 configuration }
  AFIO_EXTICR2_EXTI7_PA: uInt16  = $0000;  // PA[7] pin 
  AFIO_EXTICR2_EXTI7_PB: uInt16  = $1000;  // PB[7] pin 
  AFIO_EXTICR2_EXTI7_PC: uInt16  = $2000;  // PC[7] pin 
  AFIO_EXTICR2_EXTI7_PD: uInt16  = $3000;  // PD[7] pin 
  AFIO_EXTICR2_EXTI7_PE: uInt16  = $4000;  // PE[7] pin 
  AFIO_EXTICR2_EXTI7_PF: uInt16  = $5000;  // PF[7] pin 
  AFIO_EXTICR2_EXTI7_PG: uInt16  = $6000;  // PG[7] pin 

{****************  Bit definition for AFIO_EXTICR3 register  ****************}
  AFIO_EXTICR3_EXTI8: uInt16  = $000F;  // EXTI 8 configuration 
  AFIO_EXTICR3_EXTI9: uInt16  = $00F0;  // EXTI 9 configuration 
  AFIO_EXTICR3_EXTI10: uInt16  = $0F00;  // EXTI 10 configuration 
  AFIO_EXTICR3_EXTI11: uInt16  = $F000;  // EXTI 11 configuration 

{ EXTI8 configuration }
  AFIO_EXTICR3_EXTI8_PA: uInt16  = $0000;  // PA[8] pin 
  AFIO_EXTICR3_EXTI8_PB: uInt16  = $0001;  // PB[8] pin 
  AFIO_EXTICR3_EXTI8_PC: uInt16  = $0002;  // PC[8] pin 
  AFIO_EXTICR3_EXTI8_PD: uInt16  = $0003;  // PD[8] pin 
  AFIO_EXTICR3_EXTI8_PE: uInt16  = $0004;  // PE[8] pin 
  AFIO_EXTICR3_EXTI8_PF: uInt16  = $0005;  // PF[8] pin 
  AFIO_EXTICR3_EXTI8_PG: uInt16  = $0006;  // PG[8] pin 

{ EXTI9 configuration }
  AFIO_EXTICR3_EXTI9_PA: uInt16  = $0000;  // PA[9] pin 
  AFIO_EXTICR3_EXTI9_PB: uInt16  = $0010;  // PB[9] pin 
  AFIO_EXTICR3_EXTI9_PC: uInt16  = $0020;  // PC[9] pin 
  AFIO_EXTICR3_EXTI9_PD: uInt16  = $0030;  // PD[9] pin 
  AFIO_EXTICR3_EXTI9_PE: uInt16  = $0040;  // PE[9] pin 
  AFIO_EXTICR3_EXTI9_PF: uInt16  = $0050;  // PF[9] pin 
  AFIO_EXTICR3_EXTI9_PG: uInt16  = $0060;  // PG[9] pin 

{ EXTI10 configuration }
  AFIO_EXTICR3_EXTI10_PA: uInt16  = $0000;  // PA[10] pin 
  AFIO_EXTICR3_EXTI10_PB: uInt16  = $0100;  // PB[10] pin 
  AFIO_EXTICR3_EXTI10_PC: uInt16  = $0200;  // PC[10] pin 
  AFIO_EXTICR3_EXTI10_PD: uInt16  = $0300;  // PD[10] pin 
  AFIO_EXTICR3_EXTI10_PE: uInt16  = $0400;  // PE[10] pin 
  AFIO_EXTICR3_EXTI10_PF: uInt16  = $0500;  // PF[10] pin 
  AFIO_EXTICR3_EXTI10_PG: uInt16  = $0600;  // PG[10] pin 

{ EXTI11 configuration }
  AFIO_EXTICR3_EXTI11_PA: uInt16  = $0000;  // PA[11] pin 
  AFIO_EXTICR3_EXTI11_PB: uInt16  = $1000;  // PB[11] pin 
  AFIO_EXTICR3_EXTI11_PC: uInt16  = $2000;  // PC[11] pin 
  AFIO_EXTICR3_EXTI11_PD: uInt16  = $3000;  // PD[11] pin 
  AFIO_EXTICR3_EXTI11_PE: uInt16  = $4000;  // PE[11] pin 
  AFIO_EXTICR3_EXTI11_PF: uInt16  = $5000;  // PF[11] pin 
  AFIO_EXTICR3_EXTI11_PG: uInt16  = $6000;  // PG[11] pin 

{****************  Bit definition for AFIO_EXTICR4 register  ****************}
  AFIO_EXTICR4_EXTI12: uInt16  = $000F;  // EXTI 12 configuration 
  AFIO_EXTICR4_EXTI13: uInt16  = $00F0;  // EXTI 13 configuration 
  AFIO_EXTICR4_EXTI14: uInt16  = $0F00;  // EXTI 14 configuration 
  AFIO_EXTICR4_EXTI15: uInt16  = $F000;  // EXTI 15 configuration 

{ EXTI12 configuration }
  AFIO_EXTICR4_EXTI12_PA: uInt16  = $0000;  // PA[12] pin 
  AFIO_EXTICR4_EXTI12_PB: uInt16  = $0001;  // PB[12] pin 
  AFIO_EXTICR4_EXTI12_PC: uInt16  = $0002;  // PC[12] pin 
  AFIO_EXTICR4_EXTI12_PD: uInt16  = $0003;  // PD[12] pin 
  AFIO_EXTICR4_EXTI12_PE: uInt16  = $0004;  // PE[12] pin 
  AFIO_EXTICR4_EXTI12_PF: uInt16  = $0005;  // PF[12] pin 
  AFIO_EXTICR4_EXTI12_PG: uInt16  = $0006;  // PG[12] pin 

{ EXTI13 configuration }
  AFIO_EXTICR4_EXTI13_PA: uInt16  = $0000;  // PA[13] pin 
  AFIO_EXTICR4_EXTI13_PB: uInt16  = $0010;  // PB[13] pin 
  AFIO_EXTICR4_EXTI13_PC: uInt16  = $0020;  // PC[13] pin 
  AFIO_EXTICR4_EXTI13_PD: uInt16  = $0030;  // PD[13] pin 
  AFIO_EXTICR4_EXTI13_PE: uInt16  = $0040;  // PE[13] pin 
  AFIO_EXTICR4_EXTI13_PF: uInt16  = $0050;  // PF[13] pin 
  AFIO_EXTICR4_EXTI13_PG: uInt16  = $0060;  // PG[13] pin 

{ EXTI14 configuration }
  AFIO_EXTICR4_EXTI14_PA: uInt16  = $0000;  // PA[14] pin 
  AFIO_EXTICR4_EXTI14_PB: uInt16  = $0100;  // PB[14] pin 
  AFIO_EXTICR4_EXTI14_PC: uInt16  = $0200;  // PC[14] pin 
  AFIO_EXTICR4_EXTI14_PD: uInt16  = $0300;  // PD[14] pin 
  AFIO_EXTICR4_EXTI14_PE: uInt16  = $0400;  // PE[14] pin 
  AFIO_EXTICR4_EXTI14_PF: uInt16  = $0500;  // PF[14] pin 
  AFIO_EXTICR4_EXTI14_PG: uInt16  = $0600;  // PG[14] pin 

{ EXTI15 configuration }
  AFIO_EXTICR4_EXTI15_PA: uInt16  = $0000;  // PA[15] pin 
  AFIO_EXTICR4_EXTI15_PB: uInt16  = $1000;  // PB[15] pin 
  AFIO_EXTICR4_EXTI15_PC: uInt16  = $2000;  // PC[15] pin 
  AFIO_EXTICR4_EXTI15_PD: uInt16  = $3000;  // PD[15] pin 
  AFIO_EXTICR4_EXTI15_PE: uInt16  = $4000;  // PE[15] pin 
  AFIO_EXTICR4_EXTI15_PF: uInt16  = $5000;  // PF[15] pin 
  AFIO_EXTICR4_EXTI15_PG: uInt16  = $6000;  // PG[15] pin 

{$IF defined (STM32F10X_LD_VL) or defined (STM32F10X_MD_VL) or defined (STM32F10X_HD_VL)}
{*****************  Bit definition for AFIO_MAPR2 register  *****************}
  AFIO_MAPR2_TIM15_REMAP: uInt32  = $00000001;  // TIM15 remapping 
  AFIO_MAPR2_TIM16_REMAP: uInt32  = $00000002;  // TIM16 remapping 
  AFIO_MAPR2_TIM17_REMAP: uInt32  = $00000004;  // TIM17 remapping 
  AFIO_MAPR2_CEC_REMAP: uInt32  = $00000008;  // CEC remapping 
  AFIO_MAPR2_TIM1_DMA_REMAP: uInt32  = $00000010;  // TIM1_DMA remapping 
{$ENDIF}

{$IFDEF STM32F10X_HD_VL}
  AFIO_MAPR2_TIM13_REMAP: uInt32  = $00000100;  // TIM13 remapping 
  AFIO_MAPR2_TIM14_REMAP: uInt32  = $00000200;  // TIM14 remapping 
  AFIO_MAPR2_FSMC_NADV_REMAP: uInt32  = $00000400;  // FSMC NADV remapping 
  AFIO_MAPR2_TIM67_DAC_DMA_REMAP: uInt32  = $00000800;  // TIM6/TIM7 and DAC DMA remapping 
  AFIO_MAPR2_TIM12_REMAP: uInt32  = $00001000;  // TIM12 remapping 
  AFIO_MAPR2_MISC_REMAP: uInt32  = $00002000;  // Miscellaneous remapping 
{$ENDIF}

{$IFDEF STM32F10X_XL}
{*****************  Bit definition for AFIO_MAPR2 register  *****************}
  AFIO_MAPR2_TIM9_REMAP: uInt32  = $00000020;  // TIM9 remapping 
  AFIO_MAPR2_TIM10_REMAP: uInt32  = $00000040;  // TIM10 remapping 
  AFIO_MAPR2_TIM11_REMAP: uInt32  = $00000080;  // TIM11 remapping 
  AFIO_MAPR2_TIM13_REMAP: uInt32  = $00000100;  // TIM13 remapping 
  AFIO_MAPR2_TIM14_REMAP: uInt32  = $00000200;  // TIM14 remapping 
  AFIO_MAPR2_FSMC_NADV_REMAP: uInt32  = $00000400;  // FSMC NADV remapping 
{$ENDIF}

{****************************************************************************}
{                                                                            }
{                               SystemTick                                   }
{                                                                            }
{****************************************************************************}

{****************  Bit definition for SysTick_CTRL register  ****************}
  SysTick_CTRL_ENABLE: uInt32  = $00000001;  // Counter enable 
  SysTick_CTRL_TICKINT: uInt32  = $00000002;  // Counting down to 0 pends the SysTick handler 
  SysTick_CTRL_CLKSOURCE: uInt32  = $00000004;  // Clock source 
  SysTick_CTRL_COUNTFLAG: uInt32  = $00010000;  // Count Flag 

{****************  Bit definition for SysTick_LOAD register  ****************}
  SysTick_LOAD_RELOAD: uInt32  = $00FFFFFF;  // Value to load into the SysTick Current Value Register when the counter reaches 0 

{****************  Bit definition for SysTick_VAL register  *****************}
  SysTick_VAL_CURRENT: uInt32  = $00FFFFFF;  // Current value at the time the register is accessed 

{****************  Bit definition for SysTick_CALIB register  ***************}
  SysTick_CALIB_TENMS: uInt32  = $00FFFFFF;  // Reload value to use for 10ms timing 
  SysTick_CALIB_SKEW: uInt32  = $40000000;  // Calibration value is not exactly 10 ms 
  SysTick_CALIB_NOREF: uInt32  = $80000000;  // The reference clock is not provided 

{****************************************************************************}
{                                                                            }
{                  Nested Vectored Interrupt Controller                      }
{                                                                            }
{****************************************************************************}

{*****************  Bit definition for NVIC_ISER register  ******************}
  NVIC_ISER_SETENA: uInt32  = $FFFFFFFF;  // Interrupt set enable bits 
  NVIC_ISER_SETENA_0: uInt32  = $00000001;  // bit 0 
  NVIC_ISER_SETENA_1: uInt32  = $00000002;  // bit 1 
  NVIC_ISER_SETENA_2: uInt32  = $00000004;  // bit 2 
  NVIC_ISER_SETENA_3: uInt32  = $00000008;  // bit 3 
  NVIC_ISER_SETENA_4: uInt32  = $00000010;  // bit 4 
  NVIC_ISER_SETENA_5: uInt32  = $00000020;  // bit 5 
  NVIC_ISER_SETENA_6: uInt32  = $00000040;  // bit 6 
  NVIC_ISER_SETENA_7: uInt32  = $00000080;  // bit 7 
  NVIC_ISER_SETENA_8: uInt32  = $00000100;  // bit 8 
  NVIC_ISER_SETENA_9: uInt32  = $00000200;  // bit 9 
  NVIC_ISER_SETENA_10: uInt32  = $00000400;  // bit 10 
  NVIC_ISER_SETENA_11: uInt32  = $00000800;  // bit 11 
  NVIC_ISER_SETENA_12: uInt32  = $00001000;  // bit 12 
  NVIC_ISER_SETENA_13: uInt32  = $00002000;  // bit 13 
  NVIC_ISER_SETENA_14: uInt32  = $00004000;  // bit 14 
  NVIC_ISER_SETENA_15: uInt32  = $00008000;  // bit 15 
  NVIC_ISER_SETENA_16: uInt32  = $00010000;  // bit 16 
  NVIC_ISER_SETENA_17: uInt32  = $00020000;  // bit 17 
  NVIC_ISER_SETENA_18: uInt32  = $00040000;  // bit 18 
  NVIC_ISER_SETENA_19: uInt32  = $00080000;  // bit 19 
  NVIC_ISER_SETENA_20: uInt32  = $00100000;  // bit 20 
  NVIC_ISER_SETENA_21: uInt32  = $00200000;  // bit 21 
  NVIC_ISER_SETENA_22: uInt32  = $00400000;  // bit 22 
  NVIC_ISER_SETENA_23: uInt32  = $00800000;  // bit 23 
  NVIC_ISER_SETENA_24: uInt32  = $01000000;  // bit 24 
  NVIC_ISER_SETENA_25: uInt32  = $02000000;  // bit 25 
  NVIC_ISER_SETENA_26: uInt32  = $04000000;  // bit 26 
  NVIC_ISER_SETENA_27: uInt32  = $08000000;  // bit 27 
  NVIC_ISER_SETENA_28: uInt32  = $10000000;  // bit 28 
  NVIC_ISER_SETENA_29: uInt32  = $20000000;  // bit 29 
  NVIC_ISER_SETENA_30: uInt32  = $40000000;  // bit 30 
  NVIC_ISER_SETENA_31: uInt32  = $80000000;  // bit 31 

{*****************  Bit definition for NVIC_ICER register  ******************}
  NVIC_ICER_CLRENA: uInt32  = $FFFFFFFF;  // Interrupt clear-enable bits 
  NVIC_ICER_CLRENA_0: uInt32  = $00000001;  // bit 0 
  NVIC_ICER_CLRENA_1: uInt32  = $00000002;  // bit 1 
  NVIC_ICER_CLRENA_2: uInt32  = $00000004;  // bit 2 
  NVIC_ICER_CLRENA_3: uInt32  = $00000008;  // bit 3 
  NVIC_ICER_CLRENA_4: uInt32  = $00000010;  // bit 4 
  NVIC_ICER_CLRENA_5: uInt32  = $00000020;  // bit 5 
  NVIC_ICER_CLRENA_6: uInt32  = $00000040;  // bit 6 
  NVIC_ICER_CLRENA_7: uInt32  = $00000080;  // bit 7 
  NVIC_ICER_CLRENA_8: uInt32  = $00000100;  // bit 8 
  NVIC_ICER_CLRENA_9: uInt32  = $00000200;  // bit 9 
  NVIC_ICER_CLRENA_10: uInt32  = $00000400;  // bit 10 
  NVIC_ICER_CLRENA_11: uInt32  = $00000800;  // bit 11 
  NVIC_ICER_CLRENA_12: uInt32  = $00001000;  // bit 12 
  NVIC_ICER_CLRENA_13: uInt32  = $00002000;  // bit 13 
  NVIC_ICER_CLRENA_14: uInt32  = $00004000;  // bit 14 
  NVIC_ICER_CLRENA_15: uInt32  = $00008000;  // bit 15 
  NVIC_ICER_CLRENA_16: uInt32  = $00010000;  // bit 16 
  NVIC_ICER_CLRENA_17: uInt32  = $00020000;  // bit 17 
  NVIC_ICER_CLRENA_18: uInt32  = $00040000;  // bit 18 
  NVIC_ICER_CLRENA_19: uInt32  = $00080000;  // bit 19 
  NVIC_ICER_CLRENA_20: uInt32  = $00100000;  // bit 20 
  NVIC_ICER_CLRENA_21: uInt32  = $00200000;  // bit 21 
  NVIC_ICER_CLRENA_22: uInt32  = $00400000;  // bit 22 
  NVIC_ICER_CLRENA_23: uInt32  = $00800000;  // bit 23 
  NVIC_ICER_CLRENA_24: uInt32  = $01000000;  // bit 24 
  NVIC_ICER_CLRENA_25: uInt32  = $02000000;  // bit 25 
  NVIC_ICER_CLRENA_26: uInt32  = $04000000;  // bit 26 
  NVIC_ICER_CLRENA_27: uInt32  = $08000000;  // bit 27 
  NVIC_ICER_CLRENA_28: uInt32  = $10000000;  // bit 28 
  NVIC_ICER_CLRENA_29: uInt32  = $20000000;  // bit 29 
  NVIC_ICER_CLRENA_30: uInt32  = $40000000;  // bit 30 
  NVIC_ICER_CLRENA_31: uInt32  = $80000000;  // bit 31 

{*****************  Bit definition for NVIC_ISPR register  ******************}
  NVIC_ISPR_SETPEND: uInt32  = $FFFFFFFF;  // Interrupt set-pending bits 
  NVIC_ISPR_SETPEND_0: uInt32  = $00000001;  // bit 0 
  NVIC_ISPR_SETPEND_1: uInt32  = $00000002;  // bit 1 
  NVIC_ISPR_SETPEND_2: uInt32  = $00000004;  // bit 2 
  NVIC_ISPR_SETPEND_3: uInt32  = $00000008;  // bit 3 
  NVIC_ISPR_SETPEND_4: uInt32  = $00000010;  // bit 4 
  NVIC_ISPR_SETPEND_5: uInt32  = $00000020;  // bit 5 
  NVIC_ISPR_SETPEND_6: uInt32  = $00000040;  // bit 6 
  NVIC_ISPR_SETPEND_7: uInt32  = $00000080;  // bit 7 
  NVIC_ISPR_SETPEND_8: uInt32  = $00000100;  // bit 8 
  NVIC_ISPR_SETPEND_9: uInt32  = $00000200;  // bit 9 
  NVIC_ISPR_SETPEND_10: uInt32  = $00000400;  // bit 10 
  NVIC_ISPR_SETPEND_11: uInt32  = $00000800;  // bit 11 
  NVIC_ISPR_SETPEND_12: uInt32  = $00001000;  // bit 12 
  NVIC_ISPR_SETPEND_13: uInt32  = $00002000;  // bit 13 
  NVIC_ISPR_SETPEND_14: uInt32  = $00004000;  // bit 14 
  NVIC_ISPR_SETPEND_15: uInt32  = $00008000;  // bit 15 
  NVIC_ISPR_SETPEND_16: uInt32  = $00010000;  // bit 16 
  NVIC_ISPR_SETPEND_17: uInt32  = $00020000;  // bit 17 
  NVIC_ISPR_SETPEND_18: uInt32  = $00040000;  // bit 18 
  NVIC_ISPR_SETPEND_19: uInt32  = $00080000;  // bit 19 
  NVIC_ISPR_SETPEND_20: uInt32  = $00100000;  // bit 20 
  NVIC_ISPR_SETPEND_21: uInt32  = $00200000;  // bit 21 
  NVIC_ISPR_SETPEND_22: uInt32  = $00400000;  // bit 22 
  NVIC_ISPR_SETPEND_23: uInt32  = $00800000;  // bit 23 
  NVIC_ISPR_SETPEND_24: uInt32  = $01000000;  // bit 24 
  NVIC_ISPR_SETPEND_25: uInt32  = $02000000;  // bit 25 
  NVIC_ISPR_SETPEND_26: uInt32  = $04000000;  // bit 26 
  NVIC_ISPR_SETPEND_27: uInt32  = $08000000;  // bit 27 
  NVIC_ISPR_SETPEND_28: uInt32  = $10000000;  // bit 28 
  NVIC_ISPR_SETPEND_29: uInt32  = $20000000;  // bit 29 
  NVIC_ISPR_SETPEND_30: uInt32  = $40000000;  // bit 30 
  NVIC_ISPR_SETPEND_31: uInt32  = $80000000;  // bit 31 

{*****************  Bit definition for NVIC_ICPR register  ******************}
  NVIC_ICPR_CLRPEND: uInt32  = $FFFFFFFF;  // Interrupt clear-pending bits 
  NVIC_ICPR_CLRPEND_0: uInt32  = $00000001;  // bit 0 
  NVIC_ICPR_CLRPEND_1: uInt32  = $00000002;  // bit 1 
  NVIC_ICPR_CLRPEND_2: uInt32  = $00000004;  // bit 2 
  NVIC_ICPR_CLRPEND_3: uInt32  = $00000008;  // bit 3 
  NVIC_ICPR_CLRPEND_4: uInt32  = $00000010;  // bit 4 
  NVIC_ICPR_CLRPEND_5: uInt32  = $00000020;  // bit 5 
  NVIC_ICPR_CLRPEND_6: uInt32  = $00000040;  // bit 6 
  NVIC_ICPR_CLRPEND_7: uInt32  = $00000080;  // bit 7 
  NVIC_ICPR_CLRPEND_8: uInt32  = $00000100;  // bit 8 
  NVIC_ICPR_CLRPEND_9: uInt32  = $00000200;  // bit 9 
  NVIC_ICPR_CLRPEND_10: uInt32  = $00000400;  // bit 10 
  NVIC_ICPR_CLRPEND_11: uInt32  = $00000800;  // bit 11 
  NVIC_ICPR_CLRPEND_12: uInt32  = $00001000;  // bit 12 
  NVIC_ICPR_CLRPEND_13: uInt32  = $00002000;  // bit 13 
  NVIC_ICPR_CLRPEND_14: uInt32  = $00004000;  // bit 14 
  NVIC_ICPR_CLRPEND_15: uInt32  = $00008000;  // bit 15 
  NVIC_ICPR_CLRPEND_16: uInt32  = $00010000;  // bit 16 
  NVIC_ICPR_CLRPEND_17: uInt32  = $00020000;  // bit 17 
  NVIC_ICPR_CLRPEND_18: uInt32  = $00040000;  // bit 18 
  NVIC_ICPR_CLRPEND_19: uInt32  = $00080000;  // bit 19 
  NVIC_ICPR_CLRPEND_20: uInt32  = $00100000;  // bit 20 
  NVIC_ICPR_CLRPEND_21: uInt32  = $00200000;  // bit 21 
  NVIC_ICPR_CLRPEND_22: uInt32  = $00400000;  // bit 22 
  NVIC_ICPR_CLRPEND_23: uInt32  = $00800000;  // bit 23 
  NVIC_ICPR_CLRPEND_24: uInt32  = $01000000;  // bit 24 
  NVIC_ICPR_CLRPEND_25: uInt32  = $02000000;  // bit 25 
  NVIC_ICPR_CLRPEND_26: uInt32  = $04000000;  // bit 26 
  NVIC_ICPR_CLRPEND_27: uInt32  = $08000000;  // bit 27 
  NVIC_ICPR_CLRPEND_28: uInt32  = $10000000;  // bit 28 
  NVIC_ICPR_CLRPEND_29: uInt32  = $20000000;  // bit 29 
  NVIC_ICPR_CLRPEND_30: uInt32  = $40000000;  // bit 30 
  NVIC_ICPR_CLRPEND_31: uInt32  = $80000000;  // bit 31 

{*****************  Bit definition for NVIC_IABR register  ******************}
  NVIC_IABR_ACTIVE: uInt32  = $FFFFFFFF;  // Interrupt active flags 
  NVIC_IABR_ACTIVE_0: uInt32  = $00000001;  // bit 0 
  NVIC_IABR_ACTIVE_1: uInt32  = $00000002;  // bit 1 
  NVIC_IABR_ACTIVE_2: uInt32  = $00000004;  // bit 2 
  NVIC_IABR_ACTIVE_3: uInt32  = $00000008;  // bit 3 
  NVIC_IABR_ACTIVE_4: uInt32  = $00000010;  // bit 4 
  NVIC_IABR_ACTIVE_5: uInt32  = $00000020;  // bit 5 
  NVIC_IABR_ACTIVE_6: uInt32  = $00000040;  // bit 6 
  NVIC_IABR_ACTIVE_7: uInt32  = $00000080;  // bit 7 
  NVIC_IABR_ACTIVE_8: uInt32  = $00000100;  // bit 8 
  NVIC_IABR_ACTIVE_9: uInt32  = $00000200;  // bit 9 
  NVIC_IABR_ACTIVE_10: uInt32  = $00000400;  // bit 10 
  NVIC_IABR_ACTIVE_11: uInt32  = $00000800;  // bit 11 
  NVIC_IABR_ACTIVE_12: uInt32  = $00001000;  // bit 12 
  NVIC_IABR_ACTIVE_13: uInt32  = $00002000;  // bit 13 
  NVIC_IABR_ACTIVE_14: uInt32  = $00004000;  // bit 14 
  NVIC_IABR_ACTIVE_15: uInt32  = $00008000;  // bit 15 
  NVIC_IABR_ACTIVE_16: uInt32  = $00010000;  // bit 16 
  NVIC_IABR_ACTIVE_17: uInt32  = $00020000;  // bit 17 
  NVIC_IABR_ACTIVE_18: uInt32  = $00040000;  // bit 18 
  NVIC_IABR_ACTIVE_19: uInt32  = $00080000;  // bit 19 
  NVIC_IABR_ACTIVE_20: uInt32  = $00100000;  // bit 20 
  NVIC_IABR_ACTIVE_21: uInt32  = $00200000;  // bit 21 
  NVIC_IABR_ACTIVE_22: uInt32  = $00400000;  // bit 22 
  NVIC_IABR_ACTIVE_23: uInt32  = $00800000;  // bit 23 
  NVIC_IABR_ACTIVE_24: uInt32  = $01000000;  // bit 24 
  NVIC_IABR_ACTIVE_25: uInt32  = $02000000;  // bit 25 
  NVIC_IABR_ACTIVE_26: uInt32  = $04000000;  // bit 26 
  NVIC_IABR_ACTIVE_27: uInt32  = $08000000;  // bit 27 
  NVIC_IABR_ACTIVE_28: uInt32  = $10000000;  // bit 28 
  NVIC_IABR_ACTIVE_29: uInt32  = $20000000;  // bit 29 
  NVIC_IABR_ACTIVE_30: uInt32  = $40000000;  // bit 30 
  NVIC_IABR_ACTIVE_31: uInt32  = $80000000;  // bit 31 

{*****************  Bit definition for NVIC_PRI0 register  ******************}
  NVIC_IPR0_PRI_0: uInt32  = $000000FF;  // Priority of interrupt 0 
  NVIC_IPR0_PRI_1: uInt32  = $0000FF00;  // Priority of interrupt 1 
  NVIC_IPR0_PRI_2: uInt32  = $00FF0000;  // Priority of interrupt 2 
  NVIC_IPR0_PRI_3: uInt32  = $FF000000;  // Priority of interrupt 3 

{*****************  Bit definition for NVIC_PRI1 register  ******************}
  NVIC_IPR1_PRI_4: uInt32  = $000000FF;  // Priority of interrupt 4 
  NVIC_IPR1_PRI_5: uInt32  = $0000FF00;  // Priority of interrupt 5 
  NVIC_IPR1_PRI_6: uInt32  = $00FF0000;  // Priority of interrupt 6 
  NVIC_IPR1_PRI_7: uInt32  = $FF000000;  // Priority of interrupt 7 

{*****************  Bit definition for NVIC_PRI2 register  ******************}
  NVIC_IPR2_PRI_8: uInt32  = $000000FF;  // Priority of interrupt 8 
  NVIC_IPR2_PRI_9: uInt32  = $0000FF00;  // Priority of interrupt 9 
  NVIC_IPR2_PRI_10: uInt32  = $00FF0000;  // Priority of interrupt 10 
  NVIC_IPR2_PRI_11: uInt32  = $FF000000;  // Priority of interrupt 11 

{*****************  Bit definition for NVIC_PRI3 register  ******************}
  NVIC_IPR3_PRI_12: uInt32  = $000000FF;  // Priority of interrupt 12 
  NVIC_IPR3_PRI_13: uInt32  = $0000FF00;  // Priority of interrupt 13 
  NVIC_IPR3_PRI_14: uInt32  = $00FF0000;  // Priority of interrupt 14 
  NVIC_IPR3_PRI_15: uInt32  = $FF000000;  // Priority of interrupt 15 

{*****************  Bit definition for NVIC_PRI4 register  ******************}
  NVIC_IPR4_PRI_16: uInt32  = $000000FF;  // Priority of interrupt 16 
  NVIC_IPR4_PRI_17: uInt32  = $0000FF00;  // Priority of interrupt 17 
  NVIC_IPR4_PRI_18: uInt32  = $00FF0000;  // Priority of interrupt 18 
  NVIC_IPR4_PRI_19: uInt32  = $FF000000;  // Priority of interrupt 19 

{*****************  Bit definition for NVIC_PRI5 register  ******************}
  NVIC_IPR5_PRI_20: uInt32  = $000000FF;  // Priority of interrupt 20 
  NVIC_IPR5_PRI_21: uInt32  = $0000FF00;  // Priority of interrupt 21 
  NVIC_IPR5_PRI_22: uInt32  = $00FF0000;  // Priority of interrupt 22 
  NVIC_IPR5_PRI_23: uInt32  = $FF000000;  // Priority of interrupt 23 

{*****************  Bit definition for NVIC_PRI6 register  ******************}
  NVIC_IPR6_PRI_24: uInt32  = $000000FF;  // Priority of interrupt 24 
  NVIC_IPR6_PRI_25: uInt32  = $0000FF00;  // Priority of interrupt 25 
  NVIC_IPR6_PRI_26: uInt32  = $00FF0000;  // Priority of interrupt 26 
  NVIC_IPR6_PRI_27: uInt32  = $FF000000;  // Priority of interrupt 27 

{*****************  Bit definition for NVIC_PRI7 register  ******************}
  NVIC_IPR7_PRI_28: uInt32  = $000000FF;  // Priority of interrupt 28 
  NVIC_IPR7_PRI_29: uInt32  = $0000FF00;  // Priority of interrupt 29 
  NVIC_IPR7_PRI_30: uInt32  = $00FF0000;  // Priority of interrupt 30 
  NVIC_IPR7_PRI_31: uInt32  = $FF000000;  // Priority of interrupt 31 

{*****************  Bit definition for SCB_CPUID register  ******************}
  SCB_CPUID_REVISION: uInt32  = $0000000F;  // Implementation defined revision number 
  SCB_CPUID_PARTNO: uInt32  = $0000FFF0;  // Number of processor within family 
  SCB_CPUID_Constant: uInt32  = $000F0000;  // Reads as 0x0F 
  SCB_CPUID_VARIANT: uInt32  = $00F00000;  // Implementation defined variant number 
  SCB_CPUID_IMPLEMENTER: uInt32  = $FF000000;  // Implementer code. ARM is 0x41 

{******************  Bit definition for SCB_ICSR register  ******************}
  SCB_ICSR_VECTACTIVE: uInt32  = $000001FF;  // Active ISR number field 
  SCB_ICSR_RETTOBASE: uInt32  = $00000800;  // All active exceptions minus the IPSR_current_exception yields the empty set 
  SCB_ICSR_VECTPENDING: uInt32  = $003FF000;  // Pending ISR number field 
  SCB_ICSR_ISRPENDING: uInt32  = $00400000;  // Interrupt pending flag 
  SCB_ICSR_ISRPREEMPT: uInt32  = $00800000;  // It indicates that a pending interrupt becomes active in the next running cycle 
  SCB_ICSR_PENDSTCLR: uInt32  = $02000000;  // Clear pending SysTick bit 
  SCB_ICSR_PENDSTSET: uInt32  = $04000000;  // Set pending SysTick bit 
  SCB_ICSR_PENDSVCLR: uInt32  = $08000000;  // Clear pending pendSV bit 
  SCB_ICSR_PENDSVSET: uInt32  = $10000000;  // Set pending pendSV bit 
  SCB_ICSR_NMIPENDSET: uInt32  = $80000000;  // Set pending NMI bit 

{******************  Bit definition for SCB_VTOR register  ******************}
  SCB_VTOR_TBLOFF: uInt32  = $1FFFFF80;  // Vector table base offset field 
  SCB_VTOR_TBLBASE: uInt32  = $20000000;  // Table base in code(0) or RAM(1) 

{*****************  Bit definition for SCB_AIRCR register  ******************}
  SCB_AIRCR_VECTRESET: uInt32  = $00000001;  // System Reset bit 
  SCB_AIRCR_VECTCLRACTIVE: uInt32  = $00000002;  // Clear active vector bit 
  SCB_AIRCR_SYSRESETREQ: uInt32  = $00000004;  // Requests chip control logic to generate a reset 

  SCB_AIRCR_PRIGROUP: uInt32  = $00000700;  // PRIGROUP[2:0] bits (Priority group) 
  SCB_AIRCR_PRIGROUP_0: uInt32  = $00000100;  // Bit 0 
  SCB_AIRCR_PRIGROUP_1: uInt32  = $00000200;  // Bit 1 
  SCB_AIRCR_PRIGROUP_2: uInt32  = $00000400;  // Bit 2  

{ prority group configuration }
  SCB_AIRCR_PRIGROUP0: uInt32  = $00000000;  // Priority group=0 (7 bits of pre-emption priority, 1 bit of subpriority) 
  SCB_AIRCR_PRIGROUP1: uInt32  = $00000100;  // Priority group=1 (6 bits of pre-emption priority, 2 bits of subpriority) 
  SCB_AIRCR_PRIGROUP2: uInt32  = $00000200;  // Priority group=2 (5 bits of pre-emption priority, 3 bits of subpriority) 
  SCB_AIRCR_PRIGROUP3: uInt32  = $00000300;  // Priority group=3 (4 bits of pre-emption priority, 4 bits of subpriority) 
  SCB_AIRCR_PRIGROUP4: uInt32  = $00000400;  // Priority group=4 (3 bits of pre-emption priority, 5 bits of subpriority) 
  SCB_AIRCR_PRIGROUP5: uInt32  = $00000500;  // Priority group=5 (2 bits of pre-emption priority, 6 bits of subpriority) 
  SCB_AIRCR_PRIGROUP6: uInt32  = $00000600;  // Priority group=6 (1 bit of pre-emption priority, 7 bits of subpriority) 
  SCB_AIRCR_PRIGROUP7: uInt32  = $00000700;  // Priority group=7 (no pre-emption priority, 8 bits of subpriority) 

  SCB_AIRCR_ENDIANESS: uInt32  = $00008000;  // Data endianness bit 
  SCB_AIRCR_VECTKEY: uInt32  = $FFFF0000;  // Register key (VECTKEY) - Reads as 0xFA05 (VECTKEYSTAT) 

{******************  Bit definition for SCB_SCR register  *******************}
  SCB_SCR_SLEEPONEXIT: uInt8  = $02;  // Sleep on exit bit 
  SCB_SCR_SLEEPDEEP: uInt8  = $04;  // Sleep deep bit 
  SCB_SCR_SEVONPEND: uInt8  = $10;  // Wake up from WFE 

{*******************  Bit definition for SCB_CCR register  ******************}
  SCB_CCR_NONBASETHRDENA: uInt16  = $0001;  // Thread mode can be entered from any level in Handler mode by controlled return value 
  SCB_CCR_USERSETMPEND: uInt16  = $0002;  // Enables user code to write the Software Trigger Interrupt register to trigger (pend) a Main exception 
  SCB_CCR_UNALIGN_TRP: uInt16  = $0008;  // Trap for unaligned access 
  SCB_CCR_DIV_0_TRP: uInt16  = $0010;  // Trap on Divide by 0 
  SCB_CCR_BFHFNMIGN: uInt16  = $0100;  // Handlers running at priority -1 and -2 
  SCB_CCR_STKALIGN: uInt16  = $0200;  // On exception entry, the SP used prior to the exception is adjusted to be 8-byte aligned 

{******************  Bit definition for SCB_SHPR register *******************}
  SCB_SHPR_PRI_N: uInt32  = $000000FF;  // Priority of system handler 4,8, and 12. Mem Manage, reserved and Debug Monitor 
  SCB_SHPR_PRI_N1: uInt32  = $0000FF00;  // Priority of system handler 5,9, and 13. Bus Fault, reserved and reserved 
  SCB_SHPR_PRI_N2: uInt32  = $00FF0000;  // Priority of system handler 6,10, and 14. Usage Fault, reserved and PendSV 
  SCB_SHPR_PRI_N3: uInt32  = $FF000000;  // Priority of system handler 7,11, and 15. Reserved, SVCall and SysTick 

{*****************  Bit definition for SCB_SHCSR register  ******************}
  SCB_SHCSR_MEMFAULTACT: uInt32  = $00000001;  // MemManage is active 
  SCB_SHCSR_BUSFAULTACT: uInt32  = $00000002;  // BusFault is active 
  SCB_SHCSR_USGFAULTACT: uInt32  = $00000008;  // UsageFault is active 
  SCB_SHCSR_SVCALLACT: uInt32  = $00000080;  // SVCall is active 
  SCB_SHCSR_MONITORACT: uInt32  = $00000100;  // Monitor is active 
  SCB_SHCSR_PENDSVACT: uInt32  = $00000400;  // PendSV is active 
  SCB_SHCSR_SYSTICKACT: uInt32  = $00000800;  // SysTick is active 
  SCB_SHCSR_USGFAULTPENDED: uInt32  = $00001000;  // Usage Fault is pended 
  SCB_SHCSR_MEMFAULTPENDED: uInt32  = $00002000;  // MemManage is pended 
  SCB_SHCSR_BUSFAULTPENDED: uInt32  = $00004000;  // Bus Fault is pended 
  SCB_SHCSR_SVCALLPENDED: uInt32  = $00008000;  // SVCall is pended 
  SCB_SHCSR_MEMFAULTENA: uInt32  = $00010000;  // MemManage enable 
  SCB_SHCSR_BUSFAULTENA: uInt32  = $00020000;  // Bus Fault enable 
  SCB_SHCSR_USGFAULTENA: uInt32  = $00040000;  // UsageFault enable 

{******************  Bit definition for SCB_CFSR register  ******************}
{ MFSR }
  SCB_CFSR_IACCVIOL: uInt32  = $00000001;  // Instruction access violation 
  SCB_CFSR_DACCVIOL: uInt32  = $00000002;  // Data access violation 
  SCB_CFSR_MUNSTKERR: uInt32  = $00000008;  // Unstacking error 
  SCB_CFSR_MSTKERR: uInt32  = $00000010;  // Stacking error 
  SCB_CFSR_MMARVALID: uInt32  = $00000080;  // Memory Manage Address Register address valid flag 
{ BFSR }
  SCB_CFSR_IBUSERR: uInt32  = $00000100;  // Instruction bus error flag 
  SCB_CFSR_PRECISERR: uInt32  = $00000200;  // Precise data bus error 
  SCB_CFSR_IMPRECISERR: uInt32  = $00000400;  // Imprecise data bus error 
  SCB_CFSR_UNSTKERR: uInt32  = $00000800;  // Unstacking error 
  SCB_CFSR_STKERR: uInt32  = $00001000;  // Stacking error 
  SCB_CFSR_BFARVALID: uInt32  = $00008000;  // Bus Fault Address Register address valid flag 
{ UFSR }
  SCB_CFSR_UNDEFINSTR: uInt32  = $00010000;  // The processor attempt to execute an undefined instruction 
  SCB_CFSR_INVSTATE: uInt32  = $00020000;  // Invalid combination of EPSR and instruction 
  SCB_CFSR_INVPC: uInt32  = $00040000;  // Attempt to load EXC_RETURN into pc illegally 
  SCB_CFSR_NOCP: uInt32  = $00080000;  // Attempt to use a coprocessor instruction 
  SCB_CFSR_UNALIGNED: uInt32  = $01000000;  // Fault occurs when there is an attempt to make an unaligned memory access 
  SCB_CFSR_DIVBYZERO: uInt32  = $02000000;  // Fault occurs when SDIV or DIV instruction is used with a divisor of 0 

{******************  Bit definition for SCB_HFSR register  ******************}
  SCB_HFSR_VECTTBL: uInt32  = $00000002;  // Fault occurs because of vector table read on exception processing 
  SCB_HFSR_FORCED: uInt32  = $40000000;  // Hard Fault activated when a configurable Fault was received and cannot activate 
  SCB_HFSR_DEBUGEVT: uInt32  = $80000000;  // Fault related to debug 

{******************  Bit definition for SCB_DFSR register  ******************}
  SCB_DFSR_HALTED: uInt8  = $01;  // Halt request flag 
  SCB_DFSR_BKPT: uInt8  = $02;  // BKPT flag 
  SCB_DFSR_DWTTRAP: uInt8  = $04;  // Data Watchpoint and Trace (DWT) flag 
  SCB_DFSR_VCATCH: uInt8  = $08;  // Vector catch flag 
  SCB_DFSR_EXTERNAL: uInt8  = $10;  // External debug request flag 

{******************  Bit definition for SCB_MMFAR register  *****************}
  SCB_MMFAR_ADDRESS: uInt32  = $FFFFFFFF;  // Mem Manage fault address field 

{******************  Bit definition for SCB_BFAR register  ******************}
  SCB_BFAR_ADDRESS: uInt32  = $FFFFFFFF;  // Bus fault address field 

{******************  Bit definition for SCB_afsr register  ******************}
  SCB_AFSR_IMPDEF: uInt32  = $FFFFFFFF;  // Implementation defined 

{****************************************************************************}
{                                                                            }
{                    External Interrupt/Event Controller                     }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for EXTI_IMR register  ******************}
  EXTI_IMR_MR0: uInt32  = $00000001;  // Interrupt Mask on line 0 
  EXTI_IMR_MR1: uInt32  = $00000002;  // Interrupt Mask on line 1 
  EXTI_IMR_MR2: uInt32  = $00000004;  // Interrupt Mask on line 2 
  EXTI_IMR_MR3: uInt32  = $00000008;  // Interrupt Mask on line 3 
  EXTI_IMR_MR4: uInt32  = $00000010;  // Interrupt Mask on line 4 
  EXTI_IMR_MR5: uInt32  = $00000020;  // Interrupt Mask on line 5 
  EXTI_IMR_MR6: uInt32  = $00000040;  // Interrupt Mask on line 6 
  EXTI_IMR_MR7: uInt32  = $00000080;  // Interrupt Mask on line 7 
  EXTI_IMR_MR8: uInt32  = $00000100;  // Interrupt Mask on line 8 
  EXTI_IMR_MR9: uInt32  = $00000200;  // Interrupt Mask on line 9 
  EXTI_IMR_MR10: uInt32  = $00000400;  // Interrupt Mask on line 10 
  EXTI_IMR_MR11: uInt32  = $00000800;  // Interrupt Mask on line 11 
  EXTI_IMR_MR12: uInt32  = $00001000;  // Interrupt Mask on line 12 
  EXTI_IMR_MR13: uInt32  = $00002000;  // Interrupt Mask on line 13 
  EXTI_IMR_MR14: uInt32  = $00004000;  // Interrupt Mask on line 14 
  EXTI_IMR_MR15: uInt32  = $00008000;  // Interrupt Mask on line 15 
  EXTI_IMR_MR16: uInt32  = $00010000;  // Interrupt Mask on line 16 
  EXTI_IMR_MR17: uInt32  = $00020000;  // Interrupt Mask on line 17 
  EXTI_IMR_MR18: uInt32  = $00040000;  // Interrupt Mask on line 18 
  EXTI_IMR_MR19: uInt32  = $00080000;  // Interrupt Mask on line 19 

{******************  Bit definition for EXTI_EMR register  ******************}
  EXTI_EMR_MR0: uInt32  = $00000001;  // Event Mask on line 0 
  EXTI_EMR_MR1: uInt32  = $00000002;  // Event Mask on line 1 
  EXTI_EMR_MR2: uInt32  = $00000004;  // Event Mask on line 2 
  EXTI_EMR_MR3: uInt32  = $00000008;  // Event Mask on line 3 
  EXTI_EMR_MR4: uInt32  = $00000010;  // Event Mask on line 4 
  EXTI_EMR_MR5: uInt32  = $00000020;  // Event Mask on line 5 
  EXTI_EMR_MR6: uInt32  = $00000040;  // Event Mask on line 6 
  EXTI_EMR_MR7: uInt32  = $00000080;  // Event Mask on line 7 
  EXTI_EMR_MR8: uInt32  = $00000100;  // Event Mask on line 8 
  EXTI_EMR_MR9: uInt32  = $00000200;  // Event Mask on line 9 
  EXTI_EMR_MR10: uInt32  = $00000400;  // Event Mask on line 10 
  EXTI_EMR_MR11: uInt32  = $00000800;  // Event Mask on line 11 
  EXTI_EMR_MR12: uInt32  = $00001000;  // Event Mask on line 12 
  EXTI_EMR_MR13: uInt32  = $00002000;  // Event Mask on line 13 
  EXTI_EMR_MR14: uInt32  = $00004000;  // Event Mask on line 14 
  EXTI_EMR_MR15: uInt32  = $00008000;  // Event Mask on line 15 
  EXTI_EMR_MR16: uInt32  = $00010000;  // Event Mask on line 16 
  EXTI_EMR_MR17: uInt32  = $00020000;  // Event Mask on line 17 
  EXTI_EMR_MR18: uInt32  = $00040000;  // Event Mask on line 18 
  EXTI_EMR_MR19: uInt32  = $00080000;  // Event Mask on line 19 

{*****************  Bit definition for EXTI_RTSR register  ******************}
  EXTI_RTSR_TR0: uInt32  = $00000001;  // Rising trigger event configuration bit of line 0 
  EXTI_RTSR_TR1: uInt32  = $00000002;  // Rising trigger event configuration bit of line 1 
  EXTI_RTSR_TR2: uInt32  = $00000004;  // Rising trigger event configuration bit of line 2 
  EXTI_RTSR_TR3: uInt32  = $00000008;  // Rising trigger event configuration bit of line 3 
  EXTI_RTSR_TR4: uInt32  = $00000010;  // Rising trigger event configuration bit of line 4 
  EXTI_RTSR_TR5: uInt32  = $00000020;  // Rising trigger event configuration bit of line 5 
  EXTI_RTSR_TR6: uInt32  = $00000040;  // Rising trigger event configuration bit of line 6 
  EXTI_RTSR_TR7: uInt32  = $00000080;  // Rising trigger event configuration bit of line 7 
  EXTI_RTSR_TR8: uInt32  = $00000100;  // Rising trigger event configuration bit of line 8 
  EXTI_RTSR_TR9: uInt32  = $00000200;  // Rising trigger event configuration bit of line 9 
  EXTI_RTSR_TR10: uInt32  = $00000400;  // Rising trigger event configuration bit of line 10 
  EXTI_RTSR_TR11: uInt32  = $00000800;  // Rising trigger event configuration bit of line 11 
  EXTI_RTSR_TR12: uInt32  = $00001000;  // Rising trigger event configuration bit of line 12 
  EXTI_RTSR_TR13: uInt32  = $00002000;  // Rising trigger event configuration bit of line 13 
  EXTI_RTSR_TR14: uInt32  = $00004000;  // Rising trigger event configuration bit of line 14 
  EXTI_RTSR_TR15: uInt32  = $00008000;  // Rising trigger event configuration bit of line 15 
  EXTI_RTSR_TR16: uInt32  = $00010000;  // Rising trigger event configuration bit of line 16 
  EXTI_RTSR_TR17: uInt32  = $00020000;  // Rising trigger event configuration bit of line 17 
  EXTI_RTSR_TR18: uInt32  = $00040000;  // Rising trigger event configuration bit of line 18 
  EXTI_RTSR_TR19: uInt32  = $00080000;  // Rising trigger event configuration bit of line 19 

{*****************  Bit definition for EXTI_FTSR register  ******************}
  EXTI_FTSR_TR0: uInt32  = $00000001;  // Falling trigger event configuration bit of line 0 
  EXTI_FTSR_TR1: uInt32  = $00000002;  // Falling trigger event configuration bit of line 1 
  EXTI_FTSR_TR2: uInt32  = $00000004;  // Falling trigger event configuration bit of line 2 
  EXTI_FTSR_TR3: uInt32  = $00000008;  // Falling trigger event configuration bit of line 3 
  EXTI_FTSR_TR4: uInt32  = $00000010;  // Falling trigger event configuration bit of line 4 
  EXTI_FTSR_TR5: uInt32  = $00000020;  // Falling trigger event configuration bit of line 5 
  EXTI_FTSR_TR6: uInt32  = $00000040;  // Falling trigger event configuration bit of line 6 
  EXTI_FTSR_TR7: uInt32  = $00000080;  // Falling trigger event configuration bit of line 7 
  EXTI_FTSR_TR8: uInt32  = $00000100;  // Falling trigger event configuration bit of line 8 
  EXTI_FTSR_TR9: uInt32  = $00000200;  // Falling trigger event configuration bit of line 9 
  EXTI_FTSR_TR10: uInt32  = $00000400;  // Falling trigger event configuration bit of line 10 
  EXTI_FTSR_TR11: uInt32  = $00000800;  // Falling trigger event configuration bit of line 11 
  EXTI_FTSR_TR12: uInt32  = $00001000;  // Falling trigger event configuration bit of line 12 
  EXTI_FTSR_TR13: uInt32  = $00002000;  // Falling trigger event configuration bit of line 13 
  EXTI_FTSR_TR14: uInt32  = $00004000;  // Falling trigger event configuration bit of line 14 
  EXTI_FTSR_TR15: uInt32  = $00008000;  // Falling trigger event configuration bit of line 15 
  EXTI_FTSR_TR16: uInt32  = $00010000;  // Falling trigger event configuration bit of line 16 
  EXTI_FTSR_TR17: uInt32  = $00020000;  // Falling trigger event configuration bit of line 17 
  EXTI_FTSR_TR18: uInt32  = $00040000;  // Falling trigger event configuration bit of line 18 
  EXTI_FTSR_TR19: uInt32  = $00080000;  // Falling trigger event configuration bit of line 19 

{*****************  Bit definition for EXTI_SWIER register  *****************}
  EXTI_SWIER_SWIER0: uInt32  = $00000001;  // Software Interrupt on line 0 
  EXTI_SWIER_SWIER1: uInt32  = $00000002;  // Software Interrupt on line 1 
  EXTI_SWIER_SWIER2: uInt32  = $00000004;  // Software Interrupt on line 2 
  EXTI_SWIER_SWIER3: uInt32  = $00000008;  // Software Interrupt on line 3 
  EXTI_SWIER_SWIER4: uInt32  = $00000010;  // Software Interrupt on line 4 
  EXTI_SWIER_SWIER5: uInt32  = $00000020;  // Software Interrupt on line 5 
  EXTI_SWIER_SWIER6: uInt32  = $00000040;  // Software Interrupt on line 6 
  EXTI_SWIER_SWIER7: uInt32  = $00000080;  // Software Interrupt on line 7 
  EXTI_SWIER_SWIER8: uInt32  = $00000100;  // Software Interrupt on line 8 
  EXTI_SWIER_SWIER9: uInt32  = $00000200;  // Software Interrupt on line 9 
  EXTI_SWIER_SWIER10: uInt32  = $00000400;  // Software Interrupt on line 10 
  EXTI_SWIER_SWIER11: uInt32  = $00000800;  // Software Interrupt on line 11 
  EXTI_SWIER_SWIER12: uInt32  = $00001000;  // Software Interrupt on line 12 
  EXTI_SWIER_SWIER13: uInt32  = $00002000;  // Software Interrupt on line 13 
  EXTI_SWIER_SWIER14: uInt32  = $00004000;  // Software Interrupt on line 14 
  EXTI_SWIER_SWIER15: uInt32  = $00008000;  // Software Interrupt on line 15 
  EXTI_SWIER_SWIER16: uInt32  = $00010000;  // Software Interrupt on line 16 
  EXTI_SWIER_SWIER17: uInt32  = $00020000;  // Software Interrupt on line 17 
  EXTI_SWIER_SWIER18: uInt32  = $00040000;  // Software Interrupt on line 18 
  EXTI_SWIER_SWIER19: uInt32  = $00080000;  // Software Interrupt on line 19 

{******************  Bit definition for EXTI_PR register  *******************}
  EXTI_PR_PR0: uInt32  = $00000001;  // Pending bit for line 0 
  EXTI_PR_PR1: uInt32  = $00000002;  // Pending bit for line 1 
  EXTI_PR_PR2: uInt32  = $00000004;  // Pending bit for line 2 
  EXTI_PR_PR3: uInt32  = $00000008;  // Pending bit for line 3 
  EXTI_PR_PR4: uInt32  = $00000010;  // Pending bit for line 4 
  EXTI_PR_PR5: uInt32  = $00000020;  // Pending bit for line 5 
  EXTI_PR_PR6: uInt32  = $00000040;  // Pending bit for line 6 
  EXTI_PR_PR7: uInt32  = $00000080;  // Pending bit for line 7 
  EXTI_PR_PR8: uInt32  = $00000100;  // Pending bit for line 8 
  EXTI_PR_PR9: uInt32  = $00000200;  // Pending bit for line 9 
  EXTI_PR_PR10: uInt32  = $00000400;  // Pending bit for line 10 
  EXTI_PR_PR11: uInt32  = $00000800;  // Pending bit for line 11 
  EXTI_PR_PR12: uInt32  = $00001000;  // Pending bit for line 12 
  EXTI_PR_PR13: uInt32  = $00002000;  // Pending bit for line 13 
  EXTI_PR_PR14: uInt32  = $00004000;  // Pending bit for line 14 
  EXTI_PR_PR15: uInt32  = $00008000;  // Pending bit for line 15 
  EXTI_PR_PR16: uInt32  = $00010000;  // Pending bit for line 16 
  EXTI_PR_PR17: uInt32  = $00020000;  // Pending bit for line 17 
  EXTI_PR_PR18: uInt32  = $00040000;  // Pending bit for line 18 
  EXTI_PR_PR19: uInt32  = $00080000;  // Pending bit for line 19 

{****************************************************************************}
{                                                                            }
{                             DMA Controller                                 }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for DMA_ISR register  *******************}
  DMA_ISR_GIF1: uInt32  = $00000001;  // Channel 1 Global interrupt flag 
  DMA_ISR_TCIF1: uInt32  = $00000002;  // Channel 1 Transfer Complete flag 
  DMA_ISR_HTIF1: uInt32  = $00000004;  // Channel 1 Half Transfer flag 
  DMA_ISR_TEIF1: uInt32  = $00000008;  // Channel 1 Transfer Error flag 
  DMA_ISR_GIF2: uInt32  = $00000010;  // Channel 2 Global interrupt flag 
  DMA_ISR_TCIF2: uInt32  = $00000020;  // Channel 2 Transfer Complete flag 
  DMA_ISR_HTIF2: uInt32  = $00000040;  // Channel 2 Half Transfer flag 
  DMA_ISR_TEIF2: uInt32  = $00000080;  // Channel 2 Transfer Error flag 
  DMA_ISR_GIF3: uInt32  = $00000100;  // Channel 3 Global interrupt flag 
  DMA_ISR_TCIF3: uInt32  = $00000200;  // Channel 3 Transfer Complete flag 
  DMA_ISR_HTIF3: uInt32  = $00000400;  // Channel 3 Half Transfer flag 
  DMA_ISR_TEIF3: uInt32  = $00000800;  // Channel 3 Transfer Error flag 
  DMA_ISR_GIF4: uInt32  = $00001000;  // Channel 4 Global interrupt flag 
  DMA_ISR_TCIF4: uInt32  = $00002000;  // Channel 4 Transfer Complete flag 
  DMA_ISR_HTIF4: uInt32  = $00004000;  // Channel 4 Half Transfer flag 
  DMA_ISR_TEIF4: uInt32  = $00008000;  // Channel 4 Transfer Error flag 
  DMA_ISR_GIF5: uInt32  = $00010000;  // Channel 5 Global interrupt flag 
  DMA_ISR_TCIF5: uInt32  = $00020000;  // Channel 5 Transfer Complete flag 
  DMA_ISR_HTIF5: uInt32  = $00040000;  // Channel 5 Half Transfer flag 
  DMA_ISR_TEIF5: uInt32  = $00080000;  // Channel 5 Transfer Error flag 
  DMA_ISR_GIF6: uInt32  = $00100000;  // Channel 6 Global interrupt flag 
  DMA_ISR_TCIF6: uInt32  = $00200000;  // Channel 6 Transfer Complete flag 
  DMA_ISR_HTIF6: uInt32  = $00400000;  // Channel 6 Half Transfer flag 
  DMA_ISR_TEIF6: uInt32  = $00800000;  // Channel 6 Transfer Error flag 
  DMA_ISR_GIF7: uInt32  = $01000000;  // Channel 7 Global interrupt flag 
  DMA_ISR_TCIF7: uInt32  = $02000000;  // Channel 7 Transfer Complete flag 
  DMA_ISR_HTIF7: uInt32  = $04000000;  // Channel 7 Half Transfer flag 
  DMA_ISR_TEIF7: uInt32  = $08000000;  // Channel 7 Transfer Error flag 

{******************  Bit definition for DMA_IFCR register  ******************}
  DMA_IFCR_CGIF1: uInt32  = $00000001;  // Channel 1 Global interrupt clear 
  DMA_IFCR_CTCIF1: uInt32  = $00000002;  // Channel 1 Transfer Complete clear 
  DMA_IFCR_CHTIF1: uInt32  = $00000004;  // Channel 1 Half Transfer clear 
  DMA_IFCR_CTEIF1: uInt32  = $00000008;  // Channel 1 Transfer Error clear 
  DMA_IFCR_CGIF2: uInt32  = $00000010;  // Channel 2 Global interrupt clear 
  DMA_IFCR_CTCIF2: uInt32  = $00000020;  // Channel 2 Transfer Complete clear 
  DMA_IFCR_CHTIF2: uInt32  = $00000040;  // Channel 2 Half Transfer clear 
  DMA_IFCR_CTEIF2: uInt32  = $00000080;  // Channel 2 Transfer Error clear 
  DMA_IFCR_CGIF3: uInt32  = $00000100;  // Channel 3 Global interrupt clear 
  DMA_IFCR_CTCIF3: uInt32  = $00000200;  // Channel 3 Transfer Complete clear 
  DMA_IFCR_CHTIF3: uInt32  = $00000400;  // Channel 3 Half Transfer clear 
  DMA_IFCR_CTEIF3: uInt32  = $00000800;  // Channel 3 Transfer Error clear 
  DMA_IFCR_CGIF4: uInt32  = $00001000;  // Channel 4 Global interrupt clear 
  DMA_IFCR_CTCIF4: uInt32  = $00002000;  // Channel 4 Transfer Complete clear 
  DMA_IFCR_CHTIF4: uInt32  = $00004000;  // Channel 4 Half Transfer clear 
  DMA_IFCR_CTEIF4: uInt32  = $00008000;  // Channel 4 Transfer Error clear 
  DMA_IFCR_CGIF5: uInt32  = $00010000;  // Channel 5 Global interrupt clear 
  DMA_IFCR_CTCIF5: uInt32  = $00020000;  // Channel 5 Transfer Complete clear 
  DMA_IFCR_CHTIF5: uInt32  = $00040000;  // Channel 5 Half Transfer clear 
  DMA_IFCR_CTEIF5: uInt32  = $00080000;  // Channel 5 Transfer Error clear 
  DMA_IFCR_CGIF6: uInt32  = $00100000;  // Channel 6 Global interrupt clear 
  DMA_IFCR_CTCIF6: uInt32  = $00200000;  // Channel 6 Transfer Complete clear 
  DMA_IFCR_CHTIF6: uInt32  = $00400000;  // Channel 6 Half Transfer clear 
  DMA_IFCR_CTEIF6: uInt32  = $00800000;  // Channel 6 Transfer Error clear 
  DMA_IFCR_CGIF7: uInt32  = $01000000;  // Channel 7 Global interrupt clear 
  DMA_IFCR_CTCIF7: uInt32  = $02000000;  // Channel 7 Transfer Complete clear 
  DMA_IFCR_CHTIF7: uInt32  = $04000000;  // Channel 7 Half Transfer clear 
  DMA_IFCR_CTEIF7: uInt32  = $08000000;  // Channel 7 Transfer Error clear 

{******************  Bit definition for DMA_CCR1 register  ******************}
  DMA_CCR1_EN: uInt16  = $0001;  // Channel enable
  DMA_CCR1_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR1_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR1_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR1_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR1_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR1_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR1_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR1_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR1_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR1_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR1_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR1_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR1_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR1_PL: uInt16  = $3000;  // PL[1:0] bits(Channel Priority level) 
  DMA_CCR1_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR1_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR1_MEM2MEM: uInt16  = $4000;  // Memory to memory mode 

{******************  Bit definition for DMA_CCR2 register  ******************}
  DMA_CCR2_EN: uInt16  = $0001;  // Channel enable 
  DMA_CCR2_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR2_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR2_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR2_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR2_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR2_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR2_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR2_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR2_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR2_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR2_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR2_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR2_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR2_PL: uInt16  = $3000;  // PL[1:0] bits (Channel Priority level) 
  DMA_CCR2_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR2_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR2_MEM2MEM: uInt16  = $4000;  // Memory to memory mode 

{******************  Bit definition for DMA_CCR3 register  ******************}
  DMA_CCR3_EN: uInt16  = $0001;  // Channel enable 
  DMA_CCR3_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR3_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR3_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR3_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR3_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR3_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR3_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR3_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR3_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR3_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR3_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR3_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR3_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR3_PL: uInt16  = $3000;  // PL[1:0] bits (Channel Priority level) 
  DMA_CCR3_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR3_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR3_MEM2MEM: uInt16  = $4000;  // Memory to memory mode 

{******************  Bit definition for DMA_CCR4 register  ******************}
  DMA_CCR4_EN: uInt16  = $0001;  // Channel enable 
  DMA_CCR4_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR4_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR4_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR4_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR4_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR4_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR4_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR4_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR4_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR4_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR4_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR4_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR4_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR4_PL: uInt16  = $3000;  // PL[1:0] bits (Channel Priority level) 
  DMA_CCR4_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR4_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR4_MEM2MEM: uInt16  = $4000;  // Memory to memory mode 

{*****************  Bit definition for DMA_CCR5 register  ******************}
  DMA_CCR5_EN: uInt16  = $0001;  // Channel enable 
  DMA_CCR5_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR5_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR5_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR5_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR5_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR5_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR5_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR5_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR5_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR5_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR5_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR5_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR5_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR5_PL: uInt16  = $3000;  // PL[1:0] bits (Channel Priority level) 
  DMA_CCR5_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR5_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR5_MEM2MEM: uInt16  = $4000;  // Memory to memory mode enable 

{******************  Bit definition for DMA_CCR6 register  ******************}
  DMA_CCR6_EN: uInt16  = $0001;  // Channel enable 
  DMA_CCR6_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR6_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR6_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR6_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR6_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR6_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR6_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR6_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR6_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR6_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR6_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR6_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR6_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR6_PL: uInt16  = $3000;  // PL[1:0] bits (Channel Priority level) 
  DMA_CCR6_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR6_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR6_MEM2MEM: uInt16  = $4000;  // Memory to memory mode 

{******************  Bit definition for DMA_CCR7 register  ******************}
  DMA_CCR7_EN: uInt16  = $0001;  // Channel enable 
  DMA_CCR7_TCIE: uInt16  = $0002;  // Transfer complete interrupt enable 
  DMA_CCR7_HTIE: uInt16  = $0004;  // Half Transfer interrupt enable 
  DMA_CCR7_TEIE: uInt16  = $0008;  // Transfer error interrupt enable 
  DMA_CCR7_DIR: uInt16  = $0010;  // Data transfer direction 
  DMA_CCR7_CIRC: uInt16  = $0020;  // Circular mode 
  DMA_CCR7_PINC: uInt16  = $0040;  // Peripheral increment mode 
  DMA_CCR7_MINC: uInt16  = $0080;  // Memory increment mode 

  DMA_CCR7_PSIZE: uInt16  = $0300;  // PSIZE[1:0] bits (Peripheral size) 
  DMA_CCR7_PSIZE_0: uInt16  = $0100;  // Bit 0 
  DMA_CCR7_PSIZE_1: uInt16  = $0200;  // Bit 1 

  DMA_CCR7_MSIZE: uInt16  = $0C00;  // MSIZE[1:0] bits (Memory size) 
  DMA_CCR7_MSIZE_0: uInt16  = $0400;  // Bit 0 
  DMA_CCR7_MSIZE_1: uInt16  = $0800;  // Bit 1 

  DMA_CCR7_PL: uInt16  = $3000;  // PL[1:0] bits (Channel Priority level) 
  DMA_CCR7_PL_0: uInt16  = $1000;  // Bit 0 
  DMA_CCR7_PL_1: uInt16  = $2000;  // Bit 1 

  DMA_CCR7_MEM2MEM: uInt16  = $4000;  // Memory to memory mode enable 

{*****************  Bit definition for DMA_CNDTR1 register  *****************}
  DMA_CNDTR1_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CNDTR2 register  *****************}
  DMA_CNDTR2_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CNDTR3 register  *****************}
  DMA_CNDTR3_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CNDTR4 register  *****************}
  DMA_CNDTR4_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CNDTR5 register  *****************}
  DMA_CNDTR5_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CNDTR6 register  *****************}
  DMA_CNDTR6_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CNDTR7 register  *****************}
  DMA_CNDTR7_NDT: uInt16  = $FFFF;  // Number of data to Transfer 

{*****************  Bit definition for DMA_CPAR1 register  ******************}
  DMA_CPAR1_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 

{*****************  Bit definition for DMA_CPAR2 register  ******************}
  DMA_CPAR2_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 

{*****************  Bit definition for DMA_CPAR3 register  ******************}
  DMA_CPAR3_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 


{*****************  Bit definition for DMA_CPAR4 register  ******************}
  DMA_CPAR4_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 

{*****************  Bit definition for DMA_CPAR5 register  ******************}
  DMA_CPAR5_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 

{*****************  Bit definition for DMA_CPAR6 register  ******************}
  DMA_CPAR6_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 


{*****************  Bit definition for DMA_CPAR7 register  ******************}
  DMA_CPAR7_PA: uInt32  = $FFFFFFFF;  // Peripheral Address 

{*****************  Bit definition for DMA_CMAR1 register  ******************}
  DMA_CMAR1_MA: uInt32  = $FFFFFFFF;  // Memory Address 

{*****************  Bit definition for DMA_CMAR2 register  ******************}
  DMA_CMAR2_MA: uInt32  = $FFFFFFFF;  // Memory Address 

{*****************  Bit definition for DMA_CMAR3 register  ******************}
  DMA_CMAR3_MA: uInt32  = $FFFFFFFF;  // Memory Address 


{*****************  Bit definition for DMA_CMAR4 register  ******************}
  DMA_CMAR4_MA: uInt32  = $FFFFFFFF;  // Memory Address 

{*****************  Bit definition for DMA_CMAR5 register  ******************}
  DMA_CMAR5_MA: uInt32  = $FFFFFFFF;  // Memory Address 

{*****************  Bit definition for DMA_CMAR6 register  ******************}
  DMA_CMAR6_MA: uInt32  = $FFFFFFFF;  // Memory Address 

{*****************  Bit definition for DMA_CMAR7 register  ******************}
  DMA_CMAR7_MA: uInt32  = $FFFFFFFF;  // Memory Address 

{****************************************************************************}
{                                                                            }
{                        Analog to Digital Converter                         }
{                                                                            }
{****************************************************************************}

{*******************  Bit definition for ADC_SR register  *******************}
  ADC_SR_AWD: uInt8  = $01;  // Analog watchdog flag 
  ADC_SR_EOC: uInt8  = $02;  // End of conversion 
  ADC_SR_JEOC: uInt8  = $04;  // Injected channel end of conversion 
  ADC_SR_JSTRT: uInt8  = $08;  // Injected channel Start flag 
  ADC_SR_STRT: uInt8  = $10;  // Regular channel Start flag 

{******************  Bit definition for ADC_CR1 register  *******************}
  ADC_CR1_AWDCH: uInt32  = $0000001F;  // AWDCH[4:0] bits (Analog watchdog channel select bits) 
  ADC_CR1_AWDCH_0: uInt32  = $00000001;  // Bit 0 
  ADC_CR1_AWDCH_1: uInt32  = $00000002;  // Bit 1 
  ADC_CR1_AWDCH_2: uInt32  = $00000004;  // Bit 2 
  ADC_CR1_AWDCH_3: uInt32  = $00000008;  // Bit 3 
  ADC_CR1_AWDCH_4: uInt32  = $00000010;  // Bit 4 

  ADC_CR1_EOCIE: uInt32  = $00000020;  // Interrupt enable for EOC 
  ADC_CR1_AWDIE: uInt32  = $00000040;  // Analog Watchdog interrupt enable 
  ADC_CR1_JEOCIE: uInt32  = $00000080;  // Interrupt enable for injected channels 
  ADC_CR1_SCAN: uInt32  = $00000100;  // Scan mode 
  ADC_CR1_AWDSGL: uInt32  = $00000200;  // Enable the watchdog on a single channel in scan mode 
  ADC_CR1_JAUTO: uInt32  = $00000400;  // Automatic injected group conversion 
  ADC_CR1_DISCEN: uInt32  = $00000800;  // Discontinuous mode on regular channels 
  ADC_CR1_JDISCEN: uInt32  = $00001000;  // Discontinuous mode on injected channels 

  ADC_CR1_DISCNUM: uInt32  = $0000E000;  // DISCNUM[2:0] bits (Discontinuous mode channel count) 
  ADC_CR1_DISCNUM_0: uInt32  = $00002000;  // Bit 0 
  ADC_CR1_DISCNUM_1: uInt32  = $00004000;  // Bit 1 
  ADC_CR1_DISCNUM_2: uInt32  = $00008000;  // Bit 2 

  ADC_CR1_DUALMOD: uInt32  = $000F0000;  // DUALMOD[3:0] bits (Dual mode selection) 
  ADC_CR1_DUALMOD_0: uInt32  = $00010000;  // Bit 0 
  ADC_CR1_DUALMOD_1: uInt32  = $00020000;  // Bit 1 
  ADC_CR1_DUALMOD_2: uInt32  = $00040000;  // Bit 2 
  ADC_CR1_DUALMOD_3: uInt32  = $00080000;  // Bit 3 

  ADC_CR1_JAWDEN: uInt32  = $00400000;  // Analog watchdog enable on injected channels 
  ADC_CR1_AWDEN: uInt32  = $00800000;  // Analog watchdog enable on regular channels 


{******************  Bit definition for ADC_CR2 register  *******************}
  ADC_CR2_ADON: uInt32  = $00000001;  // A/D Converter ON / OFF 
  ADC_CR2_CONT: uInt32  = $00000002;  // Continuous Conversion 
  ADC_CR2_CAL: uInt32  = $00000004;  // A/D Calibration 
  ADC_CR2_RSTCAL: uInt32  = $00000008;  // Reset Calibration 
  ADC_CR2_DMA: uInt32  = $00000100;  // Direct Memory access mode 
  ADC_CR2_ALIGN: uInt32  = $00000800;  // Data Alignment 

  ADC_CR2_JEXTSEL: uInt32  = $00007000;  // JEXTSEL[2:0] bits (External event select for injected group) 
  ADC_CR2_JEXTSEL_0: uInt32  = $00001000;  // Bit 0 
  ADC_CR2_JEXTSEL_1: uInt32  = $00002000;  // Bit 1 
  ADC_CR2_JEXTSEL_2: uInt32  = $00004000;  // Bit 2 

  ADC_CR2_JEXTTRIG: uInt32  = $00008000;  // External Trigger Conversion mode for injected channels 

  ADC_CR2_EXTSEL: uInt32  = $000E0000;  // EXTSEL[2:0] bits (External Event Select for regular group) 
  ADC_CR2_EXTSEL_0: uInt32  = $00020000;  // Bit 0 
  ADC_CR2_EXTSEL_1: uInt32  = $00040000;  // Bit 1 
  ADC_CR2_EXTSEL_2: uInt32  = $00080000;  // Bit 2 

  ADC_CR2_EXTTRIG: uInt32  = $00100000;  // External Trigger Conversion mode for regular channels 
  ADC_CR2_JSWSTART: uInt32  = $00200000;  // Start Conversion of injected channels 
  ADC_CR2_SWSTART: uInt32  = $00400000;  // Start Conversion of regular channels 
  ADC_CR2_TSVREFE: uInt32  = $00800000;  // Temperature Sensor and VREFINT Enable 

{*****************  Bit definition for ADC_SMPR1 register  ******************}
  ADC_SMPR1_SMP10: uInt32  = $00000007;  // SMP10[2:0] bits (Channel 10 Sample time selection) 
  ADC_SMPR1_SMP10_0: uInt32  = $00000001;  // Bit 0 
  ADC_SMPR1_SMP10_1: uInt32  = $00000002;  // Bit 1 
  ADC_SMPR1_SMP10_2: uInt32  = $00000004;  // Bit 2 

  ADC_SMPR1_SMP11: uInt32  = $00000038;  // SMP11[2:0] bits (Channel 11 Sample time selection) 
  ADC_SMPR1_SMP11_0: uInt32  = $00000008;  // Bit 0 
  ADC_SMPR1_SMP11_1: uInt32  = $00000010;  // Bit 1 
  ADC_SMPR1_SMP11_2: uInt32  = $00000020;  // Bit 2 

  ADC_SMPR1_SMP12: uInt32  = $000001C0;  // SMP12[2:0] bits (Channel 12 Sample time selection) 
  ADC_SMPR1_SMP12_0: uInt32  = $00000040;  // Bit 0 
  ADC_SMPR1_SMP12_1: uInt32  = $00000080;  // Bit 1 
  ADC_SMPR1_SMP12_2: uInt32  = $00000100;  // Bit 2 

  ADC_SMPR1_SMP13: uInt32  = $00000E00;  // SMP13[2:0] bits (Channel 13 Sample time selection) 
  ADC_SMPR1_SMP13_0: uInt32  = $00000200;  // Bit 0 
  ADC_SMPR1_SMP13_1: uInt32  = $00000400;  // Bit 1 
  ADC_SMPR1_SMP13_2: uInt32  = $00000800;  // Bit 2 

  ADC_SMPR1_SMP14: uInt32  = $00007000;  // SMP14[2:0] bits (Channel 14 Sample time selection) 
  ADC_SMPR1_SMP14_0: uInt32  = $00001000;  // Bit 0 
  ADC_SMPR1_SMP14_1: uInt32  = $00002000;  // Bit 1 
  ADC_SMPR1_SMP14_2: uInt32  = $00004000;  // Bit 2 

  ADC_SMPR1_SMP15: uInt32  = $00038000;  // SMP15[2:0] bits (Channel 15 Sample time selection) 
  ADC_SMPR1_SMP15_0: uInt32  = $00008000;  // Bit 0 
  ADC_SMPR1_SMP15_1: uInt32  = $00010000;  // Bit 1 
  ADC_SMPR1_SMP15_2: uInt32  = $00020000;  // Bit 2 

  ADC_SMPR1_SMP16: uInt32  = $001C0000;  // SMP16[2:0] bits (Channel 16 Sample time selection) 
  ADC_SMPR1_SMP16_0: uInt32  = $00040000;  // Bit 0 
  ADC_SMPR1_SMP16_1: uInt32  = $00080000;  // Bit 1 
  ADC_SMPR1_SMP16_2: uInt32  = $00100000;  // Bit 2 

  ADC_SMPR1_SMP17: uInt32  = $00E00000;  // SMP17[2:0] bits (Channel 17 Sample time selection) 
  ADC_SMPR1_SMP17_0: uInt32  = $00200000;  // Bit 0 
  ADC_SMPR1_SMP17_1: uInt32  = $00400000;  // Bit 1 
  ADC_SMPR1_SMP17_2: uInt32  = $00800000;  // Bit 2 

{*****************  Bit definition for ADC_SMPR2 register  ******************}
  ADC_SMPR2_SMP0: uInt32  = $00000007;  // SMP0[2:0] bits (Channel 0 Sample time selection) 
  ADC_SMPR2_SMP0_0: uInt32  = $00000001;  // Bit 0 
  ADC_SMPR2_SMP0_1: uInt32  = $00000002;  // Bit 1 
  ADC_SMPR2_SMP0_2: uInt32  = $00000004;  // Bit 2 

  ADC_SMPR2_SMP1: uInt32  = $00000038;  // SMP1[2:0] bits (Channel 1 Sample time selection) 
  ADC_SMPR2_SMP1_0: uInt32  = $00000008;  // Bit 0 
  ADC_SMPR2_SMP1_1: uInt32  = $00000010;  // Bit 1 
  ADC_SMPR2_SMP1_2: uInt32  = $00000020;  // Bit 2 

  ADC_SMPR2_SMP2: uInt32  = $000001C0;  // SMP2[2:0] bits (Channel 2 Sample time selection) 
  ADC_SMPR2_SMP2_0: uInt32  = $00000040;  // Bit 0 
  ADC_SMPR2_SMP2_1: uInt32  = $00000080;  // Bit 1 
  ADC_SMPR2_SMP2_2: uInt32  = $00000100;  // Bit 2 

  ADC_SMPR2_SMP3: uInt32  = $00000E00;  // SMP3[2:0] bits (Channel 3 Sample time selection) 
  ADC_SMPR2_SMP3_0: uInt32  = $00000200;  // Bit 0 
  ADC_SMPR2_SMP3_1: uInt32  = $00000400;  // Bit 1 
  ADC_SMPR2_SMP3_2: uInt32  = $00000800;  // Bit 2 

  ADC_SMPR2_SMP4: uInt32  = $00007000;  // SMP4[2:0] bits (Channel 4 Sample time selection) 
  ADC_SMPR2_SMP4_0: uInt32  = $00001000;  // Bit 0 
  ADC_SMPR2_SMP4_1: uInt32  = $00002000;  // Bit 1 
  ADC_SMPR2_SMP4_2: uInt32  = $00004000;  // Bit 2 

  ADC_SMPR2_SMP5: uInt32  = $00038000;  // SMP5[2:0] bits (Channel 5 Sample time selection) 
  ADC_SMPR2_SMP5_0: uInt32  = $00008000;  // Bit 0 
  ADC_SMPR2_SMP5_1: uInt32  = $00010000;  // Bit 1 
  ADC_SMPR2_SMP5_2: uInt32  = $00020000;  // Bit 2 

  ADC_SMPR2_SMP6: uInt32  = $001C0000;  // SMP6[2:0] bits (Channel 6 Sample time selection) 
  ADC_SMPR2_SMP6_0: uInt32  = $00040000;  // Bit 0 
  ADC_SMPR2_SMP6_1: uInt32  = $00080000;  // Bit 1 
  ADC_SMPR2_SMP6_2: uInt32  = $00100000;  // Bit 2 

  ADC_SMPR2_SMP7: uInt32  = $00E00000;  // SMP7[2:0] bits (Channel 7 Sample time selection) 
  ADC_SMPR2_SMP7_0: uInt32  = $00200000;  // Bit 0 
  ADC_SMPR2_SMP7_1: uInt32  = $00400000;  // Bit 1 
  ADC_SMPR2_SMP7_2: uInt32  = $00800000;  // Bit 2 

  ADC_SMPR2_SMP8: uInt32  = $07000000;  // SMP8[2:0] bits (Channel 8 Sample time selection) 
  ADC_SMPR2_SMP8_0: uInt32  = $01000000;  // Bit 0 
  ADC_SMPR2_SMP8_1: uInt32  = $02000000;  // Bit 1 
  ADC_SMPR2_SMP8_2: uInt32  = $04000000;  // Bit 2 

  ADC_SMPR2_SMP9: uInt32  = $38000000;  // SMP9[2:0] bits (Channel 9 Sample time selection) 
  ADC_SMPR2_SMP9_0: uInt32  = $08000000;  // Bit 0 
  ADC_SMPR2_SMP9_1: uInt32  = $10000000;  // Bit 1 
  ADC_SMPR2_SMP9_2: uInt32  = $20000000;  // Bit 2 

{*****************  Bit definition for ADC_JOFR1 register  ******************}
  ADC_JOFR1_JOFFSET1: uInt16  = $0FFF;  // Data offset for injected channel 1 

{*****************  Bit definition for ADC_JOFR2 register  ******************}
  ADC_JOFR2_JOFFSET2: uInt16  = $0FFF;  // Data offset for injected channel 2 

{*****************  Bit definition for ADC_JOFR3 register  ******************}
  ADC_JOFR3_JOFFSET3: uInt16  = $0FFF;  // Data offset for injected channel 3 

{*****************  Bit definition for ADC_JOFR4 register  ******************}
  ADC_JOFR4_JOFFSET4: uInt16  = $0FFF;  // Data offset for injected channel 4 

{******************  Bit definition for ADC_HTR register  *******************}
  ADC_HTR_HT: uInt16  = $0FFF;  // Analog watchdog high threshold 

{******************  Bit definition for ADC_LTR register  *******************}
  ADC_LTR_LT: uInt16  = $0FFF;  // Analog watchdog low threshold 

{******************  Bit definition for ADC_SQR1 register  ******************}
  ADC_SQR1_SQ13: uInt32  = $0000001F;  // SQ13[4:0] bits (13th conversion in regular sequence) 
  ADC_SQR1_SQ13_0: uInt32  = $00000001;  // Bit 0 
  ADC_SQR1_SQ13_1: uInt32  = $00000002;  // Bit 1 
  ADC_SQR1_SQ13_2: uInt32  = $00000004;  // Bit 2 
  ADC_SQR1_SQ13_3: uInt32  = $00000008;  // Bit 3 
  ADC_SQR1_SQ13_4: uInt32  = $00000010;  // Bit 4 

  ADC_SQR1_SQ14: uInt32  = $000003E0;  // SQ14[4:0] bits (14th conversion in regular sequence) 
  ADC_SQR1_SQ14_0: uInt32  = $00000020;  // Bit 0 
  ADC_SQR1_SQ14_1: uInt32  = $00000040;  // Bit 1 
  ADC_SQR1_SQ14_2: uInt32  = $00000080;  // Bit 2 
  ADC_SQR1_SQ14_3: uInt32  = $00000100;  // Bit 3 
  ADC_SQR1_SQ14_4: uInt32  = $00000200;  // Bit 4 

  ADC_SQR1_SQ15: uInt32  = $00007C00;  // SQ15[4:0] bits (15th conversion in regular sequence) 
  ADC_SQR1_SQ15_0: uInt32  = $00000400;  // Bit 0 
  ADC_SQR1_SQ15_1: uInt32  = $00000800;  // Bit 1 
  ADC_SQR1_SQ15_2: uInt32  = $00001000;  // Bit 2 
  ADC_SQR1_SQ15_3: uInt32  = $00002000;  // Bit 3 
  ADC_SQR1_SQ15_4: uInt32  = $00004000;  // Bit 4 

  ADC_SQR1_SQ16: uInt32  = $000F8000;  // SQ16[4:0] bits (16th conversion in regular sequence) 
  ADC_SQR1_SQ16_0: uInt32  = $00008000;  // Bit 0 
  ADC_SQR1_SQ16_1: uInt32  = $00010000;  // Bit 1 
  ADC_SQR1_SQ16_2: uInt32  = $00020000;  // Bit 2 
  ADC_SQR1_SQ16_3: uInt32  = $00040000;  // Bit 3 
  ADC_SQR1_SQ16_4: uInt32  = $00080000;  // Bit 4 

  ADC_SQR1_L: uInt32  = $00F00000;  // L[3:0] bits (Regular channel sequence length) 
  ADC_SQR1_L_0: uInt32  = $00100000;  // Bit 0 
  ADC_SQR1_L_1: uInt32  = $00200000;  // Bit 1 
  ADC_SQR1_L_2: uInt32  = $00400000;  // Bit 2 
  ADC_SQR1_L_3: uInt32  = $00800000;  // Bit 3 

{******************  Bit definition for ADC_SQR2 register  ******************}
  ADC_SQR2_SQ7: uInt32  = $0000001F;  // SQ7[4:0] bits (7th conversion in regular sequence) 
  ADC_SQR2_SQ7_0: uInt32  = $00000001;  // Bit 0 
  ADC_SQR2_SQ7_1: uInt32  = $00000002;  // Bit 1 
  ADC_SQR2_SQ7_2: uInt32  = $00000004;  // Bit 2 
  ADC_SQR2_SQ7_3: uInt32  = $00000008;  // Bit 3 
  ADC_SQR2_SQ7_4: uInt32  = $00000010;  // Bit 4 

  ADC_SQR2_SQ8: uInt32  = $000003E0;  // SQ8[4:0] bits (8th conversion in regular sequence) 
  ADC_SQR2_SQ8_0: uInt32  = $00000020;  // Bit 0 
  ADC_SQR2_SQ8_1: uInt32  = $00000040;  // Bit 1 
  ADC_SQR2_SQ8_2: uInt32  = $00000080;  // Bit 2 
  ADC_SQR2_SQ8_3: uInt32  = $00000100;  // Bit 3 
  ADC_SQR2_SQ8_4: uInt32  = $00000200;  // Bit 4 

  ADC_SQR2_SQ9: uInt32  = $00007C00;  // SQ9[4:0] bits (9th conversion in regular sequence) 
  ADC_SQR2_SQ9_0: uInt32  = $00000400;  // Bit 0 
  ADC_SQR2_SQ9_1: uInt32  = $00000800;  // Bit 1 
  ADC_SQR2_SQ9_2: uInt32  = $00001000;  // Bit 2 
  ADC_SQR2_SQ9_3: uInt32  = $00002000;  // Bit 3 
  ADC_SQR2_SQ9_4: uInt32  = $00004000;  // Bit 4 

  ADC_SQR2_SQ10: uInt32  = $000F8000;  // SQ10[4:0] bits (10th conversion in regular sequence) 
  ADC_SQR2_SQ10_0: uInt32  = $00008000;  // Bit 0 
  ADC_SQR2_SQ10_1: uInt32  = $00010000;  // Bit 1 
  ADC_SQR2_SQ10_2: uInt32  = $00020000;  // Bit 2 
  ADC_SQR2_SQ10_3: uInt32  = $00040000;  // Bit 3 
  ADC_SQR2_SQ10_4: uInt32  = $00080000;  // Bit 4 

  ADC_SQR2_SQ11: uInt32  = $01F00000;  // SQ11[4:0] bits (11th conversion in regular sequence) 
  ADC_SQR2_SQ11_0: uInt32  = $00100000;  // Bit 0 
  ADC_SQR2_SQ11_1: uInt32  = $00200000;  // Bit 1 
  ADC_SQR2_SQ11_2: uInt32  = $00400000;  // Bit 2 
  ADC_SQR2_SQ11_3: uInt32  = $00800000;  // Bit 3 
  ADC_SQR2_SQ11_4: uInt32  = $01000000;  // Bit 4 

  ADC_SQR2_SQ12: uInt32  = $3E000000;  // SQ12[4:0] bits (12th conversion in regular sequence) 
  ADC_SQR2_SQ12_0: uInt32  = $02000000;  // Bit 0 
  ADC_SQR2_SQ12_1: uInt32  = $04000000;  // Bit 1 
  ADC_SQR2_SQ12_2: uInt32  = $08000000;  // Bit 2 
  ADC_SQR2_SQ12_3: uInt32  = $10000000;  // Bit 3 
  ADC_SQR2_SQ12_4: uInt32  = $20000000;  // Bit 4 

{******************  Bit definition for ADC_SQR3 register  ******************}
  ADC_SQR3_SQ1: uInt32  = $0000001F;  // SQ1[4:0] bits (1st conversion in regular sequence) 
  ADC_SQR3_SQ1_0: uInt32  = $00000001;  // Bit 0 
  ADC_SQR3_SQ1_1: uInt32  = $00000002;  // Bit 1 
  ADC_SQR3_SQ1_2: uInt32  = $00000004;  // Bit 2 
  ADC_SQR3_SQ1_3: uInt32  = $00000008;  // Bit 3 
  ADC_SQR3_SQ1_4: uInt32  = $00000010;  // Bit 4 

  ADC_SQR3_SQ2: uInt32  = $000003E0;  // SQ2[4:0] bits (2nd conversion in regular sequence) 
  ADC_SQR3_SQ2_0: uInt32  = $00000020;  // Bit 0 
  ADC_SQR3_SQ2_1: uInt32  = $00000040;  // Bit 1 
  ADC_SQR3_SQ2_2: uInt32  = $00000080;  // Bit 2 
  ADC_SQR3_SQ2_3: uInt32  = $00000100;  // Bit 3 
  ADC_SQR3_SQ2_4: uInt32  = $00000200;  // Bit 4 

  ADC_SQR3_SQ3: uInt32  = $00007C00;  // SQ3[4:0] bits (3rd conversion in regular sequence) 
  ADC_SQR3_SQ3_0: uInt32  = $00000400;  // Bit 0 
  ADC_SQR3_SQ3_1: uInt32  = $00000800;  // Bit 1 
  ADC_SQR3_SQ3_2: uInt32  = $00001000;  // Bit 2 
  ADC_SQR3_SQ3_3: uInt32  = $00002000;  // Bit 3 
  ADC_SQR3_SQ3_4: uInt32  = $00004000;  // Bit 4 

  ADC_SQR3_SQ4: uInt32  = $000F8000;  // SQ4[4:0] bits (4th conversion in regular sequence) 
  ADC_SQR3_SQ4_0: uInt32  = $00008000;  // Bit 0 
  ADC_SQR3_SQ4_1: uInt32  = $00010000;  // Bit 1 
  ADC_SQR3_SQ4_2: uInt32  = $00020000;  // Bit 2 
  ADC_SQR3_SQ4_3: uInt32  = $00040000;  // Bit 3 
  ADC_SQR3_SQ4_4: uInt32  = $00080000;  // Bit 4 

  ADC_SQR3_SQ5: uInt32  = $01F00000;  // SQ5[4:0] bits (5th conversion in regular sequence) 
  ADC_SQR3_SQ5_0: uInt32  = $00100000;  // Bit 0 
  ADC_SQR3_SQ5_1: uInt32  = $00200000;  // Bit 1 
  ADC_SQR3_SQ5_2: uInt32  = $00400000;  // Bit 2 
  ADC_SQR3_SQ5_3: uInt32  = $00800000;  // Bit 3 
  ADC_SQR3_SQ5_4: uInt32  = $01000000;  // Bit 4 

  ADC_SQR3_SQ6: uInt32  = $3E000000;  // SQ6[4:0] bits (6th conversion in regular sequence) 
  ADC_SQR3_SQ6_0: uInt32  = $02000000;  // Bit 0 
  ADC_SQR3_SQ6_1: uInt32  = $04000000;  // Bit 1 
  ADC_SQR3_SQ6_2: uInt32  = $08000000;  // Bit 2 
  ADC_SQR3_SQ6_3: uInt32  = $10000000;  // Bit 3 
  ADC_SQR3_SQ6_4: uInt32  = $20000000;  // Bit 4 

{******************  Bit definition for ADC_JSQR register  ******************}
  ADC_JSQR_JSQ1: uInt32  = $0000001F;  // JSQ1[4:0] bits (1st conversion in injected sequence) 
  ADC_JSQR_JSQ1_0: uInt32  = $00000001;  // Bit 0 
  ADC_JSQR_JSQ1_1: uInt32  = $00000002;  // Bit 1 
  ADC_JSQR_JSQ1_2: uInt32  = $00000004;  // Bit 2 
  ADC_JSQR_JSQ1_3: uInt32  = $00000008;  // Bit 3 
  ADC_JSQR_JSQ1_4: uInt32  = $00000010;  // Bit 4 

  ADC_JSQR_JSQ2: uInt32  = $000003E0;  // JSQ2[4:0] bits (2nd conversion in injected sequence) 
  ADC_JSQR_JSQ2_0: uInt32  = $00000020;  // Bit 0 
  ADC_JSQR_JSQ2_1: uInt32  = $00000040;  // Bit 1 
  ADC_JSQR_JSQ2_2: uInt32  = $00000080;  // Bit 2 
  ADC_JSQR_JSQ2_3: uInt32  = $00000100;  // Bit 3 
  ADC_JSQR_JSQ2_4: uInt32  = $00000200;  // Bit 4 

  ADC_JSQR_JSQ3: uInt32  = $00007C00;  // JSQ3[4:0] bits (3rd conversion in injected sequence) 
  ADC_JSQR_JSQ3_0: uInt32  = $00000400;  // Bit 0 
  ADC_JSQR_JSQ3_1: uInt32  = $00000800;  // Bit 1 
  ADC_JSQR_JSQ3_2: uInt32  = $00001000;  // Bit 2 
  ADC_JSQR_JSQ3_3: uInt32  = $00002000;  // Bit 3 
  ADC_JSQR_JSQ3_4: uInt32  = $00004000;  // Bit 4 

  ADC_JSQR_JSQ4: uInt32  = $000F8000;  // JSQ4[4:0] bits (4th conversion in injected sequence) 
  ADC_JSQR_JSQ4_0: uInt32  = $00008000;  // Bit 0 
  ADC_JSQR_JSQ4_1: uInt32  = $00010000;  // Bit 1 
  ADC_JSQR_JSQ4_2: uInt32  = $00020000;  // Bit 2 
  ADC_JSQR_JSQ4_3: uInt32  = $00040000;  // Bit 3 
  ADC_JSQR_JSQ4_4: uInt32  = $00080000;  // Bit 4 

  ADC_JSQR_JL: uInt32  = $00300000;  // JL[1:0] bits (Injected Sequence length) 
  ADC_JSQR_JL_0: uInt32  = $00100000;  // Bit 0 
  ADC_JSQR_JL_1: uInt32  = $00200000;  // Bit 1 

{******************  Bit definition for ADC_JDR1 register  ******************}
  ADC_JDR1_JDATA: uInt16  = $FFFF;  // Injected data 

{******************  Bit definition for ADC_JDR2 register  ******************}
  ADC_JDR2_JDATA: uInt16  = $FFFF;  // Injected data 

{******************  Bit definition for ADC_JDR3 register  ******************}
  ADC_JDR3_JDATA: uInt16  = $FFFF;  // Injected data 

{******************  Bit definition for ADC_JDR4 register  ******************}
  ADC_JDR4_JDATA: uInt16  = $FFFF;  // Injected data 

{*******************  Bit definition for ADC_DR register  *******************}
  ADC_DR_DATA: uInt32  = $0000FFFF;  // Regular data 
  ADC_DR_ADC2DATA: uInt32  = $FFFF0000;  // ADC2 data 

{****************************************************************************}
{                                                                            }
{                      Digital to Analog Converter                           }
{                                                                            }
{****************************************************************************}

{*******************  Bit definition for DAC_CR register  *******************}
  DAC_CR_EN1: uInt32  = $00000001;  // DAC channel1 enable 
  DAC_CR_BOFF1: uInt32  = $00000002;  // DAC channel1 output buffer disable 
  DAC_CR_TEN1: uInt32  = $00000004;  // DAC channel1 Trigger enable 

  DAC_CR_TSEL1: uInt32  = $00000038;  // TSEL1[2:0] (DAC channel1 Trigger selection) 
  DAC_CR_TSEL1_0: uInt32  = $00000008;  // Bit 0 
  DAC_CR_TSEL1_1: uInt32  = $00000010;  // Bit 1 
  DAC_CR_TSEL1_2: uInt32  = $00000020;  // Bit 2 

  DAC_CR_WAVE1: uInt32  = $000000C0;  // WAVE1[1:0] (DAC channel1 noise/triangle wave generation enable) 
  DAC_CR_WAVE1_0: uInt32  = $00000040;  // Bit 0 
  DAC_CR_WAVE1_1: uInt32  = $00000080;  // Bit 1 

  DAC_CR_MAMP1: uInt32  = $00000F00;  // MAMP1[3:0] (DAC channel1 Mask/Amplitude selector) 
  DAC_CR_MAMP1_0: uInt32  = $00000100;  // Bit 0 
  DAC_CR_MAMP1_1: uInt32  = $00000200;  // Bit 1 
  DAC_CR_MAMP1_2: uInt32  = $00000400;  // Bit 2 
  DAC_CR_MAMP1_3: uInt32  = $00000800;  // Bit 3 

  DAC_CR_DMAEN1: uInt32  = $00001000;  // DAC channel1 DMA enable 
  DAC_CR_EN2: uInt32  = $00010000;  // DAC channel2 enable 
  DAC_CR_BOFF2: uInt32  = $00020000;  // DAC channel2 output buffer disable 
  DAC_CR_TEN2: uInt32  = $00040000;  // DAC channel2 Trigger enable 

  DAC_CR_TSEL2: uInt32  = $00380000;  // TSEL2[2:0] (DAC channel2 Trigger selection) 
  DAC_CR_TSEL2_0: uInt32  = $00080000;  // Bit 0 
  DAC_CR_TSEL2_1: uInt32  = $00100000;  // Bit 1 
  DAC_CR_TSEL2_2: uInt32  = $00200000;  // Bit 2 

  DAC_CR_WAVE2: uInt32  = $00C00000;  // WAVE2[1:0] (DAC channel2 noise/triangle wave generation enable) 
  DAC_CR_WAVE2_0: uInt32  = $00400000;  // Bit 0 
  DAC_CR_WAVE2_1: uInt32  = $00800000;  // Bit 1 

  DAC_CR_MAMP2: uInt32  = $0F000000;  // MAMP2[3:0] (DAC channel2 Mask/Amplitude selector) 
  DAC_CR_MAMP2_0: uInt32  = $01000000;  // Bit 0 
  DAC_CR_MAMP2_1: uInt32  = $02000000;  // Bit 1 
  DAC_CR_MAMP2_2: uInt32  = $04000000;  // Bit 2 
  DAC_CR_MAMP2_3: uInt32  = $08000000;  // Bit 3 

  DAC_CR_DMAEN2: uInt32  = $10000000;  // DAC channel2 DMA enabled 

{****************  Bit definition for DAC_SWTRIGR register  *****************}
  DAC_SWTRIGR_SWTRIG1: uInt8  = $01;  // DAC channel1 software trigger 
  DAC_SWTRIGR_SWTRIG2: uInt8  = $02;  // DAC channel2 software trigger 

{****************  Bit definition for DAC_DHR12R1 register  *****************}
  DAC_DHR12R1_DACC1DHR: uInt16  = $0FFF;  // DAC channel1 12-bit Right aligned data 

{****************  Bit definition for DAC_DHR12L1 register  *****************}
  DAC_DHR12L1_DACC1DHR: uInt16  = $FFF0;  // DAC channel1 12-bit Left aligned data 

{*****************  Bit definition for DAC_DHR8R1 register  *****************}
  DAC_DHR8R1_DACC1DHR: uInt8  = $FF;  // DAC channel1 8-bit Right aligned data 

{****************  Bit definition for DAC_DHR12R2 register  *****************}
  DAC_DHR12R2_DACC2DHR: uInt16  = $0FFF;  // DAC channel2 12-bit Right aligned data 

{****************  Bit definition for DAC_DHR12L2 register  *****************}
  DAC_DHR12L2_DACC2DHR: uInt16  = $FFF0;  // DAC channel2 12-bit Left aligned data 

{*****************  Bit definition for DAC_DHR8R2 register  *****************}
  DAC_DHR8R2_DACC2DHR: uInt8  = $FF;  // DAC channel2 8-bit Right aligned data 

{****************  Bit definition for DAC_DHR12RD register  *****************}
  DAC_DHR12RD_DACC1DHR: uInt32  = $00000FFF;  // DAC channel1 12-bit Right aligned data 
  DAC_DHR12RD_DACC2DHR: uInt32  = $0FFF0000;  // DAC channel2 12-bit Right aligned data 

{****************  Bit definition for DAC_DHR12LD register  *****************}
  DAC_DHR12LD_DACC1DHR: uInt32  = $0000FFF0;  // DAC channel1 12-bit Left aligned data 
  DAC_DHR12LD_DACC2DHR: uInt32  = $FFF00000;  // DAC channel2 12-bit Left aligned data 

{*****************  Bit definition for DAC_DHR8RD register  *****************}
  DAC_DHR8RD_DACC1DHR: uInt16  = $00FF;  // DAC channel1 8-bit Right aligned data 
  DAC_DHR8RD_DACC2DHR: uInt16  = $FF00;  // DAC channel2 8-bit Right aligned data 

{******************  Bit definition for DAC_DOR1 register  ******************}
  DAC_DOR1_DACC1DOR: uInt16  = $0FFF;  // DAC channel1 data output 

{******************  Bit definition for DAC_DOR2 register  ******************}
  DAC_DOR2_DACC2DOR: uInt16  = $0FFF;  // DAC channel2 data output 

{*******************  Bit definition for DAC_SR register  *******************}
  DAC_SR_DMAUDR1: uInt32  = $00002000;  // DAC channel1 DMA underrun flag 
  DAC_SR_DMAUDR2: uInt32  = $20000000;  // DAC channel2 DMA underrun flag 

{****************************************************************************}
{                                                                            }
{                                    CEC                                     }
{                                                                            }
{****************************************************************************}
{*******************  Bit definition for CEC_CFGR register  *****************}
  CEC_CFGR_PE: uInt16  = $0001;  //  Peripheral Enable 
  CEC_CFGR_IE: uInt16  = $0002;  //  Interrupt Enable 
  CEC_CFGR_BTEM: uInt16  = $0004;  //  Bit Timing Error Mode 
  CEC_CFGR_BPEM: uInt16  = $0008;  //  Bit Period Error Mode 

{*******************  Bit definition for CEC_OAR register  *****************}
  CEC_OAR_OA: uInt16  = $000F;  //  OA[3:0]: Own Address 
  CEC_OAR_OA_0: uInt16  = $0001;  //  Bit 0 
  CEC_OAR_OA_1: uInt16  = $0002;  //  Bit 1 
  CEC_OAR_OA_2: uInt16  = $0004;  //  Bit 2 
  CEC_OAR_OA_3: uInt16  = $0008;  //  Bit 3 

{*******************  Bit definition for CEC_PRES register  *****************}
  CEC_PRES_PRES: uInt16  = $3FFF;  //  Prescaler Counter Value 

{*******************  Bit definition for CEC_ESR register  *****************}
  CEC_ESR_BTE: uInt16  = $0001;  //  Bit Timing Error 
  CEC_ESR_BPE: uInt16  = $0002;  //  Bit Period Error 
  CEC_ESR_RBTFE: uInt16  = $0004;  //  Rx Block Transfer Finished Error 
  CEC_ESR_SBE: uInt16  = $0008;  //  Start Bit Error 
  CEC_ESR_ACKE: uInt16  = $0010;  //  Block Acknowledge Error 
  CEC_ESR_LINE: uInt16  = $0020;  //  Line Error 
  CEC_ESR_TBTFE: uInt16  = $0040;  //  Tx Block Transfer Finished Error 

{*******************  Bit definition for CEC_CSR register  *****************}
  CEC_CSR_TSOM: uInt16  = $0001;  //  Tx Start Of Message 
  CEC_CSR_TEOM: uInt16  = $0002;  //  Tx End Of Message 
  CEC_CSR_TERR: uInt16  = $0004;  //  Tx Error 
  CEC_CSR_TBTRF: uInt16  = $0008;  //  Tx Byte Transfer Request or Block Transfer Finished 
  CEC_CSR_RSOM: uInt16  = $0010;  //  Rx Start Of Message 
  CEC_CSR_REOM: uInt16  = $0020;  //  Rx End Of Message 
  CEC_CSR_RERR: uInt16  = $0040;  //  Rx Error 
  CEC_CSR_RBTF: uInt16  = $0080;  //  Rx Block Transfer Finished 

{*******************  Bit definition for CEC_TXD register  *****************}
  CEC_TXD_TXD: uInt16  = $00FF;  //  Tx Data register 

{*******************  Bit definition for CEC_RXD register  *****************}
  CEC_RXD_RXD: uInt16  = $00FF;  //  Rx Data register 

{****************************************************************************}
{                                                                            }
{                                    TIM                                     }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for TIM_CR1 register  *******************}
  TIM_CR1_CEN: uInt16  = $0001;  // Counter enable 
  TIM_CR1_UDIS: uInt16  = $0002;  // Update disable 
  TIM_CR1_URS: uInt16  = $0004;  // Update request source 
  TIM_CR1_OPM: uInt16  = $0008;  // One pulse mode 
  TIM_CR1_DIR: uInt16  = $0010;  // Direction 

  TIM_CR1_CMS: uInt16  = $0060;  // CMS[1:0] bits (Center-aligned mode selection) 
  TIM_CR1_CMS_0: uInt16  = $0020;  // Bit 0 
  TIM_CR1_CMS_1: uInt16  = $0040;  // Bit 1 

  TIM_CR1_ARPE: uInt16  = $0080;  // Auto-reload preload enable 

  TIM_CR1_CKD: uInt16  = $0300;  // CKD[1:0] bits (clock division) 
  TIM_CR1_CKD_0: uInt16  = $0100;  // Bit 0 
  TIM_CR1_CKD_1: uInt16  = $0200;  // Bit 1 

{******************  Bit definition for TIM_CR2 register  *******************}
  TIM_CR2_CCPC: uInt16  = $0001;  // Capture/Compare Preloaded Control 
  TIM_CR2_CCUS: uInt16  = $0004;  // Capture/Compare Control Update Selection 
  TIM_CR2_CCDS: uInt16  = $0008;  // Capture/Compare DMA Selection 

  TIM_CR2_MMS: uInt16  = $0070;  // MMS[2:0] bits (Master Mode Selection) 
  TIM_CR2_MMS_0: uInt16  = $0010;  // Bit 0 
  TIM_CR2_MMS_1: uInt16  = $0020;  // Bit 1 
  TIM_CR2_MMS_2: uInt16  = $0040;  // Bit 2 

  TIM_CR2_TI1S: uInt16  = $0080;  // TI1 Selection 
  TIM_CR2_OIS1: uInt16  = $0100;  // Output Idle state 1 (OC1 output) 
  TIM_CR2_OIS1N: uInt16  = $0200;  // Output Idle state 1 (OC1N output) 
  TIM_CR2_OIS2: uInt16  = $0400;  // Output Idle state 2 (OC2 output) 
  TIM_CR2_OIS2N: uInt16  = $0800;  // Output Idle state 2 (OC2N output) 
  TIM_CR2_OIS3: uInt16  = $1000;  // Output Idle state 3 (OC3 output) 
  TIM_CR2_OIS3N: uInt16  = $2000;  // Output Idle state 3 (OC3N output) 
  TIM_CR2_OIS4: uInt16  = $4000;  // Output Idle state 4 (OC4 output) 

{******************  Bit definition for TIM_SMCR register  ******************}
  TIM_SMCR_SMS: uInt16  = $0007;  // SMS[2:0] bits (Slave mode selection) 
  TIM_SMCR_SMS_0: uInt16  = $0001;  // Bit 0 
  TIM_SMCR_SMS_1: uInt16  = $0002;  // Bit 1 
  TIM_SMCR_SMS_2: uInt16  = $0004;  // Bit 2 

  TIM_SMCR_TS: uInt16  = $0070;  // TS[2:0] bits (Trigger selection) 
  TIM_SMCR_TS_0: uInt16  = $0010;  // Bit 0 
  TIM_SMCR_TS_1: uInt16  = $0020;  // Bit 1 
  TIM_SMCR_TS_2: uInt16  = $0040;  // Bit 2 

  TIM_SMCR_MSM: uInt16  = $0080;  // Master/slave mode 

  TIM_SMCR_ETF: uInt16  = $0F00;  // ETF[3:0] bits (External trigger filter) 
  TIM_SMCR_ETF_0: uInt16  = $0100;  // Bit 0 
  TIM_SMCR_ETF_1: uInt16  = $0200;  // Bit 1 
  TIM_SMCR_ETF_2: uInt16  = $0400;  // Bit 2 
  TIM_SMCR_ETF_3: uInt16  = $0800;  // Bit 3 

  TIM_SMCR_ETPS: uInt16  = $3000;  // ETPS[1:0] bits (External trigger prescaler) 
  TIM_SMCR_ETPS_0: uInt16  = $1000;  // Bit 0 
  TIM_SMCR_ETPS_1: uInt16  = $2000;  // Bit 1 

  TIM_SMCR_ECE: uInt16  = $4000;  // External clock enable 
  TIM_SMCR_ETP: uInt16  = $8000;  // External trigger polarity 

{******************  Bit definition for TIM_DIER register  ******************}
  TIM_DIER_UIE: uInt16  = $0001;  // Update interrupt enable 
  TIM_DIER_CC1IE: uInt16  = $0002;  // Capture/Compare 1 interrupt enable 
  TIM_DIER_CC2IE: uInt16  = $0004;  // Capture/Compare 2 interrupt enable 
  TIM_DIER_CC3IE: uInt16  = $0008;  // Capture/Compare 3 interrupt enable 
  TIM_DIER_CC4IE: uInt16  = $0010;  // Capture/Compare 4 interrupt enable 
  TIM_DIER_COMIE: uInt16  = $0020;  // COM interrupt enable 
  TIM_DIER_TIE: uInt16  = $0040;  // Trigger interrupt enable 
  TIM_DIER_BIE: uInt16  = $0080;  // Break interrupt enable 
  TIM_DIER_UDE: uInt16  = $0100;  // Update DMA request enable 
  TIM_DIER_CC1DE: uInt16  = $0200;  // Capture/Compare 1 DMA request enable 
  TIM_DIER_CC2DE: uInt16  = $0400;  // Capture/Compare 2 DMA request enable 
  TIM_DIER_CC3DE: uInt16  = $0800;  // Capture/Compare 3 DMA request enable 
  TIM_DIER_CC4DE: uInt16  = $1000;  // Capture/Compare 4 DMA request enable 
  TIM_DIER_COMDE: uInt16  = $2000;  // COM DMA request enable 
  TIM_DIER_TDE: uInt16  = $4000;  // Trigger DMA request enable 

{*******************  Bit definition for TIM_SR register  *******************}
  TIM_SR_UIF: uInt16  = $0001;  // Update interrupt Flag 
  TIM_SR_CC1IF: uInt16  = $0002;  // Capture/Compare 1 interrupt Flag 
  TIM_SR_CC2IF: uInt16  = $0004;  // Capture/Compare 2 interrupt Flag 
  TIM_SR_CC3IF: uInt16  = $0008;  // Capture/Compare 3 interrupt Flag 
  TIM_SR_CC4IF: uInt16  = $0010;  // Capture/Compare 4 interrupt Flag 
  TIM_SR_COMIF: uInt16  = $0020;  // COM interrupt Flag 
  TIM_SR_TIF: uInt16  = $0040;  // Trigger interrupt Flag 
  TIM_SR_BIF: uInt16  = $0080;  // Break interrupt Flag 
  TIM_SR_CC1OF: uInt16  = $0200;  // Capture/Compare 1 Overcapture Flag 
  TIM_SR_CC2OF: uInt16  = $0400;  // Capture/Compare 2 Overcapture Flag 
  TIM_SR_CC3OF: uInt16  = $0800;  // Capture/Compare 3 Overcapture Flag 
  TIM_SR_CC4OF: uInt16  = $1000;  // Capture/Compare 4 Overcapture Flag 

{******************  Bit definition for TIM_EGR register  *******************}
  TIM_EGR_UG: uInt8  = $01;  // Update Generation 
  TIM_EGR_CC1G: uInt8  = $02;  // Capture/Compare 1 Generation 
  TIM_EGR_CC2G: uInt8  = $04;  // Capture/Compare 2 Generation 
  TIM_EGR_CC3G: uInt8  = $08;  // Capture/Compare 3 Generation 
  TIM_EGR_CC4G: uInt8  = $10;  // Capture/Compare 4 Generation 
  TIM_EGR_COMG: uInt8  = $20;  // Capture/Compare Control Update Generation 
  TIM_EGR_TG: uInt8  = $40;  // Trigger Generation 
  TIM_EGR_BG: uInt8  = $80;  // Break Generation 

{*****************  Bit definition for TIM_CCMR1 register  ******************}
  TIM_CCMR1_CC1S: uInt16  = $0003;  // CC1S[1:0] bits (Capture/Compare 1 Selection) 
  TIM_CCMR1_CC1S_0: uInt16  = $0001;  // Bit 0 
  TIM_CCMR1_CC1S_1: uInt16  = $0002;  // Bit 1 

  TIM_CCMR1_OC1FE: uInt16  = $0004;  // Output Compare 1 Fast enable 
  TIM_CCMR1_OC1PE: uInt16  = $0008;  // Output Compare 1 Preload enable 

  TIM_CCMR1_OC1M: uInt16  = $0070;  // OC1M[2:0] bits (Output Compare 1 Mode) 
  TIM_CCMR1_OC1M_0: uInt16  = $0010;  // Bit 0 
  TIM_CCMR1_OC1M_1: uInt16  = $0020;  // Bit 1 
  TIM_CCMR1_OC1M_2: uInt16  = $0040;  // Bit 2 

  TIM_CCMR1_OC1CE: uInt16  = $0080;  // Output Compare 1Clear Enable 

  TIM_CCMR1_CC2S: uInt16  = $0300;  // CC2S[1:0] bits (Capture/Compare 2 Selection) 
  TIM_CCMR1_CC2S_0: uInt16  = $0100;  // Bit 0 
  TIM_CCMR1_CC2S_1: uInt16  = $0200;  // Bit 1 

  TIM_CCMR1_OC2FE: uInt16  = $0400;  // Output Compare 2 Fast enable 
  TIM_CCMR1_OC2PE: uInt16  = $0800;  // Output Compare 2 Preload enable 

  TIM_CCMR1_OC2M: uInt16  = $7000;  // OC2M[2:0] bits (Output Compare 2 Mode) 
  TIM_CCMR1_OC2M_0: uInt16  = $1000;  // Bit 0 
  TIM_CCMR1_OC2M_1: uInt16  = $2000;  // Bit 1 
  TIM_CCMR1_OC2M_2: uInt16  = $4000;  // Bit 2 

  TIM_CCMR1_OC2CE: uInt16  = $8000;  // Output Compare 2 Clear Enable 

{----------------------------------------------------------------------------}

  TIM_CCMR1_IC1PSC: uInt16  = $000C;  // IC1PSC[1:0] bits (Input Capture 1 Prescaler) 
  TIM_CCMR1_IC1PSC_0: uInt16  = $0004;  // Bit 0 
  TIM_CCMR1_IC1PSC_1: uInt16  = $0008;  // Bit 1 

  TIM_CCMR1_IC1F: uInt16  = $00F0;  // IC1F[3:0] bits (Input Capture 1 Filter) 
  TIM_CCMR1_IC1F_0: uInt16  = $0010;  // Bit 0 
  TIM_CCMR1_IC1F_1: uInt16  = $0020;  // Bit 1 
  TIM_CCMR1_IC1F_2: uInt16  = $0040;  // Bit 2 
  TIM_CCMR1_IC1F_3: uInt16  = $0080;  // Bit 3 

  TIM_CCMR1_IC2PSC: uInt16  = $0C00;  // IC2PSC[1:0] bits (Input Capture 2 Prescaler) 
  TIM_CCMR1_IC2PSC_0: uInt16  = $0400;  // Bit 0 
  TIM_CCMR1_IC2PSC_1: uInt16  = $0800;  // Bit 1 

  TIM_CCMR1_IC2F: uInt16  = $F000;  // IC2F[3:0] bits (Input Capture 2 Filter) 
  TIM_CCMR1_IC2F_0: uInt16  = $1000;  // Bit 0 
  TIM_CCMR1_IC2F_1: uInt16  = $2000;  // Bit 1 
  TIM_CCMR1_IC2F_2: uInt16  = $4000;  // Bit 2 
  TIM_CCMR1_IC2F_3: uInt16  = $8000;  // Bit 3 

{*****************  Bit definition for TIM_CCMR2 register  ******************}
  TIM_CCMR2_CC3S: uInt16  = $0003;  // CC3S[1:0] bits (Capture/Compare 3 Selection) 
  TIM_CCMR2_CC3S_0: uInt16  = $0001;  // Bit 0 
  TIM_CCMR2_CC3S_1: uInt16  = $0002;  // Bit 1 

  TIM_CCMR2_OC3FE: uInt16  = $0004;  // Output Compare 3 Fast enable 
  TIM_CCMR2_OC3PE: uInt16  = $0008;  // Output Compare 3 Preload enable 

  TIM_CCMR2_OC3M: uInt16  = $0070;  // OC3M[2:0] bits (Output Compare 3 Mode) 
  TIM_CCMR2_OC3M_0: uInt16  = $0010;  // Bit 0 
  TIM_CCMR2_OC3M_1: uInt16  = $0020;  // Bit 1 
  TIM_CCMR2_OC3M_2: uInt16  = $0040;  // Bit 2 

  TIM_CCMR2_OC3CE: uInt16  = $0080;  // Output Compare 3 Clear Enable 

  TIM_CCMR2_CC4S: uInt16  = $0300;  // CC4S[1:0] bits (Capture/Compare 4 Selection) 
  TIM_CCMR2_CC4S_0: uInt16  = $0100;  // Bit 0 
  TIM_CCMR2_CC4S_1: uInt16  = $0200;  // Bit 1 

  TIM_CCMR2_OC4FE: uInt16  = $0400;  // Output Compare 4 Fast enable 
  TIM_CCMR2_OC4PE: uInt16  = $0800;  // Output Compare 4 Preload enable 

  TIM_CCMR2_OC4M: uInt16  = $7000;  // OC4M[2:0] bits (Output Compare 4 Mode) 
  TIM_CCMR2_OC4M_0: uInt16  = $1000;  // Bit 0 
  TIM_CCMR2_OC4M_1: uInt16  = $2000;  // Bit 1 
  TIM_CCMR2_OC4M_2: uInt16  = $4000;  // Bit 2 

  TIM_CCMR2_OC4CE: uInt16  = $8000;  // Output Compare 4 Clear Enable 

{----------------------------------------------------------------------------}

  TIM_CCMR2_IC3PSC: uInt16  = $000C;  // IC3PSC[1:0] bits (Input Capture 3 Prescaler) 
  TIM_CCMR2_IC3PSC_0: uInt16  = $0004;  // Bit 0 
  TIM_CCMR2_IC3PSC_1: uInt16  = $0008;  // Bit 1 

  TIM_CCMR2_IC3F: uInt16  = $00F0;  // IC3F[3:0] bits (Input Capture 3 Filter) 
  TIM_CCMR2_IC3F_0: uInt16  = $0010;  // Bit 0 
  TIM_CCMR2_IC3F_1: uInt16  = $0020;  // Bit 1 
  TIM_CCMR2_IC3F_2: uInt16  = $0040;  // Bit 2 
  TIM_CCMR2_IC3F_3: uInt16  = $0080;  // Bit 3 

  TIM_CCMR2_IC4PSC: uInt16  = $0C00;  // IC4PSC[1:0] bits (Input Capture 4 Prescaler) 
  TIM_CCMR2_IC4PSC_0: uInt16  = $0400;  // Bit 0 
  TIM_CCMR2_IC4PSC_1: uInt16  = $0800;  // Bit 1 

  TIM_CCMR2_IC4F: uInt16  = $F000;  // IC4F[3:0] bits (Input Capture 4 Filter) 
  TIM_CCMR2_IC4F_0: uInt16  = $1000;  // Bit 0 
  TIM_CCMR2_IC4F_1: uInt16  = $2000;  // Bit 1 
  TIM_CCMR2_IC4F_2: uInt16  = $4000;  // Bit 2 
  TIM_CCMR2_IC4F_3: uInt16  = $8000;  // Bit 3 

{******************  Bit definition for TIM_CCER register  ******************}
  TIM_CCER_CC1E: uInt16  = $0001;  // Capture/Compare 1 output enable 
  TIM_CCER_CC1P: uInt16  = $0002;  // Capture/Compare 1 output Polarity 
  TIM_CCER_CC1NE: uInt16  = $0004;  // Capture/Compare 1 Complementary output enable 
  TIM_CCER_CC1NP: uInt16  = $0008;  // Capture/Compare 1 Complementary output Polarity 
  TIM_CCER_CC2E: uInt16  = $0010;  // Capture/Compare 2 output enable 
  TIM_CCER_CC2P: uInt16  = $0020;  // Capture/Compare 2 output Polarity 
  TIM_CCER_CC2NE: uInt16  = $0040;  // Capture/Compare 2 Complementary output enable 
  TIM_CCER_CC2NP: uInt16  = $0080;  // Capture/Compare 2 Complementary output Polarity 
  TIM_CCER_CC3E: uInt16  = $0100;  // Capture/Compare 3 output enable 
  TIM_CCER_CC3P: uInt16  = $0200;  // Capture/Compare 3 output Polarity 
  TIM_CCER_CC3NE: uInt16  = $0400;  // Capture/Compare 3 Complementary output enable 
  TIM_CCER_CC3NP: uInt16  = $0800;  // Capture/Compare 3 Complementary output Polarity 
  TIM_CCER_CC4E: uInt16  = $1000;  // Capture/Compare 4 output enable 
  TIM_CCER_CC4P: uInt16  = $2000;  // Capture/Compare 4 output Polarity 
  TIM_CCER_CC4NP: uInt16  = $8000;  // Capture/Compare 4 Complementary output Polarity 

{******************  Bit definition for TIM_CNT register  *******************}
  TIM_CNT_CNT: uInt16  = $FFFF;  // Counter Value 

{******************  Bit definition for TIM_PSC register  *******************}
  TIM_PSC_PSC: uInt16  = $FFFF;  // Prescaler Value 

{******************  Bit definition for TIM_ARR register  *******************}
  TIM_ARR_ARR: uInt16  = $FFFF;  // actual auto-reload Value 

{******************  Bit definition for TIM_RCR register  *******************}
  TIM_RCR_REP: uInt8  = $FF;  // Repetition Counter Value 

{******************  Bit definition for TIM_CCR1 register  ******************}
  TIM_CCR1_CCR1: uInt16  = $FFFF;  // Capture/Compare 1 Value 

{******************  Bit definition for TIM_CCR2 register  ******************}
  TIM_CCR2_CCR2: uInt16  = $FFFF;  // Capture/Compare 2 Value 

{******************  Bit definition for TIM_CCR3 register  ******************}
  TIM_CCR3_CCR3: uInt16  = $FFFF;  // Capture/Compare 3 Value 

{******************  Bit definition for TIM_CCR4 register  ******************}
  TIM_CCR4_CCR4: uInt16  = $FFFF;  // Capture/Compare 4 Value 

{******************  Bit definition for TIM_BDTR register  ******************}
  TIM_BDTR_DTG: uInt16  = $00FF;  // DTG[0:7] bits (Dead-Time Generator set-up) 
  TIM_BDTR_DTG_0: uInt16  = $0001;  // Bit 0 
  TIM_BDTR_DTG_1: uInt16  = $0002;  // Bit 1 
  TIM_BDTR_DTG_2: uInt16  = $0004;  // Bit 2 
  TIM_BDTR_DTG_3: uInt16  = $0008;  // Bit 3 
  TIM_BDTR_DTG_4: uInt16  = $0010;  // Bit 4 
  TIM_BDTR_DTG_5: uInt16  = $0020;  // Bit 5 
  TIM_BDTR_DTG_6: uInt16  = $0040;  // Bit 6 
  TIM_BDTR_DTG_7: uInt16  = $0080;  // Bit 7 

  TIM_BDTR_LOCK: uInt16  = $0300;  // LOCK[1:0] bits (Lock Configuration) 
  TIM_BDTR_LOCK_0: uInt16  = $0100;  // Bit 0 
  TIM_BDTR_LOCK_1: uInt16  = $0200;  // Bit 1 

  TIM_BDTR_OSSI: uInt16  = $0400;  // Off-State Selection for Idle mode 
  TIM_BDTR_OSSR: uInt16  = $0800;  // Off-State Selection for Run mode 
  TIM_BDTR_BKE: uInt16  = $1000;  // Break enable 
  TIM_BDTR_BKP: uInt16  = $2000;  // Break Polarity 
  TIM_BDTR_AOE: uInt16  = $4000;  // Automatic Output enable 
  TIM_BDTR_MOE: uInt16  = $8000;  // Main Output enable 

{******************  Bit definition for TIM_DCR register  *******************}
  TIM_DCR_DBA: uInt16  = $001F;  // DBA[4:0] bits (DMA Base Address) 
  TIM_DCR_DBA_0: uInt16  = $0001;  // Bit 0 
  TIM_DCR_DBA_1: uInt16  = $0002;  // Bit 1 
  TIM_DCR_DBA_2: uInt16  = $0004;  // Bit 2 
  TIM_DCR_DBA_3: uInt16  = $0008;  // Bit 3 
  TIM_DCR_DBA_4: uInt16  = $0010;  // Bit 4 

  TIM_DCR_DBL: uInt16  = $1F00;  // DBL[4:0] bits (DMA Burst Length) 
  TIM_DCR_DBL_0: uInt16  = $0100;  // Bit 0 
  TIM_DCR_DBL_1: uInt16  = $0200;  // Bit 1 
  TIM_DCR_DBL_2: uInt16  = $0400;  // Bit 2 
  TIM_DCR_DBL_3: uInt16  = $0800;  // Bit 3 
  TIM_DCR_DBL_4: uInt16  = $1000;  // Bit 4 

{******************  Bit definition for TIM_DMAR register  ******************}
  TIM_DMAR_DMAB: uInt16  = $FFFF;  // DMA register for burst accesses 

{****************************************************************************}
{                                                                            }
{                             Real-Time Clock                                }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for RTC_CRH register  *******************}
  RTC_CRH_SECIE: uInt8  = $01;  // Second Interrupt Enable 
  RTC_CRH_ALRIE: uInt8  = $02;  // Alarm Interrupt Enable 
  RTC_CRH_OWIE: uInt8  = $04;  // OverfloW Interrupt Enable 

{******************  Bit definition for RTC_CRL register  *******************}
  RTC_CRL_SECF: uInt8  = $01;  // Second Flag 
  RTC_CRL_ALRF: uInt8  = $02;  // Alarm Flag 
  RTC_CRL_OWF: uInt8  = $04;  // OverfloW Flag 
  RTC_CRL_RSF: uInt8  = $08;  // Registers Synchronized Flag 
  RTC_CRL_CNF: uInt8  = $10;  // Configuration Flag 
  RTC_CRL_RTOFF: uInt8  = $20;  // RTC operation OFF 

{******************  Bit definition for RTC_PRLH register  ******************}
  RTC_PRLH_PRL: uInt16  = $000F;  // RTC Prescaler Reload Value High 

{******************  Bit definition for RTC_PRLL register  ******************}
  RTC_PRLL_PRL: uInt16  = $FFFF;  // RTC Prescaler Reload Value Low 

{******************  Bit definition for RTC_DIVH register  ******************}
  RTC_DIVH_RTC_DIV: uInt16  = $000F;  // RTC Clock Divider High 

{******************  Bit definition for RTC_DIVL register  ******************}
  RTC_DIVL_RTC_DIV: uInt16  = $FFFF;  // RTC Clock Divider Low 

{******************  Bit definition for RTC_CNTH register  ******************}
  RTC_CNTH_RTC_CNT: uInt16  = $FFFF;  // RTC Counter High 

{******************  Bit definition for RTC_CNTL register  ******************}
  RTC_CNTL_RTC_CNT: uInt16  = $FFFF;  // RTC Counter Low 

{******************  Bit definition for RTC_ALRH register  ******************}
  RTC_ALRH_RTC_ALR: uInt16  = $FFFF;  // RTC Alarm High 

{******************  Bit definition for RTC_ALRL register  ******************}
  RTC_ALRL_RTC_ALR: uInt16  = $FFFF;  // RTC Alarm Low 

{****************************************************************************}
{                                                                            }
{                           Independent WATCHDOG                             }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for IWDG_KR register  *******************}
  IWDG_KR_KEY: uInt16  = $FFFF;  // Key value (write only, read 0000h) 

{******************  Bit definition for IWDG_PR register  *******************}
  IWDG_PR_PR: uInt8  = $07;  // PR[2:0] (Prescaler divider) 
  IWDG_PR_PR_0: uInt8  = $01;  // Bit 0 
  IWDG_PR_PR_1: uInt8  = $02;  // Bit 1 
  IWDG_PR_PR_2: uInt8  = $04;  // Bit 2 

{******************  Bit definition for IWDG_RLR register  ******************}
  IWDG_RLR_RL: uInt16  = $0FFF;  // Watchdog counter reload value 

{******************  Bit definition for IWDG_SR register  *******************}
  IWDG_SR_PVU: uInt8  = $01;  // Watchdog prescaler value update 
  IWDG_SR_RVU: uInt8  = $02;  // Watchdog counter reload value update 

{****************************************************************************}
{                                                                            }
{                            Window WATCHDOG                                 }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for WWDG_CR register  *******************}
  WWDG_CR_T: uInt8  = $7F;  // T[6:0] bits (7-Bit counter (MSB to LSB)) 
  WWDG_CR_T0: uInt8  = $01;  // Bit 0 
  WWDG_CR_T1: uInt8  = $02;  // Bit 1 
  WWDG_CR_T2: uInt8  = $04;  // Bit 2 
  WWDG_CR_T3: uInt8  = $08;  // Bit 3 
  WWDG_CR_T4: uInt8  = $10;  // Bit 4 
  WWDG_CR_T5: uInt8  = $20;  // Bit 5 
  WWDG_CR_T6: uInt8  = $40;  // Bit 6 

  WWDG_CR_WDGA: uInt8  = $80;  // Activation bit 

{******************  Bit definition for WWDG_CFR register  ******************}
  WWDG_CFR_W: uInt16  = $007F;  // W[6:0] bits (7-bit window value) 
  WWDG_CFR_W0: uInt16  = $0001;  // Bit 0 
  WWDG_CFR_W1: uInt16  = $0002;  // Bit 1 
  WWDG_CFR_W2: uInt16  = $0004;  // Bit 2 
  WWDG_CFR_W3: uInt16  = $0008;  // Bit 3 
  WWDG_CFR_W4: uInt16  = $0010;  // Bit 4 
  WWDG_CFR_W5: uInt16  = $0020;  // Bit 5 
  WWDG_CFR_W6: uInt16  = $0040;  // Bit 6 

  WWDG_CFR_WDGTB: uInt16  = $0180;  // WDGTB[1:0] bits (Timer Base) 
  WWDG_CFR_WDGTB0: uInt16  = $0080;  // Bit 0 
  WWDG_CFR_WDGTB1: uInt16  = $0100;  // Bit 1 

  WWDG_CFR_EWI: uInt16  = $0200;  // Early Wakeup Interrupt 

{******************  Bit definition for WWDG_SR register  *******************}
  WWDG_SR_EWIF: uInt8  = $01;  // Early Wakeup Interrupt Flag 

{****************************************************************************}
{                                                                            }
{                       Flexible Static Memory Controller                    }
{                                                                            }
{****************************************************************************}

{*****************  Bit definition for FSMC_BCR1 register  ******************}
  FSMC_BCR1_MBKEN: uInt32  = $00000001;  // Memory bank enable bit 
  FSMC_BCR1_MUXEN: uInt32  = $00000002;  // Address/data multiplexing enable bit 

  FSMC_BCR1_MTYP: uInt32  = $0000000C;  // MTYP[1:0] bits (Memory type) 
  FSMC_BCR1_MTYP_0: uInt32  = $00000004;  // Bit 0 
  FSMC_BCR1_MTYP_1: uInt32  = $00000008;  // Bit 1 

  FSMC_BCR1_MWID: uInt32  = $00000030;  // MWID[1:0] bits (Memory data bus width) 
  FSMC_BCR1_MWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BCR1_MWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_BCR1_FACCEN: uInt32  = $00000040;  // Flash access enable 
  FSMC_BCR1_BURSTEN: uInt32  = $00000100;  // Burst enable bit 
  FSMC_BCR1_WAITPOL: uInt32  = $00000200;  // Wait signal polarity bit 
  FSMC_BCR1_WRAPMOD: uInt32  = $00000400;  // Wrapped burst mode support 
  FSMC_BCR1_WAITCFG: uInt32  = $00000800;  // Wait timing configuration 
  FSMC_BCR1_WREN: uInt32  = $00001000;  // Write enable bit 
  FSMC_BCR1_WAITEN: uInt32  = $00002000;  // Wait enable bit 
  FSMC_BCR1_EXTMOD: uInt32  = $00004000;  // Extended mode enable 
  FSMC_BCR1_ASYNCWAIT: uInt32  = $00008000;  // Asynchronous wait 
  FSMC_BCR1_CBURSTRW: uInt32  = $00080000;  // Write burst enable 

{*****************  Bit definition for FSMC_BCR2 register  ******************}
  FSMC_BCR2_MBKEN: uInt32  = $00000001;  // Memory bank enable bit 
  FSMC_BCR2_MUXEN: uInt32  = $00000002;  // Address/data multiplexing enable bit 

  FSMC_BCR2_MTYP: uInt32  = $0000000C;  // MTYP[1:0] bits (Memory type) 
  FSMC_BCR2_MTYP_0: uInt32  = $00000004;  // Bit 0 
  FSMC_BCR2_MTYP_1: uInt32  = $00000008;  // Bit 1 

  FSMC_BCR2_MWID: uInt32  = $00000030;  // MWID[1:0] bits (Memory data bus width) 
  FSMC_BCR2_MWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BCR2_MWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_BCR2_FACCEN: uInt32  = $00000040;  // Flash access enable 
  FSMC_BCR2_BURSTEN: uInt32  = $00000100;  // Burst enable bit 
  FSMC_BCR2_WAITPOL: uInt32  = $00000200;  // Wait signal polarity bit 
  FSMC_BCR2_WRAPMOD: uInt32  = $00000400;  // Wrapped burst mode support 
  FSMC_BCR2_WAITCFG: uInt32  = $00000800;  // Wait timing configuration 
  FSMC_BCR2_WREN: uInt32  = $00001000;  // Write enable bit 
  FSMC_BCR2_WAITEN: uInt32  = $00002000;  // Wait enable bit 
  FSMC_BCR2_EXTMOD: uInt32  = $00004000;  // Extended mode enable 
  FSMC_BCR2_ASYNCWAIT: uInt32  = $00008000;  // Asynchronous wait 
  FSMC_BCR2_CBURSTRW: uInt32  = $00080000;  // Write burst enable 

{*****************  Bit definition for FSMC_BCR3 register  ******************}
  FSMC_BCR3_MBKEN: uInt32  = $00000001;  // Memory bank enable bit 
  FSMC_BCR3_MUXEN: uInt32  = $00000002;  // Address/data multiplexing enable bit 

  FSMC_BCR3_MTYP: uInt32  = $0000000C;  // MTYP[1:0] bits (Memory type) 
  FSMC_BCR3_MTYP_0: uInt32  = $00000004;  // Bit 0 
  FSMC_BCR3_MTYP_1: uInt32  = $00000008;  // Bit 1 

  FSMC_BCR3_MWID: uInt32  = $00000030;  // MWID[1:0] bits (Memory data bus width) 
  FSMC_BCR3_MWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BCR3_MWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_BCR3_FACCEN: uInt32  = $00000040;  // Flash access enable 
  FSMC_BCR3_BURSTEN: uInt32  = $00000100;  // Burst enable bit 
  FSMC_BCR3_WAITPOL: uInt32  = $00000200;  // Wait signal polarity bit. 
  FSMC_BCR3_WRAPMOD: uInt32  = $00000400;  // Wrapped burst mode support 
  FSMC_BCR3_WAITCFG: uInt32  = $00000800;  // Wait timing configuration 
  FSMC_BCR3_WREN: uInt32  = $00001000;  // Write enable bit 
  FSMC_BCR3_WAITEN: uInt32  = $00002000;  // Wait enable bit 
  FSMC_BCR3_EXTMOD: uInt32  = $00004000;  // Extended mode enable 
  FSMC_BCR3_ASYNCWAIT: uInt32  = $00008000;  // Asynchronous wait 
  FSMC_BCR3_CBURSTRW: uInt32  = $00080000;  // Write burst enable 

{*****************  Bit definition for FSMC_BCR4 register  ******************}
  FSMC_BCR4_MBKEN: uInt32  = $00000001;  // Memory bank enable bit 
  FSMC_BCR4_MUXEN: uInt32  = $00000002;  // Address/data multiplexing enable bit 

  FSMC_BCR4_MTYP: uInt32  = $0000000C;  // MTYP[1:0] bits (Memory type) 
  FSMC_BCR4_MTYP_0: uInt32  = $00000004;  // Bit 0 
  FSMC_BCR4_MTYP_1: uInt32  = $00000008;  // Bit 1 

  FSMC_BCR4_MWID: uInt32  = $00000030;  // MWID[1:0] bits (Memory data bus width) 
  FSMC_BCR4_MWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BCR4_MWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_BCR4_FACCEN: uInt32  = $00000040;  // Flash access enable 
  FSMC_BCR4_BURSTEN: uInt32  = $00000100;  // Burst enable bit 
  FSMC_BCR4_WAITPOL: uInt32  = $00000200;  // Wait signal polarity bit 
  FSMC_BCR4_WRAPMOD: uInt32  = $00000400;  // Wrapped burst mode support 
  FSMC_BCR4_WAITCFG: uInt32  = $00000800;  // Wait timing configuration 
  FSMC_BCR4_WREN: uInt32  = $00001000;  // Write enable bit 
  FSMC_BCR4_WAITEN: uInt32  = $00002000;  // Wait enable bit 
  FSMC_BCR4_EXTMOD: uInt32  = $00004000;  // Extended mode enable 
  FSMC_BCR4_ASYNCWAIT: uInt32  = $00008000;  // Asynchronous wait 
  FSMC_BCR4_CBURSTRW: uInt32  = $00080000;  // Write burst enable 

{*****************  Bit definition for FSMC_BTR1 register  *****************}
  FSMC_BTR1_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BTR1_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BTR1_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BTR1_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BTR1_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BTR1_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BTR1_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BTR1_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BTR1_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BTR1_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BTR1_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BTR1_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BTR1_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BTR1_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BTR1_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BTR1_BUSTURN: uInt32  = $000F0000;  // BUSTURN[3:0] bits (Bus turnaround phase duration) 
  FSMC_BTR1_BUSTURN_0: uInt32  = $00010000;  // Bit 0 
  FSMC_BTR1_BUSTURN_1: uInt32  = $00020000;  // Bit 1 
  FSMC_BTR1_BUSTURN_2: uInt32  = $00040000;  // Bit 2 
  FSMC_BTR1_BUSTURN_3: uInt32  = $00080000;  // Bit 3 

  FSMC_BTR1_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BTR1_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BTR1_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BTR1_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BTR1_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BTR1_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BTR1_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BTR1_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BTR1_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BTR1_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BTR1_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BTR1_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BTR1_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_BTR2 register  ******************}
  FSMC_BTR2_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BTR2_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BTR2_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BTR2_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BTR2_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BTR2_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BTR2_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BTR2_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BTR2_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BTR2_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BTR2_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BTR2_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BTR2_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BTR2_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BTR2_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BTR2_BUSTURN: uInt32  = $000F0000;  // BUSTURN[3:0] bits (Bus turnaround phase duration) 
  FSMC_BTR2_BUSTURN_0: uInt32  = $00010000;  // Bit 0 
  FSMC_BTR2_BUSTURN_1: uInt32  = $00020000;  // Bit 1 
  FSMC_BTR2_BUSTURN_2: uInt32  = $00040000;  // Bit 2 
  FSMC_BTR2_BUSTURN_3: uInt32  = $00080000;  // Bit 3 

  FSMC_BTR2_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BTR2_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BTR2_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BTR2_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BTR2_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BTR2_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BTR2_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BTR2_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BTR2_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BTR2_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BTR2_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BTR2_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BTR2_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{******************  Bit definition for FSMC_BTR3 register  ******************}
  FSMC_BTR3_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BTR3_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BTR3_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BTR3_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BTR3_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BTR3_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BTR3_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BTR3_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BTR3_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BTR3_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BTR3_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BTR3_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BTR3_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BTR3_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BTR3_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BTR3_BUSTURN: uInt32  = $000F0000;  // BUSTURN[3:0] bits (Bus turnaround phase duration) 
  FSMC_BTR3_BUSTURN_0: uInt32  = $00010000;  // Bit 0 
  FSMC_BTR3_BUSTURN_1: uInt32  = $00020000;  // Bit 1 
  FSMC_BTR3_BUSTURN_2: uInt32  = $00040000;  // Bit 2 
  FSMC_BTR3_BUSTURN_3: uInt32  = $00080000;  // Bit 3 

  FSMC_BTR3_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BTR3_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BTR3_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BTR3_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BTR3_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BTR3_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BTR3_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BTR3_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BTR3_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BTR3_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BTR3_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BTR3_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BTR3_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_BTR4 register  ******************}
  FSMC_BTR4_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BTR4_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BTR4_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BTR4_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BTR4_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BTR4_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BTR4_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BTR4_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BTR4_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BTR4_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BTR4_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BTR4_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BTR4_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BTR4_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BTR4_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BTR4_BUSTURN: uInt32  = $000F0000;  // BUSTURN[3:0] bits (Bus turnaround phase duration) 
  FSMC_BTR4_BUSTURN_0: uInt32  = $00010000;  // Bit 0 
  FSMC_BTR4_BUSTURN_1: uInt32  = $00020000;  // Bit 1 
  FSMC_BTR4_BUSTURN_2: uInt32  = $00040000;  // Bit 2 
  FSMC_BTR4_BUSTURN_3: uInt32  = $00080000;  // Bit 3 

  FSMC_BTR4_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BTR4_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BTR4_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BTR4_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BTR4_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BTR4_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BTR4_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BTR4_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BTR4_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BTR4_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BTR4_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BTR4_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BTR4_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_BWTR1 register  *****************}
  FSMC_BWTR1_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BWTR1_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BWTR1_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BWTR1_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BWTR1_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BWTR1_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BWTR1_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BWTR1_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BWTR1_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BWTR1_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BWTR1_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BWTR1_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BWTR1_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BWTR1_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BWTR1_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BWTR1_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BWTR1_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BWTR1_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BWTR1_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BWTR1_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BWTR1_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BWTR1_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BWTR1_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BWTR1_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BWTR1_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BWTR1_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BWTR1_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BWTR1_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_BWTR2 register  *****************}
  FSMC_BWTR2_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BWTR2_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BWTR2_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BWTR2_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BWTR2_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BWTR2_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BWTR2_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BWTR2_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BWTR2_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BWTR2_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BWTR2_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BWTR2_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BWTR2_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BWTR2_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BWTR2_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BWTR2_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BWTR2_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BWTR2_CLKDIV_1: uInt32  = $00200000;  // Bit 1
  FSMC_BWTR2_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BWTR2_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BWTR2_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BWTR2_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BWTR2_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BWTR2_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BWTR2_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BWTR2_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BWTR2_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BWTR2_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_BWTR3 register  *****************}
  FSMC_BWTR3_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BWTR3_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BWTR3_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BWTR3_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BWTR3_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BWTR3_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BWTR3_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BWTR3_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BWTR3_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BWTR3_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BWTR3_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BWTR3_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BWTR3_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BWTR3_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BWTR3_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BWTR3_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BWTR3_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BWTR3_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BWTR3_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BWTR3_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BWTR3_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BWTR3_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BWTR3_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BWTR3_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BWTR3_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BWTR3_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BWTR3_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BWTR3_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_BWTR4 register  *****************}
  FSMC_BWTR4_ADDSET: uInt32  = $0000000F;  // ADDSET[3:0] bits (Address setup phase duration) 
  FSMC_BWTR4_ADDSET_0: uInt32  = $00000001;  // Bit 0 
  FSMC_BWTR4_ADDSET_1: uInt32  = $00000002;  // Bit 1 
  FSMC_BWTR4_ADDSET_2: uInt32  = $00000004;  // Bit 2 
  FSMC_BWTR4_ADDSET_3: uInt32  = $00000008;  // Bit 3 

  FSMC_BWTR4_ADDHLD: uInt32  = $000000F0;  // ADDHLD[3:0] bits (Address-hold phase duration) 
  FSMC_BWTR4_ADDHLD_0: uInt32  = $00000010;  // Bit 0 
  FSMC_BWTR4_ADDHLD_1: uInt32  = $00000020;  // Bit 1 
  FSMC_BWTR4_ADDHLD_2: uInt32  = $00000040;  // Bit 2 
  FSMC_BWTR4_ADDHLD_3: uInt32  = $00000080;  // Bit 3 

  FSMC_BWTR4_DATAST: uInt32  = $0000FF00;  // DATAST [3:0] bits (Data-phase duration) 
  FSMC_BWTR4_DATAST_0: uInt32  = $00000100;  // Bit 0 
  FSMC_BWTR4_DATAST_1: uInt32  = $00000200;  // Bit 1 
  FSMC_BWTR4_DATAST_2: uInt32  = $00000400;  // Bit 2 
  FSMC_BWTR4_DATAST_3: uInt32  = $00000800;  // Bit 3 

  FSMC_BWTR4_CLKDIV: uInt32  = $00F00000;  // CLKDIV[3:0] bits (Clock divide ratio) 
  FSMC_BWTR4_CLKDIV_0: uInt32  = $00100000;  // Bit 0 
  FSMC_BWTR4_CLKDIV_1: uInt32  = $00200000;  // Bit 1 
  FSMC_BWTR4_CLKDIV_2: uInt32  = $00400000;  // Bit 2 
  FSMC_BWTR4_CLKDIV_3: uInt32  = $00800000;  // Bit 3 

  FSMC_BWTR4_DATLAT: uInt32  = $0F000000;  // DATLA[3:0] bits (Data latency) 
  FSMC_BWTR4_DATLAT_0: uInt32  = $01000000;  // Bit 0 
  FSMC_BWTR4_DATLAT_1: uInt32  = $02000000;  // Bit 1 
  FSMC_BWTR4_DATLAT_2: uInt32  = $04000000;  // Bit 2 
  FSMC_BWTR4_DATLAT_3: uInt32  = $08000000;  // Bit 3 

  FSMC_BWTR4_ACCMOD: uInt32  = $30000000;  // ACCMOD[1:0] bits (Access mode) 
  FSMC_BWTR4_ACCMOD_0: uInt32  = $10000000;  // Bit 0 
  FSMC_BWTR4_ACCMOD_1: uInt32  = $20000000;  // Bit 1 

{*****************  Bit definition for FSMC_PCR2 register  ******************}
  FSMC_PCR2_PWAITEN: uInt32  = $00000002;  // Wait feature enable bit 
  FSMC_PCR2_PBKEN: uInt32  = $00000004;  // PC Card/NAND Flash memory bank enable bit 
  FSMC_PCR2_PTYP: uInt32  = $00000008;  // Memory type 

  FSMC_PCR2_PWID: uInt32  = $00000030;  // PWID[1:0] bits (NAND Flash databus width) 
  FSMC_PCR2_PWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_PCR2_PWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_PCR2_ECCEN: uInt32  = $00000040;  // ECC computation logic enable bit 

  FSMC_PCR2_TCLR: uInt32  = $00001E00;  // TCLR[3:0] bits (CLE to RE delay) 
  FSMC_PCR2_TCLR_0: uInt32  = $00000200;  // Bit 0 
  FSMC_PCR2_TCLR_1: uInt32  = $00000400;  // Bit 1 
  FSMC_PCR2_TCLR_2: uInt32  = $00000800;  // Bit 2 
  FSMC_PCR2_TCLR_3: uInt32  = $00001000;  // Bit 3 

  FSMC_PCR2_TAR: uInt32  = $0001E000;  // TAR[3:0] bits (ALE to RE delay) 
  FSMC_PCR2_TAR_0: uInt32  = $00002000;  // Bit 0 
  FSMC_PCR2_TAR_1: uInt32  = $00004000;  // Bit 1 
  FSMC_PCR2_TAR_2: uInt32  = $00008000;  // Bit 2 
  FSMC_PCR2_TAR_3: uInt32  = $00010000;  // Bit 3 

  FSMC_PCR2_ECCPS: uInt32  = $000E0000;  // ECCPS[1:0] bits (ECC page size) 
  FSMC_PCR2_ECCPS_0: uInt32  = $00020000;  // Bit 0 
  FSMC_PCR2_ECCPS_1: uInt32  = $00040000;  // Bit 1 
  FSMC_PCR2_ECCPS_2: uInt32  = $00080000;  // Bit 2 

{*****************  Bit definition for FSMC_PCR3 register  ******************}
  FSMC_PCR3_PWAITEN: uInt32  = $00000002;  // Wait feature enable bit 
  FSMC_PCR3_PBKEN: uInt32  = $00000004;  // PC Card/NAND Flash memory bank enable bit 
  FSMC_PCR3_PTYP: uInt32  = $00000008;  // Memory type 

  FSMC_PCR3_PWID: uInt32  = $00000030;  // PWID[1:0] bits (NAND Flash databus width) 
  FSMC_PCR3_PWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_PCR3_PWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_PCR3_ECCEN: uInt32  = $00000040;  // ECC computation logic enable bit 

  FSMC_PCR3_TCLR: uInt32  = $00001E00;  // TCLR[3:0] bits (CLE to RE delay) 
  FSMC_PCR3_TCLR_0: uInt32  = $00000200;  // Bit 0 
  FSMC_PCR3_TCLR_1: uInt32  = $00000400;  // Bit 1 
  FSMC_PCR3_TCLR_2: uInt32  = $00000800;  // Bit 2 
  FSMC_PCR3_TCLR_3: uInt32  = $00001000;  // Bit 3 

  FSMC_PCR3_TAR: uInt32  = $0001E000;  // TAR[3:0] bits (ALE to RE delay) 
  FSMC_PCR3_TAR_0: uInt32  = $00002000;  // Bit 0 
  FSMC_PCR3_TAR_1: uInt32  = $00004000;  // Bit 1 
  FSMC_PCR3_TAR_2: uInt32  = $00008000;  // Bit 2 
  FSMC_PCR3_TAR_3: uInt32  = $00010000;  // Bit 3 

  FSMC_PCR3_ECCPS: uInt32  = $000E0000;  // ECCPS[2:0] bits (ECC page size) 
  FSMC_PCR3_ECCPS_0: uInt32  = $00020000;  // Bit 0 
  FSMC_PCR3_ECCPS_1: uInt32  = $00040000;  // Bit 1 
  FSMC_PCR3_ECCPS_2: uInt32  = $00080000;  // Bit 2 

{*****************  Bit definition for FSMC_PCR4 register  ******************}
  FSMC_PCR4_PWAITEN: uInt32  = $00000002;  // Wait feature enable bit 
  FSMC_PCR4_PBKEN: uInt32  = $00000004;  // PC Card/NAND Flash memory bank enable bit 
  FSMC_PCR4_PTYP: uInt32  = $00000008;  // Memory type 

  FSMC_PCR4_PWID: uInt32  = $00000030;  // PWID[1:0] bits (NAND Flash databus width) 
  FSMC_PCR4_PWID_0: uInt32  = $00000010;  // Bit 0 
  FSMC_PCR4_PWID_1: uInt32  = $00000020;  // Bit 1 

  FSMC_PCR4_ECCEN: uInt32  = $00000040;  // ECC computation logic enable bit 

  FSMC_PCR4_TCLR: uInt32  = $00001E00;  // TCLR[3:0] bits (CLE to RE delay) 
  FSMC_PCR4_TCLR_0: uInt32  = $00000200;  // Bit 0 
  FSMC_PCR4_TCLR_1: uInt32  = $00000400;  // Bit 1 
  FSMC_PCR4_TCLR_2: uInt32  = $00000800;  // Bit 2 
  FSMC_PCR4_TCLR_3: uInt32  = $00001000;  // Bit 3 

  FSMC_PCR4_TAR: uInt32  = $0001E000;  // TAR[3:0] bits (ALE to RE delay) 
  FSMC_PCR4_TAR_0: uInt32  = $00002000;  // Bit 0 
  FSMC_PCR4_TAR_1: uInt32  = $00004000;  // Bit 1 
  FSMC_PCR4_TAR_2: uInt32  = $00008000;  // Bit 2 
  FSMC_PCR4_TAR_3: uInt32  = $00010000;  // Bit 3 

  FSMC_PCR4_ECCPS: uInt32  = $000E0000;  // ECCPS[2:0] bits (ECC page size) 
  FSMC_PCR4_ECCPS_0: uInt32  = $00020000;  // Bit 0 
  FSMC_PCR4_ECCPS_1: uInt32  = $00040000;  // Bit 1 
  FSMC_PCR4_ECCPS_2: uInt32  = $00080000;  // Bit 2 

{******************  Bit definition for FSMC_SR2 register  ******************}
  FSMC_SR2_IRS: uInt8  = $01;  // Interrupt Rising Edge status 
  FSMC_SR2_ILS: uInt8  = $02;  // Interrupt Level status 
  FSMC_SR2_IFS: uInt8  = $04;  // Interrupt Falling Edge status 
  FSMC_SR2_IREN: uInt8  = $08;  // Interrupt Rising Edge detection Enable bit 
  FSMC_SR2_ILEN: uInt8  = $10;  // Interrupt Level detection Enable bit 
  FSMC_SR2_IFEN: uInt8  = $20;  // Interrupt Falling Edge detection Enable bit 
  FSMC_SR2_FEMPT: uInt8  = $40;  // FIFO empty 

{******************  Bit definition for FSMC_SR3 register  ******************}
  FSMC_SR3_IRS: uInt8  = $01;  // Interrupt Rising Edge status 
  FSMC_SR3_ILS: uInt8  = $02;  // Interrupt Level status 
  FSMC_SR3_IFS: uInt8  = $04;  // Interrupt Falling Edge status 
  FSMC_SR3_IREN: uInt8  = $08;  // Interrupt Rising Edge detection Enable bit 
  FSMC_SR3_ILEN: uInt8  = $10;  // Interrupt Level detection Enable bit 
  FSMC_SR3_IFEN: uInt8  = $20;  // Interrupt Falling Edge detection Enable bit 
  FSMC_SR3_FEMPT: uInt8  = $40;  // FIFO empty 

{******************  Bit definition for FSMC_SR4 register  ******************}
  FSMC_SR4_IRS: uInt8  = $01;  // Interrupt Rising Edge status 
  FSMC_SR4_ILS: uInt8  = $02;  // Interrupt Level status 
  FSMC_SR4_IFS: uInt8  = $04;  // Interrupt Falling Edge status 
  FSMC_SR4_IREN: uInt8  = $08;  // Interrupt Rising Edge detection Enable bit 
  FSMC_SR4_ILEN: uInt8  = $10;  // Interrupt Level detection Enable bit 
  FSMC_SR4_IFEN: uInt8  = $20;  // Interrupt Falling Edge detection Enable bit 
  FSMC_SR4_FEMPT: uInt8  = $40;  // FIFO empty 

{*****************  Bit definition for FSMC_PMEM2 register  *****************}
  FSMC_PMEM2_MEMSET2: uInt32  = $000000FF;  // MEMSET2[7:0] bits (Common memory 2 setup time) 
  FSMC_PMEM2_MEMSET2_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PMEM2_MEMSET2_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PMEM2_MEMSET2_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PMEM2_MEMSET2_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PMEM2_MEMSET2_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PMEM2_MEMSET2_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PMEM2_MEMSET2_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PMEM2_MEMSET2_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PMEM2_MEMWAIT2: uInt32  = $0000FF00;  // MEMWAIT2[7:0] bits (Common memory 2 wait time) 
  FSMC_PMEM2_MEMWAIT2_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PMEM2_MEMWAIT2_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PMEM2_MEMWAIT2_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PMEM2_MEMWAIT2_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PMEM2_MEMWAIT2_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PMEM2_MEMWAIT2_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PMEM2_MEMWAIT2_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PMEM2_MEMWAIT2_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PMEM2_MEMHOLD2: uInt32  = $00FF0000;  // MEMHOLD2[7:0] bits (Common memory 2 hold time) 
  FSMC_PMEM2_MEMHOLD2_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PMEM2_MEMHOLD2_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PMEM2_MEMHOLD2_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PMEM2_MEMHOLD2_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PMEM2_MEMHOLD2_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PMEM2_MEMHOLD2_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PMEM2_MEMHOLD2_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PMEM2_MEMHOLD2_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PMEM2_MEMHIZ2: uInt32  = $FF000000;  // MEMHIZ2[7:0] bits (Common memory 2 databus HiZ time) 
  FSMC_PMEM2_MEMHIZ2_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PMEM2_MEMHIZ2_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PMEM2_MEMHIZ2_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PMEM2_MEMHIZ2_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PMEM2_MEMHIZ2_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PMEM2_MEMHIZ2_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PMEM2_MEMHIZ2_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PMEM2_MEMHIZ2_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_PMEM3 register  *****************}
  FSMC_PMEM3_MEMSET3: uInt32  = $000000FF;  // MEMSET3[7:0] bits (Common memory 3 setup time) 
  FSMC_PMEM3_MEMSET3_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PMEM3_MEMSET3_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PMEM3_MEMSET3_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PMEM3_MEMSET3_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PMEM3_MEMSET3_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PMEM3_MEMSET3_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PMEM3_MEMSET3_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PMEM3_MEMSET3_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PMEM3_MEMWAIT3: uInt32  = $0000FF00;  // MEMWAIT3[7:0] bits (Common memory 3 wait time) 
  FSMC_PMEM3_MEMWAIT3_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PMEM3_MEMWAIT3_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PMEM3_MEMWAIT3_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PMEM3_MEMWAIT3_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PMEM3_MEMWAIT3_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PMEM3_MEMWAIT3_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PMEM3_MEMWAIT3_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PMEM3_MEMWAIT3_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PMEM3_MEMHOLD3: uInt32  = $00FF0000;  // MEMHOLD3[7:0] bits (Common memory 3 hold time) 
  FSMC_PMEM3_MEMHOLD3_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PMEM3_MEMHOLD3_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PMEM3_MEMHOLD3_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PMEM3_MEMHOLD3_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PMEM3_MEMHOLD3_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PMEM3_MEMHOLD3_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PMEM3_MEMHOLD3_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PMEM3_MEMHOLD3_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PMEM3_MEMHIZ3: uInt32  = $FF000000;  // MEMHIZ3[7:0] bits (Common memory 3 databus HiZ time) 
  FSMC_PMEM3_MEMHIZ3_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PMEM3_MEMHIZ3_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PMEM3_MEMHIZ3_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PMEM3_MEMHIZ3_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PMEM3_MEMHIZ3_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PMEM3_MEMHIZ3_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PMEM3_MEMHIZ3_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PMEM3_MEMHIZ3_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_PMEM4 register  *****************}
  FSMC_PMEM4_MEMSET4: uInt32  = $000000FF;  // MEMSET4[7:0] bits (Common memory 4 setup time) 
  FSMC_PMEM4_MEMSET4_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PMEM4_MEMSET4_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PMEM4_MEMSET4_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PMEM4_MEMSET4_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PMEM4_MEMSET4_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PMEM4_MEMSET4_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PMEM4_MEMSET4_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PMEM4_MEMSET4_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PMEM4_MEMWAIT4: uInt32  = $0000FF00;  // MEMWAIT4[7:0] bits (Common memory 4 wait time) 
  FSMC_PMEM4_MEMWAIT4_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PMEM4_MEMWAIT4_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PMEM4_MEMWAIT4_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PMEM4_MEMWAIT4_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PMEM4_MEMWAIT4_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PMEM4_MEMWAIT4_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PMEM4_MEMWAIT4_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PMEM4_MEMWAIT4_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PMEM4_MEMHOLD4: uInt32  = $00FF0000;  // MEMHOLD4[7:0] bits (Common memory 4 hold time) 
  FSMC_PMEM4_MEMHOLD4_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PMEM4_MEMHOLD4_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PMEM4_MEMHOLD4_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PMEM4_MEMHOLD4_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PMEM4_MEMHOLD4_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PMEM4_MEMHOLD4_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PMEM4_MEMHOLD4_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PMEM4_MEMHOLD4_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PMEM4_MEMHIZ4: uInt32  = $FF000000;  // MEMHIZ4[7:0] bits (Common memory 4 databus HiZ time) 
  FSMC_PMEM4_MEMHIZ4_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PMEM4_MEMHIZ4_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PMEM4_MEMHIZ4_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PMEM4_MEMHIZ4_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PMEM4_MEMHIZ4_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PMEM4_MEMHIZ4_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PMEM4_MEMHIZ4_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PMEM4_MEMHIZ4_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_PATT2 register  *****************}
  FSMC_PATT2_ATTSET2: uInt32  = $000000FF;  // ATTSET2[7:0] bits (Attribute memory 2 setup time) 
  FSMC_PATT2_ATTSET2_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PATT2_ATTSET2_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PATT2_ATTSET2_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PATT2_ATTSET2_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PATT2_ATTSET2_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PATT2_ATTSET2_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PATT2_ATTSET2_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PATT2_ATTSET2_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PATT2_ATTWAIT2: uInt32  = $0000FF00;  // ATTWAIT2[7:0] bits (Attribute memory 2 wait time) 
  FSMC_PATT2_ATTWAIT2_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PATT2_ATTWAIT2_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PATT2_ATTWAIT2_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PATT2_ATTWAIT2_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PATT2_ATTWAIT2_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PATT2_ATTWAIT2_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PATT2_ATTWAIT2_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PATT2_ATTWAIT2_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PATT2_ATTHOLD2: uInt32  = $00FF0000;  // ATTHOLD2[7:0] bits (Attribute memory 2 hold time) 
  FSMC_PATT2_ATTHOLD2_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PATT2_ATTHOLD2_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PATT2_ATTHOLD2_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PATT2_ATTHOLD2_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PATT2_ATTHOLD2_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PATT2_ATTHOLD2_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PATT2_ATTHOLD2_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PATT2_ATTHOLD2_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PATT2_ATTHIZ2: uInt32  = $FF000000;  // ATTHIZ2[7:0] bits (Attribute memory 2 databus HiZ time) 
  FSMC_PATT2_ATTHIZ2_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PATT2_ATTHIZ2_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PATT2_ATTHIZ2_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PATT2_ATTHIZ2_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PATT2_ATTHIZ2_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PATT2_ATTHIZ2_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PATT2_ATTHIZ2_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PATT2_ATTHIZ2_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_PATT3 register  *****************}
  FSMC_PATT3_ATTSET3: uInt32  = $000000FF;  // ATTSET3[7:0] bits (Attribute memory 3 setup time) 
  FSMC_PATT3_ATTSET3_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PATT3_ATTSET3_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PATT3_ATTSET3_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PATT3_ATTSET3_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PATT3_ATTSET3_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PATT3_ATTSET3_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PATT3_ATTSET3_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PATT3_ATTSET3_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PATT3_ATTWAIT3: uInt32  = $0000FF00;  // ATTWAIT3[7:0] bits (Attribute memory 3 wait time) 
  FSMC_PATT3_ATTWAIT3_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PATT3_ATTWAIT3_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PATT3_ATTWAIT3_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PATT3_ATTWAIT3_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PATT3_ATTWAIT3_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PATT3_ATTWAIT3_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PATT3_ATTWAIT3_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PATT3_ATTWAIT3_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PATT3_ATTHOLD3: uInt32  = $00FF0000;  // ATTHOLD3[7:0] bits (Attribute memory 3 hold time) 
  FSMC_PATT3_ATTHOLD3_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PATT3_ATTHOLD3_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PATT3_ATTHOLD3_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PATT3_ATTHOLD3_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PATT3_ATTHOLD3_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PATT3_ATTHOLD3_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PATT3_ATTHOLD3_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PATT3_ATTHOLD3_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PATT3_ATTHIZ3: uInt32  = $FF000000;  // ATTHIZ3[7:0] bits (Attribute memory 3 databus HiZ time) 
  FSMC_PATT3_ATTHIZ3_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PATT3_ATTHIZ3_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PATT3_ATTHIZ3_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PATT3_ATTHIZ3_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PATT3_ATTHIZ3_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PATT3_ATTHIZ3_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PATT3_ATTHIZ3_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PATT3_ATTHIZ3_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_PATT4 register  *****************}
  FSMC_PATT4_ATTSET4: uInt32  = $000000FF;  // ATTSET4[7:0] bits (Attribute memory 4 setup time) 
  FSMC_PATT4_ATTSET4_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PATT4_ATTSET4_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PATT4_ATTSET4_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PATT4_ATTSET4_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PATT4_ATTSET4_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PATT4_ATTSET4_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PATT4_ATTSET4_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PATT4_ATTSET4_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PATT4_ATTWAIT4: uInt32  = $0000FF00;  // ATTWAIT4[7:0] bits (Attribute memory 4 wait time) 
  FSMC_PATT4_ATTWAIT4_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PATT4_ATTWAIT4_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PATT4_ATTWAIT4_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PATT4_ATTWAIT4_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PATT4_ATTWAIT4_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PATT4_ATTWAIT4_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PATT4_ATTWAIT4_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PATT4_ATTWAIT4_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PATT4_ATTHOLD4: uInt32  = $00FF0000;  // ATTHOLD4[7:0] bits (Attribute memory 4 hold time) 
  FSMC_PATT4_ATTHOLD4_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PATT4_ATTHOLD4_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PATT4_ATTHOLD4_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PATT4_ATTHOLD4_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PATT4_ATTHOLD4_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PATT4_ATTHOLD4_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PATT4_ATTHOLD4_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PATT4_ATTHOLD4_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PATT4_ATTHIZ4: uInt32  = $FF000000;  // ATTHIZ4[7:0] bits (Attribute memory 4 databus HiZ time) 
  FSMC_PATT4_ATTHIZ4_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PATT4_ATTHIZ4_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PATT4_ATTHIZ4_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PATT4_ATTHIZ4_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PATT4_ATTHIZ4_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PATT4_ATTHIZ4_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PATT4_ATTHIZ4_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PATT4_ATTHIZ4_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_PIO4 register  ******************}
  FSMC_PIO4_IOSET4: uInt32  = $000000FF;  // IOSET4[7:0] bits (I/O 4 setup time) 
  FSMC_PIO4_IOSET4_0: uInt32  = $00000001;  // Bit 0 
  FSMC_PIO4_IOSET4_1: uInt32  = $00000002;  // Bit 1 
  FSMC_PIO4_IOSET4_2: uInt32  = $00000004;  // Bit 2 
  FSMC_PIO4_IOSET4_3: uInt32  = $00000008;  // Bit 3 
  FSMC_PIO4_IOSET4_4: uInt32  = $00000010;  // Bit 4 
  FSMC_PIO4_IOSET4_5: uInt32  = $00000020;  // Bit 5 
  FSMC_PIO4_IOSET4_6: uInt32  = $00000040;  // Bit 6 
  FSMC_PIO4_IOSET4_7: uInt32  = $00000080;  // Bit 7 

  FSMC_PIO4_IOWAIT4: uInt32  = $0000FF00;  // IOWAIT4[7:0] bits (I/O 4 wait time) 
  FSMC_PIO4_IOWAIT4_0: uInt32  = $00000100;  // Bit 0 
  FSMC_PIO4_IOWAIT4_1: uInt32  = $00000200;  // Bit 1 
  FSMC_PIO4_IOWAIT4_2: uInt32  = $00000400;  // Bit 2 
  FSMC_PIO4_IOWAIT4_3: uInt32  = $00000800;  // Bit 3 
  FSMC_PIO4_IOWAIT4_4: uInt32  = $00001000;  // Bit 4 
  FSMC_PIO4_IOWAIT4_5: uInt32  = $00002000;  // Bit 5 
  FSMC_PIO4_IOWAIT4_6: uInt32  = $00004000;  // Bit 6 
  FSMC_PIO4_IOWAIT4_7: uInt32  = $00008000;  // Bit 7 

  FSMC_PIO4_IOHOLD4: uInt32  = $00FF0000;  // IOHOLD4[7:0] bits (I/O 4 hold time) 
  FSMC_PIO4_IOHOLD4_0: uInt32  = $00010000;  // Bit 0 
  FSMC_PIO4_IOHOLD4_1: uInt32  = $00020000;  // Bit 1 
  FSMC_PIO4_IOHOLD4_2: uInt32  = $00040000;  // Bit 2 
  FSMC_PIO4_IOHOLD4_3: uInt32  = $00080000;  // Bit 3 
  FSMC_PIO4_IOHOLD4_4: uInt32  = $00100000;  // Bit 4 
  FSMC_PIO4_IOHOLD4_5: uInt32  = $00200000;  // Bit 5 
  FSMC_PIO4_IOHOLD4_6: uInt32  = $00400000;  // Bit 6 
  FSMC_PIO4_IOHOLD4_7: uInt32  = $00800000;  // Bit 7 

  FSMC_PIO4_IOHIZ4: uInt32  = $FF000000;  // IOHIZ4[7:0] bits (I/O 4 databus HiZ time) 
  FSMC_PIO4_IOHIZ4_0: uInt32  = $01000000;  // Bit 0 
  FSMC_PIO4_IOHIZ4_1: uInt32  = $02000000;  // Bit 1 
  FSMC_PIO4_IOHIZ4_2: uInt32  = $04000000;  // Bit 2 
  FSMC_PIO4_IOHIZ4_3: uInt32  = $08000000;  // Bit 3 
  FSMC_PIO4_IOHIZ4_4: uInt32  = $10000000;  // Bit 4 
  FSMC_PIO4_IOHIZ4_5: uInt32  = $20000000;  // Bit 5 
  FSMC_PIO4_IOHIZ4_6: uInt32  = $40000000;  // Bit 6 
  FSMC_PIO4_IOHIZ4_7: uInt32  = $80000000;  // Bit 7 

{*****************  Bit definition for FSMC_ECCR2 register  *****************}
  FSMC_ECCR2_ECC2: uInt32  = $FFFFFFFF;  // ECC result 

{*****************  Bit definition for FSMC_ECCR3 register  *****************}
  FSMC_ECCR3_ECC3: uInt32  = $FFFFFFFF;  // ECC result 

{****************************************************************************}
{                                                                            }
{                          SD host Interface                                 }
{                                                                            }
{****************************************************************************}

{*****************  Bit definition for SDIO_POWER register  *****************}
  SDIO_POWER_PWRCTRL: uInt8  = $03;  // PWRCTRL[1:0] bits (Power supply control bits) 
  SDIO_POWER_PWRCTRL_0: uInt8  = $01;  // Bit 0 
  SDIO_POWER_PWRCTRL_1: uInt8  = $02;  // Bit 1 

{*****************  Bit definition for SDIO_CLKCR register  *****************}
  SDIO_CLKCR_CLKDIV: uInt16  = $00FF;  // Clock divide factor 
  SDIO_CLKCR_CLKEN: uInt16  = $0100;  // Clock enable bit 
  SDIO_CLKCR_PWRSAV: uInt16  = $0200;  // Power saving configuration bit 
  SDIO_CLKCR_BYPASS: uInt16  = $0400;  // Clock divider bypass enable bit 

  SDIO_CLKCR_WIDBUS: uInt16  = $1800;  // WIDBUS[1:0] bits (Wide bus mode enable bit) 
  SDIO_CLKCR_WIDBUS_0: uInt16  = $0800;  // Bit 0 
  SDIO_CLKCR_WIDBUS_1: uInt16  = $1000;  // Bit 1 

  SDIO_CLKCR_NEGEDGE: uInt16  = $2000;  // SDIO_CK dephasing selection bit 
  SDIO_CLKCR_HWFC_EN: uInt16  = $4000;  // HW Flow Control enable 

{******************  Bit definition for SDIO_ARG register  ******************}
  SDIO_ARG_CMDARG: uInt32  = $FFFFFFFF;  // Command argument 

{******************  Bit definition for SDIO_CMD register  ******************}
  SDIO_CMD_CMDINDEX: uInt16  = $003F;  // Command Index 

  SDIO_CMD_WAITRESP: uInt16  = $00C0;  // WAITRESP[1:0] bits (Wait for response bits) 
  SDIO_CMD_WAITRESP_0: uInt16  = $0040;  //  Bit 0 
  SDIO_CMD_WAITRESP_1: uInt16  = $0080;  //  Bit 1 

  SDIO_CMD_WAITINT: uInt16  = $0100;  // CPSM Waits for Interrupt Request 
  SDIO_CMD_WAITPEND: uInt16  = $0200;  // CPSM Waits for ends of data transfer (CmdPend internal signal) 
  SDIO_CMD_CPSMEN: uInt16  = $0400;  // Command path state machine (CPSM) Enable bit 
  SDIO_CMD_SDIOSUSPEND: uInt16  = $0800;  // SD I/O suspend command 
  SDIO_CMD_ENCMDCOMPL: uInt16  = $1000;  // Enable CMD completion 
  SDIO_CMD_NIEN: uInt16  = $2000;  // Not Interrupt Enable 
  SDIO_CMD_CEATACMD: uInt16  = $4000;  // CE-ATA command 

{****************  Bit definition for SDIO_RESPCMD register  ****************}
  SDIO_RESPCMD_RESPCMD: uInt8  = $3F;  // Response command index 

{*****************  Bit definition for SDIO_RESP0 register  *****************}
  SDIO_RESP0_CARDSTATUS0: uInt32  = $FFFFFFFF;  // Card Status 

{*****************  Bit definition for SDIO_RESP1 register  *****************}
  SDIO_RESP1_CARDSTATUS1: uInt32  = $FFFFFFFF;  // Card Status 

{*****************  Bit definition for SDIO_RESP2 register  *****************}
  SDIO_RESP2_CARDSTATUS2: uInt32  = $FFFFFFFF;  // Card Status 

{*****************  Bit definition for SDIO_RESP3 register  *****************}
  SDIO_RESP3_CARDSTATUS3: uInt32  = $FFFFFFFF;  // Card Status 

{*****************  Bit definition for SDIO_RESP4 register  *****************}
  SDIO_RESP4_CARDSTATUS4: uInt32  = $FFFFFFFF;  // Card Status 

{*****************  Bit definition for SDIO_DTIMER register  ****************}
  SDIO_DTIMER_DATATIME: uInt32  = $FFFFFFFF;  // Data timeout period. 

{*****************  Bit definition for SDIO_DLEN register  ******************}
  SDIO_DLEN_DATALENGTH: uInt32  = $01FFFFFF;  // Data length value 

{*****************  Bit definition for SDIO_DCTRL register  *****************}
  SDIO_DCTRL_DTEN: uInt16  = $0001;  // Data transfer enabled bit 
  SDIO_DCTRL_DTDIR: uInt16  = $0002;  // Data transfer direction selection 
  SDIO_DCTRL_DTMODE: uInt16  = $0004;  // Data transfer mode selection 
  SDIO_DCTRL_DMAEN: uInt16  = $0008;  // DMA enabled bit 

  SDIO_DCTRL_DBLOCKSIZE: uInt16  = $00F0;  // DBLOCKSIZE[3:0] bits (Data block size) 
  SDIO_DCTRL_DBLOCKSIZE_0: uInt16  = $0010;  // Bit 0 
  SDIO_DCTRL_DBLOCKSIZE_1: uInt16  = $0020;  // Bit 1 
  SDIO_DCTRL_DBLOCKSIZE_2: uInt16  = $0040;  // Bit 2 
  SDIO_DCTRL_DBLOCKSIZE_3: uInt16  = $0080;  // Bit 3 

  SDIO_DCTRL_RWSTART: uInt16  = $0100;  // Read wait start 
  SDIO_DCTRL_RWSTOP: uInt16  = $0200;  // Read wait stop 
  SDIO_DCTRL_RWMOD: uInt16  = $0400;  // Read wait mode 
  SDIO_DCTRL_SDIOEN: uInt16  = $0800;  // SD I/O enable functions 

{*****************  Bit definition for SDIO_DCOUNT register  ****************}
  SDIO_DCOUNT_DATACOUNT: uInt32  = $01FFFFFF;  // Data count value 

{*****************  Bit definition for SDIO_STA register  *******************}
  SDIO_STA_CCRCFAIL: uInt32  = $00000001;  // Command response received (CRC check failed) 
  SDIO_STA_DCRCFAIL: uInt32  = $00000002;  // Data block sent/received (CRC check failed) 
  SDIO_STA_CTIMEOUT: uInt32  = $00000004;  // Command response timeout 
  SDIO_STA_DTIMEOUT: uInt32  = $00000008;  // Data timeout 
  SDIO_STA_TXUNDERR: uInt32  = $00000010;  // Transmit FIFO underrun error 
  SDIO_STA_RXOVERR: uInt32  = $00000020;  // Received FIFO overrun error 
  SDIO_STA_CMDREND: uInt32  = $00000040;  // Command response received (CRC check passed) 
  SDIO_STA_CMDSENT: uInt32  = $00000080;  // Command sent (no response required) 
  SDIO_STA_DATAEND: uInt32  = $00000100;  // Data end (data counter, SDIDCOUNT, is zero) 
  SDIO_STA_STBITERR: uInt32  = $00000200;  // Start bit not detected on all data signals in wide bus mode 
  SDIO_STA_DBCKEND: uInt32  = $00000400;  // Data block sent/received (CRC check passed) 
  SDIO_STA_CMDACT: uInt32  = $00000800;  // Command transfer in progress 
  SDIO_STA_TXACT: uInt32  = $00001000;  // Data transmit in progress 
  SDIO_STA_RXACT: uInt32  = $00002000;  // Data receive in progress 
  SDIO_STA_TXFIFOHE: uInt32  = $00004000;  // Transmit FIFO Half Empty: at least 8 words can be written into the FIFO 
  SDIO_STA_RXFIFOHF: uInt32  = $00008000;  // Receive FIFO Half Full: there are at least 8 words in the FIFO 
  SDIO_STA_TXFIFOF: uInt32  = $00010000;  // Transmit FIFO full 
  SDIO_STA_RXFIFOF: uInt32  = $00020000;  // Receive FIFO full 
  SDIO_STA_TXFIFOE: uInt32  = $00040000;  // Transmit FIFO empty 
  SDIO_STA_RXFIFOE: uInt32  = $00080000;  // Receive FIFO empty 
  SDIO_STA_TXDAVL: uInt32  = $00100000;  // Data available in transmit FIFO 
  SDIO_STA_RXDAVL: uInt32  = $00200000;  // Data available in receive FIFO 
  SDIO_STA_SDIOIT: uInt32  = $00400000;  // SDIO interrupt received 
  SDIO_STA_CEATAEND: uInt32  = $00800000;  // CE-ATA command completion signal received for CMD61 

{******************  Bit definition for SDIO_ICR register  ******************}
  SDIO_ICR_CCRCFAILC: uInt32  = $00000001;  // CCRCFAIL flag clear bit 
  SDIO_ICR_DCRCFAILC: uInt32  = $00000002;  // DCRCFAIL flag clear bit 
  SDIO_ICR_CTIMEOUTC: uInt32  = $00000004;  // CTIMEOUT flag clear bit 
  SDIO_ICR_DTIMEOUTC: uInt32  = $00000008;  // DTIMEOUT flag clear bit 
  SDIO_ICR_TXUNDERRC: uInt32  = $00000010;  // TXUNDERR flag clear bit 
  SDIO_ICR_RXOVERRC: uInt32  = $00000020;  // RXOVERR flag clear bit 
  SDIO_ICR_CMDRENDC: uInt32  = $00000040;  // CMDREND flag clear bit 
  SDIO_ICR_CMDSENTC: uInt32  = $00000080;  // CMDSENT flag clear bit 
  SDIO_ICR_DATAENDC: uInt32  = $00000100;  // DATAEND flag clear bit 
  SDIO_ICR_STBITERRC: uInt32  = $00000200;  // STBITERR flag clear bit 
  SDIO_ICR_DBCKENDC: uInt32  = $00000400;  // DBCKEND flag clear bit 
  SDIO_ICR_SDIOITC: uInt32  = $00400000;  // SDIOIT flag clear bit 
  SDIO_ICR_CEATAENDC: uInt32  = $00800000;  // CEATAEND flag clear bit 

{*****************  Bit definition for SDIO_MASK register  ******************}
  SDIO_MASK_CCRCFAILIE: uInt32  = $00000001;  // Command CRC Fail Interrupt Enable 
  SDIO_MASK_DCRCFAILIE: uInt32  = $00000002;  // Data CRC Fail Interrupt Enable 
  SDIO_MASK_CTIMEOUTIE: uInt32  = $00000004;  // Command TimeOut Interrupt Enable 
  SDIO_MASK_DTIMEOUTIE: uInt32  = $00000008;  // Data TimeOut Interrupt Enable 
  SDIO_MASK_TXUNDERRIE: uInt32  = $00000010;  // Tx FIFO UnderRun Error Interrupt Enable 
  SDIO_MASK_RXOVERRIE: uInt32  = $00000020;  // Rx FIFO OverRun Error Interrupt Enable 
  SDIO_MASK_CMDRENDIE: uInt32  = $00000040;  // Command Response Received Interrupt Enable 
  SDIO_MASK_CMDSENTIE: uInt32  = $00000080;  // Command Sent Interrupt Enable 
  SDIO_MASK_DATAENDIE: uInt32  = $00000100;  // Data End Interrupt Enable 
  SDIO_MASK_STBITERRIE: uInt32  = $00000200;  // Start Bit Error Interrupt Enable 
  SDIO_MASK_DBCKENDIE: uInt32  = $00000400;  // Data Block End Interrupt Enable 
  SDIO_MASK_CMDACTIE: uInt32  = $00000800;  // Command Acting Interrupt Enable 
  SDIO_MASK_TXACTIE: uInt32  = $00001000;  // Data Transmit Acting Interrupt Enable 
  SDIO_MASK_RXACTIE: uInt32  = $00002000;  // Data receive acting interrupt enabled 
  SDIO_MASK_TXFIFOHEIE: uInt32  = $00004000;  // Tx FIFO Half Empty interrupt Enable 
  SDIO_MASK_RXFIFOHFIE: uInt32  = $00008000;  // Rx FIFO Half Full interrupt Enable 
  SDIO_MASK_TXFIFOFIE: uInt32  = $00010000;  // Tx FIFO Full interrupt Enable 
  SDIO_MASK_RXFIFOFIE: uInt32  = $00020000;  // Rx FIFO Full interrupt Enable 
  SDIO_MASK_TXFIFOEIE: uInt32  = $00040000;  // Tx FIFO Empty interrupt Enable 
  SDIO_MASK_RXFIFOEIE: uInt32  = $00080000;  // Rx FIFO Empty interrupt Enable 
  SDIO_MASK_TXDAVLIE: uInt32  = $00100000;  // Data available in Tx FIFO interrupt Enable 
  SDIO_MASK_RXDAVLIE: uInt32  = $00200000;  // Data available in Rx FIFO interrupt Enable 
  SDIO_MASK_SDIOITIE: uInt32  = $00400000;  // SDIO Mode Interrupt Received interrupt Enable 
  SDIO_MASK_CEATAENDIE: uInt32  = $00800000;  // CE-ATA command completion signal received Interrupt Enable 

{****************  Bit definition for SDIO_FIFOCNT register  ****************}
  SDIO_FIFOCNT_FIFOCOUNT: uInt32  = $00FFFFFF;  // Remaining number of words to be written to or read from the FIFO 

{*****************  Bit definition for SDIO_FIFO register  ******************}
  SDIO_FIFO_FIFODATA: uInt32  = $FFFFFFFF;  // Receive and transmit FIFO data 

{****************************************************************************}
{                                                                            }
{                                   USB Device FS                            }
{                                                                            }
{****************************************************************************}

{ Endpoint-specific registers }
{******************  Bit definition for USB_EP0R register  ******************}
  USB_EP0R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP0R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP0R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP0R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP0R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP0R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP0R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP0R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP0R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP0R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP0R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP0R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP0R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP0R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP0R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP0R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP1R register  ******************}
  USB_EP1R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP1R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP1R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP1R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP1R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP1R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP1R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP1R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP1R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP1R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP1R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP1R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP1R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP1R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP1R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP1R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP2R register  ******************}
  USB_EP2R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP2R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP2R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP2R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP2R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP2R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP2R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP2R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP2R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP2R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP2R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP2R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP2R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP2R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP2R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP2R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP3R register  ******************}
  USB_EP3R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP3R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP3R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP3R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP3R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP3R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP3R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP3R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP3R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP3R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP3R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP3R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP3R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP3R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP3R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP3R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP4R register  ******************}
  USB_EP4R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP4R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP4R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP4R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP4R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP4R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP4R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP4R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP4R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP4R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP4R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP4R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP4R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP4R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP4R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP4R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP5R register  ******************}
  USB_EP5R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP5R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP5R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP5R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP5R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP5R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP5R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP5R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP5R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP5R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP5R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP5R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP5R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP5R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP5R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP5R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP6R register  ******************}
  USB_EP6R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP6R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP6R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP6R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP6R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP6R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP6R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP6R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP6R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP6R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP6R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP6R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP6R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP6R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP6R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP6R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{******************  Bit definition for USB_EP7R register  ******************}
  USB_EP7R_EA: uInt16  = $000F;  // Endpoint Address 

  USB_EP7R_STAT_TX: uInt16  = $0030;  // STAT_TX[1:0] bits (Status bits, for transmission transfers) 
  USB_EP7R_STAT_TX_0: uInt16  = $0010;  // Bit 0 
  USB_EP7R_STAT_TX_1: uInt16  = $0020;  // Bit 1 

  USB_EP7R_DTOG_TX: uInt16  = $0040;  // Data Toggle, for transmission transfers 
  USB_EP7R_CTR_TX: uInt16  = $0080;  // Correct Transfer for transmission 
  USB_EP7R_EP_KIND: uInt16  = $0100;  // Endpoint Kind 

  USB_EP7R_EP_TYPE: uInt16  = $0600;  // EP_TYPE[1:0] bits (Endpoint type) 
  USB_EP7R_EP_TYPE_0: uInt16  = $0200;  // Bit 0 
  USB_EP7R_EP_TYPE_1: uInt16  = $0400;  // Bit 1 

  USB_EP7R_SETUP: uInt16  = $0800;  // Setup transaction completed 

  USB_EP7R_STAT_RX: uInt16  = $3000;  // STAT_RX[1:0] bits (Status bits, for reception transfers) 
  USB_EP7R_STAT_RX_0: uInt16  = $1000;  // Bit 0 
  USB_EP7R_STAT_RX_1: uInt16  = $2000;  // Bit 1 

  USB_EP7R_DTOG_RX: uInt16  = $4000;  // Data Toggle, for reception transfers 
  USB_EP7R_CTR_RX: uInt16  = $8000;  // Correct Transfer for reception 

{ Common registers }
{******************  Bit definition for USB_CNTR register  ******************}
  USB_CNTR_FRES: uInt16  = $0001;  // Force USB Reset 
  USB_CNTR_PDWN: uInt16  = $0002;  // Power down 
  USB_CNTR_LP_MODE: uInt16  = $0004;  // Low-power mode 
  USB_CNTR_FSUSP: uInt16  = $0008;  // Force suspend 
  USB_CNTR_RESUME: uInt16  = $0010;  // Resume request 
  USB_CNTR_ESOFM: uInt16  = $0100;  // Expected Start Of Frame Interrupt Mask 
  USB_CNTR_SOFM: uInt16  = $0200;  // Start Of Frame Interrupt Mask 
  USB_CNTR_RESETM: uInt16  = $0400;  // RESET Interrupt Mask 
  USB_CNTR_SUSPM: uInt16  = $0800;  // Suspend mode Interrupt Mask 
  USB_CNTR_WKUPM: uInt16  = $1000;  // Wakeup Interrupt Mask 
  USB_CNTR_ERRM: uInt16  = $2000;  // Error Interrupt Mask 
  USB_CNTR_PMAOVRM: uInt16  = $4000;  // Packet Memory Area Over / Underrun Interrupt Mask 
  USB_CNTR_CTRM: uInt16  = $8000;  // Correct Transfer Interrupt Mask 

{******************  Bit definition for USB_ISTR register  ******************}
  USB_ISTR_EP_ID: uInt16  = $000F;  // Endpoint Identifier 
  USB_ISTR_DIR: uInt16  = $0010;  // Direction of transaction 
  USB_ISTR_ESOF: uInt16  = $0100;  // Expected Start Of Frame 
  USB_ISTR_SOF: uInt16  = $0200;  // Start Of Frame 
  USB_ISTR_RESET: uInt16  = $0400;  // USB RESET request 
  USB_ISTR_SUSP: uInt16  = $0800;  // Suspend mode request 
  USB_ISTR_WKUP: uInt16  = $1000;  // Wake up 
  USB_ISTR_ERR: uInt16  = $2000;  // Error 
  USB_ISTR_PMAOVR: uInt16  = $4000;  // Packet Memory Area Over / Underrun 
  USB_ISTR_CTR: uInt16  = $8000;  // Correct Transfer 

{******************  Bit definition for USB_FNR register  *******************}
  USB_FNR_FN: uInt16  = $07FF;  // Frame Number 
  USB_FNR_LSOF: uInt16  = $1800;  // Lost SOF 
  USB_FNR_LCK: uInt16  = $2000;  // Locked 
  USB_FNR_RXDM: uInt16  = $4000;  // Receive Data - Line Status 
  USB_FNR_RXDP: uInt16  = $8000;  // Receive Data + Line Status 

{*****************  Bit definition for USB_DADDR register  ******************}
  USB_DADDR_ADD: uInt8  = $7F;  // ADD[6:0] bits (Device Address) 
  USB_DADDR_ADD0: uInt8  = $01;  // Bit 0 
  USB_DADDR_ADD1: uInt8  = $02;  // Bit 1 
  USB_DADDR_ADD2: uInt8  = $04;  // Bit 2 
  USB_DADDR_ADD3: uInt8  = $08;  // Bit 3 
  USB_DADDR_ADD4: uInt8  = $10;  // Bit 4 
  USB_DADDR_ADD5: uInt8  = $20;  // Bit 5 
  USB_DADDR_ADD6: uInt8  = $40;  // Bit 6 

  USB_DADDR_EF: uInt8  = $80;  // Enable Function 

{*****************  Bit definition for USB_BTABLE register  *****************}
  USB_BTABLE_BTABLE: uInt16  = $FFF8;  // Buffer Table 

{ Buffer descriptor table }
{****************  Bit definition for USB_ADDR0_TX register  ****************}
  USB_ADDR0_TX_ADDR0_TX: uInt16  = $FFFE;  // Transmission Buffer Address 0 

{****************  Bit definition for USB_ADDR1_TX register  ****************}
  USB_ADDR1_TX_ADDR1_TX: uInt16  = $FFFE;  // Transmission Buffer Address 1 

{****************  Bit definition for USB_ADDR2_TX register  ****************}
  USB_ADDR2_TX_ADDR2_TX: uInt16  = $FFFE;  // Transmission Buffer Address 2 

{****************  Bit definition for USB_ADDR3_TX register  ****************}
  USB_ADDR3_TX_ADDR3_TX: uInt16  = $FFFE;  // Transmission Buffer Address 3 

{****************  Bit definition for USB_ADDR4_TX register  ****************}
  USB_ADDR4_TX_ADDR4_TX: uInt16  = $FFFE;  // Transmission Buffer Address 4 

{****************  Bit definition for USB_ADDR5_TX register  ****************}
  USB_ADDR5_TX_ADDR5_TX: uInt16  = $FFFE;  // Transmission Buffer Address 5 

{****************  Bit definition for USB_ADDR6_TX register  ****************}
  USB_ADDR6_TX_ADDR6_TX: uInt16  = $FFFE;  // Transmission Buffer Address 6 

{****************  Bit definition for USB_ADDR7_TX register  ****************}
  USB_ADDR7_TX_ADDR7_TX: uInt16  = $FFFE;  // Transmission Buffer Address 7 

{----------------------------------------------------------------------------}

{****************  Bit definition for USB_COUNT0_TX register  ***************}
  USB_COUNT0_TX_COUNT0_TX: uInt16  = $03FF;  // Transmission Byte Count 0 

{****************  Bit definition for USB_COUNT1_TX register  ***************}
  USB_COUNT1_TX_COUNT1_TX: uInt16  = $03FF;  // Transmission Byte Count 1 

{****************  Bit definition for USB_COUNT2_TX register  ***************}
  USB_COUNT2_TX_COUNT2_TX: uInt16  = $03FF;  // Transmission Byte Count 2 

{****************  Bit definition for USB_COUNT3_TX register  ***************}
  USB_COUNT3_TX_COUNT3_TX: uInt16  = $03FF;  // Transmission Byte Count 3 

{****************  Bit definition for USB_COUNT4_TX register  ***************}
  USB_COUNT4_TX_COUNT4_TX: uInt16  = $03FF;  // Transmission Byte Count 4 

{****************  Bit definition for USB_COUNT5_TX register  ***************}
  USB_COUNT5_TX_COUNT5_TX: uInt16  = $03FF;  // Transmission Byte Count 5 

{****************  Bit definition for USB_COUNT6_TX register  ***************}
  USB_COUNT6_TX_COUNT6_TX: uInt16  = $03FF;  // Transmission Byte Count 6 

{****************  Bit definition for USB_COUNT7_TX register  ***************}
  USB_COUNT7_TX_COUNT7_TX: uInt16  = $03FF;  // Transmission Byte Count 7 

{----------------------------------------------------------------------------}

{***************  Bit definition for USB_COUNT0_TX_0 register  **************}
  USB_COUNT0_TX_0_COUNT0_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 0 (low) 

{***************  Bit definition for USB_COUNT0_TX_1 register  **************}
  USB_COUNT0_TX_1_COUNT0_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 0 (high) 

{***************  Bit definition for USB_COUNT1_TX_0 register  **************}
  USB_COUNT1_TX_0_COUNT1_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 1 (low) 

{***************  Bit definition for USB_COUNT1_TX_1 register  **************}
  USB_COUNT1_TX_1_COUNT1_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 1 (high) 

{***************  Bit definition for USB_COUNT2_TX_0 register  **************}
  USB_COUNT2_TX_0_COUNT2_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 2 (low) 

{***************  Bit definition for USB_COUNT2_TX_1 register  **************}
  USB_COUNT2_TX_1_COUNT2_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 2 (high) 

{***************  Bit definition for USB_COUNT3_TX_0 register  **************}
  USB_COUNT3_TX_0_COUNT3_TX_0: uInt16  = $000003FF;  // Transmission Byte Count 3 (low) 

{***************  Bit definition for USB_COUNT3_TX_1 register  **************}
  USB_COUNT3_TX_1_COUNT3_TX_1: uInt16  = 0; //$03FF0000;  // Transmission Byte Count 3 (high)

{***************  Bit definition for USB_COUNT4_TX_0 register  **************}
  USB_COUNT4_TX_0_COUNT4_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 4 (low) 

{***************  Bit definition for USB_COUNT4_TX_1 register  **************}
  USB_COUNT4_TX_1_COUNT4_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 4 (high) 

{***************  Bit definition for USB_COUNT5_TX_0 register  **************}
  USB_COUNT5_TX_0_COUNT5_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 5 (low) 

{***************  Bit definition for USB_COUNT5_TX_1 register  **************}
  USB_COUNT5_TX_1_COUNT5_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 5 (high) 

{***************  Bit definition for USB_COUNT6_TX_0 register  **************}
  USB_COUNT6_TX_0_COUNT6_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 6 (low) 

{***************  Bit definition for USB_COUNT6_TX_1 register  **************}
  USB_COUNT6_TX_1_COUNT6_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 6 (high) 

{***************  Bit definition for USB_COUNT7_TX_0 register  **************}
  USB_COUNT7_TX_0_COUNT7_TX_0: uInt32  = $000003FF;  // Transmission Byte Count 7 (low) 

{***************  Bit definition for USB_COUNT7_TX_1 register  **************}
  USB_COUNT7_TX_1_COUNT7_TX_1: uInt32  = $03FF0000;  // Transmission Byte Count 7 (high) 

{----------------------------------------------------------------------------}

{****************  Bit definition for USB_ADDR0_RX register  ****************}
  USB_ADDR0_RX_ADDR0_RX: uInt16  = $FFFE;  // Reception Buffer Address 0 

{****************  Bit definition for USB_ADDR1_RX register  ****************}
  USB_ADDR1_RX_ADDR1_RX: uInt16  = $FFFE;  // Reception Buffer Address 1 

{****************  Bit definition for USB_ADDR2_RX register  ****************}
  USB_ADDR2_RX_ADDR2_RX: uInt16  = $FFFE;  // Reception Buffer Address 2 

{****************  Bit definition for USB_ADDR3_RX register  ****************}
  USB_ADDR3_RX_ADDR3_RX: uInt16  = $FFFE;  // Reception Buffer Address 3 

{****************  Bit definition for USB_ADDR4_RX register  ****************}
  USB_ADDR4_RX_ADDR4_RX: uInt16  = $FFFE;  // Reception Buffer Address 4 

{****************  Bit definition for USB_ADDR5_RX register  ****************}
  USB_ADDR5_RX_ADDR5_RX: uInt16  = $FFFE;  // Reception Buffer Address 5 

{****************  Bit definition for USB_ADDR6_RX register  ****************}
  USB_ADDR6_RX_ADDR6_RX: uInt16  = $FFFE;  // Reception Buffer Address 6 

{****************  Bit definition for USB_ADDR7_RX register  ****************}
  USB_ADDR7_RX_ADDR7_RX: uInt16  = $FFFE;  // Reception Buffer Address 7 

{----------------------------------------------------------------------------}

{****************  Bit definition for USB_COUNT0_RX register  ***************}
  USB_COUNT0_RX_COUNT0_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT0_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT0_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT0_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT0_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT0_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT0_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT0_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT1_RX register  ***************}
  USB_COUNT1_RX_COUNT1_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT1_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT1_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT1_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT1_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT1_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT1_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT1_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT2_RX register  ***************}
  USB_COUNT2_RX_COUNT2_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT2_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT2_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT2_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT2_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT2_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT2_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT2_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT3_RX register  ***************}
  USB_COUNT3_RX_COUNT3_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT3_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT3_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT3_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT3_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT3_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT3_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT3_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT4_RX register  ***************}
  USB_COUNT4_RX_COUNT4_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT4_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT4_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT4_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT4_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT4_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT4_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT4_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT5_RX register  ***************}
  USB_COUNT5_RX_COUNT5_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT5_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT5_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT5_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT5_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT5_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT5_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT5_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT6_RX register  ***************}
  USB_COUNT6_RX_COUNT6_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT6_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT6_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT6_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT6_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT6_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT6_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT6_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{****************  Bit definition for USB_COUNT7_RX register  ***************}
  USB_COUNT7_RX_COUNT7_RX: uInt16  = $03FF;  // Reception Byte Count 

  USB_COUNT7_RX_NUM_BLOCK: uInt16  = $7C00;  // NUM_BLOCK[4:0] bits (Number of blocks) 
  USB_COUNT7_RX_NUM_BLOCK_0: uInt16  = $0400;  // Bit 0 
  USB_COUNT7_RX_NUM_BLOCK_1: uInt16  = $0800;  // Bit 1 
  USB_COUNT7_RX_NUM_BLOCK_2: uInt16  = $1000;  // Bit 2 
  USB_COUNT7_RX_NUM_BLOCK_3: uInt16  = $2000;  // Bit 3 
  USB_COUNT7_RX_NUM_BLOCK_4: uInt16  = $4000;  // Bit 4 

  USB_COUNT7_RX_BLSIZE: uInt16  = $8000;  // BLock SIZE 

{----------------------------------------------------------------------------}

{***************  Bit definition for USB_COUNT0_RX_0 register  **************}
  USB_COUNT0_RX_0_COUNT0_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT0_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT0_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT0_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT0_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT0_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT0_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT0_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT0_RX_1 register  **************}
  USB_COUNT0_RX_1_COUNT0_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT0_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT0_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 1 
  USB_COUNT0_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT0_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT0_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT0_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT0_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{***************  Bit definition for USB_COUNT1_RX_0 register  **************}
  USB_COUNT1_RX_0_COUNT1_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT1_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT1_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT1_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT1_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT1_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT1_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT1_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT1_RX_1 register  **************}
  USB_COUNT1_RX_1_COUNT1_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT1_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT1_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT1_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT1_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT1_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT1_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT1_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{***************  Bit definition for USB_COUNT2_RX_0 register  **************}
  USB_COUNT2_RX_0_COUNT2_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT2_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT2_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT2_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT2_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT2_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT2_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT2_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT2_RX_1 register  **************}
  USB_COUNT2_RX_1_COUNT2_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT2_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT2_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT2_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT2_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT2_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT2_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT2_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{***************  Bit definition for USB_COUNT3_RX_0 register  **************}
  USB_COUNT3_RX_0_COUNT3_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT3_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT3_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT3_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT3_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT3_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT3_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT3_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT3_RX_1 register  **************}
  USB_COUNT3_RX_1_COUNT3_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT3_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT3_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT3_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT3_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT3_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT3_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT3_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{***************  Bit definition for USB_COUNT4_RX_0 register  **************}
  USB_COUNT4_RX_0_COUNT4_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT4_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT4_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT4_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT4_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT4_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT4_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT4_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT4_RX_1 register  **************}
  USB_COUNT4_RX_1_COUNT4_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT4_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT4_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT4_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT4_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT4_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT4_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT4_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{***************  Bit definition for USB_COUNT5_RX_0 register  **************}
  USB_COUNT5_RX_0_COUNT5_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT5_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT5_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT5_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT5_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT5_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT5_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT5_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT5_RX_1 register  **************}
  USB_COUNT5_RX_1_COUNT5_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT5_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT5_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT5_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT5_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT5_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT5_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT5_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{**************  Bit definition for USB_COUNT6_RX_0  register  **************}
  USB_COUNT6_RX_0_COUNT6_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT6_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT6_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT6_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT6_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT6_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT6_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT6_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{***************  Bit definition for USB_COUNT6_RX_1 register  **************}
  USB_COUNT6_RX_1_COUNT6_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT6_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT6_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT6_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT6_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT6_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT6_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT6_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{**************  Bit definition for USB_COUNT7_RX_0 register  ***************}
  USB_COUNT7_RX_0_COUNT7_RX_0: uInt32  = $000003FF;  // Reception Byte Count (low) 

  USB_COUNT7_RX_0_NUM_BLOCK_0: uInt32  = $00007C00;  // NUM_BLOCK_0[4:0] bits (Number of blocks) (low) 
  USB_COUNT7_RX_0_NUM_BLOCK_0_0: uInt32  = $00000400;  // Bit 0 
  USB_COUNT7_RX_0_NUM_BLOCK_0_1: uInt32  = $00000800;  // Bit 1 
  USB_COUNT7_RX_0_NUM_BLOCK_0_2: uInt32  = $00001000;  // Bit 2 
  USB_COUNT7_RX_0_NUM_BLOCK_0_3: uInt32  = $00002000;  // Bit 3 
  USB_COUNT7_RX_0_NUM_BLOCK_0_4: uInt32  = $00004000;  // Bit 4 

  USB_COUNT7_RX_0_BLSIZE_0: uInt32  = $00008000;  // BLock SIZE (low) 

{**************  Bit definition for USB_COUNT7_RX_1 register  ***************}
  USB_COUNT7_RX_1_COUNT7_RX_1: uInt32  = $03FF0000;  // Reception Byte Count (high) 

  USB_COUNT7_RX_1_NUM_BLOCK_1: uInt32  = $7C000000;  // NUM_BLOCK_1[4:0] bits (Number of blocks) (high) 
  USB_COUNT7_RX_1_NUM_BLOCK_1_0: uInt32  = $04000000;  // Bit 0 
  USB_COUNT7_RX_1_NUM_BLOCK_1_1: uInt32  = $08000000;  // Bit 1 
  USB_COUNT7_RX_1_NUM_BLOCK_1_2: uInt32  = $10000000;  // Bit 2 
  USB_COUNT7_RX_1_NUM_BLOCK_1_3: uInt32  = $20000000;  // Bit 3 
  USB_COUNT7_RX_1_NUM_BLOCK_1_4: uInt32  = $40000000;  // Bit 4 

  USB_COUNT7_RX_1_BLSIZE_1: uInt32  = $80000000;  // BLock SIZE (high) 

{****************************************************************************}
{                                                                            }
{                         Controller Area Network                            }
{                                                                            }
{****************************************************************************}

{ CAN control and status registers }
{******************  Bit definition for CAN_MCR register  *******************}
  CAN_MCR_INRQ: uInt16  = $0001;  // Initialization Request 
  CAN_MCR_SLEEP: uInt16  = $0002;  // Sleep Mode Request 
  CAN_MCR_TXFP: uInt16  = $0004;  // Transmit FIFO Priority 
  CAN_MCR_RFLM: uInt16  = $0008;  // Receive FIFO Locked Mode 
  CAN_MCR_NART: uInt16  = $0010;  // No Automatic Retransmission 
  CAN_MCR_AWUM: uInt16  = $0020;  // Automatic Wakeup Mode 
  CAN_MCR_ABOM: uInt16  = $0040;  // Automatic Bus-Off Management 
  CAN_MCR_TTCM: uInt16  = $0080;  // Time Triggered Communication Mode 
  CAN_MCR_RESET: uInt16  = $8000;  // CAN software master reset 

{******************  Bit definition for CAN_MSR register  *******************}
  CAN_MSR_INAK: uInt16  = $0001;  // Initialization Acknowledge 
  CAN_MSR_SLAK: uInt16  = $0002;  // Sleep Acknowledge 
  CAN_MSR_ERRI: uInt16  = $0004;  // Error Interrupt 
  CAN_MSR_WKUI: uInt16  = $0008;  // Wakeup Interrupt 
  CAN_MSR_SLAKI: uInt16  = $0010;  // Sleep Acknowledge Interrupt 
  CAN_MSR_TXM: uInt16  = $0100;  // Transmit Mode 
  CAN_MSR_RXM: uInt16  = $0200;  // Receive Mode 
  CAN_MSR_SAMP: uInt16  = $0400;  // Last Sample Point 
  CAN_MSR_RX: uInt16  = $0800;  // CAN Rx Signal 

{******************  Bit definition for CAN_TSR register  *******************}
  CAN_TSR_RQCP0: uInt32  = $00000001;  // Request Completed Mailbox0 
  CAN_TSR_TXOK0: uInt32  = $00000002;  // Transmission OK of Mailbox0 
  CAN_TSR_ALST0: uInt32  = $00000004;  // Arbitration Lost for Mailbox0 
  CAN_TSR_TERR0: uInt32  = $00000008;  // Transmission Error of Mailbox0 
  CAN_TSR_ABRQ0: uInt32  = $00000080;  // Abort Request for Mailbox0 
  CAN_TSR_RQCP1: uInt32  = $00000100;  // Request Completed Mailbox1 
  CAN_TSR_TXOK1: uInt32  = $00000200;  // Transmission OK of Mailbox1 
  CAN_TSR_ALST1: uInt32  = $00000400;  // Arbitration Lost for Mailbox1 
  CAN_TSR_TERR1: uInt32  = $00000800;  // Transmission Error of Mailbox1 
  CAN_TSR_ABRQ1: uInt32  = $00008000;  // Abort Request for Mailbox 1 
  CAN_TSR_RQCP2: uInt32  = $00010000;  // Request Completed Mailbox2 
  CAN_TSR_TXOK2: uInt32  = $00020000;  // Transmission OK of Mailbox 2 
  CAN_TSR_ALST2: uInt32  = $00040000;  // Arbitration Lost for mailbox 2 
  CAN_TSR_TERR2: uInt32  = $00080000;  // Transmission Error of Mailbox 2 
  CAN_TSR_ABRQ2: uInt32  = $00800000;  // Abort Request for Mailbox 2 
  CAN_TSR_CODE: uInt32  = $03000000;  // Mailbox Code 

  CAN_TSR_TME: uInt32  = $1C000000;  // TME[2:0] bits 
  CAN_TSR_TME0: uInt32  = $04000000;  // Transmit Mailbox 0 Empty 
  CAN_TSR_TME1: uInt32  = $08000000;  // Transmit Mailbox 1 Empty 
  CAN_TSR_TME2: uInt32  = $10000000;  // Transmit Mailbox 2 Empty 

  CAN_TSR_LOW: uInt32  = $E0000000;  // LOW[2:0] bits 
  CAN_TSR_LOW0: uInt32  = $20000000;  // Lowest Priority Flag for Mailbox 0 
  CAN_TSR_LOW1: uInt32  = $40000000;  // Lowest Priority Flag for Mailbox 1 
  CAN_TSR_LOW2: uInt32  = $80000000;  // Lowest Priority Flag for Mailbox 2 

{******************  Bit definition for CAN_RF0R register  ******************}
  CAN_RF0R_FMP0: uInt8  = $03;  // FIFO 0 Message Pending 
  CAN_RF0R_FULL0: uInt8  = $08;  // FIFO 0 Full 
  CAN_RF0R_FOVR0: uInt8  = $10;  // FIFO 0 Overrun 
  CAN_RF0R_RFOM0: uInt8  = $20;  // Release FIFO 0 Output Mailbox 

{******************  Bit definition for CAN_RF1R register  ******************}
  CAN_RF1R_FMP1: uInt8  = $03;  // FIFO 1 Message Pending 
  CAN_RF1R_FULL1: uInt8  = $08;  // FIFO 1 Full 
  CAN_RF1R_FOVR1: uInt8  = $10;  // FIFO 1 Overrun 
  CAN_RF1R_RFOM1: uInt8  = $20;  // Release FIFO 1 Output Mailbox 

{*******************  Bit definition for CAN_IER register  ******************}
  CAN_IER_TMEIE: uInt32  = $00000001;  // Transmit Mailbox Empty Interrupt Enable 
  CAN_IER_FMPIE0: uInt32  = $00000002;  // FIFO Message Pending Interrupt Enable 
  CAN_IER_FFIE0: uInt32  = $00000004;  // FIFO Full Interrupt Enable 
  CAN_IER_FOVIE0: uInt32  = $00000008;  // FIFO Overrun Interrupt Enable 
  CAN_IER_FMPIE1: uInt32  = $00000010;  // FIFO Message Pending Interrupt Enable 
  CAN_IER_FFIE1: uInt32  = $00000020;  // FIFO Full Interrupt Enable 
  CAN_IER_FOVIE1: uInt32  = $00000040;  // FIFO Overrun Interrupt Enable 
  CAN_IER_EWGIE: uInt32  = $00000100;  // Error Warning Interrupt Enable 
  CAN_IER_EPVIE: uInt32  = $00000200;  // Error Passive Interrupt Enable 
  CAN_IER_BOFIE: uInt32  = $00000400;  // Bus-Off Interrupt Enable 
  CAN_IER_LECIE: uInt32  = $00000800;  // Last Error Code Interrupt Enable 
  CAN_IER_ERRIE: uInt32  = $00008000;  // Error Interrupt Enable 
  CAN_IER_WKUIE: uInt32  = $00010000;  // Wakeup Interrupt Enable 
  CAN_IER_SLKIE: uInt32  = $00020000;  // Sleep Interrupt Enable 

{*******************  Bit definition for CAN_ESR register  ******************}
  CAN_ESR_EWGF: uInt32  = $00000001;  // Error Warning Flag 
  CAN_ESR_EPVF: uInt32  = $00000002;  // Error Passive Flag 
  CAN_ESR_BOFF: uInt32  = $00000004;  // Bus-Off Flag 

  CAN_ESR_LEC: uInt32  = $00000070;  // LEC[2:0] bits (Last Error Code) 
  CAN_ESR_LEC_0: uInt32  = $00000010;  // Bit 0 
  CAN_ESR_LEC_1: uInt32  = $00000020;  // Bit 1 
  CAN_ESR_LEC_2: uInt32  = $00000040;  // Bit 2 

  CAN_ESR_TEC: uInt32  = $00FF0000;  // Least significant byte of the 9-bit Transmit Error Counter 
  CAN_ESR_REC: uInt32  = $FF000000;  // Receive Error Counter 

{******************  Bit definition for CAN_BTR register  *******************}
  CAN_BTR_BRP: uInt32  = $000003FF;  // Baud Rate Prescaler 
  CAN_BTR_TS1: uInt32  = $000F0000;  // Time Segment 1 
  CAN_BTR_TS2: uInt32  = $00700000;  // Time Segment 2 
  CAN_BTR_SJW: uInt32  = $03000000;  // Resynchronization Jump Width 
  CAN_BTR_LBKM: uInt32  = $40000000;  // Loop Back Mode (Debug) 
  CAN_BTR_SILM: uInt32  = $80000000;  // Silent Mode 

{ Mailbox registers }
{*****************  Bit definition for CAN_TI0R register  *******************}
  CAN_TI0R_TXRQ: uInt32  = $00000001;  // Transmit Mailbox Request 
  CAN_TI0R_RTR: uInt32  = $00000002;  // Remote Transmission Request 
  CAN_TI0R_IDE: uInt32  = $00000004;  // Identifier Extension 
  CAN_TI0R_EXID: uInt32  = $001FFFF8;  // Extended Identifier 
  CAN_TI0R_STID: uInt32  = $FFE00000;  // Standard Identifier or Extended Identifier 

{*****************  Bit definition for CAN_TDT0R register  ******************}
  CAN_TDT0R_DLC: uInt32  = $0000000F;  // Data Length Code 
  CAN_TDT0R_TGT: uInt32  = $00000100;  // Transmit Global Time 
  CAN_TDT0R_TIME: uInt32  = $FFFF0000;  // Message Time Stamp 

{*****************  Bit definition for CAN_TDL0R register  ******************}
  CAN_TDL0R_DATA0: uInt32  = $000000FF;  // Data byte 0 
  CAN_TDL0R_DATA1: uInt32  = $0000FF00;  // Data byte 1 
  CAN_TDL0R_DATA2: uInt32  = $00FF0000;  // Data byte 2 
  CAN_TDL0R_DATA3: uInt32  = $FF000000;  // Data byte 3 

{*****************  Bit definition for CAN_TDH0R register  ******************}
  CAN_TDH0R_DATA4: uInt32  = $000000FF;  // Data byte 4 
  CAN_TDH0R_DATA5: uInt32  = $0000FF00;  // Data byte 5 
  CAN_TDH0R_DATA6: uInt32  = $00FF0000;  // Data byte 6 
  CAN_TDH0R_DATA7: uInt32  = $FF000000;  // Data byte 7 

{******************  Bit definition for CAN_TI1R register  ******************}
  CAN_TI1R_TXRQ: uInt32  = $00000001;  // Transmit Mailbox Request 
  CAN_TI1R_RTR: uInt32  = $00000002;  // Remote Transmission Request 
  CAN_TI1R_IDE: uInt32  = $00000004;  // Identifier Extension 
  CAN_TI1R_EXID: uInt32  = $001FFFF8;  // Extended Identifier 
  CAN_TI1R_STID: uInt32  = $FFE00000;  // Standard Identifier or Extended Identifier 

{******************  Bit definition for CAN_TDT1R register  *****************}
  CAN_TDT1R_DLC: uInt32  = $0000000F;  // Data Length Code 
  CAN_TDT1R_TGT: uInt32  = $00000100;  // Transmit Global Time 
  CAN_TDT1R_TIME: uInt32  = $FFFF0000;  // Message Time Stamp 

{******************  Bit definition for CAN_TDL1R register  *****************}
  CAN_TDL1R_DATA0: uInt32  = $000000FF;  // Data byte 0 
  CAN_TDL1R_DATA1: uInt32  = $0000FF00;  // Data byte 1 
  CAN_TDL1R_DATA2: uInt32  = $00FF0000;  // Data byte 2 
  CAN_TDL1R_DATA3: uInt32  = $FF000000;  // Data byte 3 

{******************  Bit definition for CAN_TDH1R register  *****************}
  CAN_TDH1R_DATA4: uInt32  = $000000FF;  // Data byte 4 
  CAN_TDH1R_DATA5: uInt32  = $0000FF00;  // Data byte 5 
  CAN_TDH1R_DATA6: uInt32  = $00FF0000;  // Data byte 6 
  CAN_TDH1R_DATA7: uInt32  = $FF000000;  // Data byte 7 

{******************  Bit definition for CAN_TI2R register  ******************}
  CAN_TI2R_TXRQ: uInt32  = $00000001;  // Transmit Mailbox Request 
  CAN_TI2R_RTR: uInt32  = $00000002;  // Remote Transmission Request 
  CAN_TI2R_IDE: uInt32  = $00000004;  // Identifier Extension 
  CAN_TI2R_EXID: uInt32  = $001FFFF8;  // Extended identifier 
  CAN_TI2R_STID: uInt32  = $FFE00000;  // Standard Identifier or Extended Identifier 

{******************  Bit definition for CAN_TDT2R register  *****************}
  CAN_TDT2R_DLC: uInt32  = $0000000F;  // Data Length Code 
  CAN_TDT2R_TGT: uInt32  = $00000100;  // Transmit Global Time 
  CAN_TDT2R_TIME: uInt32  = $FFFF0000;  // Message Time Stamp 

{******************  Bit definition for CAN_TDL2R register  *****************}
  CAN_TDL2R_DATA0: uInt32  = $000000FF;  // Data byte 0 
  CAN_TDL2R_DATA1: uInt32  = $0000FF00;  // Data byte 1 
  CAN_TDL2R_DATA2: uInt32  = $00FF0000;  // Data byte 2 
  CAN_TDL2R_DATA3: uInt32  = $FF000000;  // Data byte 3 

{******************  Bit definition for CAN_TDH2R register  *****************}
  CAN_TDH2R_DATA4: uInt32  = $000000FF;  // Data byte 4 
  CAN_TDH2R_DATA5: uInt32  = $0000FF00;  // Data byte 5 
  CAN_TDH2R_DATA6: uInt32  = $00FF0000;  // Data byte 6 
  CAN_TDH2R_DATA7: uInt32  = $FF000000;  // Data byte 7 

{******************  Bit definition for CAN_RI0R register  ******************}
  CAN_RI0R_RTR: uInt32  = $00000002;  // Remote Transmission Request 
  CAN_RI0R_IDE: uInt32  = $00000004;  // Identifier Extension 
  CAN_RI0R_EXID: uInt32  = $001FFFF8;  // Extended Identifier 
  CAN_RI0R_STID: uInt32  = $FFE00000;  // Standard Identifier or Extended Identifier 

{******************  Bit definition for CAN_RDT0R register  *****************}
  CAN_RDT0R_DLC: uInt32  = $0000000F;  // Data Length Code 
  CAN_RDT0R_FMI: uInt32  = $0000FF00;  // Filter Match Index 
  CAN_RDT0R_TIME: uInt32  = $FFFF0000;  // Message Time Stamp 

{******************  Bit definition for CAN_RDL0R register  *****************}
  CAN_RDL0R_DATA0: uInt32  = $000000FF;  // Data byte 0 
  CAN_RDL0R_DATA1: uInt32  = $0000FF00;  // Data byte 1 
  CAN_RDL0R_DATA2: uInt32  = $00FF0000;  // Data byte 2 
  CAN_RDL0R_DATA3: uInt32  = $FF000000;  // Data byte 3 

{******************  Bit definition for CAN_RDH0R register  *****************}
  CAN_RDH0R_DATA4: uInt32  = $000000FF;  // Data byte 4 
  CAN_RDH0R_DATA5: uInt32  = $0000FF00;  // Data byte 5 
  CAN_RDH0R_DATA6: uInt32  = $00FF0000;  // Data byte 6 
  CAN_RDH0R_DATA7: uInt32  = $FF000000;  // Data byte 7 

{******************  Bit definition for CAN_RI1R register  ******************}
  CAN_RI1R_RTR: uInt32  = $00000002;  // Remote Transmission Request 
  CAN_RI1R_IDE: uInt32  = $00000004;  // Identifier Extension 
  CAN_RI1R_EXID: uInt32  = $001FFFF8;  // Extended identifier 
  CAN_RI1R_STID: uInt32  = $FFE00000;  // Standard Identifier or Extended Identifier 

{******************  Bit definition for CAN_RDT1R register  *****************}
  CAN_RDT1R_DLC: uInt32  = $0000000F;  // Data Length Code 
  CAN_RDT1R_FMI: uInt32  = $0000FF00;  // Filter Match Index 
  CAN_RDT1R_TIME: uInt32  = $FFFF0000;  // Message Time Stamp 

{******************  Bit definition for CAN_RDL1R register  *****************}
  CAN_RDL1R_DATA0: uInt32  = $000000FF;  // Data byte 0 
  CAN_RDL1R_DATA1: uInt32  = $0000FF00;  // Data byte 1 
  CAN_RDL1R_DATA2: uInt32  = $00FF0000;  // Data byte 2 
  CAN_RDL1R_DATA3: uInt32  = $FF000000;  // Data byte 3 

{******************  Bit definition for CAN_RDH1R register  *****************}
  CAN_RDH1R_DATA4: uInt32  = $000000FF;  // Data byte 4 
  CAN_RDH1R_DATA5: uInt32  = $0000FF00;  // Data byte 5 
  CAN_RDH1R_DATA6: uInt32  = $00FF0000;  // Data byte 6 
  CAN_RDH1R_DATA7: uInt32  = $FF000000;  // Data byte 7 

{ CAN filter registers }
{******************  Bit definition for CAN_FMR register  *******************}
  CAN_FMR_FINIT: uInt8  = $01;  // Filter Init Mode 

{******************  Bit definition for CAN_FM1R register  ******************}
  CAN_FM1R_FBM: uInt16  = $3FFF;  // Filter Mode 
  CAN_FM1R_FBM0: uInt16  = $0001;  // Filter Init Mode bit 0 
  CAN_FM1R_FBM1: uInt16  = $0002;  // Filter Init Mode bit 1 
  CAN_FM1R_FBM2: uInt16  = $0004;  // Filter Init Mode bit 2 
  CAN_FM1R_FBM3: uInt16  = $0008;  // Filter Init Mode bit 3 
  CAN_FM1R_FBM4: uInt16  = $0010;  // Filter Init Mode bit 4 
  CAN_FM1R_FBM5: uInt16  = $0020;  // Filter Init Mode bit 5 
  CAN_FM1R_FBM6: uInt16  = $0040;  // Filter Init Mode bit 6 
  CAN_FM1R_FBM7: uInt16  = $0080;  // Filter Init Mode bit 7 
  CAN_FM1R_FBM8: uInt16  = $0100;  // Filter Init Mode bit 8 
  CAN_FM1R_FBM9: uInt16  = $0200;  // Filter Init Mode bit 9 
  CAN_FM1R_FBM10: uInt16  = $0400;  // Filter Init Mode bit 10 
  CAN_FM1R_FBM11: uInt16  = $0800;  // Filter Init Mode bit 11 
  CAN_FM1R_FBM12: uInt16  = $1000;  // Filter Init Mode bit 12 
  CAN_FM1R_FBM13: uInt16  = $2000;  // Filter Init Mode bit 13 

{******************  Bit definition for CAN_FS1R register  ******************}
  CAN_FS1R_FSC: uInt16  = $3FFF;  // Filter Scale Configuration 
  CAN_FS1R_FSC0: uInt16  = $0001;  // Filter Scale Configuration bit 0 
  CAN_FS1R_FSC1: uInt16  = $0002;  // Filter Scale Configuration bit 1 
  CAN_FS1R_FSC2: uInt16  = $0004;  // Filter Scale Configuration bit 2 
  CAN_FS1R_FSC3: uInt16  = $0008;  // Filter Scale Configuration bit 3 
  CAN_FS1R_FSC4: uInt16  = $0010;  // Filter Scale Configuration bit 4 
  CAN_FS1R_FSC5: uInt16  = $0020;  // Filter Scale Configuration bit 5 
  CAN_FS1R_FSC6: uInt16  = $0040;  // Filter Scale Configuration bit 6 
  CAN_FS1R_FSC7: uInt16  = $0080;  // Filter Scale Configuration bit 7 
  CAN_FS1R_FSC8: uInt16  = $0100;  // Filter Scale Configuration bit 8 
  CAN_FS1R_FSC9: uInt16  = $0200;  // Filter Scale Configuration bit 9 
  CAN_FS1R_FSC10: uInt16  = $0400;  // Filter Scale Configuration bit 10 
  CAN_FS1R_FSC11: uInt16  = $0800;  // Filter Scale Configuration bit 11 
  CAN_FS1R_FSC12: uInt16  = $1000;  // Filter Scale Configuration bit 12 
  CAN_FS1R_FSC13: uInt16  = $2000;  // Filter Scale Configuration bit 13 

{*****************  Bit definition for CAN_FFA1R register  ******************}
  CAN_FFA1R_FFA: uInt16  = $3FFF;  // Filter FIFO Assignment 
  CAN_FFA1R_FFA0: uInt16  = $0001;  // Filter FIFO Assignment for Filter 0 
  CAN_FFA1R_FFA1: uInt16  = $0002;  // Filter FIFO Assignment for Filter 1 
  CAN_FFA1R_FFA2: uInt16  = $0004;  // Filter FIFO Assignment for Filter 2 
  CAN_FFA1R_FFA3: uInt16  = $0008;  // Filter FIFO Assignment for Filter 3 
  CAN_FFA1R_FFA4: uInt16  = $0010;  // Filter FIFO Assignment for Filter 4 
  CAN_FFA1R_FFA5: uInt16  = $0020;  // Filter FIFO Assignment for Filter 5 
  CAN_FFA1R_FFA6: uInt16  = $0040;  // Filter FIFO Assignment for Filter 6 
  CAN_FFA1R_FFA7: uInt16  = $0080;  // Filter FIFO Assignment for Filter 7 
  CAN_FFA1R_FFA8: uInt16  = $0100;  // Filter FIFO Assignment for Filter 8 
  CAN_FFA1R_FFA9: uInt16  = $0200;  // Filter FIFO Assignment for Filter 9 
  CAN_FFA1R_FFA10: uInt16  = $0400;  // Filter FIFO Assignment for Filter 10 
  CAN_FFA1R_FFA11: uInt16  = $0800;  // Filter FIFO Assignment for Filter 11 
  CAN_FFA1R_FFA12: uInt16  = $1000;  // Filter FIFO Assignment for Filter 12 
  CAN_FFA1R_FFA13: uInt16  = $2000;  // Filter FIFO Assignment for Filter 13 

{******************  Bit definition for CAN_FA1R register  ******************}
  CAN_FA1R_FACT: uInt16  = $3FFF;  // Filter Active 
  CAN_FA1R_FACT0: uInt16  = $0001;  // Filter 0 Active 
  CAN_FA1R_FACT1: uInt16  = $0002;  // Filter 1 Active 
  CAN_FA1R_FACT2: uInt16  = $0004;  // Filter 2 Active 
  CAN_FA1R_FACT3: uInt16  = $0008;  // Filter 3 Active 
  CAN_FA1R_FACT4: uInt16  = $0010;  // Filter 4 Active 
  CAN_FA1R_FACT5: uInt16  = $0020;  // Filter 5 Active 
  CAN_FA1R_FACT6: uInt16  = $0040;  // Filter 6 Active 
  CAN_FA1R_FACT7: uInt16  = $0080;  // Filter 7 Active 
  CAN_FA1R_FACT8: uInt16  = $0100;  // Filter 8 Active 
  CAN_FA1R_FACT9: uInt16  = $0200;  // Filter 9 Active 
  CAN_FA1R_FACT10: uInt16  = $0400;  // Filter 10 Active 
  CAN_FA1R_FACT11: uInt16  = $0800;  // Filter 11 Active 
  CAN_FA1R_FACT12: uInt16  = $1000;  // Filter 12 Active 
  CAN_FA1R_FACT13: uInt16  = $2000;  // Filter 13 Active 

{******************  Bit definition for CAN_F0R1 register  ******************}
  CAN_F0R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F0R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F0R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F0R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F0R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F0R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F0R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F0R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F0R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F0R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F0R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F0R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F0R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F0R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F0R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F0R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F0R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F0R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F0R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F0R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F0R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F0R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F0R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F0R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F0R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F0R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F0R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F0R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F0R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F0R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F0R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F0R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F1R1 register  ******************}
  CAN_F1R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F1R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F1R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F1R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F1R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F1R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F1R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F1R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F1R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F1R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F1R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F1R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F1R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F1R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F1R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F1R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F1R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F1R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F1R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F1R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F1R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F1R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F1R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F1R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F1R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F1R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F1R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F1R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F1R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F1R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F1R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F1R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F2R1 register  ******************}
  CAN_F2R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F2R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F2R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F2R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F2R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F2R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F2R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F2R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F2R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F2R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F2R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F2R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F2R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F2R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F2R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F2R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F2R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F2R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F2R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F2R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F2R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F2R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F2R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F2R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F2R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F2R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F2R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F2R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F2R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F2R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F2R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F2R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F3R1 register  ******************}
  CAN_F3R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F3R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F3R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F3R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F3R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F3R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F3R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F3R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F3R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F3R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F3R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F3R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F3R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F3R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F3R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F3R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F3R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F3R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F3R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F3R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F3R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F3R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F3R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F3R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F3R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F3R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F3R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F3R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F3R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F3R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F3R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F3R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F4R1 register  ******************}
  CAN_F4R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F4R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F4R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F4R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F4R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F4R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F4R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F4R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F4R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F4R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F4R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F4R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F4R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F4R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F4R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F4R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F4R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F4R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F4R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F4R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F4R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F4R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F4R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F4R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F4R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F4R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F4R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F4R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F4R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F4R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F4R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F4R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F5R1 register  ******************}
  CAN_F5R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F5R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F5R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F5R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F5R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F5R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F5R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F5R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F5R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F5R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F5R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F5R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F5R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F5R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F5R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F5R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F5R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F5R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F5R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F5R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F5R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F5R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F5R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F5R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F5R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F5R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F5R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F5R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F5R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F5R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F5R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F5R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F6R1 register  ******************}
  CAN_F6R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F6R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F6R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F6R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F6R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F6R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F6R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F6R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F6R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F6R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F6R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F6R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F6R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F6R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F6R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F6R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F6R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F6R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F6R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F6R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F6R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F6R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F6R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F6R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F6R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F6R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F6R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F6R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F6R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F6R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F6R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F6R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F7R1 register  ******************}
  CAN_F7R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F7R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F7R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F7R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F7R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F7R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F7R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F7R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F7R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F7R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F7R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F7R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F7R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F7R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F7R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F7R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F7R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F7R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F7R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F7R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F7R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F7R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F7R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F7R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F7R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F7R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F7R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F7R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F7R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F7R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F7R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F7R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F8R1 register  ******************}
  CAN_F8R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F8R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F8R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F8R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F8R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F8R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F8R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F8R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F8R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F8R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F8R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F8R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F8R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F8R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F8R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F8R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F8R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F8R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F8R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F8R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F8R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F8R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F8R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F8R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F8R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F8R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F8R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F8R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F8R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F8R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F8R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F8R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F9R1 register  ******************}
  CAN_F9R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F9R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F9R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F9R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F9R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F9R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F9R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F9R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F9R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F9R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F9R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F9R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F9R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F9R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F9R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F9R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F9R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F9R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F9R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F9R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F9R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F9R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F9R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F9R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F9R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F9R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F9R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F9R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F9R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F9R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F9R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F9R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F10R1 register  *****************}
  CAN_F10R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F10R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F10R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F10R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F10R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F10R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F10R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F10R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F10R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F10R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F10R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F10R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F10R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F10R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F10R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F10R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F10R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F10R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F10R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F10R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F10R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F10R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F10R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F10R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F10R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F10R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F10R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F10R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F10R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F10R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F10R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F10R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F11R1 register  *****************}
  CAN_F11R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F11R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F11R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F11R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F11R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F11R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F11R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F11R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F11R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F11R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F11R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F11R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F11R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F11R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F11R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F11R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F11R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F11R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F11R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F11R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F11R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F11R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F11R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F11R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F11R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F11R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F11R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F11R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F11R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F11R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F11R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F11R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F12R1 register  *****************}
  CAN_F12R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F12R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F12R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F12R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F12R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F12R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F12R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F12R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F12R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F12R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F12R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F12R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F12R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F12R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F12R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F12R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F12R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F12R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F12R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F12R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F12R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F12R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F12R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F12R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F12R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F12R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F12R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F12R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F12R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F12R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F12R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F12R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F13R1 register  *****************}
  CAN_F13R1_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F13R1_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F13R1_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F13R1_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F13R1_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F13R1_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F13R1_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F13R1_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F13R1_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F13R1_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F13R1_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F13R1_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F13R1_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F13R1_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F13R1_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F13R1_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F13R1_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F13R1_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F13R1_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F13R1_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F13R1_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F13R1_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F13R1_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F13R1_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F13R1_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F13R1_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F13R1_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F13R1_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F13R1_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F13R1_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F13R1_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F13R1_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F0R2 register  ******************}
  CAN_F0R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F0R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F0R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F0R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F0R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F0R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F0R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F0R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F0R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F0R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F0R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F0R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F0R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F0R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F0R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F0R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F0R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F0R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F0R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F0R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F0R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F0R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F0R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F0R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F0R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F0R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F0R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F0R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F0R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F0R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F0R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F0R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F1R2 register  ******************}
  CAN_F1R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F1R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F1R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F1R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F1R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F1R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F1R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F1R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F1R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F1R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F1R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F1R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F1R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F1R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F1R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F1R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F1R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F1R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F1R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F1R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F1R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F1R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F1R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F1R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F1R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F1R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F1R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F1R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F1R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F1R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F1R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F1R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F2R2 register  ******************}
  CAN_F2R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F2R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F2R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F2R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F2R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F2R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F2R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F2R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F2R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F2R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F2R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F2R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F2R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F2R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F2R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F2R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F2R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F2R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F2R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F2R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F2R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F2R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F2R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F2R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F2R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F2R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F2R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F2R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F2R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F2R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F2R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F2R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F3R2 register  ******************}
  CAN_F3R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F3R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F3R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F3R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F3R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F3R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F3R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F3R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F3R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F3R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F3R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F3R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F3R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F3R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F3R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F3R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F3R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F3R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F3R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F3R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F3R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F3R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F3R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F3R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F3R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F3R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F3R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F3R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F3R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F3R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F3R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F3R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F4R2 register  ******************}
  CAN_F4R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F4R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F4R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F4R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F4R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F4R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F4R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F4R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F4R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F4R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F4R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F4R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F4R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F4R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F4R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F4R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F4R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F4R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F4R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F4R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F4R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F4R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F4R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F4R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F4R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F4R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F4R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F4R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F4R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F4R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F4R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F4R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F5R2 register  ******************}
  CAN_F5R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F5R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F5R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F5R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F5R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F5R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F5R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F5R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F5R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F5R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F5R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F5R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F5R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F5R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F5R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F5R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F5R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F5R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F5R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F5R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F5R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F5R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F5R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F5R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F5R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F5R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F5R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F5R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F5R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F5R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F5R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F5R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F6R2 register  ******************}
  CAN_F6R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F6R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F6R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F6R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F6R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F6R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F6R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F6R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F6R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F6R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F6R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F6R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F6R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F6R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F6R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F6R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F6R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F6R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F6R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F6R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F6R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F6R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F6R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F6R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F6R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F6R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F6R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F6R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F6R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F6R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F6R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F6R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F7R2 register  ******************}
  CAN_F7R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F7R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F7R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F7R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F7R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F7R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F7R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F7R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F7R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F7R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F7R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F7R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F7R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F7R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F7R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F7R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F7R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F7R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F7R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F7R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F7R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F7R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F7R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F7R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F7R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F7R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F7R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F7R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F7R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F7R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F7R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F7R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F8R2 register  ******************}
  CAN_F8R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F8R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F8R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F8R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F8R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F8R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F8R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F8R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F8R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F8R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F8R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F8R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F8R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F8R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F8R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F8R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F8R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F8R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F8R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F8R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F8R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F8R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F8R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F8R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F8R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F8R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F8R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F8R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F8R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F8R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F8R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F8R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F9R2 register  ******************}
  CAN_F9R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F9R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F9R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F9R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F9R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F9R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F9R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F9R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F9R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F9R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F9R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F9R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F9R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F9R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F9R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F9R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F9R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F9R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F9R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F9R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F9R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F9R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F9R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F9R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F9R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F9R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F9R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F9R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F9R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F9R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F9R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F9R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F10R2 register  *****************}
  CAN_F10R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F10R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F10R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F10R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F10R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F10R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F10R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F10R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F10R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F10R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F10R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F10R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F10R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F10R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F10R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F10R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F10R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F10R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F10R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F10R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F10R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F10R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F10R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F10R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F10R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F10R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F10R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F10R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F10R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F10R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F10R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F10R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F11R2 register  *****************}
  CAN_F11R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F11R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F11R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F11R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F11R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F11R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F11R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F11R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F11R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F11R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F11R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F11R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F11R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F11R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F11R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F11R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F11R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F11R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F11R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F11R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F11R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F11R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F11R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F11R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F11R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F11R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F11R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F11R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F11R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F11R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F11R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F11R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F12R2 register  *****************}
  CAN_F12R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F12R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F12R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F12R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F12R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F12R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F12R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F12R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F12R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F12R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F12R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F12R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F12R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F12R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F12R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F12R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F12R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F12R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F12R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F12R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F12R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F12R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F12R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F12R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F12R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F12R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F12R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F12R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F12R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F12R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F12R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F12R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{******************  Bit definition for CAN_F13R2 register  *****************}
  CAN_F13R2_FB0: uInt32  = $00000001;  // Filter bit 0 
  CAN_F13R2_FB1: uInt32  = $00000002;  // Filter bit 1 
  CAN_F13R2_FB2: uInt32  = $00000004;  // Filter bit 2 
  CAN_F13R2_FB3: uInt32  = $00000008;  // Filter bit 3 
  CAN_F13R2_FB4: uInt32  = $00000010;  // Filter bit 4 
  CAN_F13R2_FB5: uInt32  = $00000020;  // Filter bit 5 
  CAN_F13R2_FB6: uInt32  = $00000040;  // Filter bit 6 
  CAN_F13R2_FB7: uInt32  = $00000080;  // Filter bit 7 
  CAN_F13R2_FB8: uInt32  = $00000100;  // Filter bit 8 
  CAN_F13R2_FB9: uInt32  = $00000200;  // Filter bit 9 
  CAN_F13R2_FB10: uInt32  = $00000400;  // Filter bit 10 
  CAN_F13R2_FB11: uInt32  = $00000800;  // Filter bit 11 
  CAN_F13R2_FB12: uInt32  = $00001000;  // Filter bit 12 
  CAN_F13R2_FB13: uInt32  = $00002000;  // Filter bit 13 
  CAN_F13R2_FB14: uInt32  = $00004000;  // Filter bit 14 
  CAN_F13R2_FB15: uInt32  = $00008000;  // Filter bit 15 
  CAN_F13R2_FB16: uInt32  = $00010000;  // Filter bit 16 
  CAN_F13R2_FB17: uInt32  = $00020000;  // Filter bit 17 
  CAN_F13R2_FB18: uInt32  = $00040000;  // Filter bit 18 
  CAN_F13R2_FB19: uInt32  = $00080000;  // Filter bit 19 
  CAN_F13R2_FB20: uInt32  = $00100000;  // Filter bit 20 
  CAN_F13R2_FB21: uInt32  = $00200000;  // Filter bit 21 
  CAN_F13R2_FB22: uInt32  = $00400000;  // Filter bit 22 
  CAN_F13R2_FB23: uInt32  = $00800000;  // Filter bit 23 
  CAN_F13R2_FB24: uInt32  = $01000000;  // Filter bit 24 
  CAN_F13R2_FB25: uInt32  = $02000000;  // Filter bit 25 
  CAN_F13R2_FB26: uInt32  = $04000000;  // Filter bit 26 
  CAN_F13R2_FB27: uInt32  = $08000000;  // Filter bit 27 
  CAN_F13R2_FB28: uInt32  = $10000000;  // Filter bit 28 
  CAN_F13R2_FB29: uInt32  = $20000000;  // Filter bit 29 
  CAN_F13R2_FB30: uInt32  = $40000000;  // Filter bit 30 
  CAN_F13R2_FB31: uInt32  = $80000000;  // Filter bit 31 

{****************************************************************************}
{                                                                            }
{                        Serial Peripheral Interface                         }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for SPI_CR1 register  *******************}
  SPI_CR1_CPHA: uInt16  = $0001;  // Clock Phase 
  SPI_CR1_CPOL: uInt16  = $0002;  // Clock Polarity 
  SPI_CR1_MSTR: uInt16  = $0004;  // Master Selection 

  SPI_CR1_BR: uInt16  = $0038;  // BR[2:0] bits (Baud Rate Control) 
  SPI_CR1_BR_0: uInt16  = $0008;  // Bit 0 
  SPI_CR1_BR_1: uInt16  = $0010;  // Bit 1 
  SPI_CR1_BR_2: uInt16  = $0020;  // Bit 2 

  SPI_CR1_SPE: uInt16  = $0040;  // SPI Enable 
  SPI_CR1_LSBFIRST: uInt16  = $0080;  // Frame Format 
  SPI_CR1_SSI: uInt16  = $0100;  // Internal slave select 
  SPI_CR1_SSM: uInt16  = $0200;  // Software slave management 
  SPI_CR1_RXONLY: uInt16  = $0400;  // Receive only 
  SPI_CR1_DFF: uInt16  = $0800;  // Data Frame Format 
  SPI_CR1_CRCNEXT: uInt16  = $1000;  // Transmit CRC next 
  SPI_CR1_CRCEN: uInt16  = $2000;  // Hardware CRC calculation enable 
  SPI_CR1_BIDIOE: uInt16  = $4000;  // Output enable in bidirectional mode 
  SPI_CR1_BIDIMODE: uInt16  = $8000;  // Bidirectional data mode enable 

{******************  Bit definition for SPI_CR2 register  *******************}
  SPI_CR2_RXDMAEN: uInt8  = $01;  // Rx Buffer DMA Enable 
  SPI_CR2_TXDMAEN: uInt8  = $02;  // Tx Buffer DMA Enable 
  SPI_CR2_SSOE: uInt8  = $04;  // SS Output Enable 
  SPI_CR2_ERRIE: uInt8  = $20;  // Error Interrupt Enable 
  SPI_CR2_RXNEIE: uInt8  = $40;  // RX buffer Not Empty Interrupt Enable 
  SPI_CR2_TXEIE: uInt8  = $80;  // Tx buffer Empty Interrupt Enable 

{*******************  Bit definition for SPI_SR register  *******************}
  SPI_SR_RXNE: uInt8  = $01;  // Receive buffer Not Empty 
  SPI_SR_TXE: uInt8  = $02;  // Transmit buffer Empty 
  SPI_SR_CHSIDE: uInt8  = $04;  // Channel side 
  SPI_SR_UDR: uInt8  = $08;  // Underrun flag 
  SPI_SR_CRCERR: uInt8  = $10;  // CRC Error flag 
  SPI_SR_MODF: uInt8  = $20;  // Mode fault 
  SPI_SR_OVR: uInt8  = $40;  // Overrun flag 
  SPI_SR_BSY: uInt8  = $80;  // Busy flag 

{*******************  Bit definition for SPI_DR register  *******************}
  SPI_DR_DR: uInt16  = $FFFF;  // Data Register 

{******************  Bit definition for SPI_CRCPR register  *****************}
  SPI_CRCPR_CRCPOLY: uInt16  = $FFFF;  // CRC polynomial register 

{*****************  Bit definition for SPI_RXCRCR register  *****************}
  SPI_RXCRCR_RXCRC: uInt16  = $FFFF;  // Rx CRC Register 

{*****************  Bit definition for SPI_TXCRCR register  *****************}
  SPI_TXCRCR_TXCRC: uInt16  = $FFFF;  // Tx CRC Register 

{*****************  Bit definition for SPI_I2SCFGR register  ****************}
  SPI_I2SCFGR_CHLEN: uInt16  = $0001;  // Channel length (number of bits per audio channel) 

  SPI_I2SCFGR_DATLEN: uInt16  = $0006;  // DATLEN[1:0] bits (Data length to be transferred) 
  SPI_I2SCFGR_DATLEN_0: uInt16  = $0002;  // Bit 0 
  SPI_I2SCFGR_DATLEN_1: uInt16  = $0004;  // Bit 1 

  SPI_I2SCFGR_CKPOL: uInt16  = $0008;  // steady state clock polarity 

  SPI_I2SCFGR_I2SSTD: uInt16  = $0030;  // I2SSTD[1:0] bits (I2S standard selection) 
  SPI_I2SCFGR_I2SSTD_0: uInt16  = $0010;  // Bit 0 
  SPI_I2SCFGR_I2SSTD_1: uInt16  = $0020;  // Bit 1 

  SPI_I2SCFGR_PCMSYNC: uInt16  = $0080;  // PCM frame synchronization 

  SPI_I2SCFGR_I2SCFG: uInt16  = $0300;  // I2SCFG[1:0] bits (I2S configuration mode) 
  SPI_I2SCFGR_I2SCFG_0: uInt16  = $0100;  // Bit 0 
  SPI_I2SCFGR_I2SCFG_1: uInt16  = $0200;  // Bit 1 

  SPI_I2SCFGR_I2SE: uInt16  = $0400;  // I2S Enable 
  SPI_I2SCFGR_I2SMOD: uInt16  = $0800;  // I2S mode selection 

{*****************  Bit definition for SPI_I2SPR register  ******************}
  SPI_I2SPR_I2SDIV: uInt16  = $00FF;  // I2S Linear prescaler 
  SPI_I2SPR_ODD: uInt16  = $0100;  // Odd factor for the prescaler 
  SPI_I2SPR_MCKOE: uInt16  = $0200;  // Master Clock Output Enable 

{****************************************************************************}
{                                                                            }
{                      Inter-integrated Circuit Interface                    }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for I2C_CR1 register  *******************}
  I2C_CR1_PE: uInt16  = $0001;  // Peripheral Enable 
  I2C_CR1_SMBUS: uInt16  = $0002;  // SMBus Mode 
  I2C_CR1_SMBTYPE: uInt16  = $0008;  // SMBus Type 
  I2C_CR1_ENARP: uInt16  = $0010;  // ARP Enable 
  I2C_CR1_ENPEC: uInt16  = $0020;  // PEC Enable 
  I2C_CR1_ENGC: uInt16  = $0040;  // General Call Enable 
  I2C_CR1_NOSTRETCH: uInt16  = $0080;  // Clock Stretching Disable (Slave mode) 
  I2C_CR1_START: uInt16  = $0100;  // Start Generation 
  I2C_CR1_STOP: uInt16  = $0200;  // Stop Generation 
  I2C_CR1_ACK: uInt16  = $0400;  // Acknowledge Enable 
  I2C_CR1_POS: uInt16  = $0800;  // Acknowledge/PEC Position (for data reception) 
  I2C_CR1_PEC: uInt16  = $1000;  // Packet Error Checking 
  I2C_CR1_ALERT: uInt16  = $2000;  // SMBus Alert 
  I2C_CR1_SWRST: uInt16  = $8000;  // Software Reset 

{******************  Bit definition for I2C_CR2 register  *******************}
  I2C_CR2_FREQ: uInt16  = $003F;  // FREQ[5:0] bits (Peripheral Clock Frequency) 
  I2C_CR2_FREQ_0: uInt16  = $0001;  // Bit 0 
  I2C_CR2_FREQ_1: uInt16  = $0002;  // Bit 1 
  I2C_CR2_FREQ_2: uInt16  = $0004;  // Bit 2 
  I2C_CR2_FREQ_3: uInt16  = $0008;  // Bit 3 
  I2C_CR2_FREQ_4: uInt16  = $0010;  // Bit 4 
  I2C_CR2_FREQ_5: uInt16  = $0020;  // Bit 5 

  I2C_CR2_ITERREN: uInt16  = $0100;  // Error Interrupt Enable 
  I2C_CR2_ITEVTEN: uInt16  = $0200;  // Event Interrupt Enable 
  I2C_CR2_ITBUFEN: uInt16  = $0400;  // Buffer Interrupt Enable 
  I2C_CR2_DMAEN: uInt16  = $0800;  // DMA Requests Enable 
  I2C_CR2_LAST: uInt16  = $1000;  // DMA Last Transfer 

{******************  Bit definition for I2C_OAR1 register  ******************}
  I2C_OAR1_ADD1_7: uInt16  = $00FE;  // Interface Address 
  I2C_OAR1_ADD8_9: uInt16  = $0300;  // Interface Address 

  I2C_OAR1_ADD0: uInt16  = $0001;  // Bit 0 
  I2C_OAR1_ADD1: uInt16  = $0002;  // Bit 1 
  I2C_OAR1_ADD2: uInt16  = $0004;  // Bit 2 
  I2C_OAR1_ADD3: uInt16  = $0008;  // Bit 3 
  I2C_OAR1_ADD4: uInt16  = $0010;  // Bit 4 
  I2C_OAR1_ADD5: uInt16  = $0020;  // Bit 5 
  I2C_OAR1_ADD6: uInt16  = $0040;  // Bit 6 
  I2C_OAR1_ADD7: uInt16  = $0080;  // Bit 7 
  I2C_OAR1_ADD8: uInt16  = $0100;  // Bit 8 
  I2C_OAR1_ADD9: uInt16  = $0200;  // Bit 9 

  I2C_OAR1_ADDMODE: uInt16  = $8000;  // Addressing Mode (Slave mode) 

{******************  Bit definition for I2C_OAR2 register  ******************}
  I2C_OAR2_ENDUAL: uInt8  = $01;  // Dual addressing mode enable 
  I2C_OAR2_ADD2: uInt8  = $FE;  // Interface address 

{*******************  Bit definition for I2C_DR register  *******************}
  I2C_DR_DR: uInt8  = $FF;  // 8-bit Data Register 

{******************  Bit definition for I2C_SR1 register  *******************}
  I2C_SR1_SB: uInt16  = $0001;  // Start Bit (Master mode) 
  I2C_SR1_ADDR: uInt16  = $0002;  // Address sent (master mode)/matched (slave mode) 
  I2C_SR1_BTF: uInt16  = $0004;  // Byte Transfer Finished 
  I2C_SR1_ADD10: uInt16  = $0008;  // 10-bit header sent (Master mode) 
  I2C_SR1_STOPF: uInt16  = $0010;  // Stop detection (Slave mode) 
  I2C_SR1_RXNE: uInt16  = $0040;  // Data Register not Empty (receivers) 
  I2C_SR1_TXE: uInt16  = $0080;  // Data Register Empty (transmitters) 
  I2C_SR1_BERR: uInt16  = $0100;  // Bus Error 
  I2C_SR1_ARLO: uInt16  = $0200;  // Arbitration Lost (master mode) 
  I2C_SR1_AF: uInt16  = $0400;  // Acknowledge Failure 
  I2C_SR1_OVR: uInt16  = $0800;  // Overrun/Underrun 
  I2C_SR1_PECERR: uInt16  = $1000;  // PEC Error in reception 
  I2C_SR1_TIMEOUT: uInt16  = $4000;  // Timeout or Tlow Error 
  I2C_SR1_SMBALERT: uInt16  = $8000;  // SMBus Alert 

{******************  Bit definition for I2C_SR2 register  *******************}
  I2C_SR2_MSL: uInt16  = $0001;  // Master/Slave 
  I2C_SR2_BUSY: uInt16  = $0002;  // Bus Busy 
  I2C_SR2_TRA: uInt16  = $0004;  // Transmitter/Receiver 
  I2C_SR2_GENCALL: uInt16  = $0010;  // General Call Address (Slave mode) 
  I2C_SR2_SMBDEFAULT: uInt16  = $0020;  // SMBus Device Default Address (Slave mode) 
  I2C_SR2_SMBHOST: uInt16  = $0040;  // SMBus Host Header (Slave mode) 
  I2C_SR2_DUALF: uInt16  = $0080;  // Dual Flag (Slave mode) 
  I2C_SR2_PEC: uInt16  = $FF00;  // Packet Error Checking Register 

{******************  Bit definition for I2C_CCR register  *******************}
  I2C_CCR_CCR: uInt16  = $0FFF;  // Clock Control Register in Fast/Standard mode (Master mode) 
  I2C_CCR_DUTY: uInt16  = $4000;  // Fast Mode Duty Cycle 
  I2C_CCR_FS: uInt16  = $8000;  // I2C Master Mode Selection 

{*****************  Bit definition for I2C_TRISE register  ******************}
  I2C_TRISE_TRISE: uInt8  = $3F;  // Maximum Rise Time in Fast/Standard mode (Master mode) 

{****************************************************************************}
{                                                                            }
{         Universal Synchronous Asynchronous Receiver Transmitter            }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for USART_SR register  ******************}
  USART_SR_PE: uInt16  = $0001;  // Parity Error 
  USART_SR_FE: uInt16  = $0002;  // Framing Error 
  USART_SR_NE: uInt16  = $0004;  // Noise Error Flag 
  USART_SR_ORE: uInt16  = $0008;  // OverRun Error 
  USART_SR_IDLE: uInt16  = $0010;  // IDLE line detected 
  USART_SR_RXNE: uInt16  = $0020;  // Read Data Register Not Empty 
  USART_SR_TC: uInt16  = $0040;  // Transmission Complete 
  USART_SR_TXE: uInt16  = $0080;  // Transmit Data Register Empty 
  USART_SR_LBD: uInt16  = $0100;  // LIN Break Detection Flag 
  USART_SR_CTS: uInt16  = $0200;  // CTS Flag 

{******************  Bit definition for USART_DR register  ******************}
  USART_DR_DR: uInt16  = $01FF;  // Data value 

{*****************  Bit definition for USART_BRR register  ******************}
  USART_BRR_DIV_Fraction: uInt16  = $000F;  // Fraction of USARTDIV 
  USART_BRR_DIV_Mantissa: uInt16  = $FFF0;  // Mantissa of USARTDIV 

{*****************  Bit definition for USART_CR1 register  ******************}
  USART_CR1_SBK: uInt16  = $0001;  // Send Break 
  USART_CR1_RWU: uInt16  = $0002;  // Receiver wakeup 
  USART_CR1_RE: uInt16  = $0004;  // Receiver Enable 
  USART_CR1_TE: uInt16  = $0008;  // Transmitter Enable 
  USART_CR1_IDLEIE: uInt16  = $0010;  // IDLE Interrupt Enable 
  USART_CR1_RXNEIE: uInt16  = $0020;  // RXNE Interrupt Enable 
  USART_CR1_TCIE: uInt16  = $0040;  // Transmission Complete Interrupt Enable 
  USART_CR1_TXEIE: uInt16  = $0080;  // PE Interrupt Enable 
  USART_CR1_PEIE: uInt16  = $0100;  // PE Interrupt Enable 
  USART_CR1_PS: uInt16  = $0200;  // Parity Selection 
  USART_CR1_PCE: uInt16  = $0400;  // Parity Control Enable 
  USART_CR1_WAKE: uInt16  = $0800;  // Wakeup method 
  USART_CR1_M: uInt16  = $1000;  // Word length 
  USART_CR1_UE: uInt16  = $2000;  // USART Enable 
  USART_CR1_OVER8: uInt16  = $8000;  // USART Oversmapling 8-bits 

{*****************  Bit definition for USART_CR2 register  ******************}
  USART_CR2_ADD: uInt16  = $000F;  // Address of the USART node 
  USART_CR2_LBDL: uInt16  = $0020;  // LIN Break Detection Length 
  USART_CR2_LBDIE: uInt16  = $0040;  // LIN Break Detection Interrupt Enable 
  USART_CR2_LBCL: uInt16  = $0100;  // Last Bit Clock pulse 
  USART_CR2_CPHA: uInt16  = $0200;  // Clock Phase 
  USART_CR2_CPOL: uInt16  = $0400;  // Clock Polarity 
  USART_CR2_CLKEN: uInt16  = $0800;  // Clock Enable 

  USART_CR2_STOP: uInt16  = $3000;  // STOP[1:0] bits (STOP bits) 
  USART_CR2_STOP_0: uInt16  = $1000;  // Bit 0 
  USART_CR2_STOP_1: uInt16  = $2000;  // Bit 1 

  USART_CR2_LINEN: uInt16  = $4000;  // LIN mode enable 

{*****************  Bit definition for USART_CR3 register  ******************}
  USART_CR3_EIE: uInt16  = $0001;  // Error Interrupt Enable 
  USART_CR3_IREN: uInt16  = $0002;  // IrDA mode Enable 
  USART_CR3_IRLP: uInt16  = $0004;  // IrDA Low-Power 
  USART_CR3_HDSEL: uInt16  = $0008;  // Half-Duplex Selection 
  USART_CR3_NACK: uInt16  = $0010;  // Smartcard NACK enable 
  USART_CR3_SCEN: uInt16  = $0020;  // Smartcard mode enable 
  USART_CR3_DMAR: uInt16  = $0040;  // DMA Enable Receiver 
  USART_CR3_DMAT: uInt16  = $0080;  // DMA Enable Transmitter 
  USART_CR3_RTSE: uInt16  = $0100;  // RTS Enable 
  USART_CR3_CTSE: uInt16  = $0200;  // CTS Enable 
  USART_CR3_CTSIE: uInt16  = $0400;  // CTS Interrupt Enable 
  USART_CR3_ONEBIT: uInt16  = $0800;  // One Bit method 

{*****************  Bit definition for USART_GTPR register  *****************}
  USART_GTPR_PSC: uInt16  = $00FF;  // PSC[7:0] bits (Prescaler value) 
  USART_GTPR_PSC_0: uInt16  = $0001;  // Bit 0 
  USART_GTPR_PSC_1: uInt16  = $0002;  // Bit 1 
  USART_GTPR_PSC_2: uInt16  = $0004;  // Bit 2 
  USART_GTPR_PSC_3: uInt16  = $0008;  // Bit 3 
  USART_GTPR_PSC_4: uInt16  = $0010;  // Bit 4 
  USART_GTPR_PSC_5: uInt16  = $0020;  // Bit 5 
  USART_GTPR_PSC_6: uInt16  = $0040;  // Bit 6 
  USART_GTPR_PSC_7: uInt16  = $0080;  // Bit 7 

  USART_GTPR_GT: uInt16  = $FF00;  // Guard time value 

{****************************************************************************}
{                                                                            }
{                                 Debug MCU                                  }
{                                                                            }
{****************************************************************************}

{***************  Bit definition for DBGMCU_IDCODE register  ****************}
  DBGMCU_IDCODE_DEV_ID: uInt32  = $00000FFF;  // Device Identifier 

  DBGMCU_IDCODE_REV_ID: uInt32  = $FFFF0000;  // REV_ID[15:0] bits (Revision Identifier) 
  DBGMCU_IDCODE_REV_ID_0: uInt32  = $00010000;  // Bit 0 
  DBGMCU_IDCODE_REV_ID_1: uInt32  = $00020000;  // Bit 1 
  DBGMCU_IDCODE_REV_ID_2: uInt32  = $00040000;  // Bit 2 
  DBGMCU_IDCODE_REV_ID_3: uInt32  = $00080000;  // Bit 3 
  DBGMCU_IDCODE_REV_ID_4: uInt32  = $00100000;  // Bit 4 
  DBGMCU_IDCODE_REV_ID_5: uInt32  = $00200000;  // Bit 5 
  DBGMCU_IDCODE_REV_ID_6: uInt32  = $00400000;  // Bit 6 
  DBGMCU_IDCODE_REV_ID_7: uInt32  = $00800000;  // Bit 7 
  DBGMCU_IDCODE_REV_ID_8: uInt32  = $01000000;  // Bit 8 
  DBGMCU_IDCODE_REV_ID_9: uInt32  = $02000000;  // Bit 9 
  DBGMCU_IDCODE_REV_ID_10: uInt32  = $04000000;  // Bit 10 
  DBGMCU_IDCODE_REV_ID_11: uInt32  = $08000000;  // Bit 11 
  DBGMCU_IDCODE_REV_ID_12: uInt32  = $10000000;  // Bit 12 
  DBGMCU_IDCODE_REV_ID_13: uInt32  = $20000000;  // Bit 13 
  DBGMCU_IDCODE_REV_ID_14: uInt32  = $40000000;  // Bit 14 
  DBGMCU_IDCODE_REV_ID_15: uInt32  = $80000000;  // Bit 15 

{*****************  Bit definition for DBGMCU_CR register  ******************}
  DBGMCU_CR_DBG_SLEEP: uInt32  = $00000001;  // Debug Sleep Mode 
  DBGMCU_CR_DBG_STOP: uInt32  = $00000002;  // Debug Stop Mode 
  DBGMCU_CR_DBG_STANDBY: uInt32  = $00000004;  // Debug Standby mode 
  DBGMCU_CR_TRACE_IOEN: uInt32  = $00000020;  // Trace Pin Assignment Control 

  DBGMCU_CR_TRACE_MODE: uInt32  = $000000C0;  // TRACE_MODE[1:0] bits (Trace Pin Assignment Control) 
  DBGMCU_CR_TRACE_MODE_0: uInt32  = $00000040;  // Bit 0 
  DBGMCU_CR_TRACE_MODE_1: uInt32  = $00000080;  // Bit 1 

  DBGMCU_CR_DBG_IWDG_STOP: uInt32  = $00000100;  // Debug Independent Watchdog stopped when Core is halted 
  DBGMCU_CR_DBG_WWDG_STOP: uInt32  = $00000200;  // Debug Window Watchdog stopped when Core is halted 
  DBGMCU_CR_DBG_TIM1_STOP: uInt32  = $00000400;  // TIM1 counter stopped when core is halted 
  DBGMCU_CR_DBG_TIM2_STOP: uInt32  = $00000800;  // TIM2 counter stopped when core is halted 
  DBGMCU_CR_DBG_TIM3_STOP: uInt32  = $00001000;  // TIM3 counter stopped when core is halted 
  DBGMCU_CR_DBG_TIM4_STOP: uInt32  = $00002000;  // TIM4 counter stopped when core is halted 
  DBGMCU_CR_DBG_CAN1_STOP: uInt32  = $00004000;  // Debug CAN1 stopped when Core is halted 
  DBGMCU_CR_DBG_I2C1_SMBUS_TIMEOUT: uInt32  = $00008000;  // SMBUS timeout mode stopped when Core is halted 
  DBGMCU_CR_DBG_I2C2_SMBUS_TIMEOUT: uInt32  = $00010000;  // SMBUS timeout mode stopped when Core is halted 
  DBGMCU_CR_DBG_TIM8_STOP: uInt32  = $00020000;  // TIM8 counter stopped when core is halted 
  DBGMCU_CR_DBG_TIM5_STOP: uInt32  = $00040000;  // TIM5 counter stopped when core is halted 
  DBGMCU_CR_DBG_TIM6_STOP: uInt32  = $00080000;  // TIM6 counter stopped when core is halted 
  DBGMCU_CR_DBG_TIM7_STOP: uInt32  = $00100000;  // TIM7 counter stopped when core is halted 
  DBGMCU_CR_DBG_CAN2_STOP: uInt32  = $00200000;  // Debug CAN2 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM15_STOP: uInt32  = $00400000;  // Debug TIM15 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM16_STOP: uInt32  = $00800000;  // Debug TIM16 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM17_STOP: uInt32  = $01000000;  // Debug TIM17 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM12_STOP: uInt32  = $02000000;  // Debug TIM12 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM13_STOP: uInt32  = $04000000;  // Debug TIM13 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM14_STOP: uInt32  = $08000000;  // Debug TIM14 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM9_STOP: uInt32  = $10000000;  // Debug TIM9 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM10_STOP: uInt32  = $20000000;  // Debug TIM10 stopped when Core is halted 
  DBGMCU_CR_DBG_TIM11_STOP: uInt32  = $40000000;  // Debug TIM11 stopped when Core is halted 

{****************************************************************************}
{                                                                            }
{                      FLASH and Option Bytes Registers                      }
{                                                                            }
{****************************************************************************}

{******************  Bit definition for FLASH_ACR register  *****************}
  FLASH_ACR_LATENCY: uInt8  = $03;  // LATENCY[2:0] bits (Latency) 
  FLASH_ACR_LATENCY_0: uInt8  = $00;  // Bit 0 
  FLASH_ACR_LATENCY_1: uInt8  = $01;  // Bit 0 
  FLASH_ACR_LATENCY_2: uInt8  = $02;  // Bit 1 

  FLASH_ACR_HLFCYA: uInt8  = $08;  // Flash Half Cycle Access Enable 
  FLASH_ACR_PRFTBE: uInt8  = $10;  // Prefetch Buffer Enable 
  FLASH_ACR_PRFTBS: uInt8  = $20;  // Prefetch Buffer Status 

{*****************  Bit definition for FLASH_KEYR register  *****************}
  FLASH_KEYR_FKEYR: uInt32  = $FFFFFFFF;  // FPEC Key 

{****************  Bit definition for FLASH_OPTKEYR register  ***************}
  FLASH_OPTKEYR_OPTKEYR: uInt32  = $FFFFFFFF;  // Option Byte Key 

{*****************  Bit definition for FLASH_SR register  ******************}
  FLASH_SR_BSY: uInt8  = $01;  // Busy 
  FLASH_SR_PGERR: uInt8  = $04;  // Programming Error 
  FLASH_SR_WRPRTERR: uInt8  = $10;  // Write Protection Error 
  FLASH_SR_EOP: uInt8  = $20;  // End of operation 

{******************  Bit definition for FLASH_CR register  ******************}
  FLASH_CR_PG: uInt16  = $0001;  // Programming 
  FLASH_CR_PER: uInt16  = $0002;  // Page Erase 
  FLASH_CR_MER: uInt16  = $0004;  // Mass Erase 
  FLASH_CR_OPTPG: uInt16  = $0010;  // Option Byte Programming 
  FLASH_CR_OPTER: uInt16  = $0020;  // Option Byte Erase 
  FLASH_CR_STRT: uInt16  = $0040;  // Start 
  FLASH_CR_LOCK: uInt16  = $0080;  // Lock 
  FLASH_CR_OPTWRE: uInt16  = $0200;  // Option Bytes Write Enable 
  FLASH_CR_ERRIE: uInt16  = $0400;  // Error Interrupt Enable 
  FLASH_CR_EOPIE: uInt16  = $1000;  // End of operation interrupt enable 

{******************  Bit definition for FLASH_AR register  ******************}
  FLASH_AR_FAR: uInt32  = $FFFFFFFF;  // Flash Address 

{*****************  Bit definition for FLASH_OBR register  ******************}
  FLASH_OBR_OPTERR: uInt16  = $0001;  // Option Byte Error 
  FLASH_OBR_RDPRT: uInt16  = $0002;  // Read protection 

  FLASH_OBR_USER: uInt16  = $03FC;  // User Option Bytes 
  FLASH_OBR_WDG_SW: uInt16  = $0004;  // WDG_SW 
  FLASH_OBR_nRST_STOP: uInt16  = $0008;  // nRST_STOP 
  FLASH_OBR_nRST_STDBY: uInt16  = $0010;  // nRST_STDBY 
  FLASH_OBR_BFB2: uInt16  = $0020;  // BFB2 

{*****************  Bit definition for FLASH_WRPR register  *****************}
  FLASH_WRPR_WRP: uInt32  = $FFFFFFFF;  // Write Protect 

{----------------------------------------------------------------------------}

{*****************  Bit definition for FLASH_RDP register  ******************}
  FLASH_RDP_RDP: uInt32  = $000000FF;  // Read protection option byte 
  FLASH_RDP_nRDP: uInt32  = $0000FF00;  // Read protection complemented option byte 

{*****************  Bit definition for FLASH_USER register  *****************}
  FLASH_USER_USER: uInt32  = $00FF0000;  // User option byte 
  FLASH_USER_nUSER: uInt32  = $FF000000;  // User complemented option byte 

{*****************  Bit definition for FLASH_Data0 register  ****************}
  FLASH_Data0_Data0: uInt32  = $000000FF;  // User data storage option byte 
  FLASH_Data0_nData0: uInt32  = $0000FF00;  // User data storage complemented option byte 

{*****************  Bit definition for FLASH_Data1 register  ****************}
  FLASH_Data1_Data1: uInt32  = $00FF0000;  // User data storage option byte 
  FLASH_Data1_nData1: uInt32  = $FF000000;  // User data storage complemented option byte 

{*****************  Bit definition for FLASH_WRP0 register  *****************}
  FLASH_WRP0_WRP0: uInt32  = $000000FF;  // Flash memory write protection option bytes 
  FLASH_WRP0_nWRP0: uInt32  = $0000FF00;  // Flash memory write protection complemented option bytes 

{*****************  Bit definition for FLASH_WRP1 register  *****************}
  FLASH_WRP1_WRP1: uInt32  = $00FF0000;  // Flash memory write protection option bytes 
  FLASH_WRP1_nWRP1: uInt32  = $FF000000;  // Flash memory write protection complemented option bytes 

{*****************  Bit definition for FLASH_WRP2 register  *****************}
  FLASH_WRP2_WRP2: uInt32  = $000000FF;  // Flash memory write protection option bytes 
  FLASH_WRP2_nWRP2: uInt32  = $0000FF00;  // Flash memory write protection complemented option bytes 

{*****************  Bit definition for FLASH_WRP3 register  *****************}
  FLASH_WRP3_WRP3: uInt32  = $00FF0000;  // Flash memory write protection option bytes 
  FLASH_WRP3_nWRP3: uInt32  = $FF000000;  // Flash memory write protection complemented option bytes 

{$IFDEF STM32F10X_CL}
{****************************************************************************}
{                Ethernet MAC Registers bits definitions                     }
{****************************************************************************}
{ Bit definition for Ethernet MAC Control Register register }
  ETH_MACCR_WD: uInt32  = $00800000;  // Watchdog disable 
  ETH_MACCR_JD: uInt32  = $00400000;  // Jabber disable 
  ETH_MACCR_IFG: uInt32  = $000E0000;  // Inter-frame gap 
  ETH_MACCR_IFG_96Bit: uInt32  = $00000000;  // Minimum IFG between frames during transmission is 96Bit 
  ETH_MACCR_IFG_88Bit: uInt32  = $00020000;  // Minimum IFG between frames during transmission is 88Bit 
  ETH_MACCR_IFG_80Bit: uInt32  = $00040000;  // Minimum IFG between frames during transmission is 80Bit 
  ETH_MACCR_IFG_72Bit: uInt32  = $00060000;  // Minimum IFG between frames during transmission is 72Bit 
  ETH_MACCR_IFG_64Bit: uInt32  = $00080000;  // Minimum IFG between frames during transmission is 64Bit 
  ETH_MACCR_IFG_56Bit: uInt32  = $000A0000;  // Minimum IFG between frames during transmission is 56Bit 
  ETH_MACCR_IFG_48Bit: uInt32  = $000C0000;  // Minimum IFG between frames during transmission is 48Bit 
  ETH_MACCR_IFG_40Bit: uInt32  = $000E0000;  // Minimum IFG between frames during transmission is 40Bit 
  ETH_MACCR_CSD: uInt32  = $00010000;  // Carrier sense disable (during transmission) 
  ETH_MACCR_FES: uInt32  = $00004000;  // Fast ethernet speed 
  ETH_MACCR_ROD: uInt32  = $00002000;  // Receive own disable 
  ETH_MACCR_LM: uInt32  = $00001000;  // loopback mode 
  ETH_MACCR_DM: uInt32  = $00000800;  // Duplex mode 
  ETH_MACCR_IPCO: uInt32  = $00000400;  // IP Checksum offload 
  ETH_MACCR_RD: uInt32  = $00000200;  // Retry disable 
  ETH_MACCR_APCS: uInt32  = $00000080;  // Automatic Pad/CRC stripping 
  ETH_MACCR_BL: uInt32  = $00000060;  // Back-off limit: random integer number (r) of slot time delays before rescheduling
                                                       a transmission attempt during retries after a collision: 0 =< r <2^k }
  ETH_MACCR_BL_10: uInt32  = $00000000;  // k = min (n, 10) 
  ETH_MACCR_BL_8: uInt32  = $00000020;  // k = min (n, 8) 
  ETH_MACCR_BL_4: uInt32  = $00000040;  // k = min (n, 4) 
  ETH_MACCR_BL_1: uInt32  = $00000060;  // k = min (n, 1) 
  ETH_MACCR_DC: uInt32  = $00000010;  // Defferal check 
  ETH_MACCR_TE: uInt32  = $00000008;  // Transmitter enable 
  ETH_MACCR_RE: uInt32  = $00000004;  // Receiver enable 

{ Bit definition for Ethernet MAC Frame Filter Register }
  ETH_MACFFR_RA: uInt32  = $80000000;  // Receive all 
  ETH_MACFFR_HPF: uInt32  = $00000400;  // Hash or perfect filter 
  ETH_MACFFR_SAF: uInt32  = $00000200;  // Source address filter enable 
  ETH_MACFFR_SAIF: uInt32  = $00000100;  // SA inverse filtering 
  ETH_MACFFR_PCF: uInt32  = $000000C0;  // Pass control frames: 3 cases 
  ETH_MACFFR_PCF_BlockAll: uInt32  = $00000040;  // MAC filters all control frames from reaching the application 
  ETH_MACFFR_PCF_ForwardAll: uInt32  = $00000080;  // MAC forwards all control frames to application even if they fail the Address Filter 
  ETH_MACFFR_PCF_ForwardPassedAddrFilter: uInt32  = $000000C0;  // MAC forwards control frames that pass the Address Filter. 
  ETH_MACFFR_BFD: uInt32  = $00000020;  // Broadcast frame disable 
  ETH_MACFFR_PAM: uInt32  = $00000010;  // Pass all mutlicast 
  ETH_MACFFR_DAIF: uInt32  = $00000008;  // DA Inverse filtering 
  ETH_MACFFR_HM: uInt32  = $00000004;  // Hash multicast 
  ETH_MACFFR_HU: uInt32  = $00000002;  // Hash unicast 
  ETH_MACFFR_PM: uInt32  = $00000001;  // Promiscuous mode 

{ Bit definition for Ethernet MAC Hash Table High Register }
  ETH_MACHTHR_HTH: uInt32  = $FFFFFFFF;  // Hash table high 

{ Bit definition for Ethernet MAC Hash Table Low Register }
  ETH_MACHTLR_HTL: uInt32  = $FFFFFFFF;  // Hash table low 

{ Bit definition for Ethernet MAC MII Address Register }
  ETH_MACMIIAR_PA: uInt32  = $0000F800;  // Physical layer address 
  ETH_MACMIIAR_MR: uInt32  = $000007C0;  // MII register in the selected PHY 
  ETH_MACMIIAR_CR: uInt32  = $0000001C;  // CR clock range: 6 cases 
  ETH_MACMIIAR_CR_Div42: uInt32  = $00000000;  // HCLK:60-72 MHz; MDC clock= HCLK/42 
  ETH_MACMIIAR_CR_Div16: uInt32  = $00000008;  // HCLK:20-35 MHz; MDC clock= HCLK/16 
  ETH_MACMIIAR_CR_Div26: uInt32  = $0000000C;  // HCLK:35-60 MHz; MDC clock= HCLK/26 
  ETH_MACMIIAR_MW: uInt32  = $00000002;  // MII write 
  ETH_MACMIIAR_MB: uInt32  = $00000001;  // MII busy 

{ Bit definition for Ethernet MAC MII Data Register }
  ETH_MACMIIDR_MD: uInt32  = $0000FFFF;  // MII data: read/write data from/to PHY 

{ Bit definition for Ethernet MAC Flow Control Register }
  ETH_MACFCR_PT: uInt32  = $FFFF0000;  // Pause time 
  ETH_MACFCR_ZQPD: uInt32  = $00000080;  // Zero-quanta pause disable 
  ETH_MACFCR_PLT: uInt32  = $00000030;  // Pause low threshold: 4 cases 
  ETH_MACFCR_PLT_Minus4: uInt32  = $00000000;  // Pause time minus 4 slot times 
  ETH_MACFCR_PLT_Minus28: uInt32  = $00000010;  // Pause time minus 28 slot times 
  ETH_MACFCR_PLT_Minus144: uInt32  = $00000020;  // Pause time minus 144 slot times 
  ETH_MACFCR_PLT_Minus256: uInt32  = $00000030;  // Pause time minus 256 slot times 
  ETH_MACFCR_UPFD: uInt32  = $00000008;  // Unicast pause frame detect 
  ETH_MACFCR_RFCE: uInt32  = $00000004;  // Receive flow control enable 
  ETH_MACFCR_TFCE: uInt32  = $00000002;  // Transmit flow control enable 
  ETH_MACFCR_FCBBPA: uInt32  = $00000001;  // Flow control busy/backpressure activate 

{ Bit definition for Ethernet MAC VLAN Tag Register }
  ETH_MACVLANTR_VLANTC: uInt32  = $00010000;  // 12-bit VLAN tag comparison 
  ETH_MACVLANTR_VLANTI: uInt32  = $0000FFFF;  // VLAN tag identifier (for receive frames) 

{ Bit definition for Ethernet MAC Remote Wake-UpFrame Filter Register }
  ETH_MACRWUFFR_D: uInt32  = $FFFFFFFF;  // Wake-up frame filter register data 
{ Eight sequential Writes to this address (offset 0x28) will write all Wake-UpFrame Filter Registers.
   Eight sequential Reads from this address (offset 0x28) will read all Wake-UpFrame Filter Registers. }
{ Wake-UpFrame Filter Reg0 : Filter 0 Byte Mask
   Wake-UpFrame Filter Reg1 : Filter 1 Byte Mask
   Wake-UpFrame Filter Reg2 : Filter 2 Byte Mask
   Wake-UpFrame Filter Reg3 : Filter 3 Byte Mask
   Wake-UpFrame Filter Reg4 : RSVD - Filter3 Command - RSVD - Filter2 Command -
                              RSVD - Filter1 Command - RSVD - Filter0 Command
   Wake-UpFrame Filter Re5 : Filter3 Offset - Filter2 Offset - Filter1 Offset - Filter0 Offset
   Wake-UpFrame Filter Re6 : Filter1 CRC16 - Filter0 CRC16
   Wake-UpFrame Filter Re7 : Filter3 CRC16 - Filter2 CRC16 }

{ Bit definition for Ethernet MAC PMT Control and Status Register }
  ETH_MACPMTCSR_WFFRPR: uInt32  = $80000000;  // Wake-Up Frame Filter Register Pointer Reset 
  ETH_MACPMTCSR_GU: uInt32  = $00000200;  // Global Unicast 
  ETH_MACPMTCSR_WFR: uInt32  = $00000040;  // Wake-Up Frame Received 
  ETH_MACPMTCSR_MPR: uInt32  = $00000020;  // Magic Packet Received 
  ETH_MACPMTCSR_WFE: uInt32  = $00000004;  // Wake-Up Frame Enable 
  ETH_MACPMTCSR_MPE: uInt32  = $00000002;  // Magic Packet Enable 
  ETH_MACPMTCSR_PD: uInt32  = $00000001;  // Power Down 

{ Bit definition for Ethernet MAC Status Register }
  ETH_MACSR_TSTS: uInt32  = $00000200;  // Time stamp trigger status 
  ETH_MACSR_MMCTS: uInt32  = $00000040;  // MMC transmit status 
  ETH_MACSR_MMMCRS: uInt32  = $00000020;  // MMC receive status 
  ETH_MACSR_MMCS: uInt32  = $00000010;  // MMC status 
  ETH_MACSR_PMTS: uInt32  = $00000008;  // PMT status 

{ Bit definition for Ethernet MAC Interrupt Mask Register }
  ETH_MACIMR_TSTIM: uInt32  = $00000200;  // Time stamp trigger interrupt mask 
  ETH_MACIMR_PMTIM: uInt32  = $00000008;  // PMT interrupt mask 

{ Bit definition for Ethernet MAC Address0 High Register }
  ETH_MACA0HR_MACA0H: uInt32  = $0000FFFF;  // MAC address0 high 

{ Bit definition for Ethernet MAC Address0 Low Register }
  ETH_MACA0LR_MACA0L: uInt32  = $FFFFFFFF;  // MAC address0 low 

{ Bit definition for Ethernet MAC Address1 High Register }
  ETH_MACA1HR_AE: uInt32  = $80000000;  // Address enable 
  ETH_MACA1HR_SA: uInt32  = $40000000;  // Source address 
  ETH_MACA1HR_MBC: uInt32  = $3F000000;  // Mask byte control: bits to mask for comparison of the MAC Address bytes 
  ETH_MACA1HR_MBC_HBits15_8: uInt32  = $20000000;  // Mask MAC Address high reg bits [15:8] 
  ETH_MACA1HR_MBC_HBits7_0: uInt32  = $10000000;  // Mask MAC Address high reg bits [7:0] 
  ETH_MACA1HR_MBC_LBits31_24: uInt32  = $08000000;  // Mask MAC Address low reg bits [31:24] 
  ETH_MACA1HR_MBC_LBits23_16: uInt32  = $04000000;  // Mask MAC Address low reg bits [23:16] 
  ETH_MACA1HR_MBC_LBits15_8: uInt32  = $02000000;  // Mask MAC Address low reg bits [15:8] 
  ETH_MACA1HR_MBC_LBits7_0: uInt32  = $01000000;  // Mask MAC Address low reg bits [7:0] 
  ETH_MACA1HR_MACA1H: uInt32  = $0000FFFF;  // MAC address1 high 

{ Bit definition for Ethernet MAC Address1 Low Register }
  ETH_MACA1LR_MACA1L: uInt32  = $FFFFFFFF;  // MAC address1 low 

{ Bit definition for Ethernet MAC Address2 High Register }
  ETH_MACA2HR_AE: uInt32  = $80000000;  // Address enable 
  ETH_MACA2HR_SA: uInt32  = $40000000;  // Source address 
  ETH_MACA2HR_MBC: uInt32  = $3F000000;  // Mask byte control 
  ETH_MACA2HR_MBC_HBits15_8: uInt32  = $20000000;  // Mask MAC Address high reg bits [15:8] 
  ETH_MACA2HR_MBC_HBits7_0: uInt32  = $10000000;  // Mask MAC Address high reg bits [7:0] 
  ETH_MACA2HR_MBC_LBits31_24: uInt32  = $08000000;  // Mask MAC Address low reg bits [31:24] 
  ETH_MACA2HR_MBC_LBits23_16: uInt32  = $04000000;  // Mask MAC Address low reg bits [23:16] 
  ETH_MACA2HR_MBC_LBits15_8: uInt32  = $02000000;  // Mask MAC Address low reg bits [15:8] 
  ETH_MACA2HR_MBC_LBits7_0: uInt32  = $01000000;  // Mask MAC Address low reg bits [70] 
  ETH_MACA2HR_MACA2H: uInt32  = $0000FFFF;  // MAC address1 high 

{ Bit definition for Ethernet MAC Address2 Low Register }
  ETH_MACA2LR_MACA2L: uInt32  = $FFFFFFFF;  // MAC address2 low 

{ Bit definition for Ethernet MAC Address3 High Register }
  ETH_MACA3HR_AE: uInt32  = $80000000;  // Address enable 
  ETH_MACA3HR_SA: uInt32  = $40000000;  // Source address 
  ETH_MACA3HR_MBC: uInt32  = $3F000000;  // Mask byte control 
  ETH_MACA3HR_MBC_HBits15_8: uInt32  = $20000000;  // Mask MAC Address high reg bits [15:8] 
  ETH_MACA3HR_MBC_HBits7_0: uInt32  = $10000000;  // Mask MAC Address high reg bits [7:0] 
  ETH_MACA3HR_MBC_LBits31_24: uInt32  = $08000000;  // Mask MAC Address low reg bits [31:24] 
  ETH_MACA3HR_MBC_LBits23_16: uInt32  = $04000000;  // Mask MAC Address low reg bits [23:16] 
  ETH_MACA3HR_MBC_LBits15_8: uInt32  = $02000000;  // Mask MAC Address low reg bits [15:8] 
  ETH_MACA3HR_MBC_LBits7_0: uInt32  = $01000000;  // Mask MAC Address low reg bits [70] 
  ETH_MACA3HR_MACA3H: uInt32  = $0000FFFF;  // MAC address3 high 

{ Bit definition for Ethernet MAC Address3 Low Register }
  ETH_MACA3LR_MACA3L: uInt32  = $FFFFFFFF;  // MAC address3 low 

{****************************************************************************}
{                Ethernet MMC Registers bits definition                      }
{****************************************************************************}

{ Bit definition for Ethernet MMC Contol Register }
  ETH_MMCCR_MCF: uInt32  = $00000008;  // MMC Counter Freeze 
  ETH_MMCCR_ROR: uInt32  = $00000004;  // Reset on Read 
  ETH_MMCCR_CSR: uInt32  = $00000002;  // Counter Stop Rollover 
  ETH_MMCCR_CR: uInt32  = $00000001;  // Counters Reset 

{ Bit definition for Ethernet MMC Receive Interrupt Register }
  ETH_MMCRIR_RGUFS: uInt32  = $00020000;  // Set when Rx good unicast frames counter reaches half the maximum value 
  ETH_MMCRIR_RFAES: uInt32  = $00000040;  // Set when Rx alignment error counter reaches half the maximum value 
  ETH_MMCRIR_RFCES: uInt32  = $00000020;  // Set when Rx crc error counter reaches half the maximum value 

{ Bit definition for Ethernet MMC Transmit Interrupt Register }
  ETH_MMCTIR_TGFS: uInt32  = $00200000;  // Set when Tx good frame count counter reaches half the maximum value 
  ETH_MMCTIR_TGFMSCS: uInt32  = $00008000;  // Set when Tx good multi col counter reaches half the maximum value 
  ETH_MMCTIR_TGFSCS: uInt32  = $00004000;  // Set when Tx good single col counter reaches half the maximum value 

{ Bit definition for Ethernet MMC Receive Interrupt Mask Register }
  ETH_MMCRIMR_RGUFM: uInt32  = $00020000;  // Mask the interrupt when Rx good unicast frames counter reaches half the maximum value 
  ETH_MMCRIMR_RFAEM: uInt32  = $00000040;  // Mask the interrupt when when Rx alignment error counter reaches half the maximum value 
  ETH_MMCRIMR_RFCEM: uInt32  = $00000020;  // Mask the interrupt when Rx crc error counter reaches half the maximum value 

{ Bit definition for Ethernet MMC Transmit Interrupt Mask Register }
  ETH_MMCTIMR_TGFM: uInt32  = $00200000;  // Mask the interrupt when Tx good frame count counter reaches half the maximum value 
  ETH_MMCTIMR_TGFMSCM: uInt32  = $00008000;  // Mask the interrupt when Tx good multi col counter reaches half the maximum value 
  ETH_MMCTIMR_TGFSCM: uInt32  = $00004000;  // Mask the interrupt when Tx good single col counter reaches half the maximum value 

{ Bit definition for Ethernet MMC Transmitted Good Frames after Single Collision Counter Register }
  ETH_MMCTGFSCCR_TGFSCC: uInt32  = $FFFFFFFF;  // Number of successfully transmitted frames after a single collision in Half-duplex mode. 

{ Bit definition for Ethernet MMC Transmitted Good Frames after More than a Single Collision Counter Register }
  ETH_MMCTGFMSCCR_TGFMSCC: uInt32  = $FFFFFFFF;  // Number of successfully transmitted frames after more than a single collision in Half-duplex mode. 

{ Bit definition for Ethernet MMC Transmitted Good Frames Counter Register }
  ETH_MMCTGFCR_TGFC: uInt32  = $FFFFFFFF;  // Number of good frames transmitted. 

{ Bit definition for Ethernet MMC Received Frames with CRC Error Counter Register }
  ETH_MMCRFCECR_RFCEC: uInt32  = $FFFFFFFF;  // Number of frames received with CRC error. 

{ Bit definition for Ethernet MMC Received Frames with Alignement Error Counter Register }
  ETH_MMCRFAECR_RFAEC: uInt32  = $FFFFFFFF;  // Number of frames received with alignment (dribble) error 

{ Bit definition for Ethernet MMC Received Good Unicast Frames Counter Register }
  ETH_MMCRGUFCR_RGUFC: uInt32  = $FFFFFFFF;  // Number of good unicast frames received. 

{****************************************************************************}
{               Ethernet PTP Registers bits definition                       }
{****************************************************************************}

{ Bit definition for Ethernet PTP Time Stamp Contol Register }
  ETH_PTPTSCR_TSARU: uInt32  = $00000020;  // Addend register update 
  ETH_PTPTSCR_TSITE: uInt32  = $00000010;  // Time stamp interrupt trigger enable 
  ETH_PTPTSCR_TSSTU: uInt32  = $00000008;  // Time stamp update 
  ETH_PTPTSCR_TSSTI: uInt32  = $00000004;  // Time stamp initialize 
  ETH_PTPTSCR_TSFCU: uInt32  = $00000002;  // Time stamp fine or coarse update 
  ETH_PTPTSCR_TSE: uInt32  = $00000001;  // Time stamp enable 

{ Bit definition for Ethernet PTP Sub-Second Increment Register }
  ETH_PTPSSIR_STSSI: uInt32  = $000000FF;  // System time Sub-second increment value 

{ Bit definition for Ethernet PTP Time Stamp High Register }
  ETH_PTPTSHR_STS: uInt32  = $FFFFFFFF;  // System Time second 

{ Bit definition for Ethernet PTP Time Stamp Low Register }
  ETH_PTPTSLR_STPNS: uInt32  = $80000000;  // System Time Positive or negative time 
  ETH_PTPTSLR_STSS: uInt32  = $7FFFFFFF;  // System Time sub-seconds 

{ Bit definition for Ethernet PTP Time Stamp High Update Register }
  ETH_PTPTSHUR_TSUS: uInt32  = $FFFFFFFF;  // Time stamp update seconds 

{ Bit definition for Ethernet PTP Time Stamp Low Update Register }
  ETH_PTPTSLUR_TSUPNS: uInt32  = $80000000;  // Time stamp update Positive or negative time 
  ETH_PTPTSLUR_TSUSS: uInt32  = $7FFFFFFF;  // Time stamp update sub-seconds 

{ Bit definition for Ethernet PTP Time Stamp Addend Register }
  ETH_PTPTSAR_TSA: uInt32  = $FFFFFFFF;  // Time stamp addend 

{ Bit definition for Ethernet PTP Target Time High Register }
  ETH_PTPTTHR_TTSH: uInt32  = $FFFFFFFF;  // Target time stamp high 

{ Bit definition for Ethernet PTP Target Time Low Register }
  ETH_PTPTTLR_TTSL: uInt32  = $FFFFFFFF;  // Target time stamp low 

{****************************************************************************}
{                 Ethernet DMA Registers bits definition                     }
{****************************************************************************}

{ Bit definition for Ethernet DMA Bus Mode Register }
  ETH_DMABMR_AAB: uInt32  = $02000000;  // Address-Aligned beats 
  ETH_DMABMR_FPM: uInt32  = $01000000;  // 4xPBL mode 
  ETH_DMABMR_USP: uInt32  = $00800000;  // Use separate PBL 
  ETH_DMABMR_RDP: uInt32  = $007E0000;  // RxDMA PBL 
  ETH_DMABMR_RDP_1Beat: uInt32  = $00020000;  // maximum number of beats to be transferred in one RxDMA transaction is 1 
  ETH_DMABMR_RDP_2Beat: uInt32  = $00040000;  // maximum number of beats to be transferred in one RxDMA transaction is 2 
  ETH_DMABMR_RDP_4Beat: uInt32  = $00080000;  // maximum number of beats to be transferred in one RxDMA transaction is 4 
  ETH_DMABMR_RDP_8Beat: uInt32  = $00100000;  // maximum number of beats to be transferred in one RxDMA transaction is 8 
  ETH_DMABMR_RDP_16Beat: uInt32  = $00200000;  // maximum number of beats to be transferred in one RxDMA transaction is 16 
  ETH_DMABMR_RDP_32Beat: uInt32  = $00400000;  // maximum number of beats to be transferred in one RxDMA transaction is 32 
  ETH_DMABMR_RDP_4xPBL_4Beat: uInt32  = $01020000;  // maximum number of beats to be transferred in one RxDMA transaction is 4 
  ETH_DMABMR_RDP_4xPBL_8Beat: uInt32  = $01040000;  // maximum number of beats to be transferred in one RxDMA transaction is 8 
  ETH_DMABMR_RDP_4xPBL_16Beat: uInt32  = $01080000;  // maximum number of beats to be transferred in one RxDMA transaction is 16 
  ETH_DMABMR_RDP_4xPBL_32Beat: uInt32  = $01100000;  // maximum number of beats to be transferred in one RxDMA transaction is 32 
  ETH_DMABMR_RDP_4xPBL_64Beat: uInt32  = $01200000;  // maximum number of beats to be transferred in one RxDMA transaction is 64 
  ETH_DMABMR_RDP_4xPBL_128Beat: uInt32  = $01400000;  // maximum number of beats to be transferred in one RxDMA transaction is 128 
  ETH_DMABMR_FB: uInt32  = $00010000;  // Fixed Burst 
  ETH_DMABMR_RTPR: uInt32  = $0000C000;  // Rx Tx priority ratio 
  ETH_DMABMR_RTPR_1_1: uInt32  = $00000000;  // Rx Tx priority ratio 
  ETH_DMABMR_RTPR_2_1: uInt32  = $00004000;  // Rx Tx priority ratio 
  ETH_DMABMR_RTPR_3_1: uInt32  = $00008000;  // Rx Tx priority ratio 
  ETH_DMABMR_RTPR_4_1: uInt32  = $0000C000;  // Rx Tx priority ratio 
  ETH_DMABMR_PBL: uInt32  = $00003F00;  // Programmable burst length 
  ETH_DMABMR_PBL_1Beat: uInt32  = $00000100;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 1 
  ETH_DMABMR_PBL_2Beat: uInt32  = $00000200;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 2 
  ETH_DMABMR_PBL_4Beat: uInt32  = $00000400;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 4 
  ETH_DMABMR_PBL_8Beat: uInt32  = $00000800;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 8 
  ETH_DMABMR_PBL_16Beat: uInt32  = $00001000;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 16 
  ETH_DMABMR_PBL_32Beat: uInt32  = $00002000;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 32 
  ETH_DMABMR_PBL_4xPBL_4Beat: uInt32  = $01000100;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 4 
  ETH_DMABMR_PBL_4xPBL_8Beat: uInt32  = $01000200;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 8 
  ETH_DMABMR_PBL_4xPBL_16Beat: uInt32  = $01000400;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 16 
  ETH_DMABMR_PBL_4xPBL_32Beat: uInt32  = $01000800;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 32 
  ETH_DMABMR_PBL_4xPBL_64Beat: uInt32  = $01001000;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 64 
  ETH_DMABMR_PBL_4xPBL_128Beat: uInt32  = $01002000;  // maximum number of beats to be transferred in one TxDMA (or both) transaction is 128 
  ETH_DMABMR_DSL: uInt32  = $0000007C;  // Descriptor Skip Length 
  ETH_DMABMR_DA: uInt32  = $00000002;  // DMA arbitration scheme 
  ETH_DMABMR_SR: uInt32  = $00000001;  // Software reset 

{ Bit definition for Ethernet DMA Transmit Poll Demand Register }
  ETH_DMATPDR_TPD: uInt32  = $FFFFFFFF;  // Transmit poll demand 

{ Bit definition for Ethernet DMA Receive Poll Demand Register }
  ETH_DMARPDR_RPD: uInt32  = $FFFFFFFF;  // Receive poll demand  

{ Bit definition for Ethernet DMA Receive Descriptor List Address Register }
  ETH_DMARDLAR_SRL: uInt32  = $FFFFFFFF;  // Start of receive list 

{ Bit definition for Ethernet DMA Transmit Descriptor List Address Register }
  ETH_DMATDLAR_STL: uInt32  = $FFFFFFFF;  // Start of transmit list 

{ Bit definition for Ethernet DMA Status Register }
  ETH_DMASR_TSTS: uInt32  = $20000000;  // Time-stamp trigger status 
  ETH_DMASR_PMTS: uInt32  = $10000000;  // PMT status 
  ETH_DMASR_MMCS: uInt32  = $08000000;  // MMC status 
  ETH_DMASR_EBS: uInt32  = $03800000;  // Error bits status 
  { combination with EBS[2:0] for GetFlagStatus function }
  ETH_DMASR_EBS_DescAccess: uInt32  = $02000000;  // Error bits 0-data buffer, 1-desc. access 
  ETH_DMASR_EBS_ReadTransf: uInt32  = $01000000;  // Error bits 0-write trnsf, 1-read transfr 
  ETH_DMASR_EBS_DataTransfTx: uInt32  = $00800000;  // Error bits 0-Rx DMA, 1-Tx DMA 
  ETH_DMASR_TPS: uInt32  = $00700000;  // Transmit process state 
  ETH_DMASR_TPS_Stopped: uInt32  = $00000000;  // Stopped - Reset or Stop Tx Command issued  
  ETH_DMASR_TPS_Fetching: uInt32  = $00100000;  // Running - fetching the Tx descriptor 
  ETH_DMASR_TPS_Waiting: uInt32  = $00200000;  // Running - waiting for status 
  ETH_DMASR_TPS_Reading: uInt32  = $00300000;  // Running - reading the data from host memory 
  ETH_DMASR_TPS_Suspended: uInt32  = $00600000;  // Suspended - Tx Descriptor unavailabe 
  ETH_DMASR_TPS_Closing: uInt32  = $00700000;  // Running - closing Rx descriptor 
  ETH_DMASR_RPS: uInt32  = $000E0000;  // Receive process state 
  ETH_DMASR_RPS_Stopped: uInt32  = $00000000;  // Stopped - Reset or Stop Rx Command issued 
  ETH_DMASR_RPS_Fetching: uInt32  = $00020000;  // Running - fetching the Rx descriptor 
  ETH_DMASR_RPS_Waiting: uInt32  = $00060000;  // Running - waiting for packet 
  ETH_DMASR_RPS_Suspended: uInt32  = $00080000;  // Suspended - Rx Descriptor unavailable 
  ETH_DMASR_RPS_Closing: uInt32  = $000A0000;  // Running - closing descriptor 
  ETH_DMASR_RPS_Queuing: uInt32  = $000E0000;  // Running - queuing the recieve frame into host memory 
  ETH_DMASR_NIS: uInt32  = $00010000;  // Normal interrupt summary 
  ETH_DMASR_AIS: uInt32  = $00008000;  // Abnormal interrupt summary 
  ETH_DMASR_ERS: uInt32  = $00004000;  // Early receive status 
  ETH_DMASR_FBES: uInt32  = $00002000;  // Fatal bus error status 
  ETH_DMASR_ETS: uInt32  = $00000400;  // Early transmit status 
  ETH_DMASR_RWTS: uInt32  = $00000200;  // Receive watchdog timeout status 
  ETH_DMASR_RPSS: uInt32  = $00000100;  // Receive process stopped status 
  ETH_DMASR_RBUS: uInt32  = $00000080;  // Receive buffer unavailable status 
  ETH_DMASR_RS: uInt32  = $00000040;  // Receive status 
  ETH_DMASR_TUS: uInt32  = $00000020;  // Transmit underflow status 
  ETH_DMASR_ROS: uInt32  = $00000010;  // Receive overflow status 
  ETH_DMASR_TJTS: uInt32  = $00000008;  // Transmit jabber timeout status 
  ETH_DMASR_TBUS: uInt32  = $00000004;  // Transmit buffer unavailable status 
  ETH_DMASR_TPSS: uInt32  = $00000002;  // Transmit process stopped status 
  ETH_DMASR_TS: uInt32  = $00000001;  // Transmit status 

{ Bit definition for Ethernet DMA Operation Mode Register }
  ETH_DMAOMR_DTCEFD: uInt32  = $04000000;  // Disable Dropping of TCP/IP checksum error frames 
  ETH_DMAOMR_RSF: uInt32  = $02000000;  // Receive store and forward 
  ETH_DMAOMR_DFRF: uInt32  = $01000000;  // Disable flushing of received frames 
  ETH_DMAOMR_TSF: uInt32  = $00200000;  // Transmit store and forward 
  ETH_DMAOMR_FTF: uInt32  = $00100000;  // Flush transmit FIFO 
  ETH_DMAOMR_TTC: uInt32  = $0001C000;  // Transmit threshold control 
  ETH_DMAOMR_TTC_64Bytes: uInt32  = $00000000;  // threshold level of the MTL Transmit FIFO is 64 Bytes 
  ETH_DMAOMR_TTC_128Bytes: uInt32  = $00004000;  // threshold level of the MTL Transmit FIFO is 128 Bytes 
  ETH_DMAOMR_TTC_192Bytes: uInt32  = $00008000;  // threshold level of the MTL Transmit FIFO is 192 Bytes 
  ETH_DMAOMR_TTC_256Bytes: uInt32  = $0000C000;  // threshold level of the MTL Transmit FIFO is 256 Bytes 
  ETH_DMAOMR_TTC_40Bytes: uInt32  = $00010000;  // threshold level of the MTL Transmit FIFO is 40 Bytes 
  ETH_DMAOMR_TTC_32Bytes: uInt32  = $00014000;  // threshold level of the MTL Transmit FIFO is 32 Bytes 
  ETH_DMAOMR_TTC_24Bytes: uInt32  = $00018000;  // threshold level of the MTL Transmit FIFO is 24 Bytes 
  ETH_DMAOMR_TTC_16Bytes: uInt32  = $0001C000;  // threshold level of the MTL Transmit FIFO is 16 Bytes 
  ETH_DMAOMR_ST: uInt32  = $00002000;  // Start/stop transmission command 
  ETH_DMAOMR_FEF: uInt32  = $00000080;  // Forward error frames 
  ETH_DMAOMR_FUGF: uInt32  = $00000040;  // Forward undersized good frames 
  ETH_DMAOMR_RTC: uInt32  = $00000018;  // receive threshold control 
  ETH_DMAOMR_RTC_64Bytes: uInt32  = $00000000;  // threshold level of the MTL Receive FIFO is 64 Bytes 
  ETH_DMAOMR_RTC_32Bytes: uInt32  = $00000008;  // threshold level of the MTL Receive FIFO is 32 Bytes 
  ETH_DMAOMR_RTC_96Bytes: uInt32  = $00000010;  // threshold level of the MTL Receive FIFO is 96 Bytes 
  ETH_DMAOMR_RTC_128Bytes: uInt32  = $00000018;  // threshold level of the MTL Receive FIFO is 128 Bytes 
  ETH_DMAOMR_OSF: uInt32  = $00000004;  // operate on second frame 
  ETH_DMAOMR_SR: uInt32  = $00000002;  // Start/stop receive 

{ Bit definition for Ethernet DMA Interrupt Enable Register }
  ETH_DMAIER_NISE: uInt32  = $00010000;  // Normal interrupt summary enable 
  ETH_DMAIER_AISE: uInt32  = $00008000;  // Abnormal interrupt summary enable 
  ETH_DMAIER_ERIE: uInt32  = $00004000;  // Early receive interrupt enable 
  ETH_DMAIER_FBEIE: uInt32  = $00002000;  // Fatal bus error interrupt enable 
  ETH_DMAIER_ETIE: uInt32  = $00000400;  // Early transmit interrupt enable 
  ETH_DMAIER_RWTIE: uInt32  = $00000200;  // Receive watchdog timeout interrupt enable 
  ETH_DMAIER_RPSIE: uInt32  = $00000100;  // Receive process stopped interrupt enable 
  ETH_DMAIER_RBUIE: uInt32  = $00000080;  // Receive buffer unavailable interrupt enable 
  ETH_DMAIER_RIE: uInt32  = $00000040;  // Receive interrupt enable 
  ETH_DMAIER_TUIE: uInt32  = $00000020;  // Transmit Underflow interrupt enable 
  ETH_DMAIER_ROIE: uInt32  = $00000010;  // Receive Overflow interrupt enable 
  ETH_DMAIER_TJTIE: uInt32  = $00000008;  // Transmit jabber timeout interrupt enable 
  ETH_DMAIER_TBUIE: uInt32  = $00000004;  // Transmit buffer unavailable interrupt enable 
  ETH_DMAIER_TPSIE: uInt32  = $00000002;  // Transmit process stopped interrupt enable 
  ETH_DMAIER_TIE: uInt32  = $00000001;  // Transmit interrupt enable 

{ Bit definition for Ethernet DMA Missed Frame and Buffer Overflow Counter Register }
  ETH_DMAMFBOCR_OFOC: uInt32  = $10000000;  // Overflow bit for FIFO overflow counter 
  ETH_DMAMFBOCR_MFA: uInt32  = $0FFE0000;  // Number of frames missed by the application 
  ETH_DMAMFBOCR_OMFC: uInt32  = $00010000;  // Overflow bit for missed frame counter 
  ETH_DMAMFBOCR_MFC: uInt32  = $0000FFFF;  // Number of frames missed by the controller 

{ Bit definition for Ethernet DMA Current Host Transmit Descriptor Register }
  ETH_DMACHTDR_HTDAP: uInt32  = $FFFFFFFF;  // Host transmit descriptor address pointer 

{ Bit definition for Ethernet DMA Current Host Receive Descriptor Register }
  ETH_DMACHRDR_HRDAP: uInt32  = $FFFFFFFF;  // Host receive descriptor address pointer 

{ Bit definition for Ethernet DMA Current Host Transmit Buffer Address Register }
  ETH_DMACHTBAR_HTBAP: uInt32  = $FFFFFFFF;  // Host transmit buffer address pointer 

{ Bit definition for Ethernet DMA Current Host Receive Buffer Address Register }
  ETH_DMACHRBAR_HRBAP: uInt32  = $FFFFFFFF;  // Host receive buffer address pointer 
{$ENDIF} { STM32F10X_CL }


{****************** (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE***}
IMPLEMENTATION
end.

