class SpaceShip {
  int x, y, vx, hit, hit2;
  boolean killed;
  PImage img, bullet, blast;
  StringDict keyHandler;
  int[][] bpos;

  SpaceShip(int xcoord, int ycoord) {
    x = xcoord; //x-coordinate of spaceship
    y = ycoord; //y-coordinate of spaceship
    vx = 0; //to set the speed of the spaceship
    killed = false; //if the enemy is killed
    hit = 0; //number of times the enemy is hit by a bullet
    hit2 = 0; //number of times the 2nd enemy in stage 3 is hit
    img = loadImage("/images/player.png");
    bullet = loadImage("/images/fire.png");
    blast = loadImage("/images/blast.png");
    keyHandler = new StringDict();
    keyHandler.set("left", "false");
    keyHandler.set("right", "false");
    keyHandler.set("up", "false");
    bpos = new int[50][2]; //list to keep track of bullet position
    for (int i=0; i<50; i++) {
      bpos[i][0] = 0;
      bpos[i][1] = 0;
    }
  }

  void display() {
    image(img, x, y, 150, 150); //displays image of spaceship

    if (keyHandler.get("left").equals("true")) {
      if (x <= 0) {
        vx = 0;
      } else {
        vx = -30; //Allows movement towards left when the 'LEFT' key is pressed
      }
    } else if (keyHandler.get("right").equals("true")) {
      if (x >= 550) {
        vx = 0;
      } else {
        vx = 30; //Allows movement towards right when the 'RIGHT' key is pressed
      }
    } else {
      vx = 0;
    }
    x += vx; //x coordinate changes depending on the key pressed allowing movement

    if (keyHandler.get("up").equals("true")) {
      boolean found = false;
      int elem = 0;
      while (found == false) {
        if (bpos[elem][0] == 0 && bpos[elem][1] == 0) {
          found = true;
          bpos[elem][0] = x; //position for shooting of a bullet when 'UP' key is pressed
          bpos[elem][1] = 850;
          slaser.rewind();
          slaser.play(); //plays bullet sound
          keyHandler.set("up", "false"); //Allows another bullet to be fired
        } else {
          elem ++;
        }
      }
    }

    for (int cnt=0; cnt<50; cnt++) {
      if (bpos[cnt][0] != 0 || bpos[cnt][1] != 0) {
        bpos[cnt][1] -= 20; //spaceship bullet speed allowing movement
        image(bullet, bpos[cnt][0]+60, bpos[cnt][1], 30, 30); //shows image of bullet
        if (t.time >= 1200 && bpos[cnt][1] <= 150 && bpos[cnt][1]>0 && bpos[cnt][0] >= t.boss.x-40 && bpos[cnt][0]< t.boss.x+210) { //sets condition and range to hit Boss ship
          hit += 1; //keeps count of hits
          image(blast, bpos[cnt][0], 50, 150, 150); //shows blast image when bullet collides with enemy
          blasts.rewind();
          blasts.play(); //plays sound of blast when bullet collides with boss ship
          bpos[cnt][1] = -20;
          if (hit == 40) { //boss dies when hit 40 times
            killed = true;
          }
        } else {
          if (bpos[cnt][1]==110 && bpos[cnt][0] >= t.enemy.x && bpos[cnt][0] < t.enemy.x+125) { //sets condition and range to hit enemy ship
            hit += 1; //keeps count of hits
            image(blast, t.enemy.x, 0, 150, 150); //shows image of blast
            blasts.rewind();
            blasts.play(); //plays sound of blast when bullet collides with enemy
            if (hit == 2) { //enemy ship dies after 2 hits
              t.enemy.state = "dead";
              killed = true;
              bpos[cnt][1] = -20;
            }
          }
          if (stage == 3 && bpos[cnt][1]==110 && bpos[cnt][0] >= t.enemy.x2 && bpos[cnt][0] < t.enemy.x2+125) {
            hit2 += 1; //keeps track of hits of 2nd enemy ship in stage 3
            image(blast, t.enemy.x2, 0, 150, 150);
            blasts.rewind();
            blasts.play();
            if (hit2 == 2) { //2nd enemy ship also dies after 2 hits
              t.enemy.state = "dead";
              killed = true;
              bpos[cnt][1] = -20;
            }
          }
        }
      }
      if (bpos[cnt][1] < -20) { //recycle array positions for bullets that have gone off screen
        bpos[cnt][0] = 0;
        bpos[cnt][1] = 0;
      }
    }
  }
}
