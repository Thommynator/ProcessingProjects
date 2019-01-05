ArrayList<ArrayList<Float>> points = new ArrayList<ArrayList<Float>>(); //<>//
int w = 40;
int d = 30;
float z = 0;

void setup() { 
  size(1200, 800, P3D);
  lights();

  for (int i=0; i<w; i++) {
    ArrayList<Float> col = new ArrayList<Float>();
    for (int j=0; j<d; j++) {
      col.add(random(1));
    }
    points.add(col);
  }
}

void draw() {
  background(50);

  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {
      rotateY(z);
      pushMatrix();
      int factor = width/w;
      int x = (int) (factor/2 + i * factor);
      int y = (int) (3*height/4 - points.get(i).get(j));
      int z = -j*factor;
      //print("x: " + x + " y: " + y + " z: " + z);  
      translate(x, y, z);
      fill(200, 100);
      noStroke();
      sphere(5);
      popMatrix();
    }
  }


  z--;
}
