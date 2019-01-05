ArrayList<ArrayList<Float>> points = new ArrayList<ArrayList<Float>>(); //<>// //<>// //<>// //<>//
int w = 300; // anount of sample points in width
int d = 300; // amount of sample points in depth
float rotationAngleY = 0;

void setup() { 
  size(1280, 720, P3D);

  // change this image name to use different hight maps
  PImage img = loadImage("data/GrandCanyonHeightMap.png");

  for (int i=0; i<w; i++) {
    ArrayList<Float> columnArray = new ArrayList<Float>();
    for (int j=0; j<d; j++) {
      int col = img.width/w * j;
      int row = img.height/d * i;
      color px = img.get(col, row);
      float h = map(brightness(px), 0, 255, 0, 500);
      columnArray.add(h);
    }
    points.add(columnArray);
  }
}

void draw() {
  background(50);
  lights();
  int factor = width/w;

  translate(width/2, 0, -d*factor/2);
  rotateX(-PI/8);
  rotateY(rotationAngleY);
  translate(-width/2, 0, d*factor/2);

  fill(200, 210);
  noStroke();

  beginShape(QUADS);
  for (int i=0; i<points.size()-1; i++) {
    for (int j=0; j<points.get(i).size()-1; j++) {

      int[] xyz;
      xyz = getXYZ(i, j, factor);
      vertex(xyz[0], xyz[1], xyz[2]);

      xyz = getXYZ(i, j+1, factor);
      vertex(xyz[0], xyz[1], xyz[2]);

      xyz = getXYZ(i+1, j+1, factor);
      vertex(xyz[0], xyz[1], xyz[2]);

      xyz = getXYZ(i+1, j, factor);
      vertex(xyz[0], xyz[1], xyz[2]);
    }
  }
  endShape();
  rotationAngleY -= 0.005;
}


// computes a 3D coordinate (x,y,z) based on a 2D coordinate (x,y)
int[] getXYZ(int i, int j, int factor) {
  int x = (int) (factor/2 + i * factor);
  int y = (int) (3*height/4 - points.get(i).get(j));
  int z = -j*factor;
  return new int[]{x, y, z};
}
