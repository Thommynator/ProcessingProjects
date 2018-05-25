class Population { //<>// //<>//
  ArrayList<Car> cars;

  Population(int amountOfCars) {
    cars = new ArrayList<Car>();
    for (int i=0; i<amountOfCars; i++) {
      cars.add(new Car(new PVector(10, 10)));
    }
  }

  // Resampling Wheel
  void nextGeneration() {
    ArrayList<Car> children = new ArrayList<Car>();

    // make sure, that the best car is for sure in the new population
    Car bestCar = getBestCar();

    Car child = generateChild(bestCar);
    child.clr = color(0, 255, 0);
    children.add(child);

    float maxScore = bestCar.getFitness();
    float beta = 0.0;
    int index = floor(random(amountOfCars));
    for (int i=1; i<amountOfCars; i++) {
      beta += random(2*maxScore);
      while (beta > cars.get(index).getFitness()) {
        beta -= cars.get(index).getFitness();
        index = (index + 1) % amountOfCars;
      }
      children.add(mutateChild(generateChild(cars.get(index))));
    }
    this.cars = children;
  }

  Car generateChild(Car parent) {
    Car child = new Car(new PVector(10, 10));
    child.neuralNet = new NeuralNet(parent.neuralNet);
    return child;
  }

  Car mutateChild(Car child) {
    child.neuralNet.mutate(random(0.2));
    return child;
  }

  Car getBestCar() {
    float bestScore = 0; 
    Car bestCar = null;
    for (Car car : cars) {
      float score = car.getFitness();
      if (score > bestScore) {
        bestScore = score;
        bestCar = car;
      }
    }
    return bestCar;
  }


  boolean isAlive() {
    for (Car car : cars) {
      if (car.isAlive) {
        return true;
      }
    }
    return false;
  }
  
  void overrideAllWithBest(){
    for(Car car : this.cars){
      car.neuralNet = new NeuralNet(this.getBestCar().neuralNet);
    }
  }

  void update() {
    for (Car car : cars) {
      car.updateState();
    }
  }

  void show() {
    for (int c = cars.size()-1; c >= 0; c--) {
      cars.get(c).show();
    }

    // highlight best car
    this.getBestCar().show(true);
  }
}