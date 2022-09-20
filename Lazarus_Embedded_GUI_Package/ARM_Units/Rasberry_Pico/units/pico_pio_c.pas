unit pico_pio_c;
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

{$IF DEFINED(DEBUG) or DEFINED(DEBUG_PIO)}
{$L pio.c-debug.obj}
{$ELSE}
{$L pio.c.obj}
{$ENDIF}

type
  Tpio_fifo_join = (
    PIO_FIFO_JOIN_NONE = 0,
    PIO_FIFO_JOIN_TX = 1,
    PIO_FIFO_JOIN_RX = 2
  );

  Tpio_mov_status_type = (
    STATUS_TX_LESSTHAN = 0,
    STATUS_RX_LESSTHAN = 1
  );

  Tpio_sm_config = record
    clkdiv : longWord;
    execctrl : longWord;
    shiftctrl : longWord;
    pinctrl : longWord;
  end;

  Tpio_program = record
    instructions : pword;
    length : byte;
    origin : byte; // required instruction memory origin or -1
  end;

(*
  Set the 'out' pins in a state machine configuration
  Can overlap with the 'in', 'set' and 'sideset' pins
param 
  c Pointer to the configuration structure to modify
  out_base 0-31 First pin to set as output
  out_count 0-32 Number of pins to set.
*)
procedure sm_config_set_out_pins(var c : Tpio_sm_config; out_base : longWord; out_count : longWord);
(*
   Set the 'set' pins in a state machine configuration
   Can overlap with the 'in', 'out' and 'sideset' pins
 param 
   c Pointer to the configuration structure to modify
   set_base 0-31 First pin to set as
   set_count 0-5 Number of pins to set.
 *)
procedure sm_config_set_set_pins(var c : Tpio_sm_config;set_base : longWord; set_count : longWord);

(*
  Set the 'in' pins in a state machine configuration
  Can overlap with the 'out', ''set' and 'sideset' pins
param 
  c Pointer to the configuration structure to modify
  in_base 0-31 First pin to use as input
 *)
procedure sm_config_set_in_pins(var c : Tpio_sm_config; in_base : longWord);

(*
  Set the 'sideset' pins in a state machine configuration
  Can overlap with the 'in', 'out' and 'set' pins
param 
  c Pointer to the configuration structure to modify
  sideset_base 0-31 base pin for 'side set'
 *)
procedure sm_config_set_sideset_pins(var c : Tpio_sm_config; sideset_base:longWord);

(*
  Set the 'sideset' options in a state machine configuration
 param 
   c Pointer to the configuration structure to modify
   bit_count Number of bits to steal from delay field in the instruction for use of side set (max 5)
   optional True if the topmost side set bit is used as a flag for whether to apply side set on that instruction
   pindirs True if the side set affects pin directions rather than values
 *)
procedure sm_config_set_sideset(var c : Tpio_sm_config; bit_count : longWord; optional : boolean; pindirs : boolean);

(*
   Set the state machine clock divider (from integer and fractional parts - 16:8) in a state machine configuration
   The clock divider can slow the state machine's execution to some rate below
   the system clock frequency, by enabling the state machine on some cycles
   but not on others, in a regular pattern. This can be used to generate e.g.
   a given UART baud rate. See the datasheet for further detail.
 
 param 
   c Pointer to the configuration structure to modify
   div_int Integer part of the divisor
   div_frac Fractional part in 1/256ths
   see also sm_config_set_clkdiv
 *)
procedure sm_config_set_clkdiv_int_frac(var c : Tpio_sm_config; div_int : word; div_frac : byte);

procedure pio_calculate_clkdiv_from_float(&div : real; out div_int : word; out div_frac : byte);

(*
  Set the state machine clock divider (from a floating point value) in a state machine configuration

  The clock divider slows the state machine's execution by masking the
   system clock on some cycles, in a repeating pattern, so that the state
   machine does not advance. Effectively this produces a slower clock for the
   state machine to run from, which can be used to generate e.g. a particular
   UART baud rate. See the datasheet for further detail.
param 
  c Pointer to the configuration structure to modify
   div The fractional divisor to be set. 1 for full speed. An integer clock divisor of n
       will cause the state machine to run 1 cycle in every n.
       Note that for small n, the jitter introduced by a fractional divider (e.g. 2.5) may be unacceptable
       although it will depend on the use case.
 *)
procedure sm_config_set_clkdiv(var c : Tpio_sm_config; &div : real);

(*
  Set the wrap addresses in a state machine configuration
param 
  c Pointer to the configuration structure to modify
   wrap_target the instruction memory address to wrap to
   wrap        the instruction memory address after which to set the program counter to wrap_target
               if the instruction does not itself update the program_counter
 *)
procedure sm_config_set_wrap(var c : Tpio_sm_config; wrap_target : longWord; wrap : longWord);

(*
  Set the 'jmp' pin in a state machine configuration
param 
  c Pointer to the configuration structure to modify
  pin The raw GPIO pin number to use as the source for a `jmp pin` instruction 
 *)
procedure sm_config_set_jmp_pin(var c : Tpio_sm_config; pin : TPinIdentifier);

(*
  Setup 'in' shifting parameters in a state machine configuration
param 
  c Pointer to the configuration structure to modify
  shift_right true to shift ISR to right, false to shift ISR to left
  autopush whether autopush is enabled
  push_threshold threshold in bits to shift in before auto/conditional re-pushing of the ISR  
 *)
procedure sm_config_set_in_shift(var c : Tpio_sm_config; shift_right : boolean; autopush : boolean; push_threshold : longWord);

(*
  Setup 'out' shifting parameters in a state machine configuration
param 
  c Pointer to the configuration structure to modify
   shift_right true to shift OSR to right, false to shift OSR to left
   autopull whether autopull is enabled
   pull_threshold threshold in bits to shift out before auto/conditional re-pulling of the OSR  
 *)
procedure sm_config_set_out_shift(var c : Tpio_sm_config; shift_right : boolean; autopull:boolean; pull_threshold : longWord);

(*
  Setup the FIFO joining in a state machine configuration
param 
  c Pointer to the configuration structure to modify
  join Specifies the join type. \see enum pio_fifo_join
 *)
procedure sm_config_set_fifo_join(var c : Tpio_sm_config; join : Tpio_fifo_join);

(*
  Set special 'out' operations in a state machine configuration
param 
  c Pointer to the configuration structure to modify
   sticky to enable 'sticky' output (i.e. re-asserting most recent OUT/SET pin values on subsequent cycles)
   has_enable_pin true to enable auxiliary OUT enable pin 
   enable_pin_index pin index for auxiliary OUT enable
 *)
procedure sm_config_set_out_special(var c : Tpio_sm_config; sticky : boolean; has_enable_pin : boolean; enable_pin_index : longWord);

(*
  Set source for 'mov status' in a state machine configuration
param 
  c Pointer to the configuration structure to modify
   status_sel the status operation selector. \see enum pio_mov_status_type
   status_n parameter for the mov status operation (currently a bit count)
 *)
procedure sm_config_set_mov_status(var c : Tpio_sm_config; status_sel : Tpio_mov_status_type; status_n : longWord);

(*
  Get the default state machine configuration
  Setting or Default
  --------or--------
  Out Pins or 32 starting at 0
  Set Pins or 0 starting at 0
   In Pins (base) or 0
   Side Set Pins (base) or 0
   Side Set or disabled
   Wrap or wrap=31, wrap_to=0
   In Shift or shift_direction=right, autopush=false, push_thrshold=32
   Out Shift or shift_direction=right, autopull=false, pull_thrshold=32
   Jmp Pin or 0
   Out Special or sticky=false, has_enable_pin=false, enable_pin_index=0 
   Mov Status or status_sel=STATUS_TX_LESSTHAN, n=0
  
 return 
   the default state machine configuration which can then be modified.
 *)
function pio_get_default_sm_config : Tpio_sm_config;

(*
  Apply a state machine configuration to a state machine
param 
  pio Handle to PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  config the configuration to apply
*)
procedure pio_sm_set_config(var pio : TPio_Registers; sm :  longWord; constref config : Tpio_sm_config);

(*
   Setup the function select for a GPIO to use output from the given PIO instance 
   PIO appears as an alternate function in the GPIO muxing, just like an SPI
   or UART. This function configures that multiplexing to connect a given PIO
   instance to a GPIO. Note that this is not necessary for a state machine to
   be able to read the *input* value from a GPIO, but only for it to set the
   output value or output enable.
 param 
   pio The PIO instance; either \ref pio0 or \ref pio1
   pin the GPIO pin whose function select to set
 *)
procedure pio_gpio_init(var pio : TPIO_Registers; pin : TPinIdentifier);

(*
  Return the DREQ to use for pacing transfers to a particular state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  is_tx true for sending data to the state machine, false for received data from the state machine
 *)
function pio_get_dreq(var pio : TPio_Registers; sm : longWord; is_tx : boolean):longWord;

(*
  Determine whether the given program can (at the time of the call) be loaded onto the PIO instance
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
   program the program definition
 return 
   true if the program can be loaded; false if there is not suitable space in the instruction memory
 *)
function pio_can_add_program(var pio : TPio_Registers; constref &program : Tpio_program):boolean; cdecl; external;

(*
  Determine whether the given program can (at the time of the call) be loaded onto the PIO instance starting at a particular location
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  program the program definition
  offset the instruction memory offset wanted for the start of the program
return 
  true if the program can be loaded at that location; false if there is not space in the instruction memory
 *)
function pio_can_add_program_at_offset(var pio : TPio_Registers; constref &program : Tpio_program; offset : longWord):boolean; cdecl; external;

(*
  Attempt to load the program, panicking if not possible
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  program the program definition
return 
  the instruction memory offset the program is loaded at
 *)
function pio_add_program(var pio : TPio_Registers; constref &program : Tpio_program):longWord; cdecl; external;

(*
  Attempt to load the program at the specified instruction memory offset, panicking if not possible
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  program the program definition
  offset the instruction memory offset wanted for the start of the program
 *)
procedure pio_add_program_at_offset(var pio : TPIO_Registers; constref &program : Tpio_program; offset : longWord); cdecl; external;

(*
  Remove a program from a PIO instance's instruction memory
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  program the program definition
  loaded_offset the loaded offset returned when the program was added
 *)
procedure pio_remove_program(var pio : TPIO_Registers; constref &program : Tpio_program; loaded_offset : longWord); cdecl; external;

(*
  Clears all of a PIO instance's instruction memory
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
 *)
procedure pio_clear_instruction_memory(var pio : TPIO_Registers); cdecl; external;

(*
  Resets the state machine to a consistent state, and configures it
  This method:
  - Disables the state machine (if running)
  - Clears the FIFOs
  - Applies the configuration specified by 'config'
  - Resets any internal state e.g. shift counters
  - Jumps to the initial program location given by 'initial_pc'
  The state machine is left disabled on return from this call.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  initial_pc the initial program memory offset to run from
  config the configuration to apply (or NULL to apply defaults)
 *)
procedure pio_sm_init(var pio : TPIO_Registers; sm : longWord; initial_pc : longWord; constref config : Tpio_sm_config); cdecl; external;

(*
  Enable or disable a PIO state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  enabled true to enable the state machine; false to disable
 *)
procedure pio_sm_set_enabled(var pio : TPIO_Registers; sm : longWord; enabled:boolean);

(*
  Enable or disable multiple PIO state machines
  Note that this method just sets the enabled state of the state machine;
  if now enabled they continue exactly from where they left off.
 
  \see pio_enable_sm_mask_in_sync() if you wish to enable multiple state machines
  and ensure their clock dividers are in sync.
 
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
  enabled true to enable the state machines; false to disable
 *)
procedure pio_set_sm_mask_enabled(var pio : TPIO_Registers; mask : longWord; enabled : boolean);

(*
  Restart a state machine with a known state
  This method clears the ISR, shift counters, clock divider counter
  pin write flags, delay counter, latched EXEC instruction, and IRQ wait condition.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_restart(var pio : TPIO_Registers; sm : longWord);

(*
  Restart multiple state machine with a known state
  This method clears the ISR, shift counters, clock divider counter
  pin write flags, delay counter, latched EXEC instruction, and IRQ wait condition.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
 *)
procedure pio_restart_sm_mask(var pio : TPIO_Registers; mask : longWord);

(*
  Restart a state machine's clock divider from a phase of 0
  Each state machine's clock divider is a free-running piece of hardware,
  that generates a pattern of clock enable pulses for the state machine,
  based *only* on the configured integer/fractional divisor. The pattern of
  running/halted cycles slows the state machine's execution to some
  controlled rate.
 
  This function clears the divider's integer and fractional phase
  accumulators so that it restarts this pattern from the beginning. It is
  called automatically by pio_sm_init() but can also be called at a later
  time, when you enable the state machine, to ensure precisely consistent
  timing each time you load and run a given PIO program.
 
  More commonly this hardware mechanism is used to synchronise the execution
  clocks of multiple state machines -- see pio_clkdiv_restart_sm_mask().
 
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_clkdiv_restart(var pio : TPIO_Registers; sm : longWord);

(*
  Restart multiple state machines' clock dividers from a phase of 0.
  Each state machine's clock divider is a free-running piece of hardware,
  that generates a pattern of clock enable pulses for the state machine,
  based *only* on the configured integer/fractional divisor. The pattern of
  running/halted cycles slows the state machine's execution to some
  controlled rate.
 
  This function simultaneously clears the integer and fractional phase
  accumulators of multiple state machines' clock dividers. If these state
  machines all have the same integer and fractional divisors configured,
  their clock dividers will run in precise deterministic lockstep from this
  point.
 
  With their execution clocks synchronised in this way, it is then safe to
  e.g. have multiple state machines performing a 'wait irq' on the same flag,
  and all clear it on the same cycle.
 
  Also note that this function can be called whilst state machines are
  running (e.g. if you have just changed the clock divisors of some state
  machines and wish to resynchronise them), and that disabling a state
  machine does not halt its clock divider: that is, if multiple state
  machines have their clocks synchronised, you can safely disable and
  reenable one of the state machines without losing synchronisation.
 
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
 *)
procedure pio_clkdiv_restart_sm_mask(var pio : TPIO_Registers; mask : longWord);

(*
  Enable multiple PIO state machines synchronizing their clock dividers
  This is equivalent to calling both pio_set_sm_mask_enabled() and
  pio_clkdiv_restart_sm_mask() on the *same* clock cycle. All state machines
  specified by 'mask' are started simultaneously and, assuming they have the
  same clock divisors, their divided clocks will stay precisely synchronised.
 
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
 *)
procedure pio_enable_sm_mask_in_sync(var pio : TPIO_Registers; mask : longWord);

(*
  Return the current program counter for a state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  the program counter
 *)

(*
  Immediately execute an instruction on a state machine
  This instruction is executed instead of the next instruction in the normal control flow on the state machine.
  Subsequent calls to this method replace the previous executed
  instruction if it is still running. \see pio_sm_is_exec_stalled() to see if an executed instruction
  is still running (i.e. it is stalled on some condition)
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  instr the encoded PIO instruction
 *)
procedure pio_sm_exec(var pio : TPIO_Registers; sm : longWord; instr : longWord);

(*
  Determine if an instruction set by pio_sm_exec() is stalled executing
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the executed instruction is still running (stalled)
 *)
function pio_sm_is_exec_stalled(var pio : TPIO_Registers; sm : longWord):boolean;

(*
  Immediately execute an instruction on a state machine and wait for it to complete
  This instruction is executed instead of the next instruction in the normal control flow on the state machine.
  Subsequent calls to this method replace the previous executed
  instruction if it is still running. \see pio_sm_is_exec_stalled() to see if an executed instruction
  is still running (i.e. it is stalled on some condition)
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  instr the encoded PIO instruction
 *)
procedure pio_sm_exec_wait_blocking(var pio : TPIO_Registers; sm : longWord; instr : longWord);

(*
  Set the current wrap configuration for a state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  param sm State machine index (0..3)
   wrap_target the instruction memory address to wrap to
   wrap        the instruction memory address after which to set the program counter to wrap_target
               if the instruction does not itself update the program_counter
 *)
procedure pio_sm_set_wrap(var pio : TPIO_Registers; sm : longWord; wrap_target : longWord; wrap : longWord);

(*
  Set the current 'out' pins for a state machine
  Can overlap with the 'in', 'set' and 'sideset' pins
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  out_base 0-31 First pin to set as output
  out_count 0-32 Number of pins to set.
 *)
procedure pio_sm_set_out_pins(var pio : TPIO_Registers; sm : longWord; out_base : longWord; out_count : longWord);

(*
  Set the current 'set' pins for a state machine
  Can overlap with the 'in', 'out' and 'sideset' pins
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  set_base 0-31 First pin to set as
  set_count 0-5 Number of pins to set.
 *)
procedure pio_sm_set_set_pins(var pio : TPIO_Registers; sm : longWord; set_base : longWord; set_count : longWord);

(*
  Set the current 'in' pins for a state machine
  Can overlap with the 'out', ''set' and 'sideset' pins
param pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  in_base 0-31 First pin to use as input
 *)
procedure pio_sm_set_in_pins(var pio : TPIO_Registers; sm : longWord; in_base : longWord);

(*
  Set the current 'sideset' pins for a state machine
  Can overlap with the 'in', 'out' and 'set' pins
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  sideset_base 0-31 base pin for 'side set'
 *)
procedure pio_sm_set_sideset_pins(var pio : TPIO_Registers; sm : longWord; sideset_base : longWord);

(*
  Write a word of data to a state machine's TX FIFO
  This is a raw FIFO access that does not check for fullness. If the FIFO is
  full, the FIFO contents and state are not affected by the write attempt.
  Hardware sets the TXOVER sticky flag for this FIFO in FDEBUG, to indicate
  that the system attempted to write to a full FIFO.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  data the 32 bit data value
  See alsp pio_sm_put_blocking
 *)
procedure pio_sm_put(var pio : TPIO_Registers; sm : longWord; data : longWord);

(*
  Read a word of data from a state machine's RX FIFO
  This is a raw FIFO access that does not check for emptiness. If the FIFO is
  empty, the hardware ignores the attempt to read from the FIFO (the FIFO
  remains in an empty state following the read) and the sticky RXUNDER flag
  for this FIFO is set in FDEBUG to indicate that the system tried to read
  from this FIFO when empty. The data returned by this function is undefined
  when the FIFO is empty.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  see also pio_sm_get_blocking()
 *)
function pio_sm_get(var pio : TPIO_Registers; sm : longWord): longWord;

(*
  Determine if a state machine's RX FIFO is full
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the RX FIFO is full
 *)
function pio_sm_is_rx_fifo_full(var pio : TPIO_Registers; sm : longWord): boolean;

(*
  Determine if a state machine's RX FIFO is empty
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the RX FIFO is empty
 *)
function pio_sm_is_rx_fifo_empty(var pio : TPIO_Registers; sm : longWord):boolean;

(*
  Return the number of elements currently in a state machine's RX FIFO
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  the number of elements in the RX FIFO
 *)
function pio_sm_get_rx_fifo_level(var pio : TPIO_Registers; sm : longWord):longWord;

(*
  Determine if a state machine's TX FIFO is full
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the TX FIFO is full
 *)
function pio_sm_is_tx_fifo_full(var pio : TPIO_Registers; sm : longWord):boolean;

(*
  Determine if a state machine's TX FIFO is empty
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the TX FIFO is empty
 *)
function pio_sm_is_tx_fifo_empty(var pio : TPIO_Registers; sm:longWord):boolean;

(*
  Return the number of elements currently in a state machine's TX FIFO
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  the number of elements in the TX FIFO
 *)
function pio_sm_get_tx_fifo_level(var pio : TPIO_Registers; sm : longWord):longWord;

(*
  Write a word of data to a state machine's TX FIFO, blocking if the FIFO is full
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  data the 32 bit data value
 *)
procedure pio_sm_put_blocking(var pio : TPIO_Registers; sm : longWord; data : longWord);

(*
  Read a word of data from a state machine's RX FIFO, blocking if the FIFO is empty
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
function pio_sm_get_blocking(var pio : TPIO_Registers; sm : longWord):longWord;

(*
  Empty out a state machine's TX FIFO
  This method executes `pull` instructions on the state machine until the TX
  FIFO is empty. This disturbs the contents of the OSR, so see also
  pio_sm_clear_fifos() which clears both FIFOs but leaves the state machine's
  internal state undisturbed.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  see also pio_sm_clear_fifos()
 *)
procedure pio_sm_drain_tx_fifo(var pio : TPIO_Registers; sm : longWord); cdecl; external;

(*! \brief set the current clock divider for a state machine using a 16:8 fraction
 *  \ingroup hardware_pio
 *
 * \param pio The PIO instance; either \ref pio0 or \ref pio1
 * \param sm State machine index (0..3)
 * \param div_int the integer part of the clock divider
 * \param div_frac the fractional part of the clock divider in 1/256s
 *)
procedure pio_sm_set_clkdiv_int_frac(var pio : TPIO_Registers; sm : longWord; div_int : word; div_frac : byte);

(*
  set the current clock divider for a state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  div the floating point clock divider
 *)
procedure pio_sm_set_clkdiv(var pio : TPIO_Registers; sm : longWord; &div : real);

(*
  Clear a state machine's TX and RX FIFOs
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_clear_fifos(var pio : TPIO_Registers; sm : longWord);

(*
  Use a state machine to set a value on all pins for the PIO instance
  This method repeatedly reconfigures the target state machine's pin configuration and executes 'set' instructions to set values on all 32 pins,
  before restoring the state machine's pin configuration to what it was.
  This method is provided as a convenience to set initial pin states, and should not be used against a state machine that is enabled.
param pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3) to use
  pin_values the pin values to set
 *)
procedure pio_sm_set_pins(var pio : TPIO_Registers; sm : longWord; pin_values : longWord); cdecl; external;

(*
  Use a state machine to set a value on multiple pins for the PIO instance
  This method repeatedly reconfigures the target state machine's pin configuration and executes 'set' instructions to set values on up to 32 pins,
  before restoring the state machine's pin configuration to what it was.
 
  This method is provided as a convenience to set initial pin states, and should not be used against a state machine that is enabled.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3) to use
  pin_values the pin values to set (if the corresponding bit in pin_mask is set)
  pin_mask a bit for each pin to indicate whether the corresponding pin_value for that pin should be applied.
 *)
procedure pio_sm_set_pins_with_mask(var pio : TPIO_Registers; sm : longWord; pin_values : longWord; pin_mask:longWord); cdecl; external;

(*
  Use a state machine to set the pin directions for multiple pins for the PIO instance
  This method repeatedly reconfigures the target state machine's pin configuration and executes 'set' instructions to set pin directions on up to 32 pins,
  before restoring the state machine's pin configuration to what it was.
 
  This method is provided as a convenience to set initial pin directions, and should not be used against a state machine that is enabled.
 
param
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3) to use
  pin_dirs the pin directions to set - 1 = out, 0 = in (if the corresponding bit in pin_mask is set)
  pin_mask a bit for each pin to indicate whether the corresponding pin_value for that pin should be applied.
 *)
procedure pio_sm_set_pindirs_with_mask(var pio : TPIO_Registers; sm : longWord; pin_dirs : longWord; pin_mask:longWord); cdecl; external;

(*
  Use a state machine to set the same pin direction for multiple consecutive pins for the PIO instance
  This method repeatedly reconfigures the target state machine's pin configuration and executes 'set' instructions to set the pin direction on consecutive pins,
  before restoring the state machine's pin configuration to what it was.
 
  This method is provided as a convenience to set initial pin directions, and should not be used against a state machine that is enabled.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3) to use
  pin_base the first pin to set a direction for
  pin_count the count of consecutive pins to set the direction for
  is_out the direction to set; true = out, false = in
 *)
procedure pio_sm_set_consecutive_pindirs(var pio : TPIO_Registers; sm : longWord; pin_base : longWord; pin_count : longWord; is_out : boolean); cdecl; external;

(*
  Mark a state machine as used
  Method for cooperative claiming of hardware. Will cause a panic if the state machine
  is already claimed. Use of this method by libraries detects accidental
  configurations that would fail in unpredictable ways.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1 
  sm State machine index (0..3)
 *)
procedure pio_sm_claim(var pio : TPIO_Registers; sm : longWord); cdecl; external;

(*
  Mark multiple state machines as used
  Method for cooperative claiming of hardware. Will cause a panic if any of the state machines
  are already claimed. Use of this method by libraries detects accidental
  configurations that would fail in unpredictable ways.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm_mask Mask of state machine indexes
 *)
procedure pio_claim_sm_mask(var pio : TPIO_Registers; sm : longWord); cdecl; external;

(*
  Mark a state machine as no longer used
  Method for cooperative claiming of hardware.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_unclaim(var pio : TPIO_Registers; sm : longWord); cdecl; external;

(*
  Claim a free state machine on a PIO instance
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  required if true the function will panic if none are available
return 
  the state machine index or -1 if required was false, and none were free
 *)
function pio_claim_unused_sm(var pio : TPIO_Registers; required:boolean):longInt; cdecl; external;

implementation
const
  PIO_SM0_PINCTRL_OUT_BASE_BITS=$0000001f;
  PIO_SM0_PINCTRL_OUT_COUNT_BITS=$03f00000;
  PIO_SM0_PINCTRL_OUT_BASE_LSB=0;
  PIO_SM0_PINCTRL_OUT_COUNT_LSB=20;
  PIO_SM0_PINCTRL_SET_BASE_BITS=$000003e0;
  PIO_SM0_PINCTRL_SET_COUNT_BITS=$1c000000;
  PIO_SM0_PINCTRL_SET_BASE_LSB=5;
  PIO_SM0_PINCTRL_SET_COUNT_LSB=26;
  PIO_SM0_PINCTRL_IN_BASE_BITS=$000f8000;
  PIO_SM0_PINCTRL_IN_BASE_LSB=15;
  PIO_SM0_PINCTRL_SIDESET_BASE_BITS=$00007c00;
  PIO_SM0_PINCTRL_SIDESET_BASE_LSB=10;
  PIO_SM0_PINCTRL_SIDESET_COUNT_BITS=$e0000000;
  PIO_SM0_PINCTRL_SIDESET_COUNT_LSB=29;
  PIO_SM0_EXECCTRL_SIDE_EN_BITS=$40000000;
  PIO_SM0_EXECCTRL_SIDE_PINDIR_BITS=$20000000;
  PIO_SM0_EXECCTRL_SIDE_EN_LSB=30;
  PIO_SM0_EXECCTRL_SIDE_PINDIR_LSB=29;
  PIO_SM0_CLKDIV_FRAC_LSB=8;
  PIO_SM0_CLKDIV_INT_LSB=16;
  PIO_SM0_EXECCTRL_WRAP_TOP_BITS=$0001f000;
  PIO_SM0_EXECCTRL_WRAP_BOTTOM_BITS=$00000f80;
  PIO_SM0_EXECCTRL_WRAP_BOTTOM_LSB=7;
  PIO_SM0_EXECCTRL_WRAP_TOP_LSB=12;
  PIO_SM0_EXECCTRL_JMP_PIN_BITS=$1f000000;
  PIO_SM0_EXECCTRL_JMP_PIN_LSB=24;
  PIO_SM0_SHIFTCTRL_IN_SHIFTDIR_BITS=$00040000;
  PIO_SM0_SHIFTCTRL_AUTOPUSH_BITS=$00010000;
  PIO_SM0_SHIFTCTRL_PUSH_THRESH_BITS=$01f00000;
  PIO_SM0_SHIFTCTRL_IN_SHIFTDIR_LSB=18;
  PIO_SM0_SHIFTCTRL_AUTOPUSH_LSB=16;
  PIO_SM0_SHIFTCTRL_PUSH_THRESH_LSB=20;
  PIO_SM0_SHIFTCTRL_OUT_SHIFTDIR_BITS=$00080000;
  PIO_SM0_SHIFTCTRL_AUTOPULL_BITS=$00020000;
  PIO_SM0_SHIFTCTRL_PULL_THRESH_BITS=$3e000000;
  PIO_SM0_SHIFTCTRL_OUT_SHIFTDIR_LSB=19;
  PIO_SM0_SHIFTCTRL_AUTOPULL_LSB=17;
  PIO_SM0_SHIFTCTRL_PULL_THRESH_LSB=25;
  PIO_SM0_SHIFTCTRL_FJOIN_TX_BITS=$40000000;
  PIO_SM0_SHIFTCTRL_FJOIN_RX_BITS=$80000000;
  PIO_SM0_SHIFTCTRL_FJOIN_TX_LSB=30;
  PIO_SM0_EXECCTRL_OUT_STICKY_BITS=$00020000;
  PIO_SM0_EXECCTRL_INLINE_OUT_EN_BITS=$00040000;
  PIO_SM0_EXECCTRL_OUT_EN_SEL_BITS=$00f80000;
  PIO_SM0_EXECCTRL_OUT_STICKY_LSB=17;
  PIO_SM0_EXECCTRL_INLINE_OUT_EN_LSB=18;
  PIO_SM0_EXECCTRL_OUT_EN_SEL_LSB=19;
  PIO_SM0_EXECCTRL_STATUS_SEL_BITS=$00000010;
  PIO_SM0_EXECCTRL_STATUS_N_BITS=$0000000f;
  PIO_SM0_EXECCTRL_STATUS_SEL_LSB=4;
  PIO_SM0_EXECCTRL_STATUS_N_LSB=0;
  PIO_CTRL_SM_RESTART_LSB=4;
  PIO_CTRL_SM_RESTART_BITS=$000000f0;
  PIO_CTRL_CLKDIV_RESTART_LSB=8;
  PIO_CTRL_CLKDIV_RESTART_BITS=$00000f00;
  PIO_CTRL_SM_ENABLE_LSB=0;
  PIO_CTRL_SM_ENABLE_BITS=$0000000f;
  PIO_FSTAT_RXFULL_LSB=0;
  PIO_FSTAT_RXEMPTY_LSB=8;
  PIO_FLEVEL_RX0_LSB=4;
  PIO_FLEVEL_RX1_LSB=12;
  PIO_FLEVEL_RX0_BITS=$000000f0;
  PIO_FSTAT_TXFULL_LSB=16;
  PIO_FSTAT_TXEMPTY_LSB=24;
  PIO_FLEVEL_TX0_LSB=0;
  PIO_FLEVEL_TX1_LSB=8;
  PIO_FLEVEL_TX0_BITS=$0000000f;
procedure sm_config_set_out_pins(var c : Tpio_sm_config; out_base : longWord; out_count : longWord);
begin
  c.pinctrl := (c.pinctrl and not(PIO_SM0_PINCTRL_OUT_BASE_BITS or PIO_SM0_PINCTRL_OUT_COUNT_BITS)) or
                 (out_base shl PIO_SM0_PINCTRL_OUT_BASE_LSB) or
                 (out_count shl PIO_SM0_PINCTRL_OUT_COUNT_LSB);
end;

procedure sm_config_set_set_pins(var c : Tpio_sm_config;set_base : longWord; set_count : longWord);
begin
  c.pinctrl := (c.pinctrl and not(PIO_SM0_PINCTRL_SET_BASE_BITS or PIO_SM0_PINCTRL_SET_COUNT_BITS)) or
                 (set_base shl PIO_SM0_PINCTRL_SET_BASE_LSB) or 
                 (set_count shl PIO_SM0_PINCTRL_SET_COUNT_LSB);
end;

procedure sm_config_set_in_pins(var c : Tpio_sm_config; in_base : longWord);
begin
  c.pinctrl := (c.pinctrl and not PIO_SM0_PINCTRL_IN_BASE_BITS) or
                 (in_base shl PIO_SM0_PINCTRL_IN_BASE_LSB);
end;

procedure sm_config_set_sideset_pins(var c : Tpio_sm_config; sideset_base:longWord);
begin
  c.pinctrl := (c.pinctrl and not PIO_SM0_PINCTRL_SIDESET_BASE_BITS) or
                 (sideset_base shl PIO_SM0_PINCTRL_SIDESET_BASE_LSB);
end;

procedure sm_config_set_sideset(var c : Tpio_sm_config; bit_count : longWord; optional : boolean; pindirs : boolean);
begin
  c.pinctrl := (c.pinctrl and not longWord(PIO_SM0_PINCTRL_SIDESET_COUNT_BITS)) or
                 longword(bit_count shl PIO_SM0_PINCTRL_SIDESET_COUNT_LSB);

  c.execctrl := (c.execctrl  and not (PIO_SM0_EXECCTRL_SIDE_EN_BITS or PIO_SM0_EXECCTRL_SIDE_PINDIR_BITS)) or
                  (longWord(optional) shl PIO_SM0_EXECCTRL_SIDE_EN_LSB) or
                  (longWord(pindirs) shl PIO_SM0_EXECCTRL_SIDE_PINDIR_LSB);
end;

procedure sm_config_set_clkdiv_int_frac(var c : Tpio_sm_config; div_int : word; div_frac : byte);
begin
  c.clkdiv := ((div_frac) shl PIO_SM0_CLKDIV_FRAC_LSB) or
              ((div_int) shl PIO_SM0_CLKDIV_INT_LSB);
end;

procedure pio_calculate_clkdiv_from_float(&div : real; out div_int : word; out div_frac : byte);
begin
   div_int := trunc(&div);
    if div_int = 0 then
      div_frac := 0
    else
      div_frac := byte((trunc(&div) - div_int) * (1 shl 8));
end;

procedure sm_config_set_clkdiv(var c : Tpio_sm_config; &div : real);
var
  div_int : word;
  div_frac : byte;
begin 
  pio_calculate_clkdiv_from_float(&div, div_int, div_frac);
  sm_config_set_clkdiv_int_frac(c, div_int, div_frac);
end;

procedure sm_config_set_wrap(var c : Tpio_sm_config; wrap_target : longWord; wrap : longWord);
begin
  c.execctrl := (c.execctrl and not(PIO_SM0_EXECCTRL_WRAP_TOP_BITS or PIO_SM0_EXECCTRL_WRAP_BOTTOM_BITS)) or
                  (wrap_target shl PIO_SM0_EXECCTRL_WRAP_BOTTOM_LSB) or
                  (wrap shl PIO_SM0_EXECCTRL_WRAP_TOP_LSB);
end;

procedure sm_config_set_jmp_pin(var c : Tpio_sm_config; pin : TPinIdentifier);
begin
  c.execctrl := (c.execctrl and longWord(not PIO_SM0_EXECCTRL_JMP_PIN_BITS)) or
                  (pin shl PIO_SM0_EXECCTRL_JMP_PIN_LSB);
end;

procedure sm_config_set_in_shift(var c : Tpio_sm_config; shift_right : boolean; autopush : boolean; push_threshold : longWord);
begin
  c.shiftctrl := (c.shiftctrl and
                    not(PIO_SM0_SHIFTCTRL_IN_SHIFTDIR_BITS or
                      PIO_SM0_SHIFTCTRL_AUTOPUSH_BITS or
                      PIO_SM0_SHIFTCTRL_PUSH_THRESH_BITS)) or
                   (longWord(shift_right) shl PIO_SM0_SHIFTCTRL_IN_SHIFTDIR_LSB) or
                   (longWord(autopush) shl PIO_SM0_SHIFTCTRL_AUTOPUSH_LSB) or
                   ((push_threshold and $1f) shl PIO_SM0_SHIFTCTRL_PUSH_THRESH_LSB);
end;

procedure sm_config_set_out_shift(var c : Tpio_sm_config; shift_right : boolean; autopull:boolean; pull_threshold : longWord);
begin
  c.shiftctrl := (c.shiftctrl and
                    not(PIO_SM0_SHIFTCTRL_OUT_SHIFTDIR_BITS or
                      PIO_SM0_SHIFTCTRL_AUTOPULL_BITS or
                      PIO_SM0_SHIFTCTRL_PULL_THRESH_BITS)) or
                   (longWord(shift_right) shl PIO_SM0_SHIFTCTRL_OUT_SHIFTDIR_LSB) or
                   (longWord(autopull) shl PIO_SM0_SHIFTCTRL_AUTOPULL_LSB) or
                   ((pull_threshold and $1f) shl PIO_SM0_SHIFTCTRL_PULL_THRESH_LSB);
end;

procedure sm_config_set_fifo_join(var c : Tpio_sm_config; join : Tpio_fifo_join);
begin
  c.shiftctrl := (c.shiftctrl and not(PIO_SM0_SHIFTCTRL_FJOIN_TX_BITS or PIO_SM0_SHIFTCTRL_FJOIN_RX_BITS)) or
                   ((longWord(join)) shl PIO_SM0_SHIFTCTRL_FJOIN_TX_LSB);
end;

procedure sm_config_set_out_special(var c : Tpio_sm_config; sticky : boolean; has_enable_pin : boolean; enable_pin_index : longWord);
begin 
  c.execctrl := (c.execctrl and
                   not(PIO_SM0_EXECCTRL_OUT_STICKY_BITS or PIO_SM0_EXECCTRL_INLINE_OUT_EN_BITS or
                     PIO_SM0_EXECCTRL_OUT_EN_SEL_BITS)) or
                  (longWord(sticky) shl PIO_SM0_EXECCTRL_OUT_STICKY_LSB) or
                  (longWord(has_enable_pin) shl PIO_SM0_EXECCTRL_INLINE_OUT_EN_LSB) or
                  ((enable_pin_index shl PIO_SM0_EXECCTRL_OUT_EN_SEL_LSB) and PIO_SM0_EXECCTRL_OUT_EN_SEL_BITS);
end;

procedure sm_config_set_mov_status(var c : Tpio_sm_config; status_sel : Tpio_mov_status_type; status_n : longWord);
begin
  c.execctrl := (c.execctrl
                   and not(PIO_SM0_EXECCTRL_STATUS_SEL_BITS or PIO_SM0_EXECCTRL_STATUS_N_BITS))
                  or ((longWord(status_sel) shl PIO_SM0_EXECCTRL_STATUS_SEL_LSB) and PIO_SM0_EXECCTRL_STATUS_SEL_BITS)
                  or ((status_n shl PIO_SM0_EXECCTRL_STATUS_N_LSB) and PIO_SM0_EXECCTRL_STATUS_N_BITS);
end;

function pio_get_default_sm_config : Tpio_sm_config;
begin
  result.clkdiv:= 0;
  result.execctrl := 0;
  result.pinctrl:= 0;
  result.shiftctrl:=0;
  sm_config_set_clkdiv_int_frac(result, 1, 0);
  sm_config_set_wrap(result, 0, 31);
  sm_config_set_in_shift(result, true, false, 32);
  sm_config_set_out_shift(result, true, false, 32);
end;

procedure pio_sm_set_config(var pio : TPio_Registers; sm :  longWord; constref config : Tpio_sm_config);
begin
  pio.sm[sm].clkdiv := config.clkdiv;
  pio.sm[sm].execctrl := config.execctrl;
  pio.sm[sm].shiftctrl := config.shiftctrl;
  pio.sm[sm].pinctrl := config.pinctrl;
end;

(*
  Return the instance number of a PIO instance
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
return 
  the PIO instance number (either 0 or 1)
*)
//static inline uint pio_get_index(PIO pio) {
//    check_pio_param(pio);
//    return pio == pio1 ? 1 : 0;
//}

procedure pio_gpio_init(var pio : TPIO_Registers; pin : TPinIdentifier);
begin
  if @pio = @pio0 then
    gpio_set_function(pin,TGPIOFunction.GPIO_FUNC_PIO0)
  else
    gpio_set_function(pin,TGPIOFunction.GPIO_FUNC_PIO1);
end;

function pio_get_dreq(var pio : TPIO_Registers; sm : longWord; is_tx : boolean):longWord;
begin
  //TODO
  //if is_tx = true then
  //  result := sm + NUM_PIO_STATE_MACHINES + (pio == pio0 ? DREQ_PIO0_TX0 : DREQ_PIO1_TX0);
  //else
  //  result := sm + (is_tx ? 0 : NUM_PIO_STATE_MACHINES) + (pio == pio0 ? DREQ_PIO0_TX0 : DREQ_PIO1_TX0);
end;

function pio_sm_get_pc(var pio : TPIO_Registers; sm : longWord):byte;
begin
  result := pio.sm[sm].addr;
end;

procedure pio_sm_set_enabled(var pio : TPIO_Registers; sm : longWord; enabled : boolean);
begin
  pio.ctrl := (pio.ctrl and not (1 shl sm)) or (longWord(enabled) shl sm);
end;

(*
  Enable or disable multiple PIO state machines
  Note that this method just sets the enabled state of the state machine;
  if now enabled they continue exactly from where they left off.

  \see pio_enable_sm_mask_in_sync() if you wish to enable multiple state machines
  and ensure their clock dividers are in sync.

param
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
  enabled true to enable the state machines; false to disable
 *)
procedure pio_set_sm_mask_enabled(var pio : TPIO_Registers; mask : longWord; enabled:boolean);
begin
  if enableD = true then
    pio.ctrl := (pio.ctrl and not mask) or mask
  else
    pio.ctrl := (pio.ctrl and not mask);
end;

(*
  Restart a state machine with a known state
  This method clears the ISR, shift counters, clock divider counter
  pin write flags, delay counter, latched EXEC instruction, and IRQ wait condition.
param
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_restart(var pio : TPIO_Registers; sm : longWord);
begin
  pio.ctrl := pio.ctrl or longWord(1 shl (PIO_CTRL_SM_RESTART_LSB + sm));
end;

(*
  Restart multiple state machine with a known state
  This method clears the ISR, shift counters, clock divider counter
  pin write flags, delay counter, latched EXEC instruction, and IRQ wait condition.
param
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
 *)
procedure pio_restart_sm_mask(var pio : TPIO_Registers; mask : longWord);
begin
  pio.ctrl := pio.ctrl or (mask shl PIO_CTRL_SM_RESTART_LSB) and PIO_CTRL_SM_RESTART_BITS;
end;

(*
  Restart a state machine's clock divider from a phase of 0
  Each state machine's clock divider is a free-running piece of hardware,
  that generates a pattern of clock enable pulses for the state machine,
  based *only* on the configured integer/fractional divisor. The pattern of
  running/halted cycles slows the state machine's execution to some
  controlled rate.

  This function clears the divider's integer and fractional phase
  accumulators so that it restarts this pattern from the beginning. It is
  called automatically by pio_sm_init() but can also be called at a later
  time, when you enable the state machine, to ensure precisely consistent
  timing each time you load and run a given PIO program.

  More commonly this hardware mechanism is used to synchronise the execution
  clocks of multiple state machines -- see pio_clkdiv_restart_sm_mask().

param
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_clkdiv_restart(var pio : TPIO_Registers; sm : longWord);
begin
  pio.ctrl := pio.ctrl or longWord(1 shl (PIO_CTRL_CLKDIV_RESTART_LSB + sm));
end;

(*
  Restart multiple state machines' clock dividers from a phase of 0.
  Each state machine's clock divider is a free-running piece of hardware,
  that generates a pattern of clock enable pulses for the state machine,
  based *only* on the configured integer/fractional divisor. The pattern of
  running/halted cycles slows the state machine's execution to some
  controlled rate.

  This function simultaneously clears the integer and fractional phase
  accumulators of multiple state machines' clock dividers. If these state
  machines all have the same integer and fractional divisors configured,
  their clock dividers will run in precise deterministic lockstep from this
  point.

  With their execution clocks synchronised in this way, it is then safe to
  e.g. have multiple state machines performing a 'wait irq' on the same flag,
  and all clear it on the same cycle.

  Also note that this function can be called whilst state machines are
  running (e.g. if you have just changed the clock divisors of some state
  machines and wish to resynchronise them), and that disabling a state
  machine does not halt its clock divider: that is, if multiple state
  machines have their clocks synchronised, you can safely disable and
  reenable one of the state machines without losing synchronisation.

param
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
 *)
procedure pio_clkdiv_restart_sm_mask(var pio : TPIO_Registers; mask : longWord);
begin
  pio.ctrl := pio.ctrl or (mask shl PIO_CTRL_CLKDIV_RESTART_LSB) and PIO_CTRL_CLKDIV_RESTART_BITS;
end;

(*
  Enable multiple PIO state machines synchronizing their clock dividers
  This is equivalent to calling both pio_set_sm_mask_enabled() and
  pio_clkdiv_restart_sm_mask() on the *same* clock cycle. All state machines
  specified by 'mask' are started simultaneously and, assuming they have the
  same clock divisors, their divided clocks will stay precisely synchronised.

param
  pio The PIO instance; either \ref pio0 or \ref pio1
  mask bit mask of state machine indexes to modify the enabled state of
 *)
procedure pio_enable_sm_mask_in_sync(var pio : TPIO_Registers; mask : longWord);
begin
  pio.ctrl := pio.ctrl or ((mask shl PIO_CTRL_CLKDIV_RESTART_LSB) and PIO_CTRL_CLKDIV_RESTART_BITS) or
                 ((mask shl PIO_CTRL_SM_ENABLE_LSB) and PIO_CTRL_SM_ENABLE_BITS);
end;

(*
  Immediately execute an instruction on a state machine
  This instruction is executed instead of the next instruction in the normal control flow on the state machine.
  Subsequent calls to this method replace the previous executed
  instruction if it is still running. \see pio_sm_is_exec_stalled() to see if an executed instruction
  is still running (i.e. it is stalled on some condition)
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  instr the encoded PIO instruction
 *)
procedure pio_sm_exec(var pio : TPIO_Registers; sm : longWord; instr : longWord);
begin
  pio.sm[sm].instr := instr;
end;

(*
  Determine if an instruction set by pio_sm_exec() is stalled executing
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the executed instruction is still running (stalled)
 *)
function pio_sm_is_exec_stalled(var pio : TPIO_Registers; sm : longWord):boolean;
begin
  //TODO
  //result := !!(pio.sm[sm].execctrl and PIO_SM0_EXECCTRL_EXEC_STALLED_BITS);
end;

(*
  Immediately execute an instruction on a state machine and wait for it to complete
  This instruction is executed instead of the next instruction in the normal control flow on the state machine.
  Subsequent calls to this method replace the previous executed
  instruction if it is still running. \see pio_sm_is_exec_stalled() to see if an executed instruction
  is still running (i.e. it is stalled on some condition)
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  instr the encoded PIO instruction
 *)
procedure pio_sm_exec_wait_blocking(var pio : TPIO_Registers; sm : longWord; instr : longWord);
begin
  pio_sm_exec(pio, sm, instr);
  while (pio_sm_is_exec_stalled(pio, sm)) do ;
end;

(*
  Set the current wrap configuration for a state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  param sm State machine index (0..3)
   wrap_target the instruction memory address to wrap to
   wrap        the instruction memory address after which to set the program counter to wrap_target
               if the instruction does not itself update the program_counter
 *)
procedure pio_sm_set_wrap(var pio : TPIO_Registers; sm : longWord; wrap_target : longWord; wrap : longWord);
begin
  pio.sm[sm].execctrl :=
            (pio.sm[sm].execctrl and  not(PIO_SM0_EXECCTRL_WRAP_TOP_BITS or PIO_SM0_EXECCTRL_WRAP_BOTTOM_BITS)) or
            (wrap_target shl PIO_SM0_EXECCTRL_WRAP_BOTTOM_LSB) or
            (wrap shl PIO_SM0_EXECCTRL_WRAP_TOP_LSB);
end;

(*
  Set the current 'out' pins for a state machine
  Can overlap with the 'in', 'set' and 'sideset' pins
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  out_base 0-31 First pin to set as output
  out_count 0-32 Number of pins to set.
 *)
procedure pio_sm_set_out_pins(var pio : TPIO_Registers; sm : longWord; out_base : longWord; out_count : longWord);
begin
  pio.sm[sm].pinctrl := (pio.sm[sm].pinctrl and not(PIO_SM0_PINCTRL_OUT_BASE_BITS or PIO_SM0_PINCTRL_OUT_COUNT_BITS)) or
                 (out_base shl PIO_SM0_PINCTRL_OUT_BASE_LSB) or
                 (out_count shl PIO_SM0_PINCTRL_OUT_COUNT_LSB);
end;


(*
  Set the current 'set' pins for a state machine
  Can overlap with the 'in', 'out' and 'sideset' pins
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  set_base 0-31 First pin to set as
  set_count 0-5 Number of pins to set.
 *)
procedure pio_sm_set_set_pins(var pio : TPIO_Registers; sm : longWord; set_base : longWord; set_count : longWord);
begin
  pio.sm[sm].pinctrl := (pio.sm[sm].pinctrl and not(PIO_SM0_PINCTRL_SET_BASE_BITS or PIO_SM0_PINCTRL_SET_COUNT_BITS)) or
                 (set_base shl PIO_SM0_PINCTRL_SET_BASE_LSB) or
                 (set_count shl PIO_SM0_PINCTRL_SET_COUNT_LSB);
end;

(*
  Set the current 'in' pins for a state machine
  Can overlap with the 'out', ''set' and 'sideset' pins
param pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  in_base 0-31 First pin to use as input
 *)
procedure pio_sm_set_in_pins(var pio : TPIO_Registers; sm : longWord; in_base : longWord);
begin
  pio.sm[sm].pinctrl := (pio.sm[sm].pinctrl and not PIO_SM0_PINCTRL_IN_BASE_BITS) or
                 (in_base shl PIO_SM0_PINCTRL_IN_BASE_LSB);
end;

(*
  Set the current 'sideset' pins for a state machine
  Can overlap with the 'in', 'out' and 'set' pins
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  sideset_base 0-31 base pin for 'side set'
 *)
procedure pio_sm_set_sideset_pins(var pio : TPIO_Registers; sm : longWord; sideset_base : longWord);
begin
  pio.sm[sm].pinctrl := (pio.sm[sm].pinctrl and not PIO_SM0_PINCTRL_SIDESET_BASE_BITS) or
                 (sideset_base shl PIO_SM0_PINCTRL_SIDESET_BASE_LSB);
end;

(*
  Write a word of data to a state machine's TX FIFO
  This is a raw FIFO access that does not check for fullness. If the FIFO is
  full, the FIFO contents and state are not affected by the write attempt.
  Hardware sets the TXOVER sticky flag for this FIFO in FDEBUG, to indicate
  that the system attempted to write to a full FIFO.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  data the 32 bit data value
  See alsp pio_sm_put_blocking
 *)
procedure pio_sm_put(var pio : TPIO_Registers; sm : longWord; data : longWord);
begin
  pio.txf[sm] := data;
end;

(*
  Read a word of data from a state machine's RX FIFO
  This is a raw FIFO access that does not check for emptiness. If the FIFO is
  empty, the hardware ignores the attempt to read from the FIFO (the FIFO
  remains in an empty state following the read) and the sticky RXUNDER flag
  for this FIFO is set in FDEBUG to indicate that the system tried to read
  from this FIFO when empty. The data returned by this function is undefined
  when the FIFO is empty.
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  see also pio_sm_get_blocking()
 *)
function pio_sm_get(var pio : TPIO_Registers; sm : longWord): longWord;
begin
  result := pio.rxf[sm];
end;

(*
  Determine if a state machine's RX FIFO is full
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the RX FIFO is full
 *)
function pio_sm_is_rx_fifo_full(var pio : TPIO_Registers; sm : longWord): boolean;
begin
  result := (pio.fstat and (1 shl (PIO_FSTAT_RXFULL_LSB + sm))) <> 0;
end;

(*
  Determine if a state machine's RX FIFO is empty
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the RX FIFO is empty
 *)
function pio_sm_is_rx_fifo_empty(var pio : TPIO_Registers; sm : longWord):boolean;
begin
  result := (pio.fstat and (1 shl (PIO_FSTAT_RXEMPTY_LSB + sm))) <> 0;
end;

(*
  Return the number of elements currently in a state machine's RX FIFO
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  the number of elements in the RX FIFO
 *)
function pio_sm_get_rx_fifo_level(var pio : TPIO_Registers; sm : longWord):longWord;
var
  bitoffs : longWord;
  mask : longWord;
begin
  bitoffs := PIO_FLEVEL_RX0_LSB + sm * (PIO_FLEVEL_RX1_LSB - PIO_FLEVEL_RX0_LSB);
  mask := PIO_FLEVEL_RX0_BITS shr PIO_FLEVEL_RX0_LSB;
  result := (pio.flevel shr bitoffs) and mask;
end;

(*
  Determine if a state machine's TX FIFO is full
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the TX FIFO is full
 *)
function pio_sm_is_tx_fifo_full(var pio : TPIO_Registers; sm : longWord):boolean;
begin
  result := (pio.fstat and (1 shl (PIO_FSTAT_TXFULL_LSB + sm))) <> 0;
end;

(*
  Determine if a state machine's TX FIFO is empty
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  true if the TX FIFO is empty
 *)
function pio_sm_is_tx_fifo_empty(var pio : TPIO_Registers; sm:longWord):boolean;
begin
  result := (pio.fstat and (1 shl (PIO_FSTAT_TXEMPTY_LSB + sm))) <> 0;
end;

(*
  Return the number of elements currently in a state machine's TX FIFO
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
return 
  the number of elements in the TX FIFO
 *)
function pio_sm_get_tx_fifo_level(var pio : TPIO_Registers; sm : longWord):longWord;
var
  bitoffs : longWord;
  mask : longWord;
begin
  bitoffs := PIO_FLEVEL_TX0_LSB + sm * (PIO_FLEVEL_TX1_LSB - PIO_FLEVEL_TX0_LSB);
  mask := PIO_FLEVEL_TX0_BITS shr PIO_FLEVEL_TX0_LSB;
  result := (pio.flevel shr bitoffs) and mask;
end;

(*
  Write a word of data to a state machine's TX FIFO, blocking if the FIFO is full
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  data the 32 bit data value
 *)
procedure pio_sm_put_blocking(var pio : TPIO_Registers; sm : longWord; data : longWord);
begin
  while (pio_sm_is_tx_fifo_full(pio, sm)) do ;
  pio_sm_put(pio, sm, data);
end;

(*
  Read a word of data from a state machine's RX FIFO, blocking if the FIFO is empty
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
function pio_sm_get_blocking(var pio : TPIO_Registers; sm : longWord):longWord;
begin
  while (pio_sm_is_rx_fifo_empty(pio, sm)) do ;
  result := pio_sm_get(pio, sm);
end;

(*! \brief set the current clock divider for a state machine using a 16:8 fraction
 *  \ingroup hardware_pio
 *
 * \param pio The PIO instance; either \ref pio0 or \ref pio1
 * \param sm State machine index (0..3)
 * \param div_int the integer part of the clock divider
 * \param div_frac the fractional part of the clock divider in 1/256s
 *)
procedure pio_sm_set_clkdiv_int_frac(var pio : TPIO_Registers; sm : longWord; div_int : word; div_frac : byte);
begin
  pio.sm[sm].clkdiv := ((div_frac) shl PIO_SM0_CLKDIV_FRAC_LSB) or
            ((div_int) shl PIO_SM0_CLKDIV_INT_LSB);
end;

(*
  set the current clock divider for a state machine
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
  div the floating point clock divider
 *)
procedure pio_sm_set_clkdiv(var pio : TPIO_Registers; sm : longWord; &div : real);
var
  div_int : word;
  div_frac : byte;
begin
  pio_calculate_clkdiv_from_float(&div, div_int, div_frac);
  pio_sm_set_clkdiv_int_frac(pio, sm, div_int, div_frac);
end;

(*
  Clear a state machine's TX and RX FIFOs
param 
  pio The PIO instance; either \ref pio0 or \ref pio1
  sm State machine index (0..3)
 *)
procedure pio_sm_clear_fifos(var pio : TPIO_Registers; sm : longWord);
begin
  // changing the FIFO join state clears the fifo
  hw_xor_bits(pio.sm[sm].shiftctrl, PIO_SM0_SHIFTCTRL_FJOIN_RX_BITS);
  hw_xor_bits(pio.sm[sm].shiftctrl, PIO_SM0_SHIFTCTRL_FJOIN_RX_BITS);
end;

begin
end.
