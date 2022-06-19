/*
 * ShiftRegister.h
 *
 *  Created on: 27.04.2016
 *      Author: tux
 */

#include "Arduino.h"

#ifndef SHIFTREGISTER_H_
#define SHIFTREGISTER_H_

class ShiftRegister
{
  public:
    ShiftRegister();
    ShiftRegister(char data, char clock, char latch, char count = 1);
    ~ShiftRegister() ;
    void setPin(char pos, bool st);
    void setPin(char pos, char len, bool st);
    void clear();
    void update();
  private:
    char latchPin;
    char clockPin;
    char dataPin;

    char shiftCount;
    bool *reg = 0;
};

#endif /* SHIFTREGISTER_H_ */
