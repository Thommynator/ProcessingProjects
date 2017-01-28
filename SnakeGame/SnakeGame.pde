int cellsize = 20;
int rows, cols;
PVector target;

Snake snake;
SnakeAI snakeAI;

void setup() {
  size(800, 800);
  rows = height/cellsize;
  cols = width/cellsize;
  createTarget();
  snake = new Snake(floor(cellsize*cols/3), floor(cellsize*rows/2), floor(random(0, 4)));
  snakeAI = new SnakeAI(floor(2*cellsize*cols/3), floor(cellsize*rows/2), floor(random(0, 4)));
}

void draw() {
  frameRate(10);
  drawGrid();

  snake.updateDirection();
  snakeAI.updateDirection(target);

  snake.moveElements();
  snakeAI.moveElements();

  // did the player collect the target?
  if (snake.elements.get(0).x == target.x && snake.elements.get(0).y == target.y) {
    snake.addElement();
    createTarget();
  }

  // did the AI collect the target?
  if (snakeAI.elements.get(0).x == target.x && snakeAI.elements.get(0).y == target.y) {
    snakeAI.addElement();
    createTarget();
  }


  if (snake.isCollided()) {
    restart();
  }

  drawTarget();

  snakeAI.show(color(255,0,0,180));
  snake.show(color(0,0,255,180));
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
  fill(200);
  rect(target.x, target.y, cellsize, cellsize);
}

// restart game
void restart() {
  snake = null;
  snakeAI = null;
  
  snake = new Snake(floor(cellsize*cols/3), floor(cellsize*rows/2), floor(random(0, 4)));
  snakeAI = new SnakeAI(floor(2*cellsize*cols/3), floor(cellsize*rows/2), floor(random(0, 4)));
  createTarget();
}