int nTargets = 2; //<>//
int amountOfPopulations = 50;

ArrayList<PVector> targets = new ArrayList<PVector>();
ArrayList<Population> populations = new ArrayList<Population>();

void setup() {
  size(500, 500);
  background(50);
  for (int i=0; i<nTargets; i++) {
    targets.add(new PVector(random(width), random(height)));
  }

  // create initial list of populations
  for (int i=0; i<amountOfPopulations; i++) {
    populations.add(new Population(nTargets));
  }
}

void draw() {
  background(50);
  drawConnections();
  drawTargets();
  mutate();
}

void mouseReleased() {
  // add new target to list
  targets.add(new PVector(mouseX, mouseY));  
  // generation new populations with adapted sequence size
  for (int i=0; i<amountOfPopulations; i++) {
    populations.set(i, new Population(targets.size()));
  }
}

Population getBestPopulation() {
  float shortestDistance = 1E15;
  Integer bestPopulationIdx = 0;
  for (int i=0; i<populations.size(); i++) {
    populations.get(i).computeDistance();
    if (populations.get(i).dist < shortestDistance) {
      bestPopulationIdx = i;
      shortestDistance = populations.get(i).dist;
    }
  }  
  Population bestPopulation = new Population(populations.get(bestPopulationIdx).sequence);
  bestPopulation.computeDistance();
  return bestPopulation;
}

void drawTargets() {
  int radius = 40;
  stroke(250);
  fill(128);
  strokeWeight(1);
  for (int i=0; i<targets.size(); i++) {
    ellipse(targets.get(i).x, targets.get(i).y, radius, radius);
  }
}

void drawConnections() {
  stroke(250);
  strokeWeight(4);
  Population bestPopulation = getBestPopulation();
  for (int i=0; i<bestPopulation.sequence.size()-1; i++) { 
    line(targets.get(bestPopulation.sequence.get(i)).x, 
      targets.get(bestPopulation.sequence.get(i)).y, 
      targets.get(bestPopulation.sequence.get(i+1)).x, 
      targets.get(bestPopulation.sequence.get(i+1)).y);
  }
}

void mutate() {
  Population bestPopulation = getBestPopulation();
  for (int i=0; i<populations.size(); i++) {
    populations.set(i, new Population(bestPopulation));
    // first one is the best population from previous iteration
    // all others are modified
    if (i>0) {
      populations.get(i).changeSequence(int(2 * random(populations.size())));
    }
  }
}