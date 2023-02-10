/*
   Final Project
   Yusra Khan
   10 December 2020
*/

const int distin = 11; //input from distance sensor
const int distout = 12; //output from distance sensor
const int led = 7; //green led to signal success
long dist; //distance reading
int pmeter, pres; //potentiometer and photoresistor inputs
byte ledmode; //on/off

void setup() {
  Serial.begin(9600);
  pinMode(distin, INPUT);
  pinMode(distout, OUTPUT);
  pinMode(led, OUTPUT);
}

void loop() {
  //distance sensor
  //ping
  digitalWrite(distout, LOW);
  delayMicroseconds(2);
  digitalWrite(distout, HIGH);
  delayMicroseconds(5);
  digitalWrite(distout, LOW);

  //get echo
  pinMode(distin, INPUT);
  dist = pulseIn(distin, HIGH);
  dist = constrain(dist, 300, 1200);
  dist = map(dist, 300, 1200, 0, 255); //map to color range

  //potentiometer
  pmeter = analogRead(A5);
  pmeter = map(pmeter, 0, 1023, 0, 255); //map to color range

  //photoresistor
  pres = analogRead(A0);

  if (Serial.available()) {
    ledmode = Serial.read(); //read from processing
    digitalWrite(led, ledmode);
  }

  //print to processing
  Serial.print(dist);
  Serial.print(",");
  Serial.print(pmeter);
  Serial.print(",");
  Serial.println(pres);

  delay(100);
}
