class SnakeAI extends Snake{
 
  SnakeAI(int x, int y, int startingDirection){
   super(x, y, startingDirection);
  }
  
  void updateDirection(PVector target) {
    if(target.y < this.elements.get(0).y) this.direction = 0;
    if(target.x > this.elements.get(0).x) this.direction = 1;
    if(target.y > this.elements.get(0).y) this.direction = 2;
    if(target.x < this.elements.get(0).x) this.direction = 3;
  }
  
}