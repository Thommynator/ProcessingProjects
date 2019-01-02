// Inspired by Coding Train - Fourier Series: https://www.youtube.com/watch?v=Mm2eYfj0SgA
float angle = 0.0;
ArrayList<PVector> points = new ArrayList();
int nSeries = 3;
int speed = 3;

void setup() {
  size(1200, 600);
  background(60);
}

void draw() {
  background(60);
  textSize(20);
  text("n=" + nSeries + ";\t \t \t speed= " + speed, 20, 30);
  text("Press UP/DOWN for n-change. \t LEFT/RIGHT for speed-change.", 20, 60);

  translate(width/4, height/2);

  int len = 120;
  Rotor rotor = new Rotor(new PVector(0.0, 0.0), len, angle, 1);
  rotor.show(true);

  for (int i=3; i<(1+2*nSeries); i+=2) {
    rotor = new Rotor(new PVector(rotor.getX(), rotor.getY()), len, angle, i);
    rotor.show(true);
  }

  stroke(200, 50);
  line(rotor.getX(), rotor.getY(), 200, rotor.getY());
  addToList(rotor.getX(), rotor.getY());
  drawPoints();
  angle += speed / 100.0;
}

void addToList(int x, int y) {
  points.add(0, new PVector(x, y));
  if (points.size() > 600) {
    points.remove(points.size() - 1);
  }
}

void drawPoints() {
  strokeWeight(2);
  stroke(200);
  noFill();

  beginShape();
  for (int i=0; i<points.size(); i++) {
    PVector vec = points.get(i);
    vertex(200+i, vec.y);
  }
  endShape();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (nSeries < 100) {
        nSeries += 1;
      }
    } else if (keyCode == DOWN) {
      if (nSeries > 1) {
        nSeries -= 1;
      }
    } else if (keyCode == LEFT) {
      if (speed > 0) {
        speed -= 1;
      }
    } else if (keyCode == RIGHT) {
      if (speed < 10) {
        speed += 1;
      }
    }
  }
}
