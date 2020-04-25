class SnowFlake{
  float x = random(width);
  float y = random(height);
  float r = random(2,5);

  void draw(){
   fill(250,235,215);
   noStroke();
   ellipse(x, y, r, r+2);

   y+=10;
   //x += random(-3,3);
   x += random(-4,1);

   if(y > height || x<0){
     y = 0;
     x = random(width);
   }
   
  }
}

//int NUM_DROPS=500;
