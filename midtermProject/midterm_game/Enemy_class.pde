class Enemy {
  int x, x2, y, y2, choose, by, b, b2;
  PImage img, bullet, blast;
  String state, state2;
  int[][] epos, epos2;

  Enemy() {
    x = 10*int(random(0, 51)); //x-coordinate of enemy
    x2 = 10*int(random(0, 51)); //x-coordinate of 2nd enemy in stage 3
    y = 10; //speed of enemy
    y2 = 10; //speed of 2nd enemy in stage 3
    choose = int(random(1, 4)); //to choose a random enemy from the 3 options
    img = loadImage("/images/enemy"+str(choose)+".png");
    bullet = loadImage("/images/beam.png");
    blast = loadImage("/images/blast.png");
    by = 150; //y-coordinate of enemy bullet
    b = x+105; //x-coordinate of enemy bullet
    b2 = x2+105; //x-coordinate of enemy bullet from the 2nd enemy
    state = "alive"; //state of enemy
    state2 = "alive"; //state of 2nd enemy
    epos = new int[10][2]; //list of enemy bullets' positions
    epos2 = new int[10][2]; //list of 2nd enemy's bullets' positions    
    for (int i=0; i<10; i++) {
      epos[i][0] = 0;
      epos[i][1] = 0;
      epos2[i][0] = 0;
      epos2[i][1] = 0;
    }
  }

  void display() {
    if (state.equals("dead")) { //resets variables for respawning
      x = 10*int(random(0, 50)); //selects random x-coordinate to spawn enemy spaceship
      y = 10;
      b = x + 105;
      state = "alive";
      choose = int(random(1, 4)); //randomly selects one of enemy ship from among 3 choices
      img = loadImage("/images/enemy"+str(choose)+".png");
    }

    if (state2.equals("dead")) {
      x2 = 10*int(random(0, 50)); //randomly selects x-coordinate of enemy spaceship when previous one dies
      y2 = 10;
      b2 = x2 + 105;
      state2 = "alive";
    }

    image(img, x, 0, 250, 150);
    if (stage == 3) { //spawns 2 enemy ships in stage 3
      image(img, x2, 0, 250, 150);
    }

    if (t.time < 200 && stage == 1) { //rate of firing bullet starts slowly for enemy space ship in stage 1 and increases after specific time interval
      if (t.time%40 == 0) {
        boolean found = false;
        int elem = 0;
        while (found == false) {
          if (epos[elem][0] == 0 && epos[elem][1] == 0) {
            found = true;
            epos[elem][0] = b; //appends bullet position to a list to allow movement of bullets independent of the movement of ship
            epos[elem][1] = by;
            elaser.rewind();
            elaser.play(); //plays enemy bullet sound
          } else {
            elem ++;
          }
        }
      }
    } else if (t.time < 600 && t.time >= 200 && stage == 1) {
      if (t.time%30 == 0) { //rate of firing bullet for enemy spaceship increased from previous
        boolean found = false;
        int elem = 0;
        while (found == false) {
          if (epos[elem][0] == 0 && epos[elem][1] == 0) {
            found = true;
            epos[elem][0] = b; //appends bullet position to a list to allow movement of bullets independent of the movement of ship
            epos[elem][1] = by;
            elaser.rewind();
            elaser.play(); //plays enemy bullet sound
          } else {
            elem ++;
          }
        }
      }
    } else {
      if (t.time%20 == 0) { //rate of firing bullet for enemy spaceship increased from previous
        boolean found = false;
        int elem = 0;
        while (found == false) {
          if (epos[elem][0] == 0 && epos[elem][1] == 0) {
            found = true;
            epos[elem][0] = b; //appends bullet position to a list to allow movement of bullets independent of the movement of ship
            epos[elem][1] = by;
            elaser.rewind();
            elaser.play(); //plays enemy bullet sound
          } else {
            elem ++;
          }
        }
      }
    }

    for (int cnt=0; cnt<10; cnt++) {
      if (epos[cnt][0] != 0 || epos[cnt][1] != 0) {
        image(bullet, epos[cnt][0], epos[cnt][1], 30, 30); //displays image of enemy bullet
        epos[cnt][1] += 20; //sets speed of vertical movement of bullet
        if (epos[cnt][0] >= t.ship.x && epos[cnt][0] < t.ship.x + 141 && epos[cnt][1] >= 900 && epos[cnt][1] < 950) { //to check if bullet hits spaceship
          if (t.powerup.flag == true) {
            t.health += 10; //if spaceship is hit when having absorber powerup, health increases by 10
            epos[cnt][1] = 1000; //bullet goes off the screen
          } else {
            image(blast, t.ship.x, 850, 150, 150); //displays image of blast when hit by enemy bullets
            blasts.rewind();
            blasts.play(); //plays blast sound effect
            t.health -= 20; //health decreases by 20 when hit by enemy bullet
            epos[cnt][1] = 1000;
            if (t.health <= 0) { //lose condition if health becomes less than or equal to 0
              t.state = "lost";
            }
          }
        }
      }

      if (epos[cnt][1] > 1000) { //recycle array positions for bullets that have gone off screen
        epos[cnt][0] = 0;
        epos[cnt][1] = 0;
      }
    }

    if (stage == 3) {
      if (t.time%20 == 0) {
        boolean found = false;
        int elem = 0;
        while (found == false) {
          if (epos2[elem][0] == 0 && epos2[elem][1] == 0) {
            found = true;
            epos2[elem][0] = b2; //appends bullet for 2nd enemy ship in stage 3
            epos2[elem][1] = by;
          } else {
            elem ++;
          }
        }
      }
      for (int cnt=0; cnt<10; cnt++) {
        if (epos2[cnt][0] != 0 || epos2[cnt][1] != 0) {
          image(bullet, epos2[cnt][0], epos2[cnt][1], 30, 30); //displays bullet
          epos2[cnt][1] += 20; //allows vertical movement of enemy bullet
          if (epos2[cnt][0] >= t.ship.x && epos2[cnt][0] < t.ship.x + 141 && epos2[cnt][1] >= 900 && epos2[cnt][1] < 950) {
            if (t.powerup.flag == true) {
              t.health += 10; //if spaceship is hit when having absorber powerup, health increases by 10
              epos2[cnt][1] = 1000; //bullet goes off the screen
            } else {
              image(blast, t.ship.x, 850, 150, 150); //displays image of blast when hit by enemy bullets
              blasts.rewind();
              blasts.play(); //plays blast sound effect
              t.health -= 20; //health decreases by 20 when hit by enemy bullet
              epos2[cnt][1] = 1000;
              if (t.health <= 0) { //lose condition if health becomes less than or equal to 0
                t.state = "lost";
              }
            }
          }
        }

        if (epos2[cnt][1] > 1000) { //recycle array positions for bullets that have gone off screen
          epos2[cnt][0] = 0;
          epos2[cnt][1] = 0;
        }
      }
    }

    if (stage == 2 || stage == 3) { //for movement of enemy spaceship in stage 2 and 3
      x += y; //movement along x-axis
      b = x+105;
      if (x < 10 || x > 550) { //prevents from going out of the frame
        y = -1 * y; //reverses motion of enemy spaceship when reaches end of frame
      }
    }

    if (stage == 3) { //for movement of the 2nd enemy spaceship in stage 3
      x2 -= y2;
      b2 = x2+105;
      if (x2 < 10 || x2 > 550) {
        y2 = -1 * y2;
      }
    }
  }
}
