import com.hamoid.*;
VideoExport videoExport;

import java.util.Random;
import java.lang.*;
import java.util.Collections;
import java.util.Arrays;

Landscape[] layers = new Landscape[4];
int angle=0;
int temp=0;
int x=0, y=0, z=0;
PGraphics myGraphics;

PFont dayFont;

//int oneDayPixel, pixelPerDegree, graphHeight;
//float min,max;
//final Float[] temperatures = {9.4,11.1,11.7,11.7,12.8,12.8,12.8,12.8,11.1,10.0,8.9,8.3,8.3,8.9,8.9,8.3,7.8,6.7,5.6,5.6,4.4,10.0,10.0,9.4};

void settings()
{
  size(1700, 200);

}

void setup() {
  //size of sketch, initial bgcolor
  dayFont=createFont("Arial Bold", 18);
  frameRate(10);
  //background(125, 190, 210);
  myGraphics = createGraphics(width, height);

  //sprout = loadImage("sproutsss.png");
  //sproutBrown = loadImage("sprouts_copy.png");
  //sprout.resize(60,60);
  //sproutBrown.resize(60,60);

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
  //calc();
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}
int current_layer = 0;
void draw() {



  myGraphics.beginDraw();
  float rg = map(abs((millis()%10000)-5000), 0, 5000, 0, 255);

  if (rg>150)
    background(255, rg, 255-rg, 70);
  else if (rg<150)
    background(rg, rg, 255, 70);



  pushMatrix();
  translate(width/2, height/2);
  rotate(-PI);
  rotate(map(millis()%10000, 0, 10000, 0, TWO_PI));
  // The Sun
  //fill(255, 255-rg, 255-rg);
  noStroke();
  fill(255, 180, 0);
  ellipse(0, 200, 50, 50);
  // The Moon
  fill(255);
  ellipse(0, -200, 50, 50);
  popMatrix();

  //delay(100);

  delay(150);

  for (int i = 0; i < layers.length; i++) {

    float j = map(i, 0, layers.length, .5, 10);

    if ( current_layer < 150)
    { 
      layers[1].current = true;
      layers[2].current = false;
      layers[3].current = false;
    } else if (current_layer < 300)

    if( current_layer < 150)
     { 
       layers[1].current = true;
       
       layers[2].current = false;
       layers[3].current = false;
     }
    else if (current_layer < 300)

    {
      renderSnow();
      layers[2].current = true;
      layers[1].current = false;
      layers[3].current = false;
    } else 
    {
      renderDrops();
      layers[3].current = true;
      layers[2].current = false;
      layers[1].current = false;
    }
    current_layer ++;
    if (current_layer == 450)
      current_layer = 0;
    layers[i].update(j*0.5);

    if (i != 0) {
      layers[i].display();




      //renderDrops();
      //renderSnow();
      //image(sproutBrown,500-currentTime/250,100);
    }
    //if(i==3) renderDrops();

    //if(i==0) renderSnow();

    //if(i==0) renderSnow();
    //renderTemperature();
  }

  strokeWeight(5);
  for (int i = 0; i < height; i+=5) {
    float j = map(i, 0, height, 0, 100);
    stroke(255, j);
    line(0, i, width, i);
  }

  fill(255);
  textFont(dayFont);
  text("X-Day", width*0.005, height*0.1);
  textSize(18);
  for (int i=1; i<=3; i++) {
    switch(i) {
    case 1: 
      text("New York", width*0.75, height/2); 
      break;
    case 2: 
      text("Cary", width*0.75, height/1.35); 
      break;
    case 3: 
      text("Tallahassee", width*0.75, height/1.05); 
      break;
    }
  }
  stroke(255);
  line(5, height-10, 5, height/5);
  fill(255);
  textSize(16);
  fill(0, 0, 255);
  text("30 F", 10, height-10);
  fill(255, 0, 0);
  text("101 F", 10, height/4.5);
  
  textSize(18);
    fill(255);
  for(int i=1;i<=3;i++){
  switch(i){
      case 1: text("New York",width*0.72,height/2); break;
      case 2: text("Cary",width*0.72,height/1.35); break;
      case 3: text("Tallahassee",width*0.72,height/1.05); break;
    }
  }
  stroke(255);
  line(5,height-10,5,height/5);
  fill(255);
  textSize(16);
  fill(0,0,255);
  text("30 F", 10, height-10);
  fill(255,0,0);
  text("101 F", 10, height/4.5);

  myGraphics.endDraw();
  image(myGraphics, 0, 0);

  //saveFrame("output2/img_####.png");
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
void renderDrops() {
  if (totalDrop<DROP_COUNT) {
    drops[totalDrop++]=new Drop();
  } else if (totalDrop>DROP_COUNT/2) {
    totalDrop += random(-1, 1);
  }

  for (int i=0; i<totalDrop; i++) {
    drops[i].move();
    drops[i].display();
  }
}
void renderSnow() {

  if (totalSnow<SNOW_COUNT) {
    snowFlakes[totalSnow++] = new SnowFlake();
  } else if (totalSnow>SNOW_COUNT/2) {
    totalSnow += random(-1, 1);
  }
  for (int i=0; i<totalSnow; i++) {
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

void focusLighting() {

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      float r, g, b;
      //float d = dist(x, y, currentTime, 10+graphHeight/2);
      float d = Math.abs(currentTime - x);
      float adjustbrightness = 0.8*255*(width/8-d)/(width/8); // was 255*(maxdist-d)/maxdist;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(red(get(x, y))+adjustbrightness, 0, 255);
      g = constrain(green(get(x, y))+adjustbrightness, 0, 255);
      b = constrain(blue(get(x, y))+adjustbrightness, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      set(x, y, c);
    }
  }
}
