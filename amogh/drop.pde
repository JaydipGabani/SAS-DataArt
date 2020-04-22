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
