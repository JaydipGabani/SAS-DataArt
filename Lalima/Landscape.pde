class Landscape {

  Horizon[] points = new Horizon[100];

  int left, right;

  int timer = 0;

  float yy;

  float shade;

  float res;


  Landscape(int b, float s, float r) {

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
    
    for (int i = 0; i < points.length; i++) {  
      
      vertex(points[i].x, points[i].y);
      System.out.println(points[i].x +","+ points[i].y);

      if (points[i].y<100)
      {
        angle += 20;
        float val = cos(radians(angle)) * 10.0;
        for (int a = 0; a < 360; a += 75) 
        {
          float xoff = cos(radians(a)) * val;
          float yoff = sin(radians(a)) * val;
          fill(random(0,255), random(0,255), random(0,255));
          ellipse(points[i].x + xoff, points[i].y +yoff, val, val);
        }
        fill(255);
        ellipse(points[i].x, points[i].y, 2, 2);
      }
      fill(75-shade, 165-shade, 70-shade);
      //noFill();
      if (points[i].x >= width-(width/points.length)-1) {
        vertex(width, height*2); 
        vertex(0, height*2);
      }
    }
    vertex(points[0].x, points[0].y);
    endShape();
    popMatrix();
  }
}
