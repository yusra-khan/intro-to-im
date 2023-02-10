/*
 * Game with Arduino and Processing
 * Yusra Khan
 * 24 November 2020
 */

const int dir = 7; //switch
const int out = 5; //dist sensor output
const int in = 4; //dist sensor input
long dist; //distance

void setup() {
  Serial.begin(9600);
  pinMode(dir, INPUT);
  pinMode(in, INPUT);
  pinMode(out, OUTPUT);
}

void loop() {
  //ping
  digitalWrite(out, LOW);
  delayMicroseconds(2);
  digitalWrite(out, HIGH);
  delayMicroseconds(5);
  digitalWrite(out, LOW);

  //get echo
  pinMode(in, INPUT);
  dist = pulseIn(in, HIGH);
  dist = constrain(dist, 300, 1200); //constrain to avoid unnecassary values

  //send to processing
  Serial.print(digitalRead(dir)); //switch reading
  Serial.print(",");
  Serial.println(dist); //distance from sensor
  
  delay(100);
}
