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
    // generate random particles
    for (int i=0; i<this.nParticles; i++) {
      this.xPos.add(random(0, width));
      this.yPos.add(random(0, height));
      this.heading.add(random(0, TWO_PI));
      this.weights.add(1.0/nParticles);
    }
  }

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


  void moveParticles() {
    if (keyPressed == true && key == CODED) {
      if (keyCode == UP) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.xPos.set(i, this.xPos.get(i) + sin(this.heading.get(i))*5);
            this.yPos.set(i, this.yPos.get(i) - cos(this.heading.get(i))*5);
          } else {
            this.xPos.set(i, this.xPos.get(i) + sin(this.heading.get(i))*5 + randomGaussian()*sigmaPos/10);
            this.yPos.set(i, this.yPos.get(i) - cos(this.heading.get(i))*5 + randomGaussian()*sigmaPos/10);
          }
        }
      }

      if (keyCode == DOWN) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.xPos.set(i, this.xPos.get(i) - sin(this.heading.get(i))*5);
            this.yPos.set(i, this.yPos.get(i) + cos(this.heading.get(i))*5);
          } else {
            this.xPos.set(i, this.xPos.get(i) - sin(this.heading.get(i))*5 + randomGaussian()*sigmaPos/10);
            this.yPos.set(i, this.yPos.get(i) + cos(this.heading.get(i))*5 + randomGaussian()*sigmaPos/10);
          }
        }
      }

      if (keyCode == LEFT) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.heading.set(i, this.heading.get(i) - 0.1);
          } else {
            this.heading.set(i, this.heading.get(i) - 0.1 + randomGaussian()*sigmaHeading);
          }
        }
      }
      if (keyCode == RIGHT) {
        for (int i=0; i<nParticles; i++) {
          if (i==0) {
            this.heading.set(i, this.heading.get(i) + 0.1);
          } else {
            this.heading.set(i, this.heading.get(i) + 0.1 + randomGaussian()*sigmaHeading);
          }        }
      }
    }
  }
}