class Rotor {

  PVector center;
  float radius;
  float angle;
  int n;

  Rotor(PVector center, int radius, float angle, int n) {
    this.center = center;
    this.radius = radius * (4 / (n * PI));
    this.angle = angle;
    this.n = n;
  }

  void show(boolean showCircle) {
    if (showCircle) {
      ellipseMode(CENTER);
      noFill();
      stroke(200, 80);
      ellipse(center.x, center.y, 2*radius, 2*radius);
    }

    float x = getX();
    float y = getY();
    stroke(200);
    line(center.x, center.y, x, y);

    fill(200, 200);
    strokeWeight(1);
    ellipseMode(CENTER);
    ellipse(x, y, 5, 5);
  }

  int getX() {
    return (int)(center.x + cos(n * angle) * radius);
  }

  int getY() {
    return (int)(center.y + sin(n * angle) * radius);
  }
}
