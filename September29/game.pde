//Assignment 3: Game using OOP

class Game {
  String state;
  boolean levelChange;
  int bat_position, r, g, b, ballx, bally, xspeed, yspeed, hits, score;
  Brick[] bricks_arr=new Brick[20];
  Game() {
    state = "home";
    levelChange = true;
    bat_position = 260;
    ballx=168;
    bally=350;
    xspeed=2;
    yspeed=5;
    hits=0;
    score=0;
    for (int i=0; i<20; i++) {
      bricks_arr[i]=new Brick(-40, -40);
    }
  }

  //first function called; calls appropriate function
  void display() {
    if (state=="home") {
      homeScreen();
    } else if (state=="play") {
      play();
    } else {
      gameOver();
    }
  }

  //homescreen
  void homeScreen() {
    //random circles
    if (frameCount==1) {
      for (int i=0; i<20; i++) {
        int circlesize=int(random(10, 100));
        noStroke();
        fill(random(100, 250), random(100, 250), random(100, 250));
        ellipse(random(0, 600), random(0, 600), circlesize, circlesize);
      }
    }

    //title
    PFont font = createFont("Monospaced.bold", 32);
    textFont(font);
    textSize(50);
    fill(255);
    text("Brick", 225, 200);
    text("Breaker", 195, 250);

    //play button
    strokeWeight(4);
    stroke(255);
    fill(10, 121, 207);
    rect(220, 300, 160, 50, 20);
    textSize(36);
    fill(255);
    text("PLAY", 255, 336);
    delay(500);
  }

  //game play
  void play() {
    //when next level starts
    if (levelChange==true) {
      r=int(random(100, 250));
      g=int(random(100, 250));
      b=int(random(100, 250));
      //change background color
      background(r, g, b);
      hits=0;
      int x, y;
      x=-1;
      y=-1;
      //create bricks
      for (int i=0; i<20; i++) {
        boolean flag=true;
        while (flag==true) {
          flag=false;
          x=int(random(0, 15));
          y=int(random(0, 15));
          //check if brick already exists at position
          for (int j=0; j<20; j++) {
            if (x*40==bricks_arr[j].xcoord && y*20==bricks_arr[j].ycoord) {
              flag=true;
            }
          }
        }
        bricks_arr[i].xcoord=x*40;
        bricks_arr[i].ycoord=y*20;
        bricks_arr[i].create();
      }
      levelChange = false;
    }

    //create and control bat
    background(r, g, b);
    noStroke();
    fill(255);
    rect(bat_position, 580, 80, 10, 5);
    if (mouseX<40) {
      bat_position = 0;
    } else if (mouseX>520) {
      bat_position=520;
    } else {
      bat_position = mouseX-40;
    }
    for (int i=0; i<20; i++) {
      bricks_arr[i].create();
    }
    ball();
    //change level when all bricks removed
    if (hits==20) {
      levelChange=true;
      //increase speed
      xspeed = (abs(xspeed)+1)*(xspeed/abs(xspeed));
      yspeed = (abs(yspeed)+1)*(yspeed/abs(yspeed));
    }

    //score counter
    fill(0, 50);
    textSize(100);
    text(score, 10, 580);
  }

  //ball
  void ball() {
    ballx+=xspeed;
    bally+=yspeed;
    //collision with walls and bat
    if (ballx<10 || ballx>590) {
      xspeed = -xspeed;
    }
    if (bally<10 || (ballx>bat_position && ballx<bat_position+80 && bally>570)) {
      yspeed=-yspeed;
    }
    if (bally>610) {
      state="over";
    }
    //collisions with bricks
    for (int i=0; i<20; i++) {
      boolean hit=false;
      if (xspeed>0 && ballx>bricks_arr[i].xcoord-10 && ballx<bricks_arr[i].xcoord && bally>bricks_arr[i].ycoord-5 && bally<bricks_arr[i].ycoord+25) {
        xspeed=-xspeed;
        hit=true;
      }
      if (xspeed<0 && ballx>bricks_arr[i].xcoord+40 && ballx<bricks_arr[i].xcoord+50 && bally>bricks_arr[i].ycoord-5 && bally<bricks_arr[i].ycoord+25) {
        xspeed=-xspeed;
        hit=true;
      }
      if (yspeed>0 && bally>bricks_arr[i].ycoord-10 && bally<bricks_arr[i].ycoord && ballx>bricks_arr[i].xcoord-5 && ballx<bricks_arr[i].xcoord+45) {
        yspeed=-yspeed;
        hit=true;
      }
      if (yspeed<0 && bally>bricks_arr[i].ycoord+20 && bally<bricks_arr[i].ycoord+30 && ballx>bricks_arr[i].xcoord-5 && ballx<bricks_arr[i].xcoord+45) {
        yspeed=-yspeed;
        hit=true;
      }
      //remove brick when hit and increase score
      if (hit==true) {
        bricks_arr[i].xcoord=-40;
        bricks_arr[i].ycoord=-40;
        hits+=1;
        score+=1;
      }
    }

    //create ball
    noStroke();
    fill(59, 14, 84);
    ellipse(ballx, bally, 20, 20);
  }

  //gme over screen
  void gameOver() {
    background(0);
    fill(255);
    textSize(100);
    text("Game Over", 30, 200);
    textSize(50);
    text("Score:"+score, 190, 300);

    //play again button
    strokeWeight(4);
    stroke(255);
    fill(10, 121, 207);
    rect(180, 350, 240, 50, 20);
    textSize(36);
    fill(255);
    text("PLAY AGAIN", 190, 385);
  }
}

//brick object
class Brick {
  int xcoord, ycoord;
  Brick(int x, int y) {
    xcoord=x;
    ycoord=y;
  }

  void create() {
    strokeWeight(2);
    stroke(0);
    fill(172, 92, 58);
    rect(xcoord, ycoord, 40, 20);
  }
}

void setup() {
  size(600, 600);
  background(0);
}

Game game = new Game();

void draw() {
  game.display();
}

void mouseClicked() {
  //when play button clicked
  if (game.state == "home" && mouseX>224 && mouseY>304 && mouseX<376 && mouseY<346) {
    game.state = "play";
  }
  //when play again button clicked
  else if (game.state=="over" && mouseX>184 && mouseY>354 && mouseX<416 && mouseY<396) {
    game.state="play";
    game.levelChange = true;
    game.bat_position = 260;
    game.ballx=168;
    game.bally=350;
    game.score=0;
    game.xspeed=2;
    game.yspeed=5;
  }
}
