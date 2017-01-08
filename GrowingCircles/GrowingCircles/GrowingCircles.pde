ArrayList<Circle> circles;
// this number describes, how many circles are generated and added to the list in the same interation
int nTotal = 30;
// the algorithm tries to find an empty spot for new circles n times.
int limit = 1000;
// scale down original image (downsampling)
int scl=5;
// list of all possible spots, where a new circle can be placed
ArrayList<PVector> spots;

PImage img;
void setup() {
  size(800,800);
  spots = new ArrayList<PVector>();
  circles = new ArrayList<Circle>();
  circles.add(new Circle(width,height));
  
  img = loadImage("img.jpg");
  img.resize(width/scl, height/scl);
  img.loadPixels();
  background(0,0,0);
  image(img,0,0);

  // found all possible spots
  for(int x = 0; x<img.width; x++){
    for(int y=0; y<img.height; y++){
      if(brightness(img.pixels[x+y*img.width])>50){
        spots.add(new PVector(x,y));
      }
    }
  }
}

void draw() {
  background(0);
  for(Circle c : circles){
    // collision with edges of canvas?
    c.collision();
    for(Circle other : circles){
      // collision to other circles?
      if(c!=other && dist(c.xPos, c.yPos, other.xPos, other.yPos)<c.radius+other.radius+1){
        c.isGrowing = false;
        break;
      }
    }
    // increase size of current circle
    c.grow();
    // show circle
    c.show();
  }
  
  // try to add nTotal new circles 
  int counts = 0;
  for(int i=0; i<nTotal; i++){
    Circle newC = newCircle();
    if(newC!=null){
      circles.add(newC);
    }
    else {
      i--;
    }
    counts++;
    if(counts>limit) {
      circles.clear();
      break;
    }
  }
}

    
// add a new circle if its origin isn't already in an other circle
Circle newCircle(){
  PVector v =spots.get((int)random(spots.size()));
  boolean valid = true;
  for(Circle other : circles){
    if(dist(v.x*scl,v.y*scl, other.xPos, other.yPos)< other.radius+2){
      valid = false;
      break;
    }
  }
  
  if(!valid){
    return null;
  }
  
  return new Circle(v.x*scl, v.y*scl);
  
}