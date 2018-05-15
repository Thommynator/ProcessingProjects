class Population {
  ArrayList<Car> cars;

  Population(int amountOfCars) {
    cars = new ArrayList();
    for (int i=0; i<amountOfCars; i++) {
      cars.add(new Car(new PVector(30, 30)));
    }
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