class Population {

  float dist;
  ArrayList<Integer> sequence = new ArrayList<Integer>();

  Population(Population copy) {
    this.dist = copy.dist;
    for (int i=0; i<copy.sequence.size(); i++) {
      this.sequence.add(copy.sequence.get(i));
    }
  }

  Population(int seqSize) {
    this.dist = 1E10;  
    for (int i=0; i<seqSize; i++) {
      this.sequence.add(i);
    }
  }

  Population(ArrayList<Integer> seq) {
    this.dist = 1E10;  
    sequence = seq;
  }

  void computeDistance() {
    float totalDistance = 0.0;
    for (int i=0; i<sequence.size()-1; i++) {
      float distance = dist(targets.get(sequence.get(i)).x, targets.get(sequence.get(i)).y, targets.get(sequence.get(i+1)).x, targets.get(sequence.get(i+1)).y);
      totalDistance += distance;
    }
    this.dist = totalDistance;
  }

  private void swapEntries(int idx1, int idx2) {
    int val1 = this.sequence.get(idx1);
    int val2 = this.sequence.get(idx2);
    this.sequence.set(idx1, val2);
    this.sequence.set(idx2, val1);
  }

  void changeSequence(int iterations) {
    for (int i=0; i<iterations; i++) {
      swapEntries(int(random(this.sequence.size())), int(random(this.sequence.size())));
    }
  }
}