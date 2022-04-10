unit pico_timer_c;
(*
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *)

{$mode objfpc}{$H+}
interface
uses
  pico_c;

{$IF DEFINED(DEBUG) or DEFINED(DEBUG_TIMER)}
{$L timer.c-debug.obj}
{$ELSE}
{$L timer.c.obj}
{$ENDIF}

type
  Thardware_alarm_callback = procedure(alarm_num:longWord);

//procedure check_hardware_alarm_num_param(alarm_num:longWord);
(*
  Return a 32 bit timestamp value in microseconds
  Returns the low 32 bits of the hardware timer.
return
  the 32 bit timestamp
note
  This value wraps roughly every 1 hour 11 minutes and 35 seconds.
*)
function time_us_32:longWord;

(*
  Return the current 64 bit timestamp value in microseconds
  Returns the full 64 bits of the hardware timer. The \ref pico_time and other functions rely on the fact that this
  value monotonically increases from power up. As such it is expected that this value counts upwards and never wraps
  (we apologize for introducing a potential year 5851444 bug).
return
  the 64 bit timestamp
*)
function time_us_64:int64;cdecl; external;

(*
  Busy wait wasting cycles for the given (32 bit) number of microseconds
param
  delay_us delay amount
*)
procedure busy_wait_us_32(delay_us:longWord);cdecl; external;

(*
  Busy wait wasting cycles for the given (64 bit) number of microseconds
param
  delay_us delay amount
*)
procedure busy_wait_us(delay_us:int64);cdecl; external;

(*
  Busy wait wasting cycles until after the specified timestamp
param
  t Absolute time to wait until
*)
procedure busy_wait_until(t : Tabsolute_time);cdecl; external;

(*
  Check if the specified timestamp has been reached
param
  t Absolute time to compare against current time
return
  true if it is now after the specified timestamp
*)
function time_reached(t : Tabsolute_time):boolean;

(*
  cooperatively claim the use of this hardware alarm_num
  This method hard asserts if the hardware alarm is currently claimed.
param
  alarm_num the hardware alarm to claim
*)
procedure hardware_alarm_claim(alarm_num:longWord); cdecl; external;

(*
  cooperatively release the claim on use of this hardware alarm_num
param
  alarm_num the hardware alarm to unclaim
*)
procedure hardware_alarm_unclaim(alarm_num:longWord); cdecl; external;

(*
  Enable/Disable a callback for a hardware timer on this core
  This method enables/disables the alarm IRQ for the specified hardware alarm on the
  calling core, and set the specified callback to be associated with that alarm.
  This callback will be used for the timeout set via hardware_alarm_set_target
param
  alarm_num the hardware alarm number
  callback the callback to install, or NULL to unset
note
  This will install the handler on the current core if the IRQ handler isn't already set.
  Therefore the user has the opportunity to call this up from the core of their choice
*)
procedure hardware_alarm_set_callback(alarm_num:longWord; callback : Thardware_alarm_callback); cdecl; external;

(*
  Set the current target for the specified hardware alarm
  This will replace any existing target
param
  alarm_num the hardware alarm number
  t the target timestamp
return
  true if the target was "missed"; i.e. it was in the past, or occurred before a future hardware timeout could be set
*)
function hardware_alarm_set_target(alarm_num : longWord; t : Tabsolute_time):boolean; cdecl; external;

(*
  Cancel an existing target (if any) for a given hardware_alarm
param
  alarm_num
*)
procedure hardware_alarm_cancel(alarm_num:longWord); cdecl; external;

implementation

//procedure check_hardware_alarm_num_param(alarm_num:longWord);
//begin
  //invalid_params_if(TIMER, alarm_num >= 4);
//end;

function time_us_32:longWord;
begin
  result := timer.timerawl;
end;

function time_reached(t : Tabsolute_time):boolean;
var
  target : int64;
  hi_target : longWord;
  hi : longWord;
begin
  target := to_us_since_boot(t);
  hi_target := target shr 32;
  hi := timer.timerawh;
  result := (hi >= hi_target) and ((timer.timerawl >= target) or (hi <> hi_target));
end;

end.
