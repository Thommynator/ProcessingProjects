class Particle {
  float x;
  float y;
  float heading;
  float weight;

  Particle(float xPos, float yPos, float heading, float weight) {
    this.x = xPos;
    this.y = yPos;
    this.heading = heading;
    this.weight = weight;
  }

  /**
  * Measure the distance to the next obstacle or canvas border in heading direction of the particle.
  */
  float measureDistance() {
    PVector checkPos = new PVector(this.x, this.y);
    // ray casting, check if ray hits target or canvas border
    while (checkPos.x < width && checkPos.y < height && checkPos.x > 0 && checkPos.y > 0) {
      checkPos.x += sin(this.heading);
      checkPos.y -= cos(this.heading);
      if (red(get((int)checkPos.x, (int)checkPos.y)) == 255) {
        break;
      }
    }
    // compute euclidean distance
    return sqrt(pow(checkPos.x-this.x, 2) + pow(checkPos.y-this.y, 2));
  }
}