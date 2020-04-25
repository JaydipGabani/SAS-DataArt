import com.hamoid.*;
//VideoExport videoExport;

import java.util.Random;
import java.lang.*;
Landscape[] layers = new Landscape[4];
int angle=0;
int temp=0;
int x=0,y=0,z=0;
PGraphics myGraphics;


void settings()
{
  size(1700, 200);
  
}

void setup() {
  //size of sketch, initial bgcolor
frameRate(23);
  //background(125, 190, 210);
  myGraphics = createGraphics(width, height);
  
  sprout = loadImage("sproutsss.png");
  sproutBrown = loadImage("sprouts_copy.png");
  sprout.resize(60,60);
  sproutBrown.resize(60,60);

  for (int i = 0; i < layers.length; i++) {

    int j = int(map(i, 0, layers.length, height/2.5, height));
    int k = int(map(i, 0, layers.length, 0, 100));
    int l = int(map(i, 0, layers.length, .5, 25));

    layers[i] = new Landscape(i, j, k, l);
  }
  //  layer00 = new Landscape(int(height/2.5), 60);
  //  layer01 = new Landscape(int(height/2), 30);
  //  layer02 = new Landscape(int(height-(height/4)), 0);

  for (int i = 0; i < 9999; i++) {
    for (int i2 = 0; i2 < layers.length; i2++) {

      float j = map(i2, 0, layers.length, .1, 10);

      layers[i2].update(j*0.5);
    }
  }
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  
}
int current_layer = 0;
void draw() {
  
  
  
  myGraphics.beginDraw();
  
  myGraphics.background(255-x, 250-y, 0+z, 70);
  //background(255-x, 250-y, 0+z);
  //x+=10;
  myGraphics.background(255-x, 250-y, 0+z, 60);
  
  if(250-y>0)//yellow to red
  {
    System.out.println("Yellow to red:" + x+","+y+","+z);
    y+=5;
  }
  else if (255-x<=200 && z>=250 && 250-y<=0) //blue to red
  {
    System.out.println("hello" + temp++);
    System.out.println(x+","+y+","+z);
    
    x-=50;
    y=250;
    z-=50;
  }
  else if(250-y<=0 && 255-x>0 && z<255)//red to blue
  {
    System.out.println("Red to blue:" + x+","+y+","+z);
    x+=20;
    y=250;
    z+=20;  
  }
  //else if (255-x<=0 && z>=250 && 250-y<=0) //red to blue
  //{
  //  System.out.println("hello");
   
  //  x=-20;
  //  y=250;
  //  z=-20;
  //}
  //else if(255-x<=0 && 250-y)//blue to yellow again
  
  delay(150);
  
  for (int i = 0; i < layers.length; i++) {

    float j = map(i, 0, layers.length, .5, 10);
    if( current_layer < 150)
     { 
       layers[1].current = true;
       layers[2].current = false;
       layers[3].current = false;
     }
    else if (current_layer < 300)
    {
      
      layers[2].current = true;
       layers[1].current = false;
       layers[3].current = false;
    }
    else 
    {
      
      layers[3].current = true;
       layers[2].current = false;
       layers[1].current = false;
    }
    current_layer ++;
    if(current_layer == 450)
      current_layer = 0;
    layers[i].update(j*0.5);
    
    if (i != 0) {
      layers[i].display();
      //renderDrops();
      //renderSnow();
      image(sproutBrown,500-currentTime/250,100);
    }
    if(i==3) renderDrops();
    if(i==0) renderSnow();
  }

  strokeWeight(5);
  for (int i = 0; i < height; i+=5) {
    float j = map(i, 0, height, 0, 100);
    stroke(255, j);
    line(0, i, width, i);
  }
  
  myGraphics.endDraw();
  image(myGraphics, 0, 0);
  
  
  currentTime+=100;
}


// AMG CODE HERE
int currentTime = 0;
int totalDrop = 0;
int totalSnow = 0;
PImage sprout, sproutBrown;
int DROP_COUNT=40;
final int SNOW_COUNT = 80;
Drop[] drops=new Drop[DROP_COUNT];
SnowFlake[] snowFlakes = new SnowFlake[SNOW_COUNT];
void renderDrops(){
  if(totalDrop<DROP_COUNT){
    drops[totalDrop++]=new Drop();
  }else if(totalDrop>DROP_COUNT/2){
    totalDrop += random(-1,1);
  }
  
  for(int i=0;i<totalDrop;i++){
    drops[i].move();
    drops[i].display();
  }
}
void renderSnow(){
  
  if(totalSnow<SNOW_COUNT){
    snowFlakes[totalSnow++] = new SnowFlake();
  }else if(totalSnow>SNOW_COUNT/2){
    totalSnow += random(-1,1);
  }
  for(int i=0;i<totalSnow;i++){
    snowFlakes[i].draw();
  }
}
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
// AMG  CODE ENDS HERE

void focusLighting(){
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      float r,g,b;
      //float d = dist(x, y, currentTime, 10+graphHeight/2);
      float d = Math.abs(currentTime - x);
      float adjustbrightness = 0.8*255*(width/8-d)/(width/8); // was 255*(maxdist-d)/maxdist;
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
