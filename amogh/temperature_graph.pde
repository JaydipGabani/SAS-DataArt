import com.hamoid.*;
VideoExport videoExport;

import java.util.Arrays; 
import java.util.Collections;

final int WINDOW_WIDTH = 6080;
final int WINDOW_HEIGHT = 360*2;
final int DROP_COUNT = 2000;
final int SNOW_COUNT = 500;
final int MODE = 1;

float maxdist = WINDOW_WIDTH/8;

final Float[] temperatures = {9.4,11.1,11.7,11.7,12.8,12.8,12.8,12.8,11.1,10.0,8.9,8.3,8.3,8.9,8.9,8.3,7.8,6.7,5.6,5.6,4.4,2.8,2.8,2.2,4.4,7.2,8.3,8.9,8.9,10.0,10.0,9.4,8.3,7.2,6.7,6.1,5.0,4.4,4.4,3.3,3.3,3.3,2.8,2.2,1.7,1.1,1.1,0.6,1.7,3.3,4.4,6.1,6.7,7.8,7.2,7.2,6.1,5.0,4.4,2.8,2.8,1.7,1.1,0.6,0.6,0.0,-0.6,-1.7,-1.1,-1.7,-2.2,-1.1,0.6,2.8,4.4,6.1,7.2,7.8,8.3,7.8,6.7,5.0,3.3,2.8,2.2,1.7,1.7,1.1,0.0,-1.7,-2.2,-2.2,-2.8,-2.8,-3.9,-3.3,-0.6,2.2,4.4,6.1,7.2,8.9,8.9,8.9,7.2,4.4,1.7,1.1,0.6,0.0,-1.7,-1.7,-1.7,-2.2,-2.8,-2.8,-2.2,-5.0,-4.4,-2.8,-1.1,1.7,6.1,9.4,10.0,10.0,10.0,9.4,7.8,6.7,5.6,4.4,3.9,2.8,-1.1,0.6,-2.2,-0.6,-2.2,-1.7,-2.2,-2.2,-2.2,-3.3,0.6,3.3,6.7,7.8,8.9,8.9,8.9,8.9,7.2,5.0,3.9,4.4,3.9,3.9,3.9,3.9
};

int totalDrop = 0;
int totalSnow = 0;
int currentTime = 0;
int oneDayPixel, pixelPerDegree, graphHeight;
float min,max;
PGraphics pg2,pg3;

void setup() {
  size(6080,720,P3D);
  pg2 = createGraphics(WINDOW_WIDTH, WINDOW_HEIGHT,P2D);
  pg3 = createGraphics(WINDOW_WIDTH, WINDOW_HEIGHT,P3D);
  frameRate(24);
  background(0,0,0);
  strokeWeight(3);
  calc();
  
  smooth();
  videoExport = new VideoExport(this);
  if(MODE==1){
    videoExport.startMovie();
  }
}

void keyPressed() {
  if (MODE==1 && key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

Drop[] drops=new Drop[DROP_COUNT];
SnowFlake[] snowFlakes = new SnowFlake[SNOW_COUNT];

void draw() {
  currentTime+=15;
  if(currentTime>WINDOW_WIDTH-500){
    currentTime = 15;
  }
  background(0);
  
  
  
  image(pg3, 0, 0);
  //rotateX(0);
  
  loadPixels();
  pg2.beginDraw();
  renderDrops();
  renderSnow();
  renderTemperature();
  renderFlower();
  pg2.endDraw();
  image(pg2,0,0);
  updatePixels();
  
  loadPixels();
  pg2.beginDraw();
  focusLighting();
  pg2.endDraw();
  image(pg2,0,0);
  updatePixels();
  
  loadPixels();
  pg3.beginDraw();
  setupTerrain();
  pg3.endDraw();
  updatePixels();
  
  
  if(MODE==1){
    videoExport.saveFrame();
  }
}
