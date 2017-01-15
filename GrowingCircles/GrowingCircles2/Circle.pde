class Circle{
  float xPos;
  float yPos;
  float radius;
  boolean isGrowing;
  color clr;
  
  Circle(float x, float y, color c){
    xPos = x;
    yPos = y;
    radius = 1;
    isGrowing = true;
    clr = c;
  }
  
  void grow(){
    if(isGrowing) radius+=1;
  }
  
  void show(){
    fill(clr);
    ellipse(xPos,yPos,radius*2, radius*2);
  }
  
  // check if circle is colliding with a canvas edge
  // if circle collides, stop growing process
  void collision(){
    if(!isGrowing
    || xPos+radius > width 
    || xPos-radius < 0 
    || yPos+radius > height 
    || yPos-radius < 0){
      isGrowing = false;
    }
  }
  
}