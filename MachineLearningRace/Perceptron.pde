class Perceptron {
  ArrayList<Float> weights;

  Perceptron(int amountOfWeights) {
    this.weights = new ArrayList<Float>(amountOfWeights);
    for (int i=0; i<amountOfWeights; i++) {
      weights.add(random(-1, 1));
    }
  }

  Perceptron(ArrayList<Float> inputWeights) {
    this.weights = new ArrayList<Float>(inputWeights.size());
    for (float w : inputWeights) {
      this.weights.add(w);
    }
  }

  float getOutput(ArrayList<Float> inputs) {
    float summedWeightedInputs = 0.0;
    for (int i=0; i<inputs.size(); i++) {
      summedWeightedInputs += weights.get(i) * inputs.get(i);
    }
    return activationFunction(summedWeightedInputs);
  }

  // Sigmoid Function from -1 to +1
  float activationFunction(float x) {
    return 2.0/(1+exp(-x)) - 1;
  }

  void mutateWeights(float mutationRate) {
    for (int i=0; i<weights.size(); i++) {
      float w = weights.get(i);
      float noise = random(-mutationRate, mutationRate);
      weights.set(i, constrain(w + noise, -1, 1));
    }
  }
}