// Watchdog - Interrupt

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
  teiler = CPU_Clock div (16 * Baud) - 1;

  BP5 = 5;        // Pin 13 des Arduino

  WDP0 = 0;
  WDP1 = 1;
  WDP2 = 2;
  WDP3 = 5;

(*
  • Bit 5, 2:0 - WDP[3:0]: Watchdog Timer Prescaler 3, 2, 1 and 0

  0 0 0 0 2K (2048) cycles 16ms
  0 0 0 1 4K (4096) cycles 32ms
  0 0 1 0 8K (8192) cycles 64ms
  0 0 1 1 16K (16384) cycles 0.125 s
  0 1 0 0 32K (32768) cycles 0.25 s
  0 1 0 1 64K (65536) cycles 0.5 s
  0 1 1 0 128K (131072) cycles 1.0 s
  0 1 1 1 256K (262144) cycles 2.0 s
  1 0 0 0 512K (524288) cycles 4.0 s
  1 0 0 1 1024K (1048576) cycles 8.0 s
  1 0 1 0 Reserved
  1 0 1 1 Reserved
  1 1 0 0 Reserved
  1 1 0 1 Reserved
  1 1 1 0 Reserved
  1 1 1 1 Reserved

*)

var
  sl: int32;
  s: string[10];

  procedure mysleep(t: int32);
  var
    i: int32;
  begin
    for i := 0 to t do begin
      asm
          Nop;
      end;
    end;
  end;

  procedure UARTInit;
  begin
    UBRR0 := teiler;
    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0);
    UCSR0C := %011 shl UCSZ0;
  end;

  procedure UARTSendChar(c: char);
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do begin
    end;
    UDR0 := byte(c);
  end;

  procedure UARTSendString(s: shortstring);
  var
    i: integer;
  begin
    for i := 1 to length(s) do begin
      UARTSendChar(s[i]);
    end;
    UARTSendChar(#10);
  end;


  procedure WDT_ISR_Interrupt; public Name 'WDT_ISR'; interrupt;
  begin
    UARTSendString('Watchdog ISR');
    sl := 1000;
  end;


begin
  UARTInit;
  UARTSendString('Reset');
  avr_cli;
  avr_wdr;
  WDTCSR := WDTCSR or (1 shl WDCE) or (1 shl WDE);
  WDTCSR := (1 shl WDIE) or (1 shl WDP3); // 4s / interrupt, system reset
  avr_sei;

  DDRB := DDRB or (1 shl BP5);
  sl := 1000;
  repeat
    UARTSendString('LED on');
    PORTB := PORTB or (1 shl BP5);
    mysleep(sl);

    UARTSendString('LED off');
    PORTB := PORTB and not (1 shl BP5);
    mysleep(sl);

    sl := sl + 100000;
    avr_wdr;
  until False;
end.
