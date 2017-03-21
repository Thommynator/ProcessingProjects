int rows, cols;
PVector target;
color background = color(50);
int cellsize = 20;
color targetColor = color(200);

Snake snake;
SnakeAI snakeAI;

void setup() {
  size(800, 800);
  rows = height/cellsize;
  cols = width/cellsize;
  createTarget();
  snake = new Snake(floor(cellsize*cols/4), floor(cellsize*rows/2), floor(random(0, 4)), color(0, 0, 255, 180));
  snakeAI = new SnakeAI(floor(3*cellsize*cols/4), floor(cellsize*rows/2), floor(random(0, 4)), color(255, 0, 0, 180));
}

void draw() {
  frameRate(15);
  

  snake.updateDirection();
  snakeAI.updateDirection(target);

  snake.moveElements();
  snakeAI.moveElements();

  // did the player collect the target?
  if (snake.elements.get(0).x == target.x && snake.elements.get(0).y == target.y) {
    snake.addElement();
    drawGrid(snake.clr);
    createTarget();
  }

  // did the AI collect the target?
  if (snakeAI.elements.get(0).x == target.x && snakeAI.elements.get(0).y == target.y) {
    snakeAI.addElement();
    drawGrid(snakeAI.clr);
    createTarget();
  }
  
  drawGrid(60);
  drawTarget();

  snakeAI.show();
  snake.show();

  if (snake.isCollided()) {
    restart();
  }
}

// draw the grid
void drawGrid(color c) {
  for (int row=0; row<rows; row++) {
    for (int col=0; col<cols; col++) {
      fill(background);
      stroke(c);
      rect(col*cellsize, row*cellsize, cellsize, cellsize);
    }
  }
}

// create a new target
void createTarget() {
  target = new PVector(floor(random(0, cols))*cellsize, floor(random(0, rows))*cellsize);
}

// draw the target on the canvas
void drawTarget() {
  fill(targetColor);
  rect(target.x, target.y, cellsize, cellsize);
}

// restart game
void restart() {
  snake = null;
  snakeAI = null;

  snake = new Snake(floor(cellsize*cols/4), floor(cellsize*rows/2), floor(random(0, 4)), color(0, 0, 255, 180));
  snakeAI = new SnakeAI(floor(3*cellsize*cols/4), floor(cellsize*rows/2), floor(random(0, 4)), color(255, 0, 0, 180));
  createTarget();
}