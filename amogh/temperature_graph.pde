import com.hamoid.*;
VideoExport videoExport;

import java.util.Arrays; 
import java.util.Collections;

// RAIN
class Drop{
  
  //data
  float x,y;
  float speed;
  color c;
  float r;
  
  //constructor
  Drop(){
    r=4;
    x=random(width);
    y=-r*5;
    speed=40;
    c=color(153, 237, 243);
  }
  
  //function
  void move(){
    y +=speed;
  }
  
  boolean reachBottom(){
    if(y>height+r*4){
      return true;
    }else{
      return false;
    }
  }
  
  void display(){
    fill(153, 237, 243);
    noStroke();
    
    //rianDrop shape
    for (int i = 2; i < 8; i++ ) {
      ellipse(x, y + i*2, i*1.5, i*1.5);
    }
  }
}

Drop[] drops=new Drop[2000];
int totalDrop=0;
int totalSnow = 0;
// </RAIN>


// <SNOW>
class SnowFlake{

  float x = random(width);
  float y = random(height);
  float r = random(5,15);

  void draw(){
   fill(250,235,215);
   noStroke();
   ellipse(x, y, r, r);

   y+=20;

   if(y > height){
     y = 0;
     x = random(width);
   }
  }
}
SnowFlake[] snowFlakes = new SnowFlake[500];
// </SNOW>

Float[] temperatures = {9.4,11.1,11.7,11.7,12.8,12.8,12.8,12.8,11.1,10.0,8.9,8.3,8.3,8.9,8.9,8.3,7.8,6.7,5.6,5.6,4.4,2.8,2.8,2.2,4.4,7.2,8.3,8.9,8.9,10.0,10.0,9.4,8.3,7.2,6.7,6.1,5.0,4.4,4.4,3.3,3.3,3.3,2.8,2.2,1.7,1.1,1.1,0.6,1.7,3.3,4.4,6.1,6.7,7.8,7.2,7.2,6.1,5.0,4.4,2.8,2.8,1.7,1.1,0.6,0.6,0.0,-0.6,-1.7,-1.1,-1.7,-2.2,-1.1,0.6,2.8,4.4,6.1,7.2,7.8,8.3,7.8,6.7,5.0,3.3,2.8,2.2,1.7,1.7,1.1,0.0,-1.7,-2.2,-2.2,-2.8,-2.8,-3.9,-3.3,-0.6,2.2,4.4,6.1,7.2,8.9,8.9,8.9,7.2,4.4,1.7,1.1,0.6,0.0,-1.7,-1.7,-1.7,-2.2,-2.8,-2.8,-2.2,-5.0,-4.4,-2.8,-1.1,1.7,6.1,9.4,10.0,10.0,10.0,9.4,7.8,6.7,5.6,4.4,3.9,2.8,-1.1,0.6,-2.2,-0.6,-2.2,-1.7,-2.2,-2.2,-2.2,-3.3,0.6,3.3,6.7,7.8,8.9,8.9,8.9,8.9,7.2,5.0,3.9,4.4,3.9,3.9,3.9,3.9
};
final int windowWidth = 6080;
final int windowHeight = 360*2;
float min,max;
int oneDayPixel = (int)Math.ceil((windowWidth)/temperatures.length);
int pixelPerDegree, graphHeight;

int getPosition(float temp){
  return (int)((max-temp)*pixelPerDegree);
}

void calc(){
  graphHeight = (int)(windowHeight/2.5);
  min = Collections.min(Arrays.asList(temperatures));
  max = Collections.max(Arrays.asList(temperatures));
  pixelPerDegree = (int)Math.ceil(graphHeight/(max-min));
}

void tempGraph(){
  int x = 5;
  for(int i=0;i<temperatures.length-1;i++,x+=oneDayPixel){
    int x1 = x;
    int y1 = 10 + getPosition(temperatures[i]);
    int x2 = x+oneDayPixel;
    int y2 = 10 + getPosition(temperatures[i+1]);
    stroke(map(temperatures[i],min,max,0,255),0,255-map(temperatures[i+1],min,max,0,255));
    line(x1, y1, x2, y2);
  }
  
}

void setup() {
  size(6080,720);
  frameRate(24);
  //background(255,255,255);
  background(0,0,0);
  strokeWeight(3);
  calc();
  
  smooth();
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

int currentTime = 0;

void draw() {
  currentTime+=15;
  if(currentTime>windowWidth){
    currentTime = 15;
  }
  background(0);
  drops[totalDrop]=new Drop();
  
  snowFlakes[totalSnow] = new SnowFlake();
  
  totalDrop++;
  if(totalDrop>=drops.length){
    totalDrop--;
  }
  totalSnow++;
  if(totalSnow>=snowFlakes.length){
    totalSnow--;
  }
  
  for(int i=0;i<totalDrop;i++){
    drops[i].move();
    drops[i].display();
  }
  
  for(int i=0;i<totalSnow;i++){
    snowFlakes[i].draw();
  }
  
  
  tempGraph();
  // background
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < 10+ graphHeight; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y*width;
      // Get the R,G,B values from image
      float r,g,b;
      r = red(get(x,y));
      g = green(get(x,y));
      b = blue(get(x,y));
      // Calculate an amount to change brightness based on proximity to the mouse
      float maxdist = windowWidth/8;//dist(0,0,width,height);
      //float d = dist(x, y, currentTime, 10+graphHeight/2);
      float d = Math.abs(currentTime - x);
      float adjustbrightness = 0.8*255*(maxdist-d)/maxdist; //255*(maxdist-d)/maxdist;
      r += adjustbrightness;
      g += adjustbrightness;
      b += adjustbrightness;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      set(x,y,c);
    }
  }
  videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
