class Population {
  ArrayList<Car> cars;

  Population(int amountOfCars) {
    cars = new ArrayList<Car>();
    for (int i=0; i<amountOfCars; i++) {
      cars.add(new Car(new PVector(30, 30)));
    }
  }

  // Resampling Wheel
  void nextGeneration() {
    ArrayList<Car> children = new ArrayList<Car>(); //<>//
    int index = floor(random(amountOfCars));
    float beta = 0.0;
    Car bestCar = getBestCar();
    float maxScore = bestCar.getFitness();
    children.add(generateChild(bestCar));

    for (int i=1; i<amountOfCars; i++) {
      beta += random(2*maxScore);
      while (beta > cars.get(index).getFitness()) {
        beta -= cars.get(index).getFitness();
        index = (index +1) % amountOfCars;
      }
      children.add(mutateChild(generateChild(cars.get(index))));
    }

    cars = children; //<>//
  }
  
  Car generateChild(Car parent){
    Car child = new Car(new PVector(30,30));
    child.neuralNet = parent.neuralNet;
    return child;
  }
  
  Car mutateChild(Car child){
    child.neuralNet.mutate(1);
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

  void update() {
    for (Car car : cars) {
      car.updateState();
    }
  }

  void show() {
    for (Car car : cars) {
      car.show();
    }
  }
}