/*
 * Arduino Assignment: Musical Instrument
 * November 17th
 * Yusra Khan
 */

#include <Servo.h>

const int red = 3; //red button
const int yellow = 4; //yellow button
const int green = 5; //green button
const int blue = 6; //blue button
const int bzr = 9; //buzzer
boolean flag = false; //to prevent clashing of a second button press while first tune is playing
int cnt = 0; //count loop

int melody[] = { //Notes E3, B3, CS3, A3 corresponding to red, yellow, green and blue respectively
  165, 247, 139, 220
};

Servo drum;

void setup() {
  Serial.begin(9600);
  pinMode(red, INPUT);
  pinMode(yellow, INPUT);
  pinMode(green, INPUT);
  pinMode(blue, INPUT);
  drum.attach(11);
  drum.write(15); //initial position of servo motor
}

void loop() {
  int duration = analogRead(A5); //potentiometer value for duration of tone and frequency of drum
  if (duration > 0) { //don't play if potentiometer at 0
    int btns = 0; //to check current values of all buttons
    for (int i = 3; i < 7; i++) {
      if (digitalRead(i) == 1 && flag == false) { //play corresponding tone for the pressed button
        tone(bzr, melody[i - 3], duration);
        flag = true;
      }
      else if (digitalRead(i) == 0) {
        btns++;
      }
    }
    if (cnt == 4) { //if none of the buttons are pressed
      flag = false;
    }

    if (cnt == 225) { //return servo to initial position
      drum.write(15);
    }

    if (cnt > 450 && cnt >= duration * 2) { //play drum
      drum.write(30);
      cnt = 0;
    }
    cnt++;
  }
  delay(1);
}
