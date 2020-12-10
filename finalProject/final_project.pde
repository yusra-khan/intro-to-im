/*
 * Final Project
 * Yusra Khan
 * 10 December 2020
 */

import processing.serial.*;

color rgb, hold;
boolean match = true; //camouflage successful?
int bgR, bgG, bgB, time;
float[] values; //from sensors
String gamestate = "start";
PFont font;
int x = 0;
int step = 1;
int cnt = 0;
boolean clrs, timer;
int wait = 49;

Serial myPort;

void setup() {
  size(500, 500);
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  font = createFont("Segoe Script", 32);
}

void draw() {

  if (gamestate.equals("start")) {
    background(255, 239, 76);
    rectMode(RADIUS);
    noStroke();
    
    // pulsing buttons
    fill(21, 188, 244);
    rect(250, 220, 120+x, 30+x, 5);
    rect(250, 330, 120+x, 30+x, 5);
    fill(10, 50, 144);
    rect(250, 220, 112+x, 22+x, 10);
    rect(250, 330, 112+x, 22+x, 10);
    
    //button text
    fill(255);
    textFont(font);
    textSize(32+x);
    textAlign(CENTER, CENTER);
    text("FREE PLAY", 250, 215);
    text("TIMED", 250, 325);
    
    //title
    fill(0);
    textSize(60);
    text("CAMOUFLAGE", 250, 100);

    //control pulses
    cnt++;
    if (cnt == 10) {
      x += step;
      if (x == 3) {
        step = -1;
      } else if (x == 0) {
        step = 1;
      }
      cnt = 0;
    }
    
  } else if (gamestate.equals("option")) {
    background(255, 239, 76);
    fill(0);
    textSize(32);
    text("Do you want color values to be displayed?", 250, 200, 250, 100);
    fill(21, 188, 244);
    rect(180, 300, 40, 24, 5);
    rect(320, 300, 40, 24, 5);
    fill(10, 50, 144);
    rect(180, 300, 34, 18, 5);
    rect(320, 300, 34, 18, 5);
    fill(255);
    textSize(24);
    text("YES", 180, 295);
    text("NO", 320, 295);
    
  } else if (gamestate.equals("play")) {

    fill(rgb);

    //set background
    if (match == true) {
      //pause for a while before moving to next color
      fill(hold);
      wait++;
      if (wait == 50) {
        myPort.write(0); //give signal to turn of LED
        //set random color of background
        bgR = int(random(0, 256));
        bgG = int(random(0, 256));
        bgB = int(random(0, 256));
        time = 50;
        match = false;
      }
    }
    background(bgR, bgG, bgB);

    //draw character
    stroke(0);
    strokeWeight(2);
    //legs
    rect(234, 295, 11, 15, 2);
    rect(266, 295, 11, 15, 2);
    //body
    rect(250, 250, 35, 35, 10);
    arc(250, 225, 70, 70, PI, TWO_PI);
    //eyes
    fill(255);
    ellipseMode(CENTER);
    ellipse(238, 230, 15, 25);
    ellipse(262, 230, 15, 25);
    fill(0);
    ellipse(239, 235, 8, 12);
    ellipse(263, 235, 8, 12);
    noFill();
    //mouth
    if (match == true) {
      fill(245, 32, 32);
      arc(250, 260, 15, 15, 0, PI);
    } else {
      arc(250, 256, 15, 20, radians(60), radians(120));
    }

    //for displaying values of background color
    if (clrs == true) {
      fill(255);
      textSize(15);
      text(bgR, 15, 10);
      text(bgG, 15, 30);
      text(bgB, 15, 50);
    }

    //timed mode
    if (timer == true) {
      fill(255);
      textSize(30);
      text(time, 450, 20);
      if (frameCount%50 == 0) {
        time -= 1;
      }

      if (time < 0 && match == false) {
        gamestate = "lost";
        hold = rgb; //prevent color changing when game is lost
      }
    }
    
  } else if (gamestate.equals("lost")) {
    background(bgR, bgG, bgB);
    fill(abs(bgR-125), abs(bgG-125), abs(bgB-125)); //set text color to be visible on background
    textSize(60);
    text("GAME OVER", 250, 100);
    noStroke();
    //button
    fill(21, 188, 244);
    rect(250, 400, 120, 30, 5);
    fill(10, 50, 144);
    rect(250, 400, 112, 22, 10);
    fill(255);
    textSize(24);
    text("BACK TO MENU", 250, 395);

    //dead character
    stroke(0);
    strokeWeight(2);
    fill(hold);
    rect(234, 295, 11, 15, 2);
    rect(266, 295, 11, 15, 2);
    rect(250, 250, 35, 35, 10);
    arc(250, 225, 70, 70, PI, TWO_PI);
    fill(0);
    text("X", 238, 230);
    text("X", 262, 230);
    line(245, 260, 255, 260);
  }
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    println(inString);
    values = float(split(inString, ","));
    rgb = color(values[0], values[1], values[2]); //set color with sensor values
    if (abs(bgR-values[0])<=10 && abs(bgG-values[1])<=10 && abs(bgB-values[2])<=10) { //successful camouflage
      match = true;
      myPort.write(1); //signal LED on
      wait = 0;
      hold = rgb; //prevent color change of character
    }
  }
}

void mouseClicked() {
  //start screen
  if (gamestate.equals("start") && mouseX<=370 && mouseX>=130) {
    //freeplay
    if (mouseY<=250 && mouseY>=190) {
      gamestate = "option";
      timer = false;
    //timed play
    } else if (mouseY<=360 && mouseY>=300) {
      gamestate = "option";
      timer = true;
    }
    
  } else if (gamestate.equals("option") && mouseY<=318 && mouseY>=282) {
    //No
    if (mouseX<=354 && mouseX>=286) {
      clrs = false;
      gamestate = "play";
    //yes
    } else if (mouseX<=214 && mouseX>=146) {
      clrs = true;
      gamestate = "play";
    }
  //game over
  } else if (gamestate.equals("lost") && mouseX<=362 && mouseX>=138 && mouseY<=412 && mouseY>=388) {
    gamestate = "start";
    match = true;
    x = 0;
    step = 0;
    cnt = 0;
    wait = 49;
  }
}
