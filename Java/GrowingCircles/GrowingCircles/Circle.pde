class Circle{
  float xPos;
  float yPos;
  float radius;
  color c = color((int)random(255),(int)random(255),(int)random(255));
  boolean isGrowing;
  
  Circle(float x, float y){
    xPos = x;
    yPos = y;
    radius = 1;
    isGrowing = true;

  }
  
  void grow(){
    if(isGrowing) radius+=1;
  }
  
  void show(){
    fill(c);
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