class Pendulum {
  float l; // length
  float phi; // angle
  float r; // ball radius
  boolean increaseAngle;
  float range;
  color c;

  Pendulum(float pendulumLength, float radius) {
    this.l = pendulumLength;
    this.phi = 0;
    this.r = radius;
    this.increaseAngle = true;
    this.range = 0.4;
    c = color(map(pendulumLength, 0, 500, 80,240),150);
  }

  void show() {
    fill(this.c);
    stroke(150, 128);
    line(origin.x, origin.y, (l-this.r)*sin(phi)+width/2, (l-this.r)*cos(phi));
    stroke(0);
    ellipse(l*sin(phi)+width/2, l*cos(phi), r*2, r*2);
  }

  void updateAngle(float t) {
    float omega = sqrt(9.81/this.l);
    this.phi = range * sin(omega*t);
  }
}