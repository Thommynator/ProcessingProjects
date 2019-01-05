ArrayList<ArrayList<Float>> points = new ArrayList<ArrayList<Float>>(); //<>//
int w = 30;
int d = 30;
float rotationAngleY = 0;

void setup() { 
  size(1200, 600, P3D);

  // generate data
  PImage img = loadImage("data/MountEverestHeightMap.png");
  
  for (int i=0; i<w; i++) {
    ArrayList<Float> columnArray = new ArrayList<Float>();
    for (int j=0; j<d; j++) {
      int col = img.width/w * j;
      int row = img.height/d * i;
      color px = img.get(col, row);
      
      float h = map(brightness(px), 0, 255, 2400, 8800);
      columnArray.add(h);
    }
    points.add(columnArray);
  }
  
 //<>//
}

void draw() {
  background(50);
  int factor = width/w;

  translate(width/2, 0, -d*factor/2);
  rotateY(rotationAngleY);
  translate(-width/2, 0, d*factor/2);
  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {

      pushMatrix();

      int x = (int) (factor/2 + i * factor);
      int y = (int) (3*height/4 - points.get(i).get(j));
      int z = -j*factor;
      //print("x: " + x + " y: " + y + " z: " + z);  
      translate(x, y, z);
      fill(200, 128);
      noStroke();
      sphere(5);
      popMatrix();
    }
  }


  rotationAngleY -= 0.005;
} //<>// //<>//
