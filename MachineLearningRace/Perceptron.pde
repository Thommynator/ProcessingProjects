class Perceptron {
  ArrayList<Float> weights;

  Perceptron(int amountOfWeights) {
    weights = new ArrayList<Float>(amountOfWeights);
    for (int i=0; i<amountOfWeights; i++) {
      weights.add(random(-1, 1));
    }
  }

  Perceptron(ArrayList inputWeights) {
    weights = inputWeights;
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
    for (float w : weights) {
      w += random(-mutationRate*w, mutationRate*w); 
    }
  }
}