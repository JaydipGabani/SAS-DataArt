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

int NUM_DROPS=500;
