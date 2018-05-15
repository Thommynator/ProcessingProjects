class NeuralNet {
  float learningRate= 1.0;
  int startNodes = 5;
  int hiddenNodes= 4;
  int outputNodes = 2;
  Perceptron[] hiddenPerceptrons= new Perceptron[hiddenNodes];
  Perceptron[] outputPerceptrons= new Perceptron[outputNodes];

  NeuralNet() {
    // initialize all hidden perceptrons
    for (int i=0; i<hiddenPerceptrons.length; i++) {
      hiddenPerceptrons[i] = new Perceptron(startNodes);
    }

    // initialize all output perceptrons
    for (int i=0; i<outputPerceptrons.length; i++) {
      outputPerceptrons[i] = new Perceptron(hiddenNodes);
    }
  }

  float[] returnOutputs(float[] inputs) {
    float[] hiddenOutputs = new float[hiddenNodes];
    for (int i=0; i<hiddenPerceptrons.length; i++) {
      hiddenOutputs[i] = hiddenPerceptrons[i].getOutput(inputs);
    }

    float[] outputs = new float[outputNodes];
    for (int i=0; i<outputPerceptrons.length; i++) {
      outputs[i] = outputPerceptrons[i].getOutput(hiddenOutputs);
    }
    return outputs;
  }
}