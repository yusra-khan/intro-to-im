/*
Data visualization assignment
Yusra Khan | 6th Oct 2020
data used: avatar.csv from https://www.kaggle.com/ekrembayar/avatar-the-last-air-bender
*/

size(800, 2000);
background(255, 242, 204);

PFont font;
font = createFont("Corbel", 32);
textFont(font);

Table data = loadTable("avatar.csv", "header"); //file from source
String characters[] = loadStrings("characters.csv"); //file made by me

//2D array of characters file data
String chars[][] = new String[characters.length][3];
for (int i=0; i<characters.length; i++) {
  chars[i] = split(characters[i], ",");
}

//get number of times a name is spoken from the internet data
for (int i=0; i<data.getRowCount(); i++) {
  //only look at the dialogues column
  String dialogue[] = split(data.getString(i, "character_words"), " ");
  for (int j=0; j<dialogue.length; j++) {
    for (int k=0; k<characters.length; k++) {
      //compare each word of dialogue with each name
      if (dialogue[j].length() > chars[k][1].length()-1 && dialogue[j].substring(0, chars[k][1].length()).equals(chars[k][1])) {
        chars[k][2] = str(int(chars[k][2])+1); //increase name count when matched
      }
    }
  }
}

int index, y;
boolean exists;
int done[] = new int[characters.length];
for(int i=0; i<characters.length; i++){
  done[i] = -1;
}
y = 20;

line(140,0,140,2000);
textSize(20);
textAlign(RIGHT);
//display names in random order with repective bars
for(int i=0; i<characters.length; i++){
  index = int(random(0,characters.length));
  exists = true;
  while(exists==true){
    exists = false;
    for(int j=0; j<characters.length; j++){
      if(index == done[j]){
        exists = true;
        index = int(random(0,characters.length));
      }
    }
  }
  done[i] = index;

  fill(0);
  text(chars[index][1].toUpperCase(), 130, y);
  noStroke();
  fill(int(chars[index][3]), int(chars[index][4]), int(chars[index][5]));
  rect(141,y-15,int(chars[index][2]),20);
  y+=30;
}
