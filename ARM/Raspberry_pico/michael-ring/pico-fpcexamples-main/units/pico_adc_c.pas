unit pico_adc_c;
(*
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *)

{$mode objfpc}{$H+}
interface
uses
  pico_gpio_c,
  pico_c;

{$IF DEFINED(DEBUG) or DEFINED(DEBUG_ADC)}
{$L adc.c-debug.obj}
{$ELSE}
{$L adc.c.obj}
{$ENDIF}

(*
  Initialise the ADC HW
*)
procedure adc_init; cdecl; external;

(*
  Initialise the gpio for use as an ADC pin
  Prepare a GPIO for use with ADC, by disabling all digital functions.
param
  gpio The GPIO number to use. Allowable GPIO numbers are 26 to 29 inclusive.
*)
procedure adc_gpio_init(gpio:longWord);

(*
  ADC input select
  Select an ADC input. 0...3 are GPIOs 26...29 respectively.
  Input 4 is the onboard temperature sensor.
param
  input Input to select.
*)
procedure adc_select_input(input : longWord);

(*
  Round Robin sampling selector
  This function sets which inputs are to be run through in round robin mode.
  Value between 0 and 0x1f (bit 0 to bit 4 for GPIO 26 to 29 and temperature sensor input respectively)
param
  input_mask A bit pattern indicating which of the 5 inputs are to be sampled. Write a value of 0 to disable round robin sampling.
*)
procedure adc_set_round_robin(input_mask : longWord);

(*
  Enable the onboard temperature sensor
param
  enable Set true to power on the onboard temperature sensor, false to power off.
*)
procedure adc_set_temp_sensor_enabled(enable: boolean);

(*
  Perform a single conversion
  Performs an ADC conversion, waits for the result, and then returns it.
return
  Result of the conversion.
*)
function adc_read:word;

(*
  Enable or disable free-running sampling mode
param
  run false to disable, true to enable free running conversion mode.
*)
procedure adc_run(run:boolean);

(*
  Set the ADC Clock divisor
 Period of samples will be (1 + div) cycles on average. Note it takes 96 cycles to perform a conversion,
  so any period less than that will be clamped to 96.
param
  clkdiv If non-zero, conversion will be started at intervals rather than back to back.
*)
procedure adc_set_clkdiv(clkdiv : real);

(*
  Setup the ADC FIFO
  FIFO is 4 samples long, if a conversion is completed and the FIFO is full the result is dropped.
param
  en Enables write each conversion result to the FIFO
  dreq_en Enable DMA requests when FIFO contains data
  dreq_thresh Threshold for DMA requests/FIFO IRQ if enabled.
  err_in_fifo If enabled, bit 15 of the FIFO contains error flag for each sample
  byte_shift Shift FIFO contents to be one byte in size (for byte DMA) - enables DMA to byte buffers.
*)
procedure adc_fifo_setup(en : boolean; dreq_en : boolean; dreq_thresh : word; err_in_fifo:boolean; byte_shift:boolean);

(*
  Check FIFO empty state
return
  Returns true if the fifo is empty
*)
function adc_fifo_is_empty: boolean;

(*
  Get number of entries in the ADC FIFO
  The ADC FIFO is 4 entries long. This function will return how many samples are currently present.
*)
function adc_fifo_get_level: byte;

(*
  Get ADC result from FIFO
  Pops the latest result from the ADC FIFO.
*)
function adc_fifo_get:word;

(*
  Wait for the ADC FIFO to have data.
  Blocks until data is present in the FIFO
*)
function adc_fifo_get_blocking: word;

(*
  Drain the ADC FIFO
  Will wait for any conversion to complete then drain the FIFO discarding any results.
*)
procedure adc_fifo_drain;

(*
  Enable/Disable ADC interrupts.
param
  enabled Set to true to enable the ADC interrupts, false to disable
*)
procedure adc_irq_set_enabled(enabled:boolean);

implementation

procedure adc_gpio_init(gpio:longWord);
begin
  //invalid_params_if(ADC, gpio < 26 || gpio > 29);
  // Select NULL function to make output driver hi-Z
  gpio_set_function(gpio,TGPIOFunction.GPIO_FUNC_NULL);
  // Also disable digital pulls and digital receiver
  gpio_disable_pulls(gpio);
  gpio_set_input_enabled(gpio, false);
end;

procedure adc_select_input(input : longWord);
begin
  //invalid_params_if(ADC, input > 4);
  hw_write_masked(adc.cs,input shl 12,%111 shl 12);
end;

procedure adc_set_round_robin(input_mask : longWord);
begin
  //invalid_params_if(ADC, input_mask & ~0x001f0000);
  hw_write_masked(adc.cs,input_mask shl 16, %11111 shl 16);
end;

procedure adc_set_temp_sensor_enabled(enable: boolean);
begin
  if enable = true then
    hw_set_bits(adc.cs, 1 shl 1)
  else
    hw_clear_bits(adc.cs, 1 shl 1);
end;

function adc_read:word;
begin
  hw_set_bits(adc.cs, 1 shl 2);
  repeat
  until (adc.cs and (1 shl 8))<>0;
  result := adc.result;
end;

procedure adc_run(run:boolean);
begin
  if run=true then
    hw_set_bits(adc.cs, 1 shl 3)
  else
    hw_clear_bits(adc.cs, 1 shl 3);
end;

procedure adc_set_clkdiv(clkdiv : real);
begin
  //invalid_params_if(ADC, clkdiv >= 1 << (23 - 8 + 1));
  adc.&div := round(clkdiv * (1 shl 8));
end;

procedure adc_fifo_setup(en : boolean; dreq_en : boolean; dreq_thresh : word; err_in_fifo:boolean; byte_shift:boolean);
begin
  hw_write_masked(adc.fcs,
                  (longWord(en) shl 0)  + (longWord(byte_shift) shl 1) + (longWord(err_in_fifo) shl 2) +
                  (longWord(dreq_en) shl 3) + (longWord(dreq_thresh) shl 24),
                  (1 shl 0) + (1 shl 1) + (1 shl 2) + (1 shl 3) + %1111 shl 24);
end;

function adc_fifo_is_empty: boolean;
begin
  result := adc.fcs and (1 shl 8) <> 0;
end;

function adc_fifo_get_level: byte;
begin
  result := (adc.fcs and (%1111 shl 16)) shr 16;
end;

function adc_fifo_get:word;
begin
  result := adc.fifo;
end;

function adc_fifo_get_blocking:word;
begin
  repeat
  until adc_fifo_is_empty;
  result := adc.fifo;
end;

procedure adc_fifo_drain;
begin
  repeat
  until (adc.cs and (1 shl 8))=1;

  while not adc_fifo_is_empty do
    adc_fifo_get();
end;

procedure adc_irq_set_enabled(enabled:boolean);
begin
  adc.inte := longWord(enabled);
end;

end.
