unit pico_clocks_c;

{$mode ObjFPC}{$H+}

interface

uses
  pico_gpio_c;

{$IF DEFINED(DEBUG) or DEFINED(DEBUG_CLOCKS)}
{$L clocks.c-debug.obj}
{$ELSE}
{$L clocks.c.obj}
{$ENDIF}

const
  KHZ=1000;
  MHZ=1000000;
type
  Tclock_index = (
    clk_gpout0 = 0,     ///< GPIO Muxing 0
    clk_gpout1,         ///< GPIO Muxing 1
    clk_gpout2,         ///< GPIO Muxing 2
    clk_gpout3,         ///< GPIO Muxing 3
    clk_ref,            ///< Watchdog and timers reference clock
    clk_sys,            ///< Processors, bus fabric, memory, memory mapped registers
    clk_peri,           ///< Peripheral clock for UART and SPI
    clk_usb,            ///< USB clock
    clk_adc,            ///< ADC clock
    clk_rtc,            ///< Real time clock
    CLK_COUNT
  );

(*
  Initialise the clock hardware
  Must be called before any other clock function.
 *)
procedure clocks_init; cdecl; external;

(*
  Configure the specified clock
  See the tables in the description for details on the possible values for clock sources.
param
  clk_index The clock to configure
  src The main clock source, can be 0.
  auxsrc The auxiliary clock source, which depends on which clock is being set. Can be 0
  src_freq Frequency of the input clock source
  freq Requested frequency
 *)
function clock_configure(clk_index: Tclock_index; src : longWord; auxsrc : longWord; src_freq : longWord; freq : longWord):boolean; cdecl; external;

(*
  Stop the specified clock
param
  clk_index The clock to stop
 *)
procedure clock_stop(clk_index : Tclock_index); cdecl; external;

(*
  Get the current frequency of the specified clock
param
  clk_index Clock
return
  Clock frequency in Hz
 *)
function clock_get_hz(clk_index: Tclock_index ):longWord; cdecl; external;

(*
  Measure a clocks frequency using the Frequency counter.
  Uses the inbuilt frequency counter to measure the specified clocks frequency.
  Currently, this function is accurate to +-1KHz. See the datasheet for more details.
 *)
function frequency_count_khz(src : longWord):longWord; cdecl; external;

(*
  Set the "current frequency" of the clock as reported by clock_get_hz without actually changing the clock
  see clock_get_hz()
 *)
procedure clock_set_reported_hz(clk_index : Tclock_index; hz : longWord); cdecl; external;

function frequency_count_mhz(src : longWord):real;

(*
  Resus callback function type.
  User provided callback for a resus event (when clk_sys is stopped by the programmer and is restarted for them).
 *)

type
  Tresus_callback = procedure;

(*
  Enable the resus function. Restarts clk_sys if it is accidentally stopped.
  The resuscitate function will restart the system clock if it falls below a certain speed (or stops). This
  could happen if the clock source the system clock is running from stops. For example if a PLL is stopped.
param
  resus_callback a function pointer provided by the user to call if a resus event happens.
 *)
procedure clocks_enable_resus(resus_callback : Tresus_callback); cdecl; external;

(*
  Output an optionally divided clock to the specified gpio pin.
param
  gpio The GPIO pin to output the clock to. Valid GPIOs are: 21, 23, 24, 25. These GPIOs are connected to the GPOUT0-3 clock generators.
  src  The source clock. See the register field CLOCKS_CLK_GPOUT0_CTRL_AUXSRC for a full list. The list is the same for each GPOUT clock generator.
  div  The amount to divide the source clock by. This is useful to not overwhelm the GPIO pin with a fast clock.
 *)
procedure clock_gpio_init(gpio : TPinIdentifier; src : longWord; &div : longWord); cdecl; external;

(*
  Configure a clock to come from a gpio input
param
  clk_index The clock to configure
  gpio The GPIO pin to run the clock from. Valid GPIOs are: 20 and 22.
  src_freq Frequency of the input clock source
  freq Requested frequency
 *)
function clock_configure_gpin(clk_index : Tclock_index; gpio : TPinIdentifier; src_freq :  longWord; freq : longword):boolean; cdecl; external;

implementation

function frequency_count_mhz(src : longWord):real;
begin
  result := frequency_count_khz(src) / KHZ;
end;

end.

