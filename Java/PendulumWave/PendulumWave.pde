/**
 * Creates a list of several pendulums, which form a wave and synch over time.
 * The "cycleTime" parameter defines, after how many periods, the pendulums will
 * be synched again. 
 */

PVector origin = new PVector(300, 15);
ArrayList<Pendulum> pends = new ArrayList<Pendulum>();
float t = 0;
int cycleTime = 16; // pendulums are lined up, after this amount of periods

void setup() {
  size(600, 600);
  ellipseMode(CENTER);

  int nPendulums = 15;
  for (int i=0; i<nPendulums; i++) {
    pends.add(new Pendulum(computeLength(cycleTime+i, height-(height*0.1)), map(i,0,nPendulums,18,4)));
  }
}

void draw() {
  background(30);
  fill(100);
  ellipse(origin.x, origin.y, 4, 4);
  for (Pendulum p : pends) {
    p.updateAngle(t);
    p.show();
  }

  t += 0.5;
}

float computeLength(int T, float maxL) {
  return maxL*pow(float(cycleTime)/T, 2);
}