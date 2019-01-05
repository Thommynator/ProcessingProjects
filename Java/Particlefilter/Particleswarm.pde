class Particleswarm { //<>//

  int nParticles;
  float radius;
  ArrayList<Float> xPos = new ArrayList<Float>();  
  ArrayList<Float> yPos = new ArrayList<Float>();  
  ArrayList<Float> heading = new ArrayList<Float>();  
  ArrayList<Float> weights = new ArrayList<Float>();  

  Particleswarm() {
    this.nParticles = 200;
    this.radius = 8;
    this.initialize();
  }

  Particleswarm(int amountOfParticles) {
    this.nParticles = amountOfParticles;
    this.radius = 8;
    this.initialize();
  }

  Particleswarm(ArrayList<Particle> swarm) {
    this.nParticles = swarm.size();
    this.radius = 8;

    for (int i=0; i<this.nParticles; i++) {
      this.xPos.add(swarm.get(i).x);
      this.yPos.add(i, swarm.get(i).y);
      this.heading.add(i, swarm.get(i).heading);
      this.weights.add(i, 1.0/(swarm.size()-1));
    }
  }

  Particle getParticle(int idx) {
    return new Particle(this.xPos.get(idx), this.yPos.get(idx), this.heading.get(idx), this.weights.get(idx));
  }

  void initialize() {
    xPos = new ArrayList<Float>();  
    yPos = new ArrayList<Float>();  
    heading = new ArrayList<Float>();  
    weights = new ArrayList<Float>();  

    // generate random particles
    for (int i=0; i<this.nParticles; i++) {
      this.xPos.add(random(0, width));
      this.yPos.add(random(0, height));
      this.heading.add(random(0, TWO_PI));
      this.weights.add(1.0/nParticles);
    }
  }

  /**
   * Re-Initialize particle swarm in case of lost state.
   * All particles except ground-truth will be initialized randomly.
   */
  void reinitialize() {
    Particle gt = this.getParticle(0);
    xPos = new ArrayList<Float>();  
    yPos = new ArrayList<Float>();  
    heading = new ArrayList<Float>();  
    weights = new ArrayList<Float>();  
    
    // add ground truth
    this.xPos.add(gt.x);
    this.yPos.add(gt.y);
    this.heading.add(gt.heading);
    this.weights.add(1.0/nParticles);
    
    // generate random particles
    for (int i=1; i<this.nParticles; i++) {
      this.xPos.add(random(0, width));
      this.yPos.add(random(0, height));
      this.heading.add(random(0, TWO_PI));
      this.weights.add(1.0/nParticles);
    }
  }

  /**
   * Draw all particles on the canvas.
   * Weight is color-coded from black (low weight) to green (high weight).
   */
  void drawParticles() {
    ellipseMode(CENTER);
    strokeWeight(1);
    stroke(20);

    // draw all other particles
    colorMode(RGB);
    for (int i=nParticles-1; i>=0; i--) {
      Particle p = getParticle(i);  
      // ground truth particle
      if (i==0) {
        fill(250, 255);
        ellipse(p.x, p.y, this.radius+10, this.radius+10);
        line(p.x, p.y, p.x + sin(p.heading) * 8, p.y - cos(p.heading) * 8);
      } else {
        //println(map(p.weight, 0, 1.0/(this.nParticles), 0, 255));
        fill(0, map(p.weight, 0, 1.0/(this.nParticles-1), 0, 255), 0);
        ellipse(p.x, p.y, this.radius, this.radius);
        line(p.x, p.y, p.x + sin(p.heading) * 8, p.y - cos(p.heading) * 8);
      }
    }
  }

  /**
   * Control "robot" and particles.
   * UP key     = forward
   * DOWN key   = backward
   * LEFT key   = left rotation
   * RIGHT key  = right rotation
   */
  void moveParticles() {
    int moveSpeed = 15;
    float rotationSpeed = 0.31;
    if (keyPressed == true && key == CODED) {
      
      if (keyCode == UP) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.xPos.set(i, this.xPos.get(i) + sin(this.heading.get(i))*moveSpeed);
            this.yPos.set(i, this.yPos.get(i) - cos(this.heading.get(i))*moveSpeed);
          } else {
            this.xPos.set(i, this.xPos.get(i) + sin(this.heading.get(i))*moveSpeed + randomGaussian()*sigmaPos/10);
            this.yPos.set(i, this.yPos.get(i) - cos(this.heading.get(i))*moveSpeed + randomGaussian()*sigmaPos/10);
          }
        }
      }

      if (keyCode == DOWN) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.xPos.set(i, this.xPos.get(i) - sin(this.heading.get(i))*moveSpeed);
            this.yPos.set(i, this.yPos.get(i) + cos(this.heading.get(i))*moveSpeed);
          } else {
            this.xPos.set(i, this.xPos.get(i) - sin(this.heading.get(i))*moveSpeed + randomGaussian()*sigmaPos/10);
            this.yPos.set(i, this.yPos.get(i) + cos(this.heading.get(i))*moveSpeed + randomGaussian()*sigmaPos/10);
          }
        }
      }

      if (keyCode == LEFT) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.heading.set(i, this.heading.get(i) - rotationSpeed);
          } else {
            this.heading.set(i, this.heading.get(i) - rotationSpeed + randomGaussian()*sigmaHeading);
          }
        }
      }
      
      if (keyCode == RIGHT) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.heading.set(i, this.heading.get(i) + rotationSpeed);
          } else {
            this.heading.set(i, this.heading.get(i) + rotationSpeed + randomGaussian()*sigmaHeading);
          }
        }
      }
    }
  }

  /**
   * Compute particle weight based on observation.
   * Conditional probability of state given observation.
   */
  void computeWeights() {
    float weightSum = 0; 
    // observation: measure distance
    float[] observation = this.getParticle(0).measureDistance(true);
    for (int i=1; i<swarm.nParticles; i++) {

      //if particle lays on an obstacle
      if (red(downSampledBG.get((int)this.getParticle(i).x/downSampleFactor, (int)this.getParticle(i).y/downSampleFactor)) > 230) {
        this.weights.set(i, 0.0);
        continue;
      } 

      float x[] = this.getParticle(i).measureDistance(false);
      float weight = 0;
      // use distance to compute weights
      for (int j=0; j<x.length; j++) {
        weight +=  exp(-0.5 * pow((x[j]-observation[j]), 2) / sigmaDist) / (sigmaDist * TWO_PI);
      }
      weight /= x.length;

      // use heading to compute weights
      weight *=  exp(-0.5 * pow((this.getParticle(i).heading - this.getParticle(0).heading), 2) / sigmaHeading) / (sigmaHeading * TWO_PI);

      // use position
      if (usePos) {
        weight *= exp(-0.5 * pow((this.getParticle(i).x - this.getParticle(0).x), 2) / sigmaPos) / (sigmaPos * TWO_PI);
        weight *= exp(-0.5 * pow((this.getParticle(i).y - this.getParticle(0).y), 2) / sigmaPos) / (sigmaPos * TWO_PI);
      }

      // check for NaN
      weight = weight == Float.NaN ? 0 : weight;

      // set weight and add it to the sum
      this.weights.set(i, weight);
      weightSum += weight;
    }

    for (int i=1; i<this.nParticles; i++) {
      this.weights.set(i, this.weights.get(i)/weightSum);
    }
  }

  /**
   * Particle Resampling.
   * Use the "Resampling Wheel" for picking the particles.
   */
  Particleswarm resample() {
    ArrayList<Integer> pickedIndices = new ArrayList();
    // add ground truth particle as first index
    pickedIndices.add(0);

    // find maximum weight
    float maxWeight = 0;
    for (float w : this.weights) {
      if (w > maxWeight) {
        maxWeight = w;
      }
    }

    // Resampling Wheel
    int idx = 1;
    for (int i=1; i<this.nParticles; i++) {
      float beta = random(0, 2*maxWeight);
      while (this.weights.get(idx) < beta) {
        beta -= this.weights.get(idx);
        idx = (idx+1)%(this.nParticles-1);
        idx = idx==0 ? 1 : idx;
      }
      pickedIndices.add(idx);
    }

    ArrayList<Particle> newSwarm = new ArrayList();

    // create new swarm
    newSwarm.add(this.getParticle(pickedIndices.get(0)));
    for (int i=1; i<this.nParticles; i++) {
      float xPos = this.getParticle(pickedIndices.get(i)).x + randomGaussian() * 5;
      float yPos = this.getParticle(pickedIndices.get(i)).y + randomGaussian() * 5;
      float heading = this.getParticle(pickedIndices.get(i)).heading + randomGaussian()*0.75;
      float weight = this.getParticle(pickedIndices.get(i)).weight;
      newSwarm.add(new Particle(xPos, yPos, heading, weight));
    }

    return new Particleswarm(newSwarm);
  }
}