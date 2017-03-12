Particleswarm swarm; //<>//
ArrayList<Obstacle> obstacles = new ArrayList();
int iteration = 0;
boolean useResampling = false;
PImage downSampledBG;
int downSampleFactor = 10;
String imageName = "streets.png";

// if true, use position for weightening 
boolean usePos = true;

// uncertainties
float sigmaDist = 200.0;
float sigmaHeading = 0.2;
float sigmaPos = 200.0;

void setup() {
  size(800, 800);
  background(200);
  swarm = new Particleswarm(4000);
  createObstacles(10);
  drawObstacles();
  save("bg.png");
  downSampledBG = loadImage(imageName);
  downSampledBG.resize(width/downSampleFactor, height/downSampleFactor);
}

void draw() {
  frameRate(30);
  background(loadImage(imageName));
  swarm.moveParticles();

  if (iteration % 1 == 0) {
    computeWeights();
  }

  if (useResampling && iteration % 1 == 0) {
    resample();
  }

  swarm.drawParticles();
  iteration++;

  fill(0);
  text("Resampling " + useResampling, 10, 20);
  text("usePos " + usePos, 10, 30);
}


void computeWeights() {
  float weightSum = 0; 
  // observation: measure distance
  float[] observation = swarm.getParticle(0).measureDistance(true);
  for (int i=1; i<swarm.nParticles; i++) {
    
    //if particle lays on an obstacle
    if(red(downSampledBG.get((int)swarm.getParticle(i).x/downSampleFactor, (int)swarm.getParticle(i).y/downSampleFactor)) > 230){
      swarm.weights.set(i, 0.0);
      continue;
    } 
    
    float x[] = swarm.getParticle(i).measureDistance(false);
    float weight = 0;
    // use distance to compute weights
    for (int j=0; j<x.length; j++) {
      weight +=  exp(-0.5 * pow((x[j]-observation[j]), 2) / sigmaDist) / (sigmaDist * TWO_PI);
    }
    weight /= x.length;

    // use heading to compute weights
    weight *=  exp(-0.5 * pow((swarm.getParticle(i).heading - swarm.getParticle(0).heading), 2) / sigmaHeading) / (sigmaHeading * TWO_PI);

    // use position
    if (usePos) {
      weight *= exp(-0.5 * pow((swarm.getParticle(i).x - swarm.getParticle(0).x), 2) / sigmaPos) / (sigmaPos * TWO_PI);
      weight *= exp(-0.5 * pow((swarm.getParticle(i).y - swarm.getParticle(0).y), 2) / sigmaPos) / (sigmaPos * TWO_PI);
    }

    // set weight and add it to the sum
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
    float heading = swarm.getParticle(pickedIndices.get(i)).heading + randomGaussian()*0.75;
    float weight = swarm.getParticle(pickedIndices.get(i)).weight;
    newSwarm.add(new Particle(xPos, yPos, heading, weight));
  }

  swarm = new Particleswarm(newSwarm);
}

void createObstacles(int number) {
  for (int i=0; i<number; i++) {
    obstacles.add(new Obstacle(new PVector(random(20, width-20), random(20, height-20)), (int)random(100, 200)));
  }
}

void drawObstacles() {
  ellipseMode(CENTER);
  for (Obstacle o : obstacles) {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(o.pos.x, o.pos.y, o.radius, o.radius);
  }
}

void keyReleased() {
  if (key == ' ') {
    useResampling = !useResampling;
  }
  if (key=='i') {
    swarm = new Particleswarm(1000);
  }
  if (key=='p') {
    usePos = !usePos;
  }
}