// X Line Properties
int startX = 40;
int endX = 1140;
int lengthX = endX - startX;

// X Line Properties
int startY = 50;
int endY = 750;
int lengthY = endY - startY;

void setup(){
  size(1300, 800);
  background(255, 255, 255);
  drawLines();
  drawDatapoints();
  loadData();
  legend();
}

void drawLines(){
  //X
  line(startX, 750 , endX, 750);
  //Y
  line(40, startY ,40 , endY);
 
}

void drawDatapoints(){
     textSize(15);
     fill(0, 102, 153, 204);
    
    //Calculate value per pixel
    float pixelValueX = lengthX / (float) 1800;
    float pixelValueY = lengthY / (float) 70;
    
    //X Values
    for(int i = 1; i <= 9; i++){
      text((i*2)*100, ((pixelValueX*i)*2)*100, 770);
    }
    
    //Y Values
    for(int i = 1; i <= 10; i++){
      text(i*10, 15 , (lengthY + (startY*2)) - ((pixelValueY*i)*10));
    }

}

void loadData() {
    String[] rows = loadStrings("scatterplot.txt");
    
    for (int i = 0; i < rows.length; i++) {
        if (i == 0) {
            continue;  
        }
    
    String columns[] = split(rows[i], "\t");
    int CAT = int(columns[0]);
    int EIG1 = int(columns[1]);
    float EIG2 = float(columns[2].replace(",", "."));
    
    float x = map(EIG1,0,70, 0,1050);
    float y = map(EIG2,0,1800, 800,50);
    
    //Changes Color per category
    stroke(0);
    if (CAT == 1) {
        fill(0,191,255);
    } else if (CAT == 2) {
        fill(0,0,255);
    } else if (CAT == 3) {
        fill(138,43,226);
    } else {
        fill(75,0,130);
    }
    
    ellipse(x, y, 10, 10);
    }
}

//draws the legend
void legend(){
    fill(0,191,255);
    text("CAT 1", 1210, 680);
    fill(0,0,255);
    text("CAT 2", 1210, 700);
    fill(138,43,226);
    text("CAT 3", 1210, 720);
    fill(75,0,130);
    text("CAT 4", 1210, 740);
}