/**
* This class represents a snake, the player or the AI can control on the canvas.
*/

class Snake {
  // List of all "body parts" of the snake
  ArrayList<PVector> elements = new ArrayList<PVector>();

  /** 
   * Moving direction of the snake "head"
   * 0: Up
   * 1: Right
   * 2: Down
   * 3: Left
   */
  int direction;
  
  // color of the snake body
  color clr;
  
  // the color of the cell, the snake just accessed
  color accessedCell;
  
  Snake(int x, int y, int startingDirection, color c) {
    elements.add(new PVector(x, y));
    direction = startingDirection;
    clr = c;
  }

  // visualize snake body
  void show() {
    for (PVector e : elements) {
      fill(this.clr);
      rect(e.x, e.y, cellsize, cellsize);
    }
  }

  // update moving direction, using the key input of the player
  void updateDirection() {
    if (key == CODED) {
      switch(keyCode) {
      case UP:
        if (direction != 2) {
          direction = 0;
        }
        break;
      case RIGHT:
        if (direction != 3) {
          direction = 1;
        }
        break;
      case DOWN:
        if (direction != 0) {
          direction = 2;
        }
        break;
      case LEFT:
        if (direction != 1) {
          direction = 3;
        }
        break;
      }
    }
  }

  // move all body parts from end to head 1 cell further
  void moveElements() {
    if (elements.size()>1) {
      for (int i=elements.size()-1; i>0; i--) {
        elements.set(i, elements.get(i-1));
      }
    }
    elements.set(0, this.newPos(elements.get(0), this.direction));
    this.accessedCell = get(floor(elements.get(0).x+cellsize/2), floor(elements.get(0).y + cellsize/2));
  }

  // compute a new position in 4-neighborhood, defined by the direction
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

  // add a new body part to the list
  void addElement() {
    elements.add(newPos(elements.get(0), (this.direction+2)%4));
  }

  // check if snaked clollided with wall or itself
  boolean isCollided() {
    // collision with wall
    if (elements.get(0).x > width || elements.get(0).x < 0) {
      return true;
    }
    if (elements.get(0).y > height || elements.get(0).y < 0) {
      return true;
    }

    // collision with self or opponent
      if ((red(accessedCell) == red(background) && green(accessedCell) == green(background)  && blue(accessedCell) == blue(background))
      || (red(accessedCell) == red(targetColor) && green(accessedCell) == green(targetColor)  && blue(accessedCell) == blue(targetColor))) {
        return false;
    }
    return true;
  }
}