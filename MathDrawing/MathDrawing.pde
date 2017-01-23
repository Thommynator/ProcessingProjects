int t = 0;
final int N_LINES = 50;
void setup() {
  colorMode(HSB);
  size(800, 800);
}

void draw() {
  translate(width/2, height/2);
  background(20);
  strokeWeight(2);

  for (int i=0; i<N_LINES; i++) {
    //point(x1(t), y1(t));
    int c = int(t+i);
    stroke(c%255, 100, 230, 100);
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));

    if (i<N_LINES-1) {
      stroke(c%255, 100, 230, 255);
      line(x1(t+i), y1(t+i), x1(t+i+1), y1(t+i+1));
      line(x2(t+i), y2(t+i), x2(t+i+1), y2(t+i+1));
    }
  }

  t++;
}

float x1(float t) {
  return sin(t/20)*width/3 + sin(t/14)*20;
}

float y1(float t) {
  return cos(t/35)*height/2.5;
}

float x2(float t) {
  return sin(t/15)*width/5 + sin(t/26)*20;
}

float y2(float t) {
  return cos(t/33)*80;
}