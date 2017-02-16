Particleswarm swarm; //<>//
ArrayList<Obstacle> obstacles = new ArrayList();

void setup() {
  size(800, 800);
  swarm = new Particleswarm(200);
  createObstacles(10);
}

void draw() {

  background(200);
  swarm.moveParticles();
  drawObstacles();

  computeWeights();
  swarm.drawParticles();
}


void computeWeights() {
  float weightSum = 0; 
  // observation: measure distance
  float observation = swarm.getParticle(0).measureDistance(true);
  for (int i=1; i<swarm.nParticles; i++) {
    float sigma = 100.0;
    float x = swarm.getParticle(i).measureDistance(false);
    float weight =  1.0/(sigma * sqrt(TWO_PI)) * exp(-0.5*pow((x-observation)/sigma, 2));   
    swarm.weight.set(i, weight);
    weightSum += weight;
  }
  for(int i=1; i<swarm.nParticles; i++){
      swarm.weight.set(i, swarm.weight.get(i)/weightSum);
  }
  
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