// Blink Pin 13

program Project1;

{$H-,J-,O-}

uses
  intrinsics;

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
  teiler = CPU_Clock div (16 * Baud) - 1;

  BP5 = 5;        // Pin 13 des Arduino
  sl = 200000;

  WDP3 = 5;

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


begin
  UARTInit;
  UARTSendString('Reset');
  avr_cli;
  asm
      Wdr
  end;
  WDTCSR := WDTCSR or (1 shl WDCE) or (1 shl WDE);
  WDTCSR := (1 shl WDE) or (1 shl WDP3); // 4s / interrupt, system reset
  avr_sei;

  DDRB := DDRB or (1 shl BP5);
  repeat
    UARTSendString('LED on');
    PORTB := PORTB or (1 shl BP5);
    mysleep(sl);

    UARTSendString('LED off');
    PORTB := PORTB and not (1 shl BP5);
    mysleep(sl);
  until False;
end.
