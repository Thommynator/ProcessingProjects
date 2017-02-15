class Particleswarm { //<>//

  int nParticles;
  float radius;
  ArrayList<Float> xPos = new ArrayList<Float>();  
  ArrayList<Float> yPos = new ArrayList<Float>();  
  ArrayList<Float> heading = new ArrayList<Float>();  
  ArrayList<Float> weight = new ArrayList<Float>();  

  Particleswarm() {
    this.nParticles = 2000;
    this.radius = 5;
    this.initialize();
  }

  Particleswarm(int amountOfParticles) {
    this.nParticles = amountOfParticles;
    this.radius = 5;
    this.initialize();
  }

  Particle getParticle(int idx) {
    return new Particle(this.xPos.get(idx), this.yPos.get(idx), this.heading.get(idx), this.weight.get(idx));
  }

  void initialize() {
    // generate random particles
    for (int i=0; i<this.nParticles; i++) {
      this.xPos.add(random(0, width));
      this.yPos.add(random(0, height));
      this.heading.add(random(0, TWO_PI));
      this.weight.add(1.0/nParticles);
    }
  }

  void drawParticles() {
    ellipseMode(CENTER);
    strokeWeight(1);
    stroke(20);

    // draw all other particles
    colorMode(HSB);
    for (int i=0; i<nParticles; i++) {
      Particle p = getParticle(i);  
      // ground truth particle
      if (i==0) {
        fill(250, 255);
        ellipse(p.x, p.y, this.radius+10, this.radius+10);
        line(p.x, p.y, p.x + sin(p.heading) * 8, p.y - cos(p.heading) * 8);
      } else {
        fill(map(p.weight, 0, 1, 0, 255), 255, 255);
        ellipse(p.x, p.y, this.radius, this.radius);
        line(p.x, p.y, p.x + sin(p.heading) * 8, p.y - cos(p.heading) * 8);
      }
    }
    colorMode(RGB);
  }


  void moveParticles() {
    if (keyPressed == true && key == CODED) {
      if (keyCode == UP) {
        for (int i=0; i<nParticles; i++) {
          this.xPos.set(i, this.xPos.get(i) + sin(this.heading.get(i))*5);
          this.yPos.set(i, this.yPos.get(i) - cos(this.heading.get(i))*5);
        }
      }

      if (keyCode == LEFT) {
        for (int i=0; i<nParticles; i++) {
          this.heading.set(i, this.heading.get(i) - 0.1);
        }
      }
      if (keyCode == RIGHT) {
        for (int i=0; i<nParticles; i++) {
          this.heading.set(i, this.heading.get(i) + 0.1);
        }
      }
    }
  }
}