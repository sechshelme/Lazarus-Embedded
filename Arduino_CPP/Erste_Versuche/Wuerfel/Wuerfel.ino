#include <TimerOne.h>


void Ausgabe(int Nr)
{
  for (int i = 2; i <= 8; i++) digitalWrite(i, LOW);
  Serial.println(Nr);
  switch (Nr) {
    case 1: {
        digitalWrite(4 + 1, HIGH);
        break;
      }
    case 2: {
        digitalWrite(3 + 1, HIGH);
        digitalWrite(5 + 1, HIGH);
        break;
      }
    case 3: {
        digitalWrite(1 + 1, HIGH);
        digitalWrite(4 + 1, HIGH);
        digitalWrite(7 + 1, HIGH);
        break;
      }
    case 4: {
        digitalWrite(1 + 1, HIGH);
        digitalWrite(3 + 1, HIGH);
        digitalWrite(5 + 1, HIGH);
        digitalWrite(7 + 1, HIGH);
        break;
      }
    case 5: {
        digitalWrite(1 + 1, HIGH);
        digitalWrite(3 + 1, HIGH);
        digitalWrite(4 + 1, HIGH);
        digitalWrite(5 + 1, HIGH);
        digitalWrite(7 + 1, HIGH);
        break;
      }
    case 6: {
        digitalWrite(1 + 1, HIGH);
        digitalWrite(2 + 1, HIGH);
        digitalWrite(3 + 1, HIGH);
        digitalWrite(5 + 1, HIGH);
        digitalWrite(6 + 1, HIGH);
        digitalWrite(7 + 1, HIGH);
        break;
      }
  }
}

void blinken() {
  digitalWrite(13, digitalRead(13) ^ 1);
}

void setup() {
  Serial.begin(9600);
  for (int i = 2; i <= 8; i++)  pinMode(i, OUTPUT);
  pinMode(13, OUTPUT);
  Timer1.initialize(50000);
  Timer1.attachInterrupt(blinken);
}

// the loop function runs over and over again forever
void loop() {
  for (int i = 1; i <= 6; i++)  {
    Ausgabe(i);
    delay(700);
  }
}
