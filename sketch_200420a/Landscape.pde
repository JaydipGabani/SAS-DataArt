class Landscape {

  Horizon[] points = new Horizon[100];
  int left, right;
  int timer = 0;
  float yy;
  float shade;
  float res;  
  int layer;
  public boolean current = false;
  Landscape(int layer, int b, float s, float r) {

    this.layer = layer;
    res = r;
    shade = s;

    for (int i = 0; i < points.length; i++) {
      float j = map(i, 0, points.length, 0, width);
      points[i] = new Horizon(j, b, i);
    }
  }

  void update(float speedx) {

    timer-=3;
    if (timer < 0) {
      yy = random(-75, 75);
      timer = int(random(25, 200));
    } 

    for (int i = 0; i < points.length; i++) {
      points[i].update(yy, speedx*0.15, res); 

      // points[i].display();
    }
  }

  void display() {

    pushMatrix();
    scale(1.5, 1);
    translate((-width/points.length)*2, 0);
    noStroke();

    fill(75-shade, 165-shade, 70-shade);

    beginShape();

    for (int i = 0; i < points.length; i++) 
    { 
      vertex(points[i].x, points[i].y); 

      if (points[i].x >= width-(width/points.length)-1) {
        vertex(width, height*2); 
        vertex(0, height*2);
      }
      //System.out.println(points[i].x);

      if ((int)i%3==0)
      {
        pushMatrix();
        //beginShape();
        //fill(204, 101, 192, 127);
        noStroke();
        angle += 5;
        float val = 10.0;
        for (int a = 0; a < 360; a += 75) 
        {
          float xoff = cos(radians(a)) * val;
          float yoff = sin(radians(a)) * val;
          //System.out.println(points[i].y +"  "+layer);
          
          if (layer==1) //no precipitation
          {
            if (points[i].y<=100)//outdoor and warm
              fill(138,255,0);
            else if (points[i].y>100 && points[i].y<=110)//pleasant and indoor
              fill(255,0,48);
            else
              fill(200, 80, 205);//cold and indoor
          } else if (layer==2) //snowy layer
          {
            if (points[i].y<=110)//warm
              fill(138,255,0);
            else if (points[i].y>110 && points[i].y<=130)//pleasant
              fill(255,0,48);
            else
              fill(204, 101, 192);//cold
          } else if (layer==3) //rainy layer
          {
            if (points[i].y<=140)//warm temp
              fill(138,255,0);
            else if (points[i].y>140 && points[i].y<=180)//pleasant
              fill(255,0,48);
            else
              fill(204, 101, 192);//cold
          }
          if (current)
          {
            stroke(0);
            strokeWeight(0.2);
            ellipse(points[i].x + xoff, points[i].y + yoff - 10, val, val);
            fill(255);
            ellipse(points[i].x, points[i].y - 10, 6, 6);
          }
        }

        popMatrix();
      }
    }
    noStroke();
    fill(75-shade, 165-shade, 70-shade);
    vertex(points[0].x, points[0].y);

    endShape();
    popMatrix();
  }
}
