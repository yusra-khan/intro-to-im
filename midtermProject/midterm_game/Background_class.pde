class Background {
  int x1, x2, y1, y2;
  PImage img1, img2;

  Background(int xone, int xtwo, int yone, int ytwo) {
    x1 = xone; //x-coordinate of 1st background image
    x2 = xtwo; //x-coordinate of 2nd background image
    y1 = yone; //y-coordinate of 1st background image
    y2 = ytwo; //y-coordinate of 2nd background image
    img1 = loadImage("/images/stage"+str(stage)+".jpg"); //background image
    img2 = loadImage("/images/stage"+str(stage)+"b.jpg"); //inverted background image
  }

  void display() {
    if (y1 >= 0 || y1 >= -1000) {
      y1+=25;
      image(img1, 0, y1, 700, 1000); //Shows movement of background
    }
    if (y2 >= -1000) {
      y2+=25;
      image(img2, 0, y2, 700, 1000); //Shows movement of 2nd image background
    }
    if (y1 == 0) {
      y2 = -1000; //Brings back image back to its original position allowing a continuous moving background
    }
    if (y2 == 0) {
      y1 = -1000;
    }
  }
}
