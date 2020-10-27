class Powerups {
  int x, y, xa, ya, time;
  PImage booster, absorb;
  boolean flag;

  Powerups() {
    x = -1; //x-coordinate of health powerup
    y = -1; //y-coordinate of health powerup
    xa = -1; //x-coordinate of absorber powerup
    ya = -1; //y-coordinate of absorber powerup
    booster = loadImage("/images/health.png"); //health booster
    absorb = loadImage("/images/absorber.png"); //absorber
    time = 1; //how long will the absorber be in effect
    flag = false; //if spaceship catches the absorber
  }

  void health() {
    if (t.time%1000 == 0) { //appearance of health booster after every 1000 frames
      x = 10 * int(random(0, 61));
      y = 0;
    }

    if (x != -1 && y != -1) {
      image(booster, x, y, 100, 100); //display health booster
      y += 10;
      if (x >= t.ship.x-70 && x < t.ship.x+120 && y >= 875 && y < 950) {
        if (t.health < 100) {
          t.health = 100;
        }
        y = 1000;
      }
    }

    if (y >= 1000) {
      x = -1;
      y = -1;
    }
  }

  void absorber() {
    if (t.time%450 == 0) { //appearance of absorber after every 450 frames
      xa = 10 * int(random(0, 61));
      ya = 0;
    }

    if (xa != -1 && ya != -1) {
      image(absorb, xa, ya, 100, 100); //display absorber
      ya += 15;
      if (xa >= t.ship.x-70 && xa < t.ship.x+120 && ya >= 875 && ya < 925) { //bring absorber in effect if spaceship catches it
        flag = true;
        ya = 1000;
      }
      if (flag == true) {
        if (time <= 100) { //keep absorber for 50 frames
          image(absorb, t.ship.x-25, t.ship.y, 200, 200);
          time += 1;
        } else {
          flag = false;
          time = 1;
        }
      }
    }

    if (ya > 1000 && flag == false) {
      xa = -1;
      ya = -1;
    }
  }
}
