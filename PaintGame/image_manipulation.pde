/*
Image manipulation assignment
 Yusra Khan
 13th Oct 2020
 */

PImage img;
color c = color(255); //pixel color
int imageNum; //random selected image
String mode = "new"; //what to display
int brush = 1; //brush size
int dim = 5; //diameter of paint

//to draw the image
void setImage(String m) {
  //when every new image is loaded
  if (m == "new") {
    background(205, 176, 228);
    fill(0);
    textSize(24);
    //instructions
    text("RIGHT click to select color", 50, 200);
    text("LEFT press to paint", 50, 240);
    text("ENTER to start", 50, 280);

    //displaying one image at random
    if (keyPressed && key == ENTER) {
      imageNum = int(random(1, 11));
      img = loadImage("flowers"+str(imageNum)+".jpg");
      image(img, 50, 0, 450, 800);
      mode = "draw";
    }

    //when reload button is clicked
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
  //side toolbar
  noStroke();
  fill(205, 176, 228);
  rect(0, 0, 50, 800);

  //call image drawing function
  setImage(mode);

  //execute following only when image has been displayed
  if (mode != "new") {
    //line to seperate toolbar from image
    fill(0);
    stroke(0);
    line(50, 0, 50, 800);

    //brush size options
    fill(c);
    noStroke();
    int diameter = 5;
    int y = 160;
    for (int x=1; x<6; x++) {
      //highlight which brush is selected
      if (brush == x) {
        stroke(0);
        dim = diameter;
      }
      ellipse(25, y, diameter, diameter);
      y=y-(20+(5*x));
      diameter+=5;
      noStroke();
    }

    //paint when mouse is presses and only paint on the image
    if (mousePressed && (mouseButton == LEFT) && mouseX>50) {
      noStroke();
      fill(c);
      ellipse(mouseX, mouseY, dim, dim);
    }

    //new image and reload buttons
    image(loadImage("new.png"), 1, 680, 45, 50);
    image(loadImage("reload.png"), 5, 740, 40, 40);
  }
}

void mouseClicked() {
  //mouse click functions only when the image has been displayed
  if (mode != "new") {
    //right click to select color
    if (mouseButton == RIGHT) {
      c = get(mouseX, mouseY);

      //on left click
    } else {
      //brush selections
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

        //new image and reload buttons
      } else if (mouseX>5 && mouseX<45 && mouseY>680 && mouseY<730) {
        mode = "new";
      } else if (mouseX>5 && mouseX<45 && mouseY>740 && mouseY<780) {
        mode = "reload";
      }
    }
  }
}
