/*
Midterm Project
Yusra Khan
October 27
*/

import ddf.minim.*;
Minim minim = new Minim(this);
AudioPlayer homemusic, stage1, stage2, stage3, slaser, elaser, gamewin, gamelose, blasts;
int stage = 0;
Game t;
PFont font;

void setup() {
  size(700, 1000); //initialize screen
  background(255);
  t = new Game();
  font = loadFont("OCRAExtended-48.vlw");
  homemusic = minim.loadFile("/music/music.mp3");
  stage1 = minim.loadFile("/music/Stage1.mp3");
  stage2 = minim.loadFile("/music/Stage2.mp3");
  stage3 = minim.loadFile("/music/Stage3.mp3");
  slaser = minim.loadFile("/music/slaser.mp3");
  elaser = minim.loadFile("/music/elaser.mp3");
  gamewin = minim.loadFile("/music/gamewin.mp3");
  gamelose = minim.loadFile("/music/gamelose.mp3");
  blasts = minim.loadFile("/music/blast.mp3");
}

void draw() {
  t.display();
}

void mouseClicked() {
  if (t.state.equals("menu")) { //define function of play and instructions buttons on the homescreen
    if (mouseX >= 370 && mouseX <= 620 && mouseY >= 600 && mouseY <= 650) {
      t.state = "instructions";
    } else if (mouseX >= 400 && mouseX <= 550 && mouseY >= 500 && mouseY <= 550) {
      t.state = "play";
      stage = 1;
    }
  }

  if (t.state.equals("instructions")) {
    if (mouseX >= 590 && mouseX <= 690 && mouseY >= 25 && mouseY <= 65) { //button to go back to menu
      t.state = "menu";
    }
  }

  if (t.state.equals("lost") || t.state.equals("win")) { //reset all variables when game ends
    t.x1 = 0;
    t.x2 = 0;
    t.y1 = 0;
    t.y2 = -1000;
    t.time = 1;
    t.health = 100;
    t.img = loadImage("/images/stage0.jpg");
    t.ship = new SpaceShip(300, 850);
    t.enemy = new Enemy();
    t.powerup = new Powerups();
    t.asteroid = new Asteroid();
    t.boss = new Boss();

    if (t.state.equals("lost")) { //play game lose sound
      gamelose.rewind();
      gamelose.pause();
    } else if (t.state.equals("win")) { //play game win sound
      gamewin.rewind();
      gamewin.pause();
    }

    if (mouseX >= 250 && mouseX <= 470 && mouseY >= 550 && mouseY <= 600) { //define function of play button
      t.state = "play";
      stage = 1;
      t.score = 0;
    } else if (mouseX >= 250 && mouseX <= 470 && mouseY >= 650 && mouseY <= 700) { //define function of menu button
      t.state = "menu";
      stage = 0;
      t.score = 0;
    }
  }
}

void keyPressed() { //for movement of spaceship
  if (keyCode == LEFT) {
    t.ship.keyHandler.set("left", "true");
  } else if (keyCode == RIGHT) {
    t.ship.keyHandler.set("right", "true");
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    t.ship.keyHandler.set("left", "false");
  } else if (keyCode == RIGHT) {
    t.ship.keyHandler.set("right", "false");
  } else if (keyCode == UP) { //for shooting bullets
    t.ship.keyHandler.set("up", "true");
  }
}
