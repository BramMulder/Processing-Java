JSONObject json; //<>//

//Arraylists
ArrayList<Float> latitude = new ArrayList<Float>();
ArrayList<Float> longitude = new ArrayList<Float>();
ArrayList<Float> depth = new ArrayList<Float>();
ArrayList<Float> size = new ArrayList<Float>();
  
ArrayList<Float> xPixels = new ArrayList<Float>();
ArrayList<Float> yPixels = new ArrayList<Float>();

//Map sizes
float xMin = 13.6;
float xMax = 24.5;

float yMin = 63.4;
float yMax = 66.4;

//PPG - Pixel Per Graden
float PPGx = 78.5;
float PPGy = 194.6;


//Drawing The map

PImage bg;


void setup() {
  //window size
  size(856, 584);
  //background
  bg = loadImage("../mapIceland2.png");
  background(bg);
  
  //Title & Source Text
  textSize(20);
  text("Earthquakes Iceland 12/05/16", 260, 30);
  textSize(10);
  text("Source: Icelandic Meteorological Office", 660, 580);
  
  //Methods
  loadJson();
  calculatePixels();
  drawPoints();
  drawLegend();
  
}

void loadJson(){
  json = loadJSONObject("measurements.json");
  JSONArray results = json.getJSONArray("results");
  
  for(int i=0; i < results.size(); i++){
    JSONObject result = results.getJSONObject(i);
    
//Puts values into the arraylists    
    latitude.add(result.getFloat("latitude"));
    longitude.add( result.getFloat("longitude"));
    depth.add(result.getFloat("depth"));
    size.add(result.getFloat("size"));
  }
}

void calculatePixels(){
  for(int i = 0; i < longitude.size(); i++){
      float temp = 24.5 + longitude.get(i);
      xPixels.add(temp);
  }
  for(int i = 0; i < latitude.size(); i++){
      float temp = 66.4 - latitude.get(i);
      yPixels.add(temp);
  }
}

void drawPoints(){
    for(int i = 0; i < xPixels.size(); i++){
      //Calculate where the ellipse has to be on the map in pixels
      float xPixel = xPixels.get(i);
      float yPixel = yPixels.get(i);
      float x = xPixel * PPGx;
      float y = yPixel * PPGy;
      
      //calculate which color the ellipse has to be according to the depth      
      int[] colorEllipse = colorChoose(depth.get(i));
      fill(colorEllipse[0], colorEllipse[1], colorEllipse[2]);

      //calculate the size of the ellipse
      float ellipseSize = (1 + size.get(i)) * 10;
            
      //draw the ellipse
      ellipse(x, y, ellipseSize, ellipseSize);      
      
    }
}

int[] colorChoose(float depth){
  //Bright green by default - easy to spot errors
  int[] rgb = {0,255,0};
  if(depth < 1)   {rgb[0]= 255; rgb[1] = 255; rgb[2]= 255;}      // white
  else if(depth < 2)   {rgb[0]= 204; rgb[1] = 0; rgb[2]= 204;}   // purple
  else if(depth < 5)   {rgb[0]= 0; rgb[1] = 0; rgb[2]= 255;}     // blue
  else if(depth <= 10) {rgb[0]= 255; rgb[1] =255; rgb[2]= 51;}   // yellow
  else if(depth > 10)  {rgb[0]= 255; rgb[1] = 0; rgb[2]= 0;}     // red
  return rgb;
}

void drawLegend(){
  fill(255,255,255);
  rect(0, 490, 80, 200);
  fill(0,0,0);
  textSize(12);
  text("depth - km", 5, 490, 100, 200);
  
  // <1
  text(" 0 - 1", 0, 520);
  fill(255, 255, 255);
  ellipse(55, 515, 10, 10);
  
  // <2
  fill(0,0,0);
  text(" 1 - 2", 0, 535);
  fill(204, 0, 204);
  ellipse(55, 530, 10, 10);
  
  // <5
  fill(0,0,0);
  text(" 2 - 5", 0, 550);
  fill(0, 0, 255);
  ellipse(55, 545, 10, 10);
  
  // <=10
  fill(0,0,0);
  text(" 5 - 10", 0, 565);
  fill(255, 255, 51);
  ellipse(55, 560, 10, 10);
  
  // >10
  fill(0,0,0);
  text(" > 10", 0, 580);
  fill(255, 0, 0);
  ellipse(55, 575, 10, 10);
}