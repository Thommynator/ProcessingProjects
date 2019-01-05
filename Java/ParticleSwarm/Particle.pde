class Particle {

  PVector pos; // x, y pos
  float v; // velocity
  float heading; // in rad
  float r; // radius i n px
  color clr; 
  int rndOffsetX = 0;
  int rndOffsetY = 0;


  Particle(float x, float y) {
    pos = new PVector(x, y);
    v = 0;
    heading = random(0, PI);
    r = random(5,15);
    clr = color(random(20,200), 50);
  }

  void show() {
    fill(clr);
    stroke(0,50);
    ellipse(pos.x, pos.y, r*2, r*2);
  }

  void move(float x, float y) {
    int spread = 10;
    float dx = pos.x - x; //<>//
    float dy = pos.y - y;
    rndOffsetX += random(-spread, spread);
    rndOffsetY += random(-spread, spread);
    float speed = 0.01;
    if(mousePressed) speed = 0.02;
    
    pos.x -= speed*(dx + rndOffsetX);
    pos.y -= speed*(dy + rndOffsetY);
    
    if(pos.x > width) pos.x = width;
    if(pos.x < 0) pos.x = 0;
    if(pos.y > height) pos.y = height;
    if(pos.y < 0) pos.y = 0;
  }
}