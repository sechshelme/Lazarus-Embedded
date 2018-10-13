program GPIO_Write;
  
procedure Delay;
var
  i: uint32;
begin
  for i := 0 to 300000 do asm nop end;
end;

procedure Delay_ms;
var
  i: uint32;
begin
  for i := 0 to 100 do asm nop end;
end;

procedure OutPut(v: Byte);
begin
  v := v shr 5;
  PortB.ODR := (1 shl v) shl 8;  
end;

type
  TData = array[0..3] of Byte;
  
var
  z: UInt32;
  dw, dr: TData;
  
const
  ADRESS = $54;
  
 
  
procedure I2C_Init;
begin
  I2C1.CR1 := I2C1.CR1 or $405; 
  I2C1.CR2 := $2A;
  I2C1.CCR := $8023;
  I2C1.TRISE := $0D;
  I2C1.OAR1 := $40A0;
end;

procedure Write_E(addr : Byte);
var
  i: integer;
begin
  I2C1.CR1 := I2C1.CR1 or $401;
  delay_ms;
  while ((I2C1.SR2 and $02) <> 0) do;
  
  while (not((I2C1.SR1 and $01 <> 0) and (I2C1.SR2 and $03 <> 0))) do;
  I2C1.DR := ADRESS;
  delay_ms;

  while (not((I2C1.SR1 and $82 <> 0) and (I2C1.SR2 and $07 <> 0))) do;
  I2C1.OAR1 := I2C1.OAR1 or $00A0;
  I2C1.DR := $00;
  delay_ms;
  
  for i := 0 to 3 do begin
    while (not((I2C1.SR1 and $84 <> 0) and (I2C1.SR2 and $07 <> 0))) do;
    I2C1.DR := dw[i];
    delay_ms;    
  end;
  
  I2C1.CR1 := $0200;  
end;

begin
  dw[0] := 0;
  dw[1] := 1;
  dw[2] := 2;
  dw[3] := 3;

  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%111 shl 2);

  // Ports auf Ausgabe schalten
  PortA.CRL := $33333333;
  PortA.CRH := $33333333;

  PortB.CRL := $33333333;
  PortB.CRH := $33333333;

  PortC.CRL := $33333333;
  PortC.CRH := $33333333;  
  
  z:=0;
  
  Write_E(0);
  
  while true do begin  
    Inc(z);
    OutPut(z shr 8);
  end;
end.
