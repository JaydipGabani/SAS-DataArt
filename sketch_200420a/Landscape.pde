class Landscape {

  Horizon[] points = new Horizon[100];
  int left, right;
  int timer = 0;
  float yy;
  float shade;
  float res;  
  int layer;

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
      System.out.println(points[i].x);

      if ((int)i%8==0)
      {
        pushMatrix();
        //beginShape();
        //fill(204, 101, 192, 127);
        noStroke();
        //angle += 5;
        float val = 10.0;
        for (int a = 0; a < 360; a += 75) 
        {
          float xoff = cos(radians(a)) * val;
          float yoff = sin(radians(a)) * val;
          if (layer==1)
            fill(204, 101, 192);
          else if (layer==2)
            fill(0, 50, 255);
          else if (layer==3)
            fill(255, 50, 0);
          ellipse(points[i].x + xoff, points[i].y + yoff - 10, val, val);
        }
        fill(255);
        ellipse(points[i].x, points[i].y - 10, 6, 6);

        ////translate(580, 70);
        //for (int f= 0; f < 10; f ++) {
        //  //rotate(PI/5);
        //  ellipse(points[i].x, points[i].y, 10, 40);
        //  //rotate(PI/5);
        //}
        ////endShape();
        popMatrix();
      }
    }
    fill(75-shade, 165-shade, 70-shade);
    vertex(points[0].x, points[0].y);

    endShape();
    popMatrix();
  }
}
