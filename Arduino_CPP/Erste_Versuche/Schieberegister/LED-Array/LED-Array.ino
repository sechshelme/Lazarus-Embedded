class ShiftRegister
{
  public:
    ShiftRegister(byte data, byte clock, byte latch, byte count = 1);
    ~ShiftRegister() ;
    void setPin(byte pos, boolean st);
    void setPin(byte pos, byte len, boolean st);
    void clear();
    void update();
  private:
    byte latchPin;
    byte clockPin;
    byte dataPin;

    byte shiftCount;
    boolean *reg = 0;

};

ShiftRegister::ShiftRegister(byte data, byte clock, byte latch, byte count) {
  shiftCount = count;
  reg = new boolean[shiftCount];
  for (int i = 0; i < shiftCount; i++) {
    reg[i] = false;
  }
  dataPin = data;
  clockPin = clock;
  latchPin = latch;
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
}

ShiftRegister::~ShiftRegister() {
  delete[] reg;
  reg = 0;
}

void ShiftRegister::setPin(byte pos, boolean st) {
  reg[pos] = st;
}

void ShiftRegister::setPin(byte pos, byte len, boolean st) {
  for (int i = pos; i < pos + len; i++) {
    reg[i] = st;
  }
}

void ShiftRegister::clear() {
  for (int i = 0; i < shiftCount; i++) {
    reg[i] = false;
  }
}

void ShiftRegister::update() {
  digitalWrite(latchPin, LOW);
  //  for (int i = 0; i < shiftCount; i++) {
  for (int i = shiftCount - 1; i >= 0; i--) {

    digitalWrite(dataPin, reg[i]);

    digitalWrite(clockPin, HIGH);
    digitalWrite(clockPin, LOW);

  }
  digitalWrite(latchPin, HIGH);
}

// --- End ShiftRegister ---

//byte latchPin = 9;
//byte clockPin = 8;
//byte dataPin = 10;
byte latchPin = 3;
byte clockPin = 2;
byte dataPin = 4;
byte dimmerPin = 5;

byte maxLED = 70;

ShiftRegister shift(dataPin, clockPin, latchPin, maxLED);

void setup() {
    Serial.begin(9600);
    pinMode(dimmerPin, OUTPUT);
    analogWrite(dimmerPin, 00);
}

byte pos = maxLED / 2;

void loop() {
  
  pos += random(3) - 1;
  Serial.println(pos);

  if (pos == 255) {
    pos = 0;
  };
  if (pos > maxLED) {
    pos = maxLED;
  };

  shift.clear();
  shift.setPin(0, pos, HIGH);

  shift.update();
}
