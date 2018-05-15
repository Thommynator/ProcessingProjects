class Car {
  color clr;
  PVector pos;
  float heading;
  float vel;
  float[] distances;

  float drivenDistance;
  boolean isAlive;

  NeuralNet neuralNet;

  Car(PVector pos) {
    this.clr = color(240, 240, 255);
    this.pos = pos;
    this.heading = random(PI/2);
    this.vel = max(1, random(5));
    this.distances = new float[]{0.0, 0.0, 0.0, 0.0, 0.0};
    this.drivenDistance = 0.0;
    this.isAlive = true;

    this.neuralNet = new NeuralNet();
  }

  void updateState() {
    if (isAlive()) {
      this.measureDistances();
      this.adaptControls();
      this.updatePosition();
    }
  }

  void measureDistances() {
    this.distances[0] = rayDistance(this.heading-radians(20));
    this.distances[1] = rayDistance(this.heading-radians(10));
    this.distances[2] = rayDistance(this.heading);
    this.distances[3] = rayDistance(this.heading+radians(10));
    this.distances[4] = rayDistance(this.heading+radians(20));
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
    fill(0, 0, 255);
    ellipse(x, y, 5, 5);
    stroke(0, 0, 255, 125);
    line(this.pos.x, this.pos.y, x, y);
    float maxDist = dist(0, 0, width, height);
    return map(dist(this.pos.x, this.pos.y, x, y), 0, maxDist, 0, 1);
  }

  void adaptControls() {
    float[] control = this.neuralNet.returnOutputs(distances);
    println("vel change", control[0]);
    println("heading change", control[1]);

    this.vel += control[0];
    this.heading += control[1];
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
    return this.pos.x;
  }

  void show() {
    rectMode(CENTER);
    fill(this.clr);
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
  
  boolean isOnTrack(float x, float y){
    return red(backgroundPixels[convertCoordinateToIndex(x, y)]) == red(streetColor)
        && green(backgroundPixels[convertCoordinateToIndex(x, y)]) == green(streetColor)
        && blue(backgroundPixels[convertCoordinateToIndex(x, y)]) == blue(streetColor);
  }
  
  boolean isInsideCanvas(float x, float y) {
    return x > 0 && x < width && y > 0 && y < height;
  }
}