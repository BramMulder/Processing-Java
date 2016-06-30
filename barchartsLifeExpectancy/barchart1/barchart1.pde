// @Author:  Bram Mulder
// @Date:    26/06/16
// @Version: 1.0
// @Copyright Code: Anyone can use it for non-commercial purposes
// @Copyright Data: © Centraal Bureau voor de Statistiek, Den Haag/Heerlen 25-6-2016
// @Link to dataset: http://statline.cbs.nl/Statweb/publication/?DM=SLNL&PA=71885NED&D1=a&D2=a&D3=5,14&D4=a&D5=0&D6=a&HDR=T,G3&STB=G2,G1,G4,G5&VW=T


Table table;

int baseLineX = 50;
int baseLineY = 550;
int barWidth = 30;
int imgCount = 0;

int chosenAge = 0;
int chosenYear = 0;
String chosenGender = "";
  

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

void drawBars(String gender, int age, int year){
  int addSpace = 0;
  int rowNumber = 4;
  
  //Pick the right row according to input
  if((gender.equals("Mannen")) && (age == 20)) rowNumber = 3;
  if((gender.equals("Mannen")) && (age == 65)) rowNumber = 17;
  if((gender.equals("Vrouwen")) && (age == 20)) rowNumber = 10;
  if((gender.equals("Vrouwen")) && (age == 65)) rowNumber = 24;
  rowNumber = rowNumber + year;   
    
      TableRow row = table.getRow(rowNumber);
          //Loop over every value in the row - starting after the tags
          for(int j = 4; j < 24; j++){
              //Add a blank space every block of data (4 bars == 1 block)  
              if(j%4 == 0){
                  addSpace = addSpace + barWidth;
              }
              //Check if there is data - if not show "no data"
              if(row.getInt(j) == 0){
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
              rect(baseLineX+(((j-4)*barWidth)+addSpace), baseLineY, barWidth, -row.getFloat(j)*5);              
          }
          
      drawTitle(rowNumber);
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
  TableRow row = table.getRow(1);
  //X
  for(int i = 4; i < 24; i++){
    textSize(10);
    if(i%4 == 0)text(row.getString(i), baseLineX * (i/1.4)-50 , (baseLineY + 5) + i*2);
  }
  //Y
  for(int i = 0; i <= 10; i++){
    text(i*10, baseLineX-20, (baseLineY - i*50)+5);
  }
}

void drawLegend(){
  fill(0,0,0);
  TableRow row = table.getRow(2);
  //Basisonderwijs
  text(row.getString(4), 950, 405);
  fill(0,191,255);
  rect(1040, 397, 20, 10);
  //VMBO
  fill(0,0,0);
  text(row.getString(5), 950, 425);
  fill(30,144,255);
  rect(1040, 417, 20, 10);
  //HAVO, VWO, MBO
  fill(0,0,0);
  text(row.getString(6), 950, 445);
  fill(65,105,225);
  rect(1040, 437, 20, 10);
  //HBO, UNI
  fill(0,0,0);
  text(row.getString(7), 950, 465);
  fill(0,0,255);
  rect(1040, 457, 20, 10);  
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
   text("Gezonde levensverwachting in jaren; opleidingsniveau" + ", " + row.getString(1) + ", " + row.getString(0) + ", " + row.getString(3)  ,60,30);
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
   if(key == 'm'){
     chosenGender = "Mannen";
   }
   if(key == 'v'){
     chosenGender = "Vrouwen";
   }
   if(key == 'z'){
     chosenAge = 20;
   }
   if(key == 'x'){
     chosenAge = 65;
   }
   if(key == '/'){
     if(chosenYear == 0) println("Please choose a Year");
     else if(chosenGender.equals("")) println("Please choose a Gender");
     else if(chosenAge == 0)  println("Please choose an Age");
     else    drawBars(chosenGender, chosenAge, chosenYear);
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