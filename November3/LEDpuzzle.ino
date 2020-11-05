/*Arduino Assignment: LED puzzle
   November 3rd
   Yusra Khan
*/

const int redBtn = 3;
const int blueBtn = 4;
const int yellowBtn = 5;
const int greenBtn = 6;
const int redLED = 7;
const int blueLED = 8;
const int yellowLED = 9;
const int greenLED = 10;
int cnt = 1; //level number
int sequence[100];
boolean fail = false; //game lose flag
int next = 0; //move onto next level when next<cnt
int btn = 0; //if all buttons pressed correctly move on to next level
int previous = 0; //to avoid same press of button being read multiple times

void setup() {
  Serial.begin(9600);
  pinMode(redBtn, INPUT);
  pinMode(greenBtn, INPUT);
  pinMode(yellowBtn, INPUT);
  pinMode(blueBtn, INPUT);
  pinMode(redLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(yellowLED, OUTPUT);
  pinMode(blueLED, OUTPUT);
}

void loop() {
  if (cnt != next && (digitalRead(greenBtn) + digitalRead(yellowBtn) + digitalRead(blueBtn)) == 0) { //new level only when no button is pressed
    btn = 0;
    previous = 0;
    next++;
    for (int i = 0; i < cnt; i++) { //random LEDs with incremental amount each level stored in array
      sequence[i] = int(random(8, 11));
      digitalWrite(sequence[i], HIGH);
      delay(500);
      digitalWrite(sequence[i], LOW);
      delay(500);
    }
  }

  if (fail == false && cnt == next) { //only when new level has been displayed
    int buttons = digitalRead(greenBtn) + digitalRead(yellowBtn) + digitalRead(blueBtn);
    if (buttons == 1) { //when any one button is pressed
      if (previous == 0) { //if no button was pressed in previous iteration
        int inbtn = sequence[btn] - 4; //corresponding button to LED
        if (digitalRead(inbtn) == 1) { //when correct button pressed
          previous = 1;
          btn++; //to check next LED in array
          if (btn == cnt) { //when entire correct sequence has been pressed
            cnt++;
            delay(1000);
          }
        }
        else { //when incorrect button pressed
          fail = true;
        }
      }
    }
    else if (buttons == 0) {
      previous = 0;
    }
    else { //if multiple buttons pressed simultaneously
      fail = true;
    }
  }
  else if (fail == true) { //game lost
    digitalWrite(redLED, HIGH); //red LED signals game lost
    if (digitalRead(redBtn) == 1) { //reset game by pressing red button
      cnt = 1;
      fail = false;
      next = 0;
      digitalWrite(redLED, LOW);
      delay(1000);
    }
  }
}
