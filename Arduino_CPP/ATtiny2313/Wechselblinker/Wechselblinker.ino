void setup() {
  // put your setup code here, to run once:
  DDRD = 255;

}

void loop() {
  PORTD |= (1 << 0);
  PORTD &= ~(1 << 1);
  delay(200);
  
  PORTD |= (1 << 1);
  PORTD &= ~(1 << 0);
  delay(200);
}
