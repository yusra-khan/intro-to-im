int[] positions = {150, 300, 450}; //coordinates for the moving dot
int xposition, yposition, xcoord, ycoord, xinc, yinc;
int colorPos = 0;
int start = 0;

void setup() {
  size(600, 600);
  frameRate(5);
}

void draw() {
  background(199, 235, 232);

  //moving dots
  xposition = int(random(0, 3));
  yposition = int(random(0, 3));
  noStroke();
  fill(0);
  ellipse(positions[xposition], positions[yposition], 5, 5);

  //circle at mouse position
  fill(255, 147, 152);
  ellipse(mouseX, mouseY, 10, 10);

  //big circle
  stroke(0);
  strokeWeight(2);
  noFill();
  ellipse(80, 80, 160, 160);

  //inside circles
  xcoord = 80;
  ycoord = 40;
  xinc = 40;
  yinc = 40;
  for (int i = 0; i<4; i++) {
    //color switching
    int[] rgb = {255, 255, 255, 255};
    int pos = i+colorPos;
    if (pos > 3) {
      pos = pos-4;
    }
    rgb[pos] = 140;
    xcoord += xinc;
    ycoord += yinc;
    if (xcoord == 120) {
      xinc = -40;
    }
    if (xcoord == 40) {
      xinc = 40;
    }
    if (ycoord == 120) {
      yinc = -40;
    }
    if (ycoord == 40) {
      yinc = 40;
    }
    fill(rgb[0], rgb[1], rgb[2], 150);
    ellipse(xcoord, ycoord, 80, 80);
  }
  colorPos += 1;
  if (colorPos > 3) {
    colorPos = 0;
  }

  //moving zigzag lines
  int end1 = 0 + start;
  stroke(40, 97, 176);
  strokeWeight(3);
  while (end1<370) {
    for (int i=400; i<600; i+=60) {
      line(end1, i, end1+10, i-10);
      line(end1+10, i-10, end1+20, i);
    }
    end1 += 20;
  }
  int end2 = 370 - start;
  stroke(255, 122, 40);
  while (end2>0) {
    for (int i=430; i<600; i+=60) {
      line(end2, i, end2-10, i-10);
      line(end2-10, i-10, end2-20, i);
    }
    end2 -= 20;
  }
  start -= 2;

  //vertical lines
  for (int i=400; i<600; i+=60) {
    stroke(212, 22, 127);
    line(i, 0, i, 370);
    stroke(31, 203, 53);
    line(i+30, 0, i+30, 370);
  }

  //corner rectangles
  int rectx = 370;
  int recty = 370;
  int wid = 550;
  int len = 500;
  fill(199, 235, 232);
  stroke(0);
  for (int i=0; i<10; i++) {
    rect(rectx, recty, wid, len);
    rectx += 20;
    recty += 20;
    wid -= 40;
    len -= 40;
  }
}

//mouse trail
void mouseMoved() {
  noStroke();
  fill(251, 147, 152);
  ellipse(mouseX, mouseY, 10, 10);
}
