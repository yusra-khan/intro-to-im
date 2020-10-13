/*
Image manipulation assignment
Yusra Khan
13th Oct 2020
*/

PImage img;
color c = color(255);
int imageNum;
String mode = "new";
int brush = 1;
int dim = 5;

void setImage(String m) {
  if (m == "new") {
    background(205, 176, 228);
    fill(0);
    textSize(24);
    text("RIGHT click to select color", 50, 200);
    text("LEFT press to paint", 50, 240);
    text("ENTER to start", 50, 280);
    if (keyPressed && key == ENTER) {
      imageNum = int(random(1, 11));
      img = loadImage("flowers"+str(imageNum)+".jpg");
      image(img, 50, 0, 450, 800);
      mode = "draw";
    }
  } else if (m == "reload") {
    img = loadImage("flowers"+str(imageNum)+".jpg");
    image(img, 50, 0, 450, 800);
    mode = "draw";
  }
}

void setup() {
  size(500, 800);
}

void draw() {
  noStroke();
  fill(205, 176, 228);
  rect(0, 0, 50, 800);
  setImage(mode);
  if (mode != "new") {
    fill(0);
    stroke(0);
    line(50, 0, 50, 800);
    fill(c);
    int diameter = 5;
    int y = 160;
    for (int x=1; x<6; x++) {
      if (brush == x) {
        stroke(0);
        dim = diameter;
      }
      ellipse(25, y, diameter, diameter);
      y=y-(20+(5*x));
      diameter+=5;
      noStroke();
    }
    if (mousePressed && (mouseButton == LEFT) && mouseX>50) {
      noStroke();
      fill(c);
      ellipse(mouseX, mouseY, dim, dim);
    }
    image(loadImage("new.png"), 1, 680, 45, 50);
    image(loadImage("refresh.png"), 5, 740, 40, 40);
  }
}

void mouseClicked() {
  if (mode != "new") {
    if (mouseButton == RIGHT) {
      c = get(mouseX, mouseY);
    } else {
      if (mouseX>22 && mouseX<28 && mouseY>157 && mouseY<163) {
        brush=1;
      } else if (mouseX>20 && mouseX<30 && mouseY>130 && mouseY<140) {
        brush=2;
      } else if (mouseX>18 && mouseX<32 && mouseY>98 && mouseY<112) {
        brush=3;
      } else if (mouseX>15 && mouseX<35 && mouseY>60 && mouseY<80) {
        brush=4;
      } else if (mouseX>13 && mouseX<37 && mouseY>18 && mouseY<42) {
        brush=5;
      } else if (mouseX>5 && mouseX<45 && mouseY>680 && mouseY<730) {
        mode = "new";
      } else if (mouseX>5 && mouseX<45 && mouseY>740 && mouseY<780) {
        mode = "reload";
      }
    }
  }
}
