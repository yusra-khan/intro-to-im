class Boss {
  PImage img1, img2, img3, bullet, blast;
  String state;
  int[] bx;
  int[][] by, bllt;
  int x, y;

  Boss() {
    img1=loadImage("/images/boss1.png");
    img2=loadImage("/images/boss2.png");
    img3=loadImage("/images/boss3.png");
    bullet=loadImage("/images/beam.png");
    blast=loadImage("/images/blast.png");
    state = "alive";
    x = 200; //x-coordinate of boss
    y = 2; //speed of boss
    bx = new int[5]; //initial x-coordinates of the 5 boss bullets
    bx[0] = x+25;
    bx[1] = x+75;
    bx[2] = x+150;
    bx[3] = x+225;
    bx[4] = x+275;
    by = new int[10][5]; //list for the y-coordinates of every set of 5 boss bullets
    bllt = new int[10][5]; //x-coordinates of every set of 5 boss bullets
    for (int i=0; i<10; i++) {
      for (int j=0; j<5; j++) {
        by[i][j] = 0;
        bllt[i][j] = 0;
      }
    }
  }

  void display() { //determining which boss to display according to the stage
    if (stage == 1) {
      image(img1, x, 0, 300, 200);
    } else if (stage == 2) {
      image(img2, x, 0, 300, 200);
    } else if (stage == 3) {
      image(img3, x, 0, 300, 200);
    }

    if (t.time%20 == 0) { //creating a new set of bullets after every interval of 20 frames
      boolean found = false;
      int elem = 0;
      while (found == false) {
        int zeros = 0;
        for (int i=0; i<5; i++) {
          if (by[elem][i] == 0) {
            zeros++;
          }
        }
        if (zeros == 5) {
          found = true;
          for (int i=0; i<5; i++) {
            bllt[elem][i] = bx[i];
            by[elem][i] = 200;
          }
          elaser.rewind();
          elaser.play(); //sound of enemy bullets
        } else {
          elem++;
        }
      }
    }

    for (int c=0; c<10; c++) { //to display all the bullets as they travel down the screen
      if (by[c][0] != 0 || by[c][1] != 0 || by[c][2] != 0 || by[c][3] != 0 || by[c][4] != 0) {
        if (stage == 3) { //to create the spreading effect of bullets in stage 3
          bllt[c][0] -= 8;
          bllt[c][1] -= 4;
          bllt[c][3] += 4;
          bllt[c][4] += 8;
        }
        for (int cnt=0; cnt<5; cnt++) { //to display each of the 5 bullets in a set
          by[c][cnt] += 20; //speed of the bullets
          image(bullet, bllt[c][cnt], by[c][cnt], 30, 30);
          if (bllt[c][cnt] >= t.ship.x && bllt[c][cnt] < t.ship.x+141 && by[c][cnt] >= 900 && by[c][cnt] < 950) { //if a bullet hits the spaceship
            if (t.powerup.flag == true) { //health increases if absorber is present
              t.health += 10;
              by[c][cnt] = 1000;
            } else {
              image(blast, t.ship.x, 850, 150, 150);
              blasts.rewind();
              blasts.play();
              t.health -= 20;
              by[c][cnt] = 1000;
              if (t.health <= 0) {
                t.state = "lost";
              }
            }
          }
        }

        int offscreen = 0;
        for (int i=0; i<5; i++) {
          if (by[c][i] > 1000) {
            offscreen++;
          }
        }
        if (offscreen == 5) {
          for (int i=0; i<5; i++) {
            by[c][i] = 0;
            bllt[c][i] = 0;
          }
        }
      }

      if (stage == 2 || stage == 3) { //movement of boss in stages 2 and 3
        x += y;
        if (x < 10 || x > 400) {
          y = -1 * y;
        }
        bx[0] = x+25;
        bx[1] = x+75;
        bx[2] = x+150;
        bx[3] = x+225;
        bx[4] = x+275;
      }
    }
  }
}
