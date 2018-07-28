program Project1;

//Procedure UARTBusyWait;assembler;
//asm
//  .LwaitBusy:
//    sbis UCSR0A+(-32),UDR0
//      rjmp .LwaitBusy
//end;

begin
  PORTB := 1;
  PORTB := PORTB or 1;
  PORTB := PORTB or 2;
  PORTB := PORTB or 7;

  asm
    sbi 4, 5        // DDRD, Pin5 --> Output

// --- Hauptschleife
    .Lloop:
      sbi 5, 5      // PORTD, Pin5 --> On
      ldi r20, 50   // 50ms
      call .LDelay  // Delay

      cbi 5, 5      // PORTD, Pin5 --> Off
      ldi r20, 250  // 250ms
      call .LDelay  // Delay
    jmp .Lloop

// --- Delay
    .LDelay:
    .L1:
      ldi r21, 16 // 16MHz
      .L2:
        ldi r22, 250
        .L3:
          nop
          dec r22
        brne .L3
        dec r21
      brne .L2
      dec r20
    brne .L1
    ret
  end;
end.
