ArrayList<Particle> particles = new ArrayList();

void setup() {
  size(800, 800);
  background(50);
  for (int i=0; i<100; i++) {
    float x = width/2 + random(-10, 10);
    float y = height/2 + random(-10, 10);
    particles.add(new Particle(x, y));
  }
}

void draw() {

  for (Particle p : particles) {
    p.move(mouseX, mouseY);
    p.show();
  }
}