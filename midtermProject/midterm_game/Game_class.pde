class Game {
  int x1, x2, y1, y2, time, score, health;
  String state;
  PImage img, ins, logo, black;
  SpaceShip ship;
  Enemy enemy;
  Boss boss;
  Asteroid asteroid;
  Powerups powerup;


  Game() {
    x1 = 0; //x-coordinate of 1st image of background
    x2 = 0; //x-coordinate of 2nd image of background
    y1 = 0; //y-coordinate of 1st image of background
    y2 = -1000; //y-coordinate of 2nd image of background
    time = 1; //keep track of frames
    score = 0;
    health = 100;
    state = "initial";
    img = loadImage("/images/stage0.jpg");
    ins = loadImage("/images/instructions.png");
    logo = loadImage("/images/logo.png");
    black = loadImage("/images/logo.jpg");
    ship = new SpaceShip(300, 850);
    enemy = new Enemy();
    boss = new Boss();
    asteroid = new Asteroid();
    powerup = new Powerups();
  }

  void display() {
    if (state.equals("initial")) { //to display logo
      image(black, 50, 350, 600, 300);
      time += 1;
      if (time == 100) {
        state = "menu";
        time = 1;
      }
    } else if (state.equals("menu")) { //display homescreen
      image(img, 0, 0);
      homescreen();
    } else if (state.equals("instructions")) { //display instructions page
      image(ins, 0, 0);
      noFill();
      stroke(255);
      rect(590, 25, 100, 40, 7); //button back to homescreen
      fill(255);
      textSize(28);
      text("BACK", 605, 55);
    } else if (state.equals("play")) {
      Background b = new Background(x1, x2, y1, y2);
      b.display();
      x1 = b.x1;
      x2 = b.x2;
      y1 = b.y1;
      y2 = b.y2;
      ship.display();
      asteroid.display();
      scorecounter();
      powerup.health();
      powerup.absorber();
      time += 1;
      if (time >= 900 && (stage == 1 || stage == 2)) { //bring boss after 900 frames for stage 1 and 2
        boss.display();
      } else if (time >= 1200 && stage == 3) { //bring boss after 1200 frames for stage 3
        boss.display();
      } else {
        enemy.display();
      }
      healthpointer();
      homemusic.pause();
      if (stage == 1) { //play different music for every stage
        stage3.pause();
        stage1.play();
      } else if (stage ==2) {
        stage1.pause();
        stage2.play();
      } else if (stage == 3) {
        stage1.pause();
        stage2.pause();
        stage3.play();
      }
    } else if (state.equals("transition")) { //transition between stages
      background(0);
      textSize(100);
      fill(0, 0, 255);
      text("STAGE "+str(stage), 150, 500);
      for (int i=0; i<50; i++) { //refresh all positions
        ship.bpos[i][0] = 0;
        ship.bpos[i][1] = 0;
      }
      for (int i=0; i<10; i++) {
        enemy.epos[i][0] = 0;
        enemy.epos[i][1] = 0;
        enemy.epos2[i][0] = 0;
        enemy.epos2[i][1] = 0;
        for (int j=0; j<5; j++) {
          boss.by[i][j] = 0;
          boss.bllt[i][j] = 0;
        }
      }
      powerup.x = -1;
      powerup.y = -1;
      powerup.xa = -1;
      powerup.ya = -1;
      time += 1;
      if (time == 100) { //display transition screen for 100 frames
        state = "play";
        time = 1;
      }
    } else {
      if (state.equals("lost")) { //call gameover screen
        gameover();
        gamelose.play();
      } else if (state.equals("win")) { //call gamewin screen
        gamewin();
        gamewin.play();
      }
    }
  }

  void homescreen() {
    fill(255);
    stroke(255);
    rect(400, 500, 150, 50, 7); //make play and instructions buttons
    rect(370, 600, 250, 50, 7);
    textFont(font, 48);
    fill(0);
    textSize(32);
    text("PLAY", 435, 535);
    text("INSTRUCTIONS", 380, 635);
    image(logo, 30, 25, 500, 200);
    stage1.pause();
    stage2.pause();
    stage3.pause();
    homemusic.play(); //background music
  }

  void scorecounter() {
    if (time%10 == 0) { //increase score by 1 every 10 frames
      score += 1;
    }

    if (ship.killed == true) { //when an enemy is killed
      if (ship.hit >= 40) { //when a boss is killed
        if (stage == 3) { //game is won if stage 3 boss is killed
          score += 50;
          state = "win";
        } else {
          score += 50; //score increases by 50 when a boss is killed
          stage += 1; //next stage
          time = 1;
          state = "transition";
        }
      } else {
        score += 10; //score increases by 10 when a normal enemy is killed
      }

      if (ship.hit2 == 2) { //resetting the number of hits on the enemy
        ship.hit2 = 0;
      } else {
        ship.hit = 0;
      }

      ship.killed = false;
    }

    fill(255);
    textSize(25);
    text(score, 5, 30); //display the score in the corner
  }

  void healthpointer() {
    if (health < 0) { //to avoid health running out from the back if it goes into negatives
      health = 0;
    }

    stroke(255);
    noFill();
    rect(598, 20, 101, 20); //display the health bar
    noStroke();
    fill(0, 255, 0);
    rect(599, 21, health, 18);

    if (health <= 0) { //game is lost when health becomes 0
      state = "lost";
    }
  }

  void gameover() {
    textSize(100);
    fill(255, 0, 0);
    text("GAME OVER", 70, 400); //display the game over message
    textSize(48);
    text("Score:"+str(score), 250, 500); //display final score        
    fill(255);
    rect(250, 550, 220, 50, 7); //create play again and menu buttons
    rect(250, 650, 220, 50, 7);
    fill(0);
    textSize(32);
    text("PLAY AGAIN", 265, 585);
    text("MAIN MENU", 267, 685);
    homemusic.rewind(); //resets all background musics
    homemusic.pause();
    stage1.rewind();
    stage1.pause();
    stage2.rewind();
    stage2.pause();
    stage3.rewind();
    stage3.pause();
  }

  void gamewin() {
    textSize(100);
    fill(255, 0, 0);
    text("YOU WIN!!!", 70, 400); //display game win message
    textSize(48);
    text("Score: "+str(score), 250, 500); //display final score
    fill(255);
    rect(250, 550, 220, 50, 7); //create play again and menu buttons
    rect(250, 650, 220, 50, 7);
    fill(0);
    textSize(32);
    text("PLAY AGAIN", 265, 585);
    text("MAIN MENU", 267, 685);
    homemusic.rewind(); //resets all background musics
    homemusic.pause();
    stage1.rewind();
    stage1.pause();
    stage2.rewind();
    stage2.pause();
    stage3.rewind();
    stage3.pause();
  }
}
