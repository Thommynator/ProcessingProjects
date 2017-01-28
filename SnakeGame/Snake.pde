class Snake {
  ArrayList<PVector> elements = new ArrayList<PVector>();

  /**
   * 0: Up
   * 1: Right
   * 2: Down
   * 3: Left
   */
  ArrayList<Integer> keyStrokes = new ArrayList<Integer>();

  int direction;

  Snake(int x, int y) {
    elements.add(new PVector(x, y));
    keyStrokes.add(1);
    direction = 1;
  }

  void show() {
    for (PVector e : elements) {
      fill(100);
      rect(e.x, e.y, cellsize, cellsize);
    }
  }

  void saveKey() {
    if (key == CODED) {
      switch(keyCode) {
      case UP:
        if (keyStrokes.get(keyStrokes.size()-1) != 0 && keyStrokes.get(keyStrokes.size()-1) != 2) {
          keyStrokes.add(0);
        }
        break;
      case RIGHT:
        if (keyStrokes.get(keyStrokes.size()-1) != 1 && keyStrokes.get(keyStrokes.size()-1) != 3) {
          keyStrokes.add(1);
        }
        break;
      case DOWN:
        if (keyStrokes.get(keyStrokes.size()-1) != 2 && keyStrokes.get(keyStrokes.size()-1) != 0) {
          keyStrokes.add(2);
        }
        break;
      case LEFT:
        if (keyStrokes.get(keyStrokes.size()-1) != 3 && keyStrokes.get(keyStrokes.size()-1) != 1) {
          keyStrokes.add(3);
        }
        break;
      }
    }
  }

  void updateDirection() {
    if (keyStrokes.get(keyStrokes.size()-1) != direction) {
      direction = keyStrokes.get(keyStrokes.size()-1);
      keyStrokes.remove(keyStrokes.size()-1);
    }
  }

  void moveElements() {
    if (elements.size()>1) {
      for (int i=elements.size()-1; i>0; i--) {
        elements.set(i, elements.get(i-1));
      }
    }
    elements.set(0, this.newPos(elements.get(0), this.direction));
  }

  PVector newPos(PVector currentPos, int direction) {
    PVector newPos = elements.get(0);
    switch(direction) {
    case 0:
      newPos = new PVector(currentPos.x, currentPos.y-cellsize);
      break;
    case 1:
      newPos = new PVector(currentPos.x+cellsize, currentPos.y);
      break;
    case 2:
      newPos = new PVector(currentPos.x, currentPos.y+cellsize);
      break;
    case 3:
      newPos = new PVector(currentPos.x-cellsize, currentPos.y);
      break;
    }
    return newPos;
  }

  void addElement() {
    elements.add(newPos(elements.get(0), (this.direction+2)%4));
  }
  
  boolean isCollided(){
  return false;
  }
}