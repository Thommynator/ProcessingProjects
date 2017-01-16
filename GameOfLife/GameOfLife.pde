float nInitialCellsProb = 0.4;

int cellsize = 10;
int rows;
int cols;
ArrayList<Boolean> cellsAlive;
ArrayList<Boolean> newGeneration;

int it = 0;


void setup() {
  size(800, 800);
  background(255);
  rows = height/cellsize;
  cols = width/cellsize;
  initializeGrid();
}

void draw() {
  frameRate(20);
  // rules
  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {
      int n = countLivingNeighbors(y, x);
      int idx = convertRowCol2Idx(y, x);

      // 1. a dead cell, which has exactly 3 living neighbors will be alive in the next generation
      if (!cellsAlive.get(idx) && n==3) {
        newGeneration.set(idx, true);
      }

      // 2. a living cell, which has less than 2 living neighbors will die in the next generation
      if (cellsAlive.get(idx) && n<2) {
        newGeneration.set(idx, false);
      }

      // 3. a living cell, which has 2 or 3 living neighbors will stay alive in the next generation
      if (cellsAlive.get(idx) && (n==2 || n==3)) {
        newGeneration.set(idx, true);
      }

      // 4. a living cell, which has more than 3 living cells will die in the next generation
      if (cellsAlive.get(idx) && n>3) {
        newGeneration.set(idx, false);
      }
    }
  }

  cellsAlive = (ArrayList<Boolean>)newGeneration.clone();
  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {
      if (cellsAlive.get(convertRowCol2Idx(y, x))) {
        fill(0, 255, 0);
      } else {
        fill(50,50,50);
      }
      rect(x*cellsize, y*cellsize, cellsize, cellsize);
    }
  }
  
  //saveFrame("data/cgol-####.jpg");
  
}

/**
 * Choose a cell, defined by row and col and count its alive neighbors.
 */
int countLivingNeighbors(int row, int col) {
  int c=0;

  for (int i=-1; i<2; i++) {
    for (int j=-1; j<2; j++) {
      // if checkcell is equal to center cell
      if (i==0 && j==0) {
        continue;
      }
      // if check cell is outside of grid
      if (col+j < 0 || col+j >= cols || row+i < 0 || row+i >= rows) {
        continue;
      }
      if (cellsAlive.get(convertRowCol2Idx(row+i, col+j))) {
        c++;
      }
    }
  }
  return c;
}

/**
 * Convert a row & col index into an 1-dimensional array index.
 */
int convertRowCol2Idx(int row, int col) {
  return col + row*cols;
}


/**
 * Initialize a new grid
 */
void initializeGrid() {
  cellsAlive = new ArrayList<Boolean>();
  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {
      if (random(1)>nInitialCellsProb) {
        cellsAlive.add(true);
      } else {
        cellsAlive.add(false);
      }
    }
  }
  newGeneration = (ArrayList<Boolean>)cellsAlive.clone();
}