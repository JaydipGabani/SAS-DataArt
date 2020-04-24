Landscape[] layers = new Landscape[4];
int angle=0;
int x=0,y=0,z=0;
PGraphics myGraphics;

void settings()
{
  size(1700, 200);
}

void setup() {
  //size of sketch, initial bgcolor
  //background(125, 190, 210);
  myGraphics = createGraphics(width, height);
  
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
}

void draw() {

  //background(150, 200, 215); 
  //tint(255, 127);
  myGraphics.beginDraw();
  myGraphics.background(255-x, 250-y, 0+z, 60);
  //background(255-x, 250-y, 0+z);
  //x+=10;
  
  if(250-y>0)
  {
    y+=5;
  }
  else if(250-y<=0)
  {
    x+=50;
    y=250;
    z+=10;
  }
  else if (255-x<=0 && 250-y<=0 && z==255)
  {
    x+=50;
    y=250;
    z-=10;
  }
  //else if( )
  delay(150);
  
  for (int i = 0; i < layers.length; i++) {

    float j = map(i, 0, layers.length, .5, 10);

    layers[i].update(j*0.5);
    if (i != 0) {
      layers[i].display();

    }
  }

  //  layer00.update(.33);
  //  layer00.display();

  //  layer01.update(1);
  //  layer01.display();

  //  layer02.update(3);
  //  layer02.display();

  strokeWeight(5);
  for (int i = 0; i < height; i+=5) {
    float j = map(i, 0, height, 0, 100);
    stroke(255, j);
    line(0, i, width, i);
  }
  
  myGraphics.endDraw();
  image(myGraphics, 0, 0);

}
