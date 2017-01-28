int cellsize = 20;
int rows, cols;
PVector target;

Snake snake;
void setup() {
  size(800, 800);
  rows = height/cellsize;
  cols = width/cellsize;
  createTarget();
  snake = new Snake(0, 0);
}

void draw() {
  frameRate(10);
  drawGrid();
  snake.saveKey();
  snake.updateDirection();
  snake.moveElements();
  if (snake.elements.get(0).x == target.x && snake.elements.get(0).y == target.y) {
    snake.addElement();
    createTarget();
  }
  drawTarget();
  snake.show();
}


void drawGrid() {
  for (int r=0; r<rows; r++) {
    for (int c=0; c<cols; c++) {
      fill(50);
      stroke(60);
      rect(c*cellsize, r*cellsize, cellsize, cellsize);
    }
  }
}

void createTarget() {
  target = new PVector(floor(random(0, cols))*cellsize, floor(random(0, rows))*cellsize);
}

void drawTarget() {
  fill(180);
  rect(target.x, target.y, cellsize, cellsize);
}