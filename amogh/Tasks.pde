
import java.util.Random;

// define these in main:
//    int oneDayPixel, pixelPerDegree, graphHeight;
//    int oneDayPixel = width/24;
// float min,max;
// Now, call the function calc() in setup


void renderTemperature(){
  int x = 5;  // Start the graph 5 pixels from the left
  for(int i=0;i<temperatures.length-1;i++,x+=oneDayPixel){
    int x1 = x;
    int y1 = 10 + getPosition(temperatures[i]);
    int x2 = x+oneDayPixel;
    int y2 = 10 + getPosition(temperatures[i+1]);
    stroke(map(temperatures[i],min,max,0,255),0,255-map(temperatures[i+1],min,max,0,255));
    line(x1, y1, x2, y2);
  } 
}


void renderDrops(){
  drops[totalDrop]=new Drop();
  totalDrop++;
  if(totalDrop>=drops.length){
    totalDrop--;
  }
  for(int i=0;i<totalDrop;i++){
    drops[i].move();
    drops[i].display();
  }
}

void renderSnow(){
  snowFlakes[totalSnow] = new SnowFlake();
  totalSnow++;
  if(totalSnow>=snowFlakes.length){
    totalSnow--;
  }
  for(int i=0;i<totalSnow;i++){
    snowFlakes[i].draw();
  }
}

void focusLighting(){
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < 10+ graphHeight; y++ ) {
      float r,g,b;
      //float d = dist(x, y, currentTime, 10+graphHeight/2);
      float d = Math.abs(currentTime - x);
      float adjustbrightness = 0.8*255*(maxdist-d)/maxdist; // was 255*(maxdist-d)/maxdist;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(red(get(x,y))+adjustbrightness, 0, 255);
      g = constrain(green(get(x,y))+adjustbrightness, 0, 255);
      b = constrain(blue(get(x,y))+adjustbrightness, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      set(x,y,c);
    }
  }
  
}

void renderFlower(){
  // A design for a simple flower
  fill(204, 101, 192, 127);
  translate(580, 70);
  noStroke();
  for (int i = 0; i < 10; i ++) {
    ellipse(0, 15, 10, 40);
    rotate(PI/5);
  }}

void setupTerrain(){
  int cols, rows;
  int scl = 14;
  int w = 6080;
  int h = 720;
  
  float flying = 0;
  
  float[][] terrain;
   
  //size(6080,720,P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  flying -= 0.06; /// was -0.06
  
  float yoff = flying;
  
  for (int y = 0; y < rows - 1; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100); // was -70 to 70
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  
  background(0);
  stroke(255);
  noFill();
  
  translate(width / 1.5, height / 1.5 - 50); // was 2
  rotateX(PI/3); // was 3
  translate(- w / 2, - h / 2);
  
  float redFill = 237; // was 237
  float greenFill = 201; // was 201
  float blueFill = 175; // was 175
  
  Random random = new Random();
  
  //for (int y = 0; y < rows - 1; y++) {
  for (int x = 0; x < cols-1; x++) {
    beginShape(TRIANGLE_STRIP);
    stroke(  166, 145, 80);
    //stroke(redFill,greenFill,blueFill);
    //for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
      float rand = random.nextFloat()*0.06;
      
      // pick a direction at random and increase count of green by 1
      if(blueFill - rand >= 0){
        blueFill = blueFill-rand;
      }else{
        blueFill = 0;
        if(greenFill+rand <= 255){
          greenFill = greenFill+rand;
        }else{
          greenFill = 255;
          if(redFill - rand >= 0){
            redFill -= rand;
          }else{
            redFill = 0;
          }
        }
      }

      color colour = color(redFill,greenFill,blueFill);
      fill(colour);
      //vertex(x * scl, y * scl, terrain[x][y]);
      //vertex(x * scl, (y + 1) * scl, terrain[x][y+1]);
      vertex(x * scl, (y) * scl, terrain[x][y]);
      vertex((x+1) * scl, (y) * scl, terrain[x+1][y]);
    }
    endShape();
  }
  translate(0,0);
}

// UTILS

int getPosition(float temp){
  return (int)((max-temp)*pixelPerDegree);
}

void calc(){
  graphHeight = (int)(WINDOW_HEIGHT/2.5);
  oneDayPixel = (int)Math.ceil((WINDOW_WIDTH)/temperatures.length);
  min = Collections.min(Arrays.asList(temperatures));
  max = Collections.max(Arrays.asList(temperatures));
  pixelPerDegree = (int)Math.ceil(graphHeight/(max-min));
}
