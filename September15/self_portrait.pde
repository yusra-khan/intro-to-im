//Intro to IM self-portrait assignment

void setup() {
  size(500, 500);
  background(225, 190, 248);
}

void draw() {
  
  //LEGS
  stroke(0);
  strokeWeight(1);
  fill(10);
  quad(224, 250, 278, 250, 282, 370, 220, 370);
  fill(225, 190, 248);
  triangle(250, 270, 260, 370, 240, 370);
  stroke(225, 190, 248);
  line(240, 370, 260, 370);
  //feet
  stroke(0);
  fill(255);
  arc(226, 371, 30, 25, radians(160), radians(360), CHORD);
  line(211, 371, 241, 367);
  arc(266, 371, 30, 25, radians(160), radians(360), CHORD);
  line(251, 371, 281, 367);

  //TORSO
  //hands
  stroke(0);
  fill(255, 231, 183);
  arc(222, 240, 25, 40, radians(90), radians(180));
  arc(280, 240, 25, 40, radians(0), radians(90));
  noFill();
  arc(222, 240, 15, 30, radians(90), radians(155));
  arc(280, 240, 15, 30, radians(25), radians(90));
  //arms
  fill(31, 6, 59);
  rect(202, 160, 20, 80, 10, 0, 0, 0);
  arc(212, 212, 50, 60, radians(70), radians(110));
  rect(280, 160, 20, 80, 0, 10, 0, 0);
  arc(290, 212, 50, 60, radians(70), radians(110));
  //shirt
  fill(250);
  rect(222, 160, 58, 90, 0, 0, 10, 10);
  arc(250, 215, 80, 90, radians(50), radians(130));
  //jacket
  fill(31, 6, 59);
  rect(222, 178, 22, 84, 0, 50, 5, 10);
  rect(258, 178, 22, 84, 50, 0, 10, 5);
  //strings
  stroke(255);
  strokeWeight(2);
  noFill();
  arc(275, 205, 80, 90, radians(190), radians(200));
  arc(196, 206, 80, 90, radians(350), radians(360));
  arc(199, 192, 80, 90, radians(20), radians(30));
  line(265, 190, 265, 200);
  arc(280, 198, 30, 40, radians(150), radians(170));

  //HIJAB
  stroke(0);
  strokeWeight(1);
  fill(30);
  ellipse(250, 117, 100, 150);
  fill(225, 190, 248);
  ellipse(250, 107, 70, 100);

  //NECK
  fill(255, 231, 183);
  quad(240, 140, 260, 140, 265, 152, 235, 152);
  arc(250, 107, 70, 100, radians(68), radians(112));

  //FACE
  fill(255, 231, 183);
  ellipse(250, 100, 70, 100);

  //CAP
  noStroke();
  fill(100);
  arc(250, 100, 69, 99, radians(200), radians(340), CHORD);
  stroke(0);
  fill(255, 231, 183);
  arc(250, 105, 110, 60, radians(229), radians(312));

  //EYES
  fill(255);
  ellipse(235, 95, 20, 10);
  ellipse(265, 95, 20, 10);
  fill(111, 74, 0);
  ellipse(235, 95, 8, 8);
  ellipse(265, 95, 8, 8);
  fill(0);
  ellipse(235, 95, 5, 5);
  ellipse(265, 95, 5, 5);
  fill(255);
  ellipse(234, 93, 3, 3);
  ellipse(264, 93, 3, 3);

  //EYEBROWS
  strokeWeight(2);
  noFill();
  arc(235, 95, 30, 20, radians(235), radians(305));
  arc(265, 95, 30, 20, radians(235), radians(305));

  //NOSE
  strokeWeight(1);
  arc(267, 100, 30, 40, radians(150), radians(190));
  arc(244, 115, 30, 10, radians(330), radians(360));
  arc(244, 115, 30, 10, radians(0), radians(60));

  //MOUTH
  fill(246, 154, 181);
  noStroke();
  arc(250, 119, 23, 30, radians(50), radians(130));
  fill(255, 231, 183);
  stroke(0);
  arc(250, 120, 30, 20, radians(45), radians(135));
  line(237, 128, 238, 125);
  line(262, 128, 261, 125);

  //HIJAB(inner)
  noFill();
  stroke(30);
  strokeWeight(8);
  arc(250, 105, 75, 105, radians(188), radians(352));
  stroke(0);
  strokeWeight(1);
  ellipse(250, 107, 70, 100);
  stroke(30);
  arc(250, 106, 70, 100, radians(188), radians(352));
  noFill();
  stroke(0);
  arc(250, 150, 70, 60, radians(40), radians(140));
  arc(250, 120, 85, 100, radians(130), radians(180));
  arc(250, 120, 85, 100, radians(0), radians(50));
  arc(250, 140, 50, 60, radians(70), radians(110));
  arc(250, 100, 70, 100, radians(188), radians(240));
  arc(250, 100, 70, 100, radians(300), radians(350));

  //GLASSES
  strokeWeight(2);
  stroke(143, 143, 143);
  ellipse(235, 98, 24, 24);
  ellipse(265, 98, 24, 24);
  arc(250, 100, 5, 5, radians(235), radians(305));
  line(223, 93, 220, 88);
  line(277, 93, 280, 88);
}
