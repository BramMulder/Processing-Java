class Matrix{
  
  //Takes Two Data Points (Student's Grades for X & Y axis) and X & Y ranges for the map function
  void loadData(int dataX, int dataY, int positionXstart, int positionXend, int positionYstart, int positionYend) {
      String[] rows = loadStrings("studentcijfers3.txt");
      
      for (int i = 0; i < rows.length; i++) {
          if (i == 0) {
              continue;  
          }
      
      String columns[] = split(rows[i], "\t");
      float ANA = float(columns[2].replace(",", "."));
      float DEV = float(columns[3].replace(",", "."));
      float PRJ = float(columns[4].replace(",", "."));
      float SKL = float(columns[5].replace(",", "."));   
      
      float[] values = new float[4];
      values[0]=ANA;
      values[1]=DEV;
      values[2]=PRJ;
      values[3]=SKL;
      
      float x = map(values[dataX],0,10, positionXstart, positionXend);
      float y = map(values[dataY],0,10, positionYstart,positionYend);
      
      //Colors for the different plots
      //Red -> Yellow -> Orange -> Green
      if(dataY == 0)fill(255,0,0);
      if(dataY == 1)fill(255,255,0);
      if(dataY == 2)fill(255,155,0);
      if(dataY == 3)fill(34,139,34);

      ellipse(x, y, 5, 5);
      }
  }
 
}