
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import com.hamoid.*;

VideoExport videoExport;
float[] d = new float[1097];

int limit;
Table table;


void setup(){
    size(1080, 128);
    textSize(24);
    videoExport = new VideoExport(this, "test2.mp4");
    table = loadTable("2119329.csv", "header");
  videoExport.setFrameRate(60);

  videoExport.startMovie();
   int i = 0;
   frameRate(100);
  for (TableRow row : table.rows()) {

    float id = Float.parseFloat(row.getString("TEMP"));

    d[i] = id;
    i++;
    
  }
    
}
void draw(){
  frameRate(60);
    //background(0);
    stroke(128);
    strokeWeight(1);
    limit+=1          ;        
    if (limit > width) {limit = 0  ;

    }
    
    strokeWeight(1);
       
    for (int i = 1; i< limit;i++){
        int x = i;
        float y = d[i];
        if( y > 60.0) stroke(0, 0, 250);
        else stroke(250, 0, 0);
        line(i, y, i-1, d[i-1]);
    }    
    videoExport.saveFrame();

}
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
