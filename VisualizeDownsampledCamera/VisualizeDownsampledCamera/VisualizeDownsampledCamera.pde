import processing.video.*;

// true: visualization with rectangles, false: with ellipses
boolean useRectangles = false;

// show mini image in top-left corner?
boolean showThumbnail = false;

int cellSize = 10; // width & height of one cell in px
int cols;
int rows;
Capture cam;

void setup() {
  background(255);
  size(640, 480);
  cam = new Capture(this, width, height, 30);
  cam.start();
  rows = height/cellSize;
  cols = width/cellSize;
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw() {
  frameRate(30);
  background(255);
  if (cam.available()) {
    cam.read();
  }
  PImage clone = cam.get();
  clone.resize(cam.width/cellSize, cam.height/cellSize);
  clone.loadPixels();

  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {
      float b = brightness(clone.pixels[x+y*cols]);
      float s = map(b, 0, 255, cellSize, 0);
      fill(b);
      noStroke();
      if (useRectangles) {
        rect(width-x*cellSize-cellSize/2, y*cellSize+cellSize/2, s, s);
      } else {
        ellipse(width-x*cellSize-cellSize/2, y*cellSize+cellSize/2, s, s);
      }
    }
  }


  if (showThumbnail) {
    tint(255, 200);
    image(clone, 0, 0);
  }
}