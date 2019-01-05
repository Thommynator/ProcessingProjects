class Pointer{
  
   float angle;
   float pLength;
   float pWidth;
   
   Pointer(float pointerLength, int pointerWidth){
     this.pLength = pointerLength;
     this.pWidth = pointerWidth;
     angle = 0;
   }
   
   void show(){
     int x = int(sin(angle) * pLength);
     int y = int(-cos(angle) * pLength);
     strokeWeight(pWidth);
     line(width/2, height/2, width/2+x, height/2+y);
   }
}