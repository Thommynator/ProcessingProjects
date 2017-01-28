int cellsize = 20;
int rows, cols;
PVector target;

Snake snake;
void setup() {
  size(800, 800);
  rows = height/cellsize;
  cols = width/cellsize;
  createTarget();
  snake = new Snake(cellsize*cols/2, cellsize*rows/2, floor(random(0,4)));
}

void draw() {
  frameRate(15);
  drawGrid();
  snake.updateDirection();
  snake.moveElements();
  if (snake.elements.get(0).x == target.x && snake.elements.get(0).y == target.y) {
    snake.addElement();
    createTarget();
  }
  if (snake.isCollided()) {
    restart();
  }
  drawTarget();
  snake.show();
}

// draw the grid
void drawGrid() {
  for (int r=0; r<rows; r++) {
    for (int c=0; c<cols; c++) {
      fill(50);
      stroke(60);
      rect(c*cellsize, r*cellsize, cellsize, cellsize);
    }
  }
}

// create a new target
void createTarget() {
  target = new PVector(floor(random(0, cols))*cellsize, floor(random(0, rows))*cellsize);
}

// draw the target on the canvas
void drawTarget() {
  fill(180);
  rect(target.x, target.y, cellsize, cellsize);
}

// restart game
void restart() {
  snake = null;
  snake = new Snake(cellsize*cols/2, cellsize*rows/2, floor(random(0,4)));
  createTarget();
}