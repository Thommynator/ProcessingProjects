class Car {
  color clr;
  PVector pos;
  float heading;
  float vel;

  int nSensors;
  ArrayList<Float> distances;

  float drivenDistance;
  boolean isAlive;

  float fitness;

  NeuralNet neuralNet;

  Car(PVector pos) {
    this.clr = color(240, 240, 255);
    this.pos = pos;
    this.heading = random(PI/2);
    this.vel = max(1, random(5));
    this.nSensors = 9; 
    this.distances = new ArrayList<Float>(nSensors);
    this.drivenDistance = 0.0;
    this.isAlive = true;

    this.neuralNet = new NeuralNet(nSensors, 6, 2);
  }

  void updateState() {
    if (isAlive()) {
      this.measureDistances();
      this.adaptControls();
      this.updatePosition();
    }
  }

  /**
   * Measures the distance of all sensors to a wall.
   * The sensors are more or less equally distributed over the front 180° cone of the car.
   * If the amount of sensors is odd, there will be no front sensor (0°). If the amount is
   * even, there will be a front sensor.
   */
  void measureDistances() {
    this.distances = new ArrayList<Float>(this.nSensors);

    if (this.nSensors % 2 != 0) {
      this.distances.add(normalizeDistance(rayDistance(this.heading)));
    }

    for (int i=1; i<=(nSensors/2); i++) {
      float angle = PI / (floor(nSensors/2)*2);
      this.distances.add(normalizeDistance(rayDistance(this.heading+i*angle))); 
      this.distances.add(normalizeDistance(rayDistance(this.heading-i*angle)));
    }
  }

  float rayDistance(float angle) {
    float x = this.pos.x; 
    float y = this.pos.y; 
    while (isInsideCanvas(x, y)) {
      if (!isOnTrack(x, y)) {
        break;
      }
      x += cos(angle)*2; 
      y += sin(angle)*2;
    }
    fill(255, 255, 255, 100); 
    ellipse(x, y, 5, 5); 
    strokeWeight(1); 
    stroke(255, 255, 255, 100); 
    line(this.pos.x, this.pos.y, x, y); 
    return dist(this.pos.x, this.pos.y, x, y);
  }

  /**
   * Normalizes the distances to range 0 to 1.
   */
  float normalizeDistance(float dist) {
    float maxDist = dist(0, 0, width, height); 
    return map(dist, 0, maxDist, 0, 1);
  }

  // adapt the amount of input nodes of the NeuralNet accordingly: distances.size() + 1 (vel)
  void adaptControls() {
    ArrayList<Float> inputs = distances; 
    //inputs.add(vel);

    ArrayList<Float> control = this.neuralNet.returnOutputs(inputs); 
    //println("vel change", control.get(0));
    //println("heading change", control.get(1));

    this.vel += control.get(0); 
    this.heading += control.get(1);
  }

  void updatePosition() {
    if (!isAlive()) {
      this.clr = color(255, 0, 0); 
      this.vel = 0.0; 
      return;
    }
    float deltaX = this.vel * cos(this.heading); 
    float deltaY = this.vel * sin(this.heading); 
    this.pos.x += deltaX; 
    this.pos.y += deltaY; 
    drivenDistance += abs(deltaX) + abs(deltaY);
  }

  float getFitness() {
    this.fitness = dist(this.pos.x, this.pos.y, 0, 0); 
    return this.fitness;
  }
  void show() {
    this.show(false);
  }

  void show(boolean highlight) {
    rectMode(CENTER); 
    if (highlight) {
      fill(color(255, 255, 0));
    } else {
      fill(this.clr);
    }
    stroke(0); 
    pushMatrix(); 
    translate(this.pos.x, this.pos.y); 
    rotate(this.heading); 
    rect(0, 0, 20, 10); 
    ellipse(5, 0, 3, 3); 
    popMatrix();
  }

  int convertCoordinateToIndex(float x, float y) {
    return floor(x) + floor(y) * width;
  }

  boolean isAlive() {
    // skip computation, if we already know from prev loop, that car is not alive
    if (!this.isAlive) {
      return false;
    }

    float x = pos.x; 
    float y = pos.y; 
    if (isInsideCanvas(x, y) && isOnTrack(x, y)) {
      return true;
    } else {
      this.isAlive = false; 
      return false;
    }
  }

  boolean isOnTrack(float x, float y) {
    return red(backgroundPixels[convertCoordinateToIndex(x, y)]) == red(streetColor)
      && green(backgroundPixels[convertCoordinateToIndex(x, y)]) == green(streetColor)
      && blue(backgroundPixels[convertCoordinateToIndex(x, y)]) == blue(streetColor);
  }

  boolean isInsideCanvas(float x, float y) {
    return x > 0 && x < width && y > 0 && y < height;
  }
}