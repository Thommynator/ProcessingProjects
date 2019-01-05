int amountOfCars = 200;
int iteration = 1;
Population population;
ArrayList<PVector> trackCoordinates;
int[] backgroundPixels;
color streetColor = color(20);

int ttl = 1000; // time-to-live: amount of loops per iteration
int ttlCounter = 0;
int skipedFrames = 1;

void setup() {
  size(800, 800);
  population = new Population(amountOfCars);
  createTrack(10);
}

void draw() {
  background(200);
  textSize(20);
  fill(0);
  text("Iteration: " + iteration, 10, height-10); 
  text("Speed: " + skipedFrames + "x", 150, height-10); 
  drawTrack();

  population.show();
  population.getBestCar().neuralNet.show();

  for (int skip = 0; skip < skipedFrames; skip++) {
    population.update();

    if (!population.isAlive() || ttlCounter > ttl) {
      population.nextGeneration();
      iteration++;
      ttlCounter = 0;
      break;
    }
    ttlCounter++;
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

void keyPressed() {
  if (key == ' ') {
    createTrack(10);
  } else if (key == '+') {
    skipedFrames++;
  } else if (key == '-') {
    if (skipedFrames == 0) {
      return;
    }
    skipedFrames--;
  } else if (key == 'o'){
    population.overrideAllWithBest();
  }
  
}