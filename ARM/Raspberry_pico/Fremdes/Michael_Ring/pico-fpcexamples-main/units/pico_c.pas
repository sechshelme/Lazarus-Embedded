unit pico_c;
{$mode objfpc}
{$H+}
{$modeswitch advancedrecords}
{$SCOPEDENUMS ON}

{$IF DEFINED(DEBUG) or DEFINED(DEBUG_CORE)}
{$L platform.c-debug.obj}
{$L claim.c-debug.obj}
{$L clocks.c-debug.obj}
{$L xosc.c-debug.obj}
{$L pll.c-debug.obj}
{$L watchdog.c-debug.obj}
{$L irq.c-debug.obj}
{$ELSE}
{$L platform.c.obj}
{$L claim.c.obj}
{$L clocks.c.obj}
{$L xosc.c.obj}
{$L pll.c.obj}
{$L watchdog.c.obj}
{$L irq.c.obj}
{$ENDIF}

// A (usually) device specific 2nd Stage Bootloader is required to initialize the Quad-SPI Flash and Cache of RP2040 based boards
// To build a 2nd Stage bootloader for a new board that is supported by pico-sdk do:
// export PICO_SDK_PATH=<path of your pico-sdk>
// cd pico-examples
// mkdir build
// cd build
// PICO_BOARD=<Name of the board> cmake -DCMAKE_BUILD_TYPE=Release ..
// make blink 
// mkdir units
// arm-none-eabi-as pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S -o units/boot2_<Name of board>.obj
// You can find the name of a board by looking at the directory ./src/boards/include/boards/
// Example:
// ./src/boards/include/boards/adafruit_feather_rp2040.h --> <Name of board> is adafruit_feather_rp2040

{$IF DEFINED(FPC_MCU_FEATHER_RP2040)}
  {$L boot2_adafruit_feather_rp2040.obj}
{$ELSEIF DEFINED(FPC_MCU_ITSYBITSY_RP2040)}
  {$L boot2_adafruit_itsybitsy_rp2040.obj}
{$ELSEIF DEFINED(FPC_MCU_QTPY_RP2040)}
  {$L boot2_adafruit_qtpy_rp2040.obj}
{$ELSEIF DEFINED(FPC_MCU_TINY_2040)}
  {$L boot2_pimoroni_tiny2040.obj}
{$ELSE}
  {$L boot2_pico.obj}
{$ENDIF}

{$LinkLib gcc-armv6m,static}

interface
uses
  heapmgr;

type 
  TByteArray = array of Byte;

  TPicoError = record
  const
    NO_DATA = -3;
    &GENERIC = -2;
    TIMEOUT = -1;
    OK = 0;
    NONE = 0;
  end;

const
  PICO_OK = 0;
  PICO_ERROR_NONE = 0;
  PICO_ERROR_TIMEOUT = -1;
  PICO_ERROR_GENERIC = -2;
  PICO_ERROR_NO_DATA = -3;

(*
  Structure containing date and time information
  When setting an RTC alarm, set a field to -1 tells</b>
  the RTC to not match on this field
*)
type TPicoDatetime = record
  year:word;    //< 0..4095
  month: 1..12; //< 1..12, 1 is January
  day: 1..31;   //< 1..28,29,30,31 depending on month
  dotw: 0..6;   //< 0..6, 0 is Sunday
  hour: 0..23;  //< 0..23
  min: 0..59;   //< 0..59
  sec: 0..59;   //< 0..59
end;

type
  Tabsolute_time = record
    _private_us_since_boot : int64;
  end;


procedure clocks_init; cdecl; external;
procedure runtime_init;
procedure hard_assertion_failure; public name 'hard_assertion_failure';
procedure __unhandled_user_irq; public name '__unhandled_user_irq';
procedure __assert_func; public name '__assert_func';
procedure panic(fmt: PAnsiChar; Args: Array of const); public name 'panic';
(*
  convert an absolute_time_t into a number of microseconds since boot.
param:
  t the number of microseconds since boot
return:
  return an absolute_time_t value equivalent to t
*)
function to_us_since_boot(t :  Tabsolute_time):int64;

(*
  update an absolute_time_t value to represent a given number of microseconds since boot
param:
  t the absolute time value to update
  us_since_boot the number of microseconds since boot to represent
*)
procedure update_us_since_boot(var t : Tabsolute_time; us_since_boot:int64);

(*
  Atomically set the specified bits to 1 in a HW register
param:
  addr Address of writable register
  mask Bit-mask specifying bits to set
*)
procedure hw_set_bits(var register : longWord; mask : longWord);

(*
  Atomically clear the specified bits to 0 in a HW register
param:
  addr Address of writable register
  mask Bit-mask specifying bits to clear
*)
procedure hw_clear_bits(var register : longWord;mask:longWord);

(*
  Atomically flip the specified bits in a HW register
param:
  addr Address of writable register
  mask Bit-mask specifying bits to invert
*)
procedure hw_xor_bits(var register : longWord;mask:longWord);

(*
  Set new values for a sub-set of the bits in a HW register
  Note: this method allows safe concurrent modification of *different* bits of
  a register, but multiple concurrent access to the same bits is still unsafe.
param:
  addr Address of writable register
  values Bits values
  write_mask Mask of bits to change
*)
procedure hw_write_masked(var register : longWord; values : longWord; write_mask:longWord);

implementation

procedure hard_assertion_failure;
begin
  Halt;
end;

procedure __unhandled_user_irq;
begin
  Halt;
end;

procedure __assert_func;
begin
  Halt;
end;

procedure panic(fmt: PAnsiChar; Args: Array of const);
begin
  Halt;
end;

function to_us_since_boot(t : Tabsolute_time):int64;
begin
  result := t._private_us_since_boot;
end;

procedure update_us_since_boot(var t : Tabsolute_time; us_since_boot:int64);
begin
  t._private_us_since_boot := us_since_boot;
end;

procedure runtime_init;
const
  RESETS_SAFE_BITS=     %1111111111100110110111111;
  RESETS_PRECLOCK_BITS= %0001111000100110110111110;
  RESETS_POSTCLOCK_BITS=%1110000111000000000000001;
begin
  hw_set_bits(resets.reset,RESETS_SAFE_BITS);
  hw_clear_bits(resets.reset,RESETS_PRECLOCK_BITS);
  repeat
  until (resets.reset_done and RESETS_PRECLOCK_BITS) = RESETS_PRECLOCK_BITS;
  clocks_init;
  hw_clear_bits(resets.reset,RESETS_POSTCLOCK_BITS);
  repeat
  until (resets.reset_done and RESETS_POSTCLOCK_BITS) = RESETS_POSTCLOCK_BITS;
end;

procedure hw_set_bits(var Register : longWord; mask:longWord);
begin
  pLongWord(pointer(@Register)+$2000)^ := mask;
end;

procedure hw_clear_bits(var Register : longWord; mask:longWord);
begin
  pLongWord(pointer(@Register) + $3000)^ := mask;
end;

procedure hw_xor_bits(var Register : longWord; mask:longWord);
begin
  pLongWord(pointer(@Register) + $1000)^ := mask;
end;

procedure hw_write_masked(var Register : longWord; values : longWord; write_mask:longWord);
begin
  Register := (Register and not write_mask) or values;
end;

begin
  runtime_init;
end.

