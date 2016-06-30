void setup()
{
  size(700, 750);
  background(255);
  
  //Call to the rectangle draw method
  for (int i = 0; i < 600; i = i + 150)
  {
    rect(i, 20);
  }
  
  //Draws the individual scatterplots and 
  Matrix matrix = new Matrix();
  //ANA - DEV
  matrix.loadData(0, 1, 50, 200, 320, 170);
  matrix.loadData(1, 0, 200, 350, 170, 20);
  
  //ANA - PRJ
  matrix.loadData(0, 2, 50, 200, 470, 320);
  matrix.loadData(2, 0, 350, 500, 170, 20);
  
  //ANA - SKL
  matrix.loadData(0, 3, 50, 200, 620, 470);
  matrix.loadData(3, 0, 500, 650, 170, 20);
  
  //DEV - PRJ
  matrix.loadData(1, 2, 200, 350, 470, 320);
  matrix.loadData(2, 1, 350, 500, 320, 170);
  
  //DEV - SKL
  matrix.loadData(1, 3, 200, 350, 620, 470);
  matrix.loadData(3, 1, 500, 650, 320, 170);
  
  //PRJ - SKL
  matrix.loadData(2, 3, 350, 500, 620, 470);
  matrix.loadData(3, 2, 400, 650, 470, 320);
  
  
  //Draws the tags on the axis
  Tags tags = new Tags();
  //X left
  tags.drawTagsX(35, 325);
  tags.drawTagsX(35, 625);
  //X right
  tags.drawTagsX(655, 175);
  tags.drawTagsX(655, 475);
  
  //Y bottom
  tags.drawTagsY(35, 635);
  tags.drawTagsY(345, 635);
  //Y top
  tags.drawTagsY(200, 15);
  tags.drawTagsY(495, 15);
  
  //Title
  fill(0,0,0);
  textSize(20);
  text("Matrix Plot of ANA, DEV, PRJ & SKL Grades", 150, 700);  

}
   
//Draw the rectangle grid
void rect(int x, int y)
{
  pushMatrix();
  translate(x, y);
  rect(50, 0, 150, 150);
  rect(50, 150, 150, 150);
  rect(50, 300, 150, 150);
  rect(50, 450, 150, 150);
  popMatrix();
}
  
//Draw the tags in the rectangles
void draw()
{
  fill(0);
  textSize(15);
  text("ANA", 110, 100);
  text("DEV", 260, 250);
  text("PRJ", 410, 400);
  text("SKL", 560, 550);
}