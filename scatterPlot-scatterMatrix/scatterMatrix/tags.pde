//Draws the value tags on the axis
class Tags{
  void drawTagsX(int startX, int startY){
    fill(0,0,0);
    for(int i = 0; i <= 5; i++){
      text(i*2, startX, startY-i*30);
    }
  }
  
   void drawTagsY(int startX, int startY){
    fill(0,0,0);
    for(int i = 0; i <= 5; i++){
      text(i*2, startX+i*30, startY);
    }
  }
}