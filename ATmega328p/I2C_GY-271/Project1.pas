program Project1;

{$H-}

const
  CPU_Clock = 16000000; // Taktfrequenz Arduino, default 16MHz.
  Baud = 9600;          // Baudrate
//  I2Caddr = $1E;
// I2Caddr = $0D;
I2Caddr = %001101;
  TWI_Write = 0;
  TWI_Read = 1;

  (*
   Parameter ADS1115
   =================

   Low:  11100011  (default 860SPS)

   ???00011: SPS

   000 : 8SPS
   001 : 16SPS
   010 : 32SPS
   011 : 64SPS
   100 : 128SPS (default)
   101 : 250SPS
   110 : 475SPS
   111 : 860SPS


   High: 11000011  (default 2,048V )

   1???0011: Kanal (Multiplex)
   1100???1: Gain  Bit [11:9]  (Volt)

   000 : FS = ±6.144V
   001 : FS = ±4.096V
   010 : FS = ±2.048V (default)
   011 : FS = ±1.024V
   100 : FS = ±0.512V
   101 : FS = ±0.256V
   110 : FS = ±0.256V
   111 : FS = ±0.256V

   *)

procedure delay_ms(time : uint8);
const
  fcpu = 16000000;
  fmul = 1 * fcpu div 1000000;
label
  loop1, loop2, loop3;
begin
  asm
    ldd r20, time
    loop1:
      ldi r21, fmul
      loop2:  // 1000 * fmul = 1000 * 1 * 8 = 8000 cycles / 8MHz
        ldi r22, 250
        loop3:  // 4 * 250 = 1000 cycles
          nop
          dec r22
          brne loop3
        dec r21
        brne loop2
      dec r20
      brne loop1
  end['r20','r21','r22'];
end;

  // === UART-Schnittstelle

  procedure UARTInit;
  const
    teiler = CPU_Clock div (16 * Baud) - 1;
  begin
    UBRR0 := Teiler;
    UCSR0A := (0 shl U2X0);
    UCSR0B := (1 shl TXEN0) or (1 shl RXEN0){ or (1 shl RXCIE0)};
    UCSR0C := %011 shl UCSZ0;
  end;

  procedure UARTSendChar(c: char);
  begin
    while UCSR0A and (1 shl UDRE0) = 0 do begin
    end;
    UDR0 := byte(c);
  end;

  function UARTReadChar: char;
  begin
    while UCSR0A and (1 shl RXC0) = 0 do begin
    end;
    Result := char(UDR0);
  end;

  procedure UARTSendString(s: ShortString);
  var
    i: integer;
  begin
    for i := 1 to length(s) do begin
      UARTSendChar(s[i]);
    end;
  end;

  // === I2C Bus

  procedure TWIInit;
  const
    F_SCL = 400000;                                // SCL Frequenz (400KHz)
    TWBR_val = byte((CPU_Clock div F_SCL) - 16) div 2;
  begin
    TWSR := 0;
    TWBR := byte(TWBR_val);
  end;

  procedure TWIStart(addr: byte);
  begin
    // Senden einleiten
    TWCR := 0;
    TWCR := (1 shl TWINT) or (1 shl TWSTA) or (1 shl TWEN);
    while ((TWCR and (1 shl TWINT)) = 0) do begin
    end;

    // Adresse des Endgerätes senden
    TWDR := addr;
    TWCR := (1 shl TWINT) or (1 shl TWEN);
    while ((TWCR and (1 shl TWINT)) = 0) do begin
    end;
  end;

  procedure TWIStop;
  begin
    TWCR := (1 shl TWINT) or (1 shl TWSTO) or (1 shl TWEN);
  end;

  procedure TWIWrite(u8data: byte);
  begin
    TWDR := u8data;
    TWCR := (1 shl TWINT) or (1 shl TWEN);
    while ((TWCR and (1 shl TWINT)) = 0) do begin
    end;
  end;

  function TWIReadACK: byte;
  begin
    TWCR := (1 shl TWINT) or (1 shl TWEN) or (1 shl TWEA);
    while (TWCR and (1 shl TWINT)) = 0 do begin
    end;
    Result := TWDR;
  end;

  function TWIReadNACK: byte;
  begin
    TWCR := (1 shl TWINT) or (1 shl TWEN);
    while (TWCR and (1 shl TWINT)) = 0 do begin
    end;
    Result := TWDR;
  end;

  // === Ende I2C

const
Mode_Standby   = %00000000;
Mode_Continuous= %00000001;

ODR_10Hz       = %00000000;
ODR_50Hz       = %00000100;
ODR_100Hz      = %00001000;
ODR_200Hz      = %00001100;

RNG_2G         = %00000000;
RNG_8G         = %00010000;

OSR_512        = %00000000;
OSR_256        = %01000000;
OSR_128        = %10000000;
OSR_64         = %11000000;


type
  TVec3=record
    x, y, z: Int16;
  end;

procedure I2C_GY_271_WriteReg(Reg, val:Byte);
begin
  TWIStart((I2Caddr shl 1) or TWI_Write);
  TWIWrite(Reg);
  TWIWrite(val);
  TWIStop;
  delay_ms(100);
end;

procedure I2C_GY_271_Init;
begin
  I2C_GY_271_WriteReg($0B, $01);

//  I2C_GY_271_WriteReg($09, Mode_Continuous or ODR_200Hz or RNG_8G or OSR_512);
  I2C_GY_271_WriteReg($09, Mode_Continuous or ODR_200Hz or RNG_2G or OSR_256);
end;

function I2C_GY_271_Read: TVec3;
//var
//  h, l:Byte;
begin
  TWIStart((I2Caddr shl 1) or TWI_Write);
  TWIWrite($03);
  TWIStop;
  delay_ms(100);

  TWIStart((I2Caddr shl 1) or TWI_Read);
  Result.x := TWIReadACK;
  Result.x += TWIReadACK shl 8;
  Result.y := TWIReadACK;
  Result.y += TWIReadACK shl 8;
  Result.z := TWIReadACK;
  Result.z += TWIReadNACK shl 8;
  TWIStop;
  delay_ms(100);
end;

var
  s: ShortString;
  p: TVec3;

begin
  asm
           Cli
  end;
  UARTInit;
  TWIInit;
I2C_GY_271_Init;
  asm
           Sei
  end;

  repeat
    p:=I2C_GY_271_Read;
str(p.x:10, s);
UARTSendString('x: ');
UARTSendString(s);
str(p.y:10, s);
UARTSendString('y: ');
UARTSendString(s);
str(p.z:10, s);
UARTSendString('z: ');
UARTSendString(s + #13#10);
  until 1 = 2;
end.

// ====== H


(*
/*
  QMC5883L.h - QMC5883L library
  Copyright (c) 2017 e-Gizmo Mechatronix Central
  Rewritten by Amoree.  All right reserved.
  July 10,2017
*/

#ifndef QMC5883L_h
#define QMC5883L_h


#if ARDUINO >= 100
  #include "Arduino.h"
#else
  #include "WProgram.h"
#endif

#include "Wire.h"

#define QMC5883L_ADDR 0x0D//The default I2C address is 0D: 0001101


//Registers Control //0x09

#define Mode_Standby    0b00000000
#define Mode_Continuous 0b00000001

#define ODR_10Hz        0b00000000
#define ODR_50Hz        0b00000100
#define ODR_100Hz       0b00001000
#define ODR_200Hz       0b00001100

#define RNG_2G          0b00000000
#define RNG_8G          0b00010000

#define OSR_512         0b00000000
#define OSR_256         0b01000000
#define OSR_128         0b10000000
#define OSR_64          0b11000000


class QMC5883L{

public:
void setAddress(uint8_t addr);
void init();
void setMode(uint16_t mode,uint16_t odr,uint16_t rng,uint16_t osr);
void softReset();
void read(uint16_t* x,uint16_t* y,uint16_t* z);
void read(int* x,int* y,int* z);

private:
void WriteReg(uint8_t Reg,uint8_t val);
uint8_t address = QMC5883L_ADDR;

};

#endif

*)

// ======CPP

(*
/*
  QMC5883L.cpp - QMC5883L library
  Copyright (c) 2017 e-Gizmo Mechatronix Central
  Rewritten by Amoree.  All right reserved.
  July 10,2017

  SET continuous measurement mode
  OSR = 512
  Full Scale Range = 8G(Gauss)
  ODR = 200HZ

*/

#include "QMC5883L.h"

#include <Wire.h>

void QMC5883L::setAddress(uint8_t addr){
  address = addr;
}

void QMC5883L::WriteReg(byte Reg,byte val){
  Wire.beginTransmission(address); //Start
  Wire.write(Reg); // To tell the QMC5883L to get measures continously
  Wire.write(val); //Set up the Register
  Wire.endTransmission();
}

void QMC5883L::init(){
  WriteReg(0x0B,0x01);
  //Define Set/Reset period
  setMode(Mode_Continuous,ODR_200Hz,RNG_8G,OSR_512);
}

void QMC5883L::setMode(uint16_t mode,uint16_t odr,uint16_t rng,uint16_t osr){
  WriteReg(0x09,mode|odr|rng|osr);
  Serial.println(mode|odr|rng|osr,HEX);
}


void QMC5883L::softReset(){
  WriteReg(0x0A,0x80);
}

void QMC5883L::read(int* x,int* y,int* z){
  Wire.beginTransmission(address);
  Wire.write(0x00);
  Wire.endTransmission();
  Wire.requestFrom(address, 6);
  *x = Wire.read(); //LSB  x
  *x |= Wire.read() << 8; //MSB  x
  *y = Wire.read(); //LSB  z
  *y |= Wire.read() << 8; //MSB z
  *z = Wire.read(); //LSB y
  *z |= Wire.read() << 8; //MSB y
}
*)
