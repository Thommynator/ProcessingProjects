Particleswarm swarm; //<>//
String imageName = "bg.png";

// uncertainties
float sigmaDist = 200.0;
float sigmaHeading = 0.2;
float sigmaPos = 200.0;

boolean usePos = false; // if true, use position for weightening 
boolean useResampling = false;

PImage downSampledBG;
int downSampleFactor = 10;
ArrayList<Obstacle> obstacles = new ArrayList();
int iteration = 0;

void setup() {
  size(800, 800);
  background(200);
  swarm = new Particleswarm(2000);
  createObstacles(10);
  drawObstacles();
  save("bg.png");
  downSampledBG = loadImage(imageName);
  downSampledBG.resize(width/downSampleFactor, height/downSampleFactor);
}

void draw() {
  frameRate(30);
  background(loadImage(imageName));
  image(downSampledBG, 0,0);
  swarm.moveParticles();

  if (iteration % 1 == 0) {
    swarm.computeWeights();
  }

  if (useResampling && iteration % 1 == 0) {
    swarm = swarm.resample();
  }

  swarm.drawParticles();
  iteration++;

  fill(0);
  text("Resampling " + useResampling, 10, 20);
  text("usePos " + usePos, 10, 30);
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
    swarm.initialize(); //<>//
  }
  if (key=='p') {
    usePos = !usePos;
  }
}