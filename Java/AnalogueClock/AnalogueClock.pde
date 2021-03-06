Pointer hourP, minuteP, secondP;
int millis;
int clockRadius = 200;
PImage sun, moon, leftImg, rightImg;

void setup() {
  size(600, 600);
  background(220);

  hourP = new Pointer(clockRadius-clockRadius*0.5, 5);
  minuteP = new Pointer(clockRadius-clockRadius*0.2, 3);
  secondP = new Pointer(clockRadius-clockRadius*0.05, 1);

  // load images for daylight indicator
  sun  = loadImage("data/sun.png");
  moon = loadImage("data/moon.png");
  leftImg = loadImage("data/left.png");
  rightImg = loadImage("data/right.png");
  millis = second()*1000;
}

void draw() {
  background(220);
  drawClock();
  daylightIndicator();

  // compute pointer position
  hourP.angle = map(hour()+minute()/60.0, 0, 12, 0, 2*PI);
  minuteP.angle = map(minute()+second()/60.0, 0, 60, 0, 2*PI);
  secondP.angle = map((millis+millis())%60000, 0, 60000, 0, 2*PI);

  // display all pointer
  hourP.show();
  minuteP.show();
  secondP.show();
  millis = millis%60000;
}

void drawClock() {
  ellipseMode(CENTER);
  fill(250);
  strokeWeight(10);
  ellipse(width/2, height/2, clockRadius*2, clockRadius*2);

  // 5 minutes indicator
  for (int i=0; i<12; i++) {
    float angle = map(i, 0, 12, 0, 2*PI);
    int x1 = int(width/2 + sin(angle)*clockRadius);
    int y1 = int(height/2 - cos(angle)*clockRadius);
    int x2 = int(width/2 + sin(angle)*(clockRadius-clockRadius*0.05));
    int y2 = int(height/2 -cos(angle)*(clockRadius-clockRadius*0.05));
    strokeWeight(2);
    line(x1, y1, x2, y2);
  }

  // 1 minute indicator
  for (int i=0; i<60; i++) {
    float angle = map(i, 0, 60, 0, 2*PI);
    int x1 = int(width/2 + sin(angle)*clockRadius);
    int y1 = int(height/2 - cos(angle)*clockRadius);
    int x2 = int(width/2 + sin(angle)*(clockRadius-clockRadius*0.03));
    int y2 = int(height/2 -cos(angle)*(clockRadius-clockRadius*0.03));
    strokeWeight(2);
    line(x1, y1, x2, y2);
  }
}


void daylightIndicator() {
  imageMode(CENTER);

  strokeWeight(5);
  int lineHeight = height-50;
  int left = 150;
  int right = width-left;
  line(left, lineHeight, right, lineHeight);

  fill(220);
  float pos;
  if (hour() < 12) {
    // sunrise
    pos = map((hour()*60+minute())%(12*60), 0, (12*60), left, right);
    ellipse(pos, lineHeight, 30, 30);
    image(rightImg, pos, lineHeight);
    // sunset
  } else {
    pos = map((hour()*60+minute())%(12*60), 0, (12*60), right, left);
    ellipse(pos, lineHeight, 30, 30);
    image(leftImg, pos, lineHeight);
  }

  image(moon, left-50, lineHeight);
  image(sun, right+50, lineHeight);
}