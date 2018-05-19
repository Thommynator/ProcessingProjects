class NeuralNet {
  int inputNodes;
  int hiddenNodes;
  int outputNodes;
  ArrayList<Perceptron> hiddenPerceptrons;
  ArrayList<Perceptron> outputPerceptrons;

  NeuralNet(int inputNodes, int hiddenNodes, int outputNodes) {

    this.inputNodes = inputNodes;
    this.hiddenNodes = hiddenNodes;
    this.outputNodes = outputNodes;

    this.hiddenPerceptrons= new ArrayList<Perceptron>(hiddenNodes);
    this.outputPerceptrons= new ArrayList<Perceptron>(outputNodes);

    // initialize all hidden perceptrons
    for (int i=0; i<hiddenNodes; i++) {
      hiddenPerceptrons.add(new Perceptron(inputNodes));
    }

    // initialize all output perceptrons
    for (int i=0; i<outputNodes; i++) {
      outputPerceptrons.add(new Perceptron(hiddenNodes));
    }
  }

  /*
   * Creates a new neural net and copies all weights of other.
   */
  NeuralNet(NeuralNet other) {
    this.inputNodes = other.inputNodes;
    this.hiddenNodes = other.hiddenNodes;
    this.outputNodes = other.outputNodes;

    this.hiddenPerceptrons= new ArrayList<Perceptron>(hiddenNodes);
    this.outputPerceptrons= new ArrayList<Perceptron>(outputNodes);

    for (Perceptron p : other.hiddenPerceptrons) {
      this.hiddenPerceptrons.add(new Perceptron(p.weights));
    }
    
    for (Perceptron p : other.outputPerceptrons) {
      this.outputPerceptrons.add(new Perceptron(p.weights));
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
    for (int i=0; i < hiddenNodes; i++) {
      Perceptron hp = hiddenPerceptrons.get(i);
      hp.mutateWeights(mutationRate);
      hiddenPerceptrons.set(i, hp);
    }

    for (int i=0; i < outputNodes; i++) {
      Perceptron op = outputPerceptrons.get(i);
      op.mutateWeights(mutationRate);
      outputPerceptrons.set(i, op);
    }
  }

  void show() {
    int topRightX = width-30;
    int topRightY = 20;
    int hSpace = 100;
    int vSpace = 50;

    //output nodes
    for (int i=0; i < outputNodes; i++) {
      int x = topRightX;
      int y = topRightY + i*vSpace;

      fill(50);
      ellipse(x, y, 10, 10);

      // hidden nodes
      for (int j=0; j < hiddenNodes; j++) {
        float w = map(outputPerceptrons.get(i).weights.get(j), -1, 1, 0, 5);
        stroke(0, 128);
        strokeWeight(w);
        line(x, y, topRightX - hSpace, topRightY + j*vSpace);
        ellipse(topRightX - hSpace, topRightY + j*vSpace, 10, 10);

        // input nodes
        for (int k=0; k < inputNodes; k++) {
          w = map(hiddenPerceptrons.get(j).weights.get(k), -1, 1, 0, 5);
          stroke(0, 128);
          strokeWeight(w);
          line(topRightX - hSpace, topRightY + j*vSpace, topRightX - 2*hSpace, topRightY + k*vSpace);
          ellipse(topRightX - 2*hSpace, topRightY + k*vSpace, 10, 10);
        }
      }
    }
  }
}