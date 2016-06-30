// @Author:  Bram Mulder
// @Date:    26/06/16
// @Version: 1.0
// @Copyright Code: Anyone can use it for non-commercial purposes
// @Copyright Data: © Centraal Bureau voor de Statistiek, Den Haag/Heerlen 25-6-2016
// @Link to dataset: http://statline.cbs.nl/Statweb/publication/?DM=SLNL&PA=71885NED&D1=a&D2=a&D3=5,14&D4=a&D5=0&D6=a&HDR=T,G3&STB=G2,G1,G4,G5&VW=T


Table table;

//Start of drawing
int baseLineX = 50;
int baseLineY = 550;

int barWidth = 30;
int imgCount = 0;

int chosenYear = 0;
String chosenSubject = "";
  

void setup(){
size(1100,600);
table = loadTable("../data/gezonde_levensverwachting_comma.csv", "header, csv");

drawAxes();
drawValuesAxes();
drawLegend();
drawGrid();

}

void draw(){
}

void drawBars(String subject, int year){
  int addSpace = 0;
  int lineMin = 4;
  int lineMax = 7;
  year = year + 3;
  
  //Pick the right columns according to input
  if(subject.equals("Levensverwachting"))            {lineMin = 4;  lineMax = 7;}
  else if(subject.equals("Gezondheid"))              {lineMin = 8;  lineMax = 11;}
  else if(subject.equals("Lichamelijke Gezondheid")) {lineMin = 12; lineMax = 15;}
  else if(subject.equals("Chronische Ziektes"))      {lineMin = 16; lineMax = 19;}
  else if(subject.equals("Geestelijke Gezondheid"))  {lineMin = 20; lineMax = 23;}
      
      //Row for every Year/Gender
      TableRow row1 = table.getRow(year);
      TableRow row2 = table.getRow(year+7);
      TableRow row3 = table.getRow(year+14);
      TableRow row4 = table.getRow(year+21);
      

        //Loop over every value in the row - starting after the tags
        for(int i = 0; i < 4; i++){  
          addSpace = addSpace + barWidth;
          for(int j = lineMin; j <= lineMax; j++){
              //Check if there is data - if not show "no data"
              if((row1.getInt(j) == 0) || (row2.getInt(j) == 0) || (row3.getInt(j) == 0) || (row4.getInt(j) == 0)){
                    pushMatrix();
                     translate(baseLineX+(((j-4)*barWidth)+addSpace)+30, baseLineY-5);
                     rotate(-HALF_PI);
                     textSize(15);
                     text("No Data",0,0);
                    popMatrix(); 
              }
              
              //Give the bars a color
              if(j%4 == 0) fill(0,191,255);
              if(j%4 == 1) fill(30,144,255);
              if(j%4 == 2) fill(65,105,225);
              if(j%4 == 3) fill(0,0,255);
                            
              //Draw a bar
              if(i == 0)     rect(baseLineX+(((j-lineMin)*barWidth)+addSpace), baseLineY, barWidth, -row1.getFloat(j)*5);
              else if(i == 1)rect(baseLineX+(((j-lineMin)*barWidth)+addSpace+130), baseLineY, barWidth, -row2.getFloat(j)*5);   
              else if(i == 2)rect(baseLineX+(((j-lineMin)*barWidth)+addSpace+260), baseLineY, barWidth, -row3.getFloat(j)*5);   
              else if(i == 3)rect(baseLineX+(((j-lineMin)*barWidth)+addSpace+390), baseLineY, barWidth, -row4.getFloat(j)*5);                
          }
        }
          
      drawTitle(year);
}

void drawAxes(){
  //X
  line(baseLineX, baseLineY, 900, 550);
  //Y
  line(baseLineX, baseLineY, 50, 50);
}

void drawValuesAxes(){
  fill(0,0,0);
  textSize(12);
  //X
  text("Mannen - 20 Jaar", baseLineX + 50 , baseLineY + 20);
  text("Vrouwen - 20 Jaar", baseLineX + 210 , baseLineY + 20);
  text("Mannen - 65 Jaar", baseLineX + 360 , baseLineY + 20);
  text("Vrouwen - 65 Jaar", baseLineX + 520 , baseLineY + 20);
  //Y
  for(int i = 0; i <= 10; i++){
    text(i*10, baseLineX-25, (baseLineY - i*50)+5);
  }
}

void drawLegend(){
  fill(0,0,0);
  TableRow row = table.getRow(2);
  //Basisonderwijs
  text(row.getString(4), 950, 405);
  fill(0,191,255);
  rect(1050, 395, 20, 10);
  //VMBO
  fill(0,0,0);
  text(row.getString(5), 950, 425);
  fill(30,144,255);
  rect(1050, 415, 20, 10);
  //HAVO, VWO, MBO
  fill(0,0,0);
  text(row.getString(6), 950, 445);
  fill(65,105,225);
  rect(1050, 435, 20, 10);
  //HBO, UNI
  fill(0,0,0);
  text(row.getString(7), 950, 465);
  fill(0,0,255);
  rect(1050, 455, 20, 10);  
}

//Code by @Salt and Onion - https://processing.org/discourse/beta/num_1194739467.html
//Tweaked it to match it to my view
void drawGrid(){ 
 int widthSpace = 10;
 int heightSpace = 10;
 //Vertical
 for(int i=baseLineX; i<=900 ; i+=widthSpace){
   line(i,50,i,height-baseLineX);
 }
 //Horizontal
 for(int w=50; w<550; w+=heightSpace){
   line(baseLineX,w,900,w);
 }
}

void drawTitle(int rowNumber){
   fill(0,0,0);
   TableRow row = table.getRow(rowNumber);
   textSize(20);
   text(chosenSubject + ",  Mannen & Vrouwen"+ ", " + row.getString(3)  ,230,30);
}

void printTable(){
  for(int i = 4; i < table.getRowCount()-1; i++){
      TableRow row = table.getRow(i);
        println();
        for(int j = 0; j < 24; j++){
            print(row.getString(j) + " ");
        }
  }
}

void keyPressed(){
  if((parseInt(key) >= 49) && (parseInt(key) <= 55)){
      switch(key){
        //Key ID's of numbers 1-7
        case 49: chosenYear = 1; break;
        case 50: chosenYear = 2; break;
        case 51: chosenYear = 3; break;
        case 52: chosenYear = 4; break;
        case 53: chosenYear = 5; break;
        case 54: chosenYear = 6; break;
        case 55: chosenYear = 7; break;
        default: println("error");
     }
   }
   if(key == 'a'){
     chosenSubject = "Levensverwachting";
   }
   if(key == 's'){
     chosenSubject = "Gezondheid";
   }
   if(key == 'd'){
     chosenSubject = "Lichamelijke Gezondheid";
   }
   if(key == 'f'){
     chosenSubject = "Chronische Ziektes";
   }
   if(key == 'g'){
     chosenSubject = "Geestelijke Gezondheid";
   }
   if(key == '/'){
     if(chosenYear == 0)println("Please pick a year");
     else if(chosenSubject.equals(""))println("Please pick a subject");
     else drawBars(chosenSubject, chosenYear);
     //test();
   }
   if(key == 'c'){
     background(#cbcbcb);
     setup();
   }
   if(key == 'i'){
      println("Saved as an image");
      saveFrame("levensverwachting" + imgCount + ".png");
      imgCount++;
    }
}

void mouseClicked(){
   line(50, mouseY, 900, mouseY);
}