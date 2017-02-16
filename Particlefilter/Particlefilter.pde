Particleswarm swarm; //<>//
ArrayList<Obstacle> obstacles = new ArrayList();
int iteration = 0;

void setup() {
  size(800, 800);
  swarm = new Particleswarm(1000);
  createObstacles(10);
}

void draw() {

  background(200);
  swarm.moveParticles();
  drawObstacles();

  if (iteration%30 == 0) {
    computeWeights();
  }
  
  if (keyPressed == true && key == ' ') {
    resample();
  }
  swarm.drawParticles();
  iteration++;
}


void computeWeights() {
  float weightSum = 0; 
  // observation: measure distance
  float[] observation = swarm.getParticle(0).measureDistance(true);

  float sigmaDist = 1.0;
  float sigmaHeading = 10.0;

  // use distance to compute weights
  for (int i=1; i<swarm.nParticles; i++) {
    float x[] = swarm.getParticle(i).measureDistance(false);
    float weight = 0;
    for (int j=0; j<x.length; j++) {
      weight +=  1.0/(sigmaDist * sqrt(TWO_PI)) * exp(-0.5*pow((x[j]-observation[j])/sigmaDist, 2));
    }

    // use heading to compute weights
    weight *= 1.0/(sigmaHeading * sqrt(TWO_PI)) * exp(-0.5*pow((swarm.getParticle(i).heading - swarm.getParticle(0).heading)/sigmaHeading, 2));   

    swarm.weights.set(i, weight);
    weightSum += weight;
  }

  for (int i=1; i<swarm.nParticles; i++) {
    swarm.weights.set(i, swarm.weights.get(i)/weightSum);
  }
}

/**
 * Particle Resampling.
 * Use the "Resampling Wheel" for picking the particles.
 */
void resample() {
  ArrayList<Integer> pickedIndices = new ArrayList();
  // add ground truth particle as first index
  pickedIndices.add(0);

  // find maximum weight
  float maxWeight = 0;
  for (float w : swarm.weights) {
    if (w > maxWeight) {
      maxWeight = w;
    }
  }

  // Resampling Wheel
  int idx = 1;
  for (int i=1; i<swarm.nParticles; i++) {
    float beta = random(0, 2*maxWeight);
    while (swarm.weights.get(idx) < beta) {
      beta -= swarm.weights.get(idx);
      idx = (idx+1)%(swarm.nParticles-1);
      idx = idx==0 ? 1 : idx;
    }
    pickedIndices.add(idx);
  }

  ArrayList<Particle> newSwarm = new ArrayList();

  // create new swarm
  newSwarm.add(swarm.getParticle(pickedIndices.get(0)));
  for (int i=1; i<swarm.nParticles; i++) {
    float xPos = swarm.getParticle(pickedIndices.get(i)).x + randomGaussian() * 5;
    float yPos = swarm.getParticle(pickedIndices.get(i)).y + randomGaussian() * 5;
    float heading = swarm.getParticle(pickedIndices.get(i)).heading +randomGaussian();
    float weight = swarm.getParticle(pickedIndices.get(i)).weight;
    newSwarm.add(new Particle(xPos, yPos, heading, weight));
  }

  swarm = new Particleswarm(newSwarm);
}

void createObstacles(int number) {
  for (int i=0; i<number; i++) {
    obstacles.add(new Obstacle(new PVector(random(20, width-20), random(20, height-20)), (int)random(50, 100)));
  }
}

void drawObstacles() {
  ellipseMode(CENTER);
  for (Obstacle o : obstacles) {
    fill(100);
    strokeWeight(5);
    stroke(255, 0, 0);
    ellipse(o.pos.x, o.pos.y, o.radius, o.radius);
  }
}