class Perceptron {
  float[] weights;

  Perceptron(int amountOfWeights) {
    weights = new float[amountOfWeights];
    for (int i=0; i<amountOfWeights; i++) {
      weights[i] = random(-1, 1);
    }
  }

  Perceptron(float[] inputWeights) {
    weights = inputWeights;
  }

  float getOutput(float[] inputs) {
    float summedWeightedInputs = 0.0;
    for (int i=0; i<inputs.length; i++) {
      summedWeightedInputs += weights[i] * inputs[i];
    }
    return activationFunction(summedWeightedInputs);
  }

  // Sigmoid Function from -1 to +1
  float activationFunction(float x) {
    return 2.0/(1+exp(-x)) - 1;
  }
}