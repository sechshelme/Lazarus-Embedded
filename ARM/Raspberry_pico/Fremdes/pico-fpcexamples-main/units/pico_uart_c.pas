unit pico_uart_c;
(*
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *)

{$mode objfpc}{$H+}
interface
uses
  pico_c;

{$IF DEFINED(DEBUG) or DEFINED(DEBUG_UART)}
{$L uart.c-debug.obj}
{$ELSE}
{$L uart.c.obj}
{$ENDIF}

type
  TUARTParity = (
    UART_PARITY_NONE,
    UART_PARITY_EVEN,
    UART_PARITY_ODD
  );
  TUARTStopBits = (
    UART_STOPBITS_ONE,
    UART_STOPBITS_TWO
  );

  TUARTDataBits = (
    UART_DATABITS_FIVE,
    UART_DATABITS_SIX,
    UART_DATABITS_SEVEN,
    UART_DATABITS_EIGHT
  );

(*
  Initialise a UART
  Put the UART into a known state, and enable it. Must be called before other functions.
param
  uart UART instance. uart0 or uart1
  baudrate Baudrate of UART in Hz
return
  Actual set baudrate
note
  There is no guarantee that the baudrate requested will be possible, the nearest will be chosen,
  and this function will return the configured baud rate.
*)
function uart_init(var uart:TUART_Registers; baudrate:longWord):longWord; cdecl; external;

(*
  DeInitialise a UART
  Disable the UART if it is no longer used. Must be reinitialised before
  being used again.
param
  uart UART instance. uart0 or uart1
*)
procedure uart_deinit(var uart : TUART_Registers); cdecl; external;

(*
  Set UART baud rate
  Set baud rate as close as possible to requested, and return actual rate selected.
param
  uart UART instance. uart0 or uart1
  baudrate Baudrate in Hz
 *)
function uart_set_baudrate(var uart : TUART_Registers; baudrate:longWord):longWord; cdecl; external;

(*
  Set UART flow control CTS/RTS
param
  uart UART instance. \ref uart0 or \ref uart1
  cts If true enable flow control of TX  by clear-to-send input
  rts If true enable assertion of request-to-send output by RX flow control
*)
procedure uart_set_hw_flow(var uart:TUART_Registers; cts:boolean; rts:boolean);

(*
  Set UART data format
  Configure the data format (bits etc() for the UART
param
  uart UART instance. \ref uart0 or \ref uart1
  data_bits Number of bits of data. 5..8
  stop_bits Number of stop bits 1..2
  parity Parity option.
*)
procedure uart_set_format(var uart:TUART_Registers; data_bits:TUARTDataBits; stop_bits:TUARTStopBits; parity:TUARTParity);

(*
  Setup UART interrupts
  Enable the UART's interrupt output. An interrupt handler will need to be installed prior to calling
 this function.
param
  uart UART instance. \ref uart0 or \ref uart1
  rx_has_data If true an interrupt will be fired when the RX FIFO contain data.
  tx_needs_data If true an interrupt will be fired when the TX FIFO needs data.
*)
procedure uart_set_irq_enables(var uart:TUART_Registers; rx_has_data:boolean; tx_needs_data : boolean);

(*
  Test if specific UART is enabled
param
  uart UART instance. \ref uart0 or \ref uart1
return
  true if the UART is enabled
*)
function uart_is_enabled(var uart:TUART_Registers): boolean;

(*
  Enable/Disable the FIFOs on specified UART
param
  uart UART instance. \ref uart0 or \ref uart1
  enabled true to enable FIFO (default), false to disable
*)
procedure uart_set_fifo_enabled(var uart:TUART_Registers; enabled:boolean);

(*
  Determine if space is available in the TX FIFO
param
  uart UART instance. \ref uart0 or \ref uart1
return
  false if no space available, true otherwise
*)
function uart_is_writable(var uart:TUART_Registers):boolean;

(*
  Wait for the UART TX fifo to be drained
param
  uart UART instance. \ref uart0 or \ref uart1
*)
procedure uart_tx_wait_blocking(var uart:TUART_Registers);

(*
  Determine whether data is waiting in the RX FIFO
param
  uart UART instance. \ref uart0 or \ref uart1
return
  0 if no data available, otherwise the number of bytes, at least, that can be read
note
  HW limitations mean this function will return either 0 or 1.
*)
function uart_is_readable(var uart:TUART_Registers):boolean;

(*
  Write to the UART for transmission.
  This function will block until all the data has been sent to the UART
param
  uart UART instance. \ref uart0 or \ref uart1
  src The bytes to send
  len The number of bytes to send
*)
procedure uart_write_blocking(var uart:TUART_Registers; var src:TByteArray;len:longWord);

(*
  Read from the UART
  This function will block until all the data has been received from the UART
param
  uart UART instance. \ref uart0 or \ref uart1
  dst Buffer to accept received bytes
  len The number of bytes to receive.
*)
procedure uart_read_blocking(var uart:TUART_Registers; var dst : TByteArray; len : longWord);

(*
  Write single character to UART for transmission.
  This function will block until all the character has been sent
param
  uart UART instance. \ref uart0 or \ref uart1
  c The character  to send
*)
procedure uart_putc_raw(var uart:TUART_Registers; c : Char);

(*
  Write single character to UART for transmission, with optional CR/LF conversions
  This function will block until the character has been sent
param
  uart UART instance. \ref uart0 or \ref uart1
  c The character  to send
*)
procedure uart_putc(var uart:TUART_Registers; c : Char);

(*
  Write string to UART for transmission, doing any CR/LF conversions
  This function will block until the entire string has been sent
param
  uart UART instance. \ref uart0 or \ref uart1
  s The null terminated string to send
*)
procedure uart_puts(var uart:TUART_Registers; s : string);

(*
  Read a single character to UART
  This function will block until the character has been read
param
  uart UART instance. \ref uart0 or \ref uart1
return
  The character read.
*)
function uart_getc(var uart:TUART_Registers):Char;

(*
  Assert a break condition on the UART transmission.
param
  uart UART instance. \ref uart0 or \ref uart1
  en Assert break condition (TX held low) if true. Clear break condition if false.
*)
procedure uart_set_break(var uart:TUART_Registers; en : boolean);

(*
  Set CR/LF conversion on UART
param
  uart UART instance. \ref uart0 or \ref uart1
  translate If true, convert line feeds to carriage return on transmissions
*)
procedure uart_set_translate_crlf(var uart:TUART_Registers; translate:boolean); cdecl; external;

(*
  Wait for the default UART'S TX fifo to be drained
 *)
//procedure uart_default_tx_wait_blocking;

(*
  Wait for up to a certain number of microseconds for the RX FIFO to be non empty
param
  uart UART instance. \ref uart0 or \ref uart1
  us the number of microseconds to wait at most (may be 0 for an instantaneous check)
return
  true if the RX FIFO became non empty before the timeout, false otherwise
*)
function uart_is_readable_within_us(var uart:TUART_Registers; us:longWord):boolean; cdecl; external;

implementation

var
  uart_char_to_line_feed : array[0..1] of word; cvar;

procedure uart_set_hw_flow(var uart:TUART_Registers; cts:boolean; rts:boolean);
begin
  hw_write_masked(uart.cr,
                  (longWord(cts) shl 15) + (longWord(rts) shl 14),
                  $00004000 + $00008000);
end;

procedure uart_set_format(var uart:TUART_Registers; data_bits:TUARTDataBits; stop_bits:TUARTStopBits; parity:TUARTParity);
begin
  hw_write_masked(uart.lcr_h,(longWord(data_bits) shl 5)+(longWord(stop_bits) shl 3)+(longWord(parity) shl 1),
                  $00000060 + $00000008 + $00000002 + $00000004);
end;

procedure uart_set_irq_enables(var uart:TUART_Registers; rx_has_data:boolean; tx_needs_data : boolean);
begin
  uart.imsc := (longWord(tx_needs_data) shl 5) or (longWord(rx_has_data) shl 4);
  if rx_has_data=true then
    hw_write_masked(uart.ifls, 0 << 3,$00000038);
  if tx_needs_data=true then
    hw_write_masked(uart.ifls, 0 << 0,$00000007);
end;

function uart_is_enabled(var uart:TUART_Registers): boolean;
begin
  result := (uart.cr and $00000001)=1;
end;

procedure uart_set_fifo_enabled(var uart:TUART_Registers; enabled:boolean);
begin
  hw_write_masked(uart.lcr_h,longWord(enabled) shl 4,$00000010);
end;

function uart_is_writable(var uart:TUART_Registers):boolean;
begin
  result := (uart.fr and $00000020)=0;
end;

procedure uart_tx_wait_blocking(var uart:TUART_Registers);
begin
  repeat
  until uart.fr and $00000008 <> 0;
end;

function uart_is_readable(var uart:TUART_Registers):boolean;
begin
  result := (uart.fr and $00000010)=0;
end;

procedure uart_write_blocking(var uart:TUART_Registers; var src:TByteArray;len:longWord);
var
  i : word;
begin
  for i := 0 to len-1 do
  begin
    repeat
    until uart_is_writable(uart);
    uart.dr := src[i];
  end;
end;

procedure uart_read_blocking(var uart:TUART_Registers; var dst : TByteArray; len : longWord);
var
  i : word;
begin
  for i := 0 to len-1 do
  begin
    repeat
    until uart_is_readable(uart);
    dst[i] := uart.dr;
  end;
end;

procedure uart_putc_raw(var uart:TUART_Registers; c: Char);
begin
  repeat
  until uart_is_writable(uart);
  uart.dr := longWord(c);
end;

procedure uart_putc(var uart:TUART_Registers; c : Char);
begin
  if @uart = pointer(UART0_BASE) then
    if char(uart_char_to_line_feed[0]) = c then
      uart_putc_raw(uart,#10)
  else
    if char(uart_char_to_line_feed[1]) = c then
      uart_putc_raw(uart,#10);
  uart_putc_raw(uart, c);
end;

procedure uart_puts(var uart:TUART_Registers; s : string);
var
  last_was_cr : boolean;
  i : longWord;
begin
  for i := 1 to length(s) do
  begin
    last_was_cr := false;
    if (last_was_cr) then
      uart_putc_raw(uart,s[i])
    else
      uart_putc(uart, s[i]);
    last_was_cr := (s[i] = #10);
  end;
end;

function uart_getc(var uart:TUART_Registers):Char;
begin
  repeat
  until uart_is_readable(uart);
  result := char(uart.dr);
end;

procedure uart_set_break(var uart:TUART_Registers; en : boolean);
begin
  if en=true then
    hw_set_bits(uart.lcr_h,$00000001)
  else
    hw_clear_bits(uart.lcr_h,$00000001);
end;

//procedure uart_default_tx_wait_blocking;
//begin
//  uart_tx_wait_blocking(uart,0);
//end;

begin
  uart_char_to_line_feed[0] := $100;
  uart_char_to_line_feed[1] := $100;
end.
