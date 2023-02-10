class Asteroid {
  int x, x2, y, y2, dim, dim2, speed, speed2;
  PImage img;

  Asteroid() {
    x = 10 * int(random(0, 56)); //random x-coordinate of asteroid
    x2 = 10 * int(random(0, 56)); //random x-coordinate of 2nd asteroid
    y = 0; //y-coordinate of asteroid
    y2 = 0; //y-coordinate of 2nd asteroid
    img = loadImage("/images/asteroid.png");
    dim = 10 * int(random(5, 16)); //random size of asteroid
    dim2 = 10 * int(random(5, 16)); //random size of 2nd asteroid
    speed = 1500/dim; //speed of asteroid
    speed2 = 1500/dim2; //speed of 2nd asteroid
  }

  void display() {
    image(img, x, y, dim, dim); //1st asteroid
    if (stage == 2 || stage == 3) {
      image(img, x2, y2, dim2, dim2); //2nd asteroid
    }

    if (y < 1000) { //movement down the screen
      y += speed;
    } else {
      y = 0; //resetting variables when asteroid goes out of frame
      x = 10 * int(random(0, 56));
      dim = 10 * int(random(5, 16));
      speed = 1500/dim;
    }

    if (stage == 2 || stage == 3) { //movement of 2nd asteroid
      if (y2 < 1000) {
        y2 += speed2;
      } else {
        x2 = 10 * int(random(0, 56));
        y2 = 0;
        dim2 = 10 * int(random(5, 16));
        speed2 = 1500/dim2;
      }
    }

    if (x >= t.ship.x-dim+30 && x < t.ship.x+120 && y >= 875 && y < 925) { //if asteroid hits spaceship
      image(t.enemy.blast, t.ship.x, 850, 150, 150);
      blasts.rewind();
      blasts.play();
      t.health -= 10;
      y = 1000;
      if (t.health <= 0) {
        t.state = "lost";
      }
    }

    if (stage != 1 && x2 >= t.ship.x-dim2+30 && x2 < t.ship.x+120 && y2 >= 875 && y2 < 925) { //if the 2nd asteroid hits spaceship
      image(t.enemy.blast, t.ship.x, 850, 150, 150);
      blasts.rewind();
      blasts.play();
      t.health -= 10;
      y2 = 1000;
      if (t.health <= 0) {
        t.state = "lost";
      }
    }
  }
}
