/*
 * Game with Arduino and Processing
 * Yusra Khan
 * 24 November 2020
 */

import processing.serial.*;

char direction = 'h'; //dependent on switch
int[] position = {250, 250}; //x y position of pacman
int startAngle = 30; //mouth
int stopAngle = 330;
int factor = 1; //for movement of mouth
int foodx = int(random(50, 450)); //food
int foody = int(random(50, 450));
int score = 0;
PFont font;

Serial myPort;

void setup() {
  size(500, 500);
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  font = createFont("Comic Sans MS", 200);
}

void draw() {
  background(174, 232, 207);
  ellipseMode(CENTER);
  noStroke();
  
  //score
  fill(254,184,219,150);
  textAlign(CENTER, CENTER);
  textSize(200);
  textFont(font);
  text(score, 250, 225);
  
  //food
  fill(0);
  ellipse(foodx, foody, 10, 10);
  //new food if eaten
  if(foodx >= position[0]-20 && foodx <= position[0]+20 && foody >= position[1]-20 && foody <= position[1]+20){
    foodx = int(random(50, 450));
    foody = int(random(50, 450));
    score +=1;
  }
  
  //pacman
  fill(255, 214, 0);
  arc(position[0], position[1], 50, 50, radians(startAngle), radians(stopAngle));
  if (startAngle == 0) {
    factor = -1;
  } else if (startAngle == 30) {
    factor = 1;
  }
  startAngle -= factor;
  stopAngle += factor;
  
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    float[] values = float(split(inString, ","));
    if (values[0] == 0) {
      direction = 'h';
      position[0] = int(map(values[1], 300, 1200, 25, 475)); //map sensor values to window size
    } else {
      direction = 'v';
      position[1] = int(map(values[1], 300, 1200, 25, 475));
    }
  }
}
