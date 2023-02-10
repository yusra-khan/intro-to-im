/*
 * Arduino Assignment: Analog and Digital
 * November 10th
 * Yusra Khan
 */

const int digitalLED = 4; //yellow
const int button = 8; //blue
const int match = 12; //green
const int analogLED = 11; //blue
int brightness = 0; //brightness of blue LED
int state = 0; //digital state of yellow LED
int cnt = 0; //for blinking

void setup() {
  Serial.begin(9600);
  pinMode(digitalLED, OUTPUT);
  pinMode(button, INPUT);
  pinMode(match, OUTPUT);
}

void loop() {
  int sensor = analogRead(A5); //get value from photoresistor
  sensor = map(sensor, 0, 1023, 0, 255); //to make it easier to correspond LED brightness
  if(cnt>=sensor){ //change yellow LED state if main loop has iterated equal to or more times than the current sensor reading
    state = !state;
    digitalWrite(digitalLED, state);
    cnt = 0; //restart count for next state change
  }

  int btnVal = digitalRead(button); //get digital value from switch
  if(brightness<255){ //while blue LED is not at maximum brightness increase it if button is pressed
    brightness += btnVal;
  }
  analogWrite(analogLED, brightness);

  if(brightness>=sensor-10 && brightness <= sensor+10){ //if brightness of blue LED is equal to (or close to) sensor value light up green LED
    digitalWrite(match, HIGH);
  }
  else{
    digitalWrite(match, LOW);
  }

  cnt++;
  delay(10); //to slow reading from switch
}
