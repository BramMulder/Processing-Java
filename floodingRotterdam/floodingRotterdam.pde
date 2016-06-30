/**
* A flooding application in Rotterdam
* Draws black points on the canvas with different heights, dark being low and bright being high
* Floods when 'z' is pressed
* Resets canvas when 'r' is pressed
*
* @author    Ferry Liekens, Bram Mulder
* @version   1.0
* @since     2016-06-12 
* @copyright Anyone can use it for non-commercial purposes
*/

BufferedReader reader;
String line;
//minimal and maximal coordinates to create a 1000x1000 / 500x500 area
float minX;
float maxX;
float minY;
float maxY;
//if small is chosen the coordinates need to be rescaled
boolean small = false;
//recolours the canvas if 'r' is pressed
boolean resetCanvas=false;
//amount of floods done
int timesRan = 0;
//Creates a dynamic name for the saved image
int imgCount = 0;
//array lists for the different floodlevels
ArrayList level1 = new ArrayList();
ArrayList level2 = new ArrayList();
ArrayList level3 = new ArrayList();
ArrayList level4 = new ArrayList();
ArrayList level5 = new ArrayList();
ArrayList level6 = new ArrayList();

void setup(){
  size(1000, 1000);
  drawIntro();
}

void draw(){
}

void DrawEast(){
  try {
      reader = createReader("../rotterdamopendata_hoogtebestandtotaal_oost.csv");
      reader.readLine();
      while((line = reader.readLine()) != null){
          String[] pieces = split(line, ",");
          float x = float(pieces[0]);
          float y = float(pieces[1]);
          float z = float(pieces[2]);
          
          //only draws points inside the 1000x1000 / 500x500 meters area
          if((x>minX && x < maxX) && (y >minY && y < maxY)){
            x = x - minX;
            y = y - minY;
            DrawPoint(x, y, z);
          }
      }
      resetCanvas=false;
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line == null) {
      // Stop reading because of an error or file is empty
      println("File empty or empty Line");
      noLoop();  
    } 
}

void DrawPoint(float x, float y, float z){
        z = map(z, -5, 80.0, 0, 200);
        if(small){
          x = map(x, 0, 500, 0, 1000);
          y = map(y, 0, 500, 0, 1000);
        }
        
        //gives every ellipse a different color to view height difference
        fill(z,z,z);
        
        //saves coordinates and height of points to increase performance, splits different z values to make flood levels
        if(z < 10){           Vector3 vector = new Vector3(); vector.x = x; vector.y = y; vector.z = z; level1.add(vector);}
        if(z >= 10 && z <20){ Vector3 vector = new Vector3(); vector.x = x; vector.y = y; vector.z = z; level2.add(vector);}
        if(z >= 20 && z <30){ Vector3 vector = new Vector3(); vector.x = x; vector.y = y; vector.z = z; level3.add(vector);}
        if(z >= 30 && z <50){ Vector3 vector = new Vector3(); vector.x = x; vector.y = y; vector.z = z; level4.add(vector);}
        if(z >= 50 && z <70){ Vector3 vector = new Vector3(); vector.x = x; vector.y = y; vector.z = z; level5.add(vector);}
        if(z >= 70){          Vector3 vector = new Vector3(); vector.x = x; vector.y = y; vector.z = z; level6.add(vector);}
        
        //recolours canvas
        if(resetCanvas){resetColours(x,y,z);}
        
        ellipse(x, y, 5, 5);
}

void FloodCity(){
  //recolours the points under a certain z value (height) into blue
  if(timesRan==1){
    for (int i = 0; i < level1.size(); i++) {
      Vector3 vector3 = ((Vector3) level1.get(i));
      set(round(vector3.x), round(vector3.y), #2491f9);
    }
  }
    if(timesRan==2){
    for (int i = 0; i < level2.size(); i++) {
      Vector3 vector3 = ((Vector3) level2.get(i));
      set(round(vector3.x), round(vector3.y), #2491f9);
    }
  }
    if(timesRan==3){
    for (int i = 0; i < level3.size(); i++) {
      Vector3 vector3 = ((Vector3) level3.get(i));
      set(round(vector3.x), round(vector3.y), #2491f9);
    }
  }
  if(timesRan==4){
    for (int i = 0; i < level4.size(); i++) {
      Vector3 vector3 = ((Vector3) level4.get(i));
      set(round(vector3.x), round(vector3.y), #2491f9);
    }
  }
  if(timesRan==5){
    for (int i = 0; i < level5.size(); i++) {
      Vector3 vector3 = ((Vector3) level5.get(i));
      set(round(vector3.x), round(vector3.y), #2491f9);
    }
  }
    if(timesRan==6){
    for (int i = 0; i < level6.size(); i++) {
      Vector3 vector3 = ((Vector3) level6.get(i));
      set(round(vector3.x), round(vector3.y), #2491f9);
    }
  }
}

void keyPressed(){
  if (key == 's' || key == 'S') {
      small =true;
      minX = 92550;
      maxX = 93050;
      minY = 436750;
      maxY = 437250;
      DrawEast();
    }
    else if(key== 'b' || key == 'B'){
      minX = 92300;
      maxX = 93300;
      minY = 436500;
      maxY = 437500;
      DrawEast();
    }
    else if(key== 'z' || key == 'Z'){
      timesRan++;
      FloodCity();
    }
    //Resets the canvas
    else if(key == 'r' || key == 'R'){
      resetCanvas=true;
      timesRan=0;
      DrawEast();
    }
    //Saves an image
    else if(key== 'i' || key == 'I'){
      println("Saved as an image");
      saveFrame("rotterdam" + imgCount + ".png");
      imgCount++;
    }
}     

void resetColours(float x, float y, float z){
  //set() works with a different colour code than ellipse so have to make a lot of if's
  if(z < 10)             set(round(x),round(y), #000000);
  if(z >= 10 && z <20)   set(round(x),round(y), #151515);
  if(z >= 20 && z <30)   set(round(x),round(y), #1C1C1C);
  if(z >= 30 && z <40)   set(round(x),round(y), #313131);
  if(z >= 40 && z <50)   set(round(x),round(y), #414141);
  if(z >= 50 && z <60)   set(round(x),round(y), #585858);
  if(z >= 60 && z <80)   set(round(x),round(y), #696969);
  if(z >= 80 && z <100)  set(round(x),round(y), #848484);
  if(z >= 100 && z <150) set(round(x),round(y), #898989);
  if(z >= 150)           set(round(x),round(y), #BDBDBD);
}

void drawIntro(){
  textSize(30);
  text("Press 'S' for a 500x500 area, press 'B' for a 1000x1000 area", 50, 500);
}