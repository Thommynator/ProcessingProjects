class Particle { //<>//
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
  float[] measureDistance(boolean showMeasurement) {
    float[] dist = new float[5];
    for (int i=-dist.length/2; i<=dist.length/2; i++) {
      PVector checkPos = new PVector(this.x/downSampleFactor, this.y/downSampleFactor);
      // ray casting, check if ray hits target or canvas border
      while (checkPos.x < downSampledBG.width && checkPos.y < downSampledBG.height && checkPos.x > 0 && checkPos.y > 0) {
        checkPos.x += sin(this.heading + i*0.1);
        checkPos.y -= cos(this.heading + i*0.1);
        if (red(downSampledBG.get((int)checkPos.x, (int)checkPos.y)) > 230) {
          break;
        }
      }

      checkPos.x = checkPos.x*downSampleFactor;
      checkPos.y = checkPos.y*downSampleFactor;
      if (showMeasurement) {
        strokeWeight(1);
        stroke(20);
        line(this.x, this.y, checkPos.x, checkPos.y);
      }
      // compute euclidean distance
      dist[i+dist.length/2] = sqrt(pow(checkPos.x-this.x, 2) + pow(checkPos.y-this.y, 2));
    }
    return dist;
  }
}