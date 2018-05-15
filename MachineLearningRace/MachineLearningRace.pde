int amountOfCars = 10;
int iteration = 1;
Population population;
ArrayList<PVector> trackCoordinates;
int[] backgroundPixels;
color streetColor = color(20);

void setup() {
  size(800, 800);
  population = new Population(amountOfCars);
  createTrack(10);
}

void draw() {
  background(200);
  textSize(20);
  fill(0);
  text("Iteration: "+iteration, 10, height-10); 
  drawTrack();

  population.update(); //<>//
  population.show();

  if (!population.isAlive()) {
    population = new Population(amountOfCars);
    //createTrack(10);
    iteration++;
  }
}

void createTrack(int points) {
  PVector start = new PVector(0, 0);
  trackCoordinates = new ArrayList();
  trackCoordinates.add(start); // start control point (not drawn)
  trackCoordinates.add(start);

  if (points>0) {
    int widthFactor = width/points;
    int heightFactor = height/points;
    for (int i= 1; i<points-1; i++) {
      trackCoordinates.add(
        new PVector(int(widthFactor*i + random(200)), int(heightFactor*i + random(200))));
    }
  }
  PVector end = new PVector(width, height);
  trackCoordinates.add(end); // end control point (not drawn)
  trackCoordinates.add(end);
}

void drawTrack() {
  noFill();
  strokeWeight(60);
  stroke(streetColor);
  beginShape();
  for (PVector coord : trackCoordinates) {
    curveVertex(coord.x, coord.y);
  }
  endShape();
  strokeWeight(1);
  backgroundPixels = get().pixels;
}