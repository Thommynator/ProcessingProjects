class NeuralNet {
  int startNodes = 8;
  int hiddenNodes= 4;
  int outputNodes = 2;
  ArrayList<Perceptron> hiddenPerceptrons= new ArrayList<Perceptron>(hiddenNodes);
  ArrayList<Perceptron> outputPerceptrons= new ArrayList<Perceptron>(outputNodes);

  NeuralNet() {
    // initialize all hidden perceptrons
    for (int i=0; i<hiddenNodes; i++) {
      hiddenPerceptrons.add(new Perceptron(startNodes));
    }

    // initialize all output perceptrons
    for (int i=0; i<outputNodes; i++) {
      outputPerceptrons.add(new Perceptron(hiddenNodes));
    }
  }

  ArrayList<Float> returnOutputs(ArrayList inputs) {
    ArrayList<Float> hiddenOutputs = new ArrayList<Float>(hiddenNodes);
    for (int i=0; i<hiddenNodes; i++) {
      hiddenOutputs.add(hiddenPerceptrons.get(i).getOutput(inputs));
    }

    ArrayList<Float> outputs = new ArrayList<Float>(outputNodes);
    for (int i=0; i<outputNodes; i++) {
      outputs.add(outputPerceptrons.get(i).getOutput(hiddenOutputs));
    }
    return outputs;
  }

  void mutate(float mutationRate) {
    for (Perceptron hp : hiddenPerceptrons) {
      hp.mutateWeights(mutationRate);
    }

    for (Perceptron op : outputPerceptrons) {
      op.mutateWeights(mutationRate);
    }
  }
}