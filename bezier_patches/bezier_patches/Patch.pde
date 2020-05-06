class Patch {
  int col = 4;
  int row = 4;
  PVector[][] patchArrayList;
  color c; 
  
  Patch() {
    this.patchArrayList = new PVector[this.col][this.row];
    this.c = color(random(0,255), random(0,255),random(0,255));
  }
  
  public void drawPatch() {
    pushMatrix();
    noFill();
    stroke(256, 256, 256);
    beginShape();
    vertex((patchArrayList[0][0].x), (patchArrayList[0][0].y), (patchArrayList[0][0].z));
    vertex((patchArrayList[3][0].x), (patchArrayList[3][0].y), (patchArrayList[3][0].z));
    vertex((patchArrayList[3][3].x), (patchArrayList[3][3].y), (patchArrayList[3][3].z));
    vertex((patchArrayList[0][3].x), (patchArrayList[0][3].y), (patchArrayList[0][3].z));
    endShape(CLOSE);
    popMatrix();
    
  }
  
  public void drawQuad(){
    for(int s = 0; s < 3; s++){
      for(int t = 0; t < 3; t++){                  
          pushMatrix();
          noFill();
          stroke(256, 256, 256);
          beginShape();
          vertex((patchArrayList[s][t].x), (patchArrayList[s][t].y), (patchArrayList[s][t].z));
          vertex((patchArrayList[s+1][t].x), (patchArrayList[s+1][t].y), (patchArrayList[s+1][t].z));
          vertex((patchArrayList[s+1][t+1].x), (patchArrayList[s+1][t+1].y), (patchArrayList[s+1][t+1].z));
          vertex((patchArrayList[s][t+1].x), (patchArrayList[s][t+1].y), (patchArrayList[s][t+1].z));
          endShape(CLOSE);
          popMatrix();
      }
    }
  }
   //<>//
  public void drawPolygon(){
    int s1 = 10;
    int t1 = 10;
    PVector[][] patchPolygonList = new PVector[s1][t1];
    
    for(int s = 0; s < s1; s++){
      PVector p1 = calculateBP(patchArrayList[0][0], patchArrayList[0][1], patchArrayList[0][2], patchArrayList[0][3], s/9.0);
      PVector p2 = calculateBP(patchArrayList[1][0], patchArrayList[1][1], patchArrayList[1][2], patchArrayList[1][3], s/9.0);
      PVector p3 = calculateBP(patchArrayList[2][0], patchArrayList[2][1], patchArrayList[2][2], patchArrayList[2][3], s/9.0);
      PVector p4 = calculateBP(patchArrayList[3][0], patchArrayList[3][1], patchArrayList[3][2], patchArrayList[3][3], s/9.0);      
      
      for(int t = 0; t < t1; t++){ 
          patchPolygonList[s][t] =(calculateBP(p1, p2, p3, p4, t/9.0)); //<>//
      }
    }
        
    for (int i = 0; i < 9 ; i++){
      for(int j = 0; j < 9; j++){          
          pushMatrix();          
          beginShape();        
          vertex((patchPolygonList[i][j].x), (patchPolygonList[i][j].y), (patchPolygonList[i][j].z));
          vertex((patchPolygonList[i+1][j].x), (patchPolygonList[i+1][j].y), (patchPolygonList[i+1][j].z));
          vertex((patchPolygonList[i+1][j+1].x), (patchPolygonList[i+1][j+1].y), (patchPolygonList[i+1][j+1].z));
          vertex((patchPolygonList[i][j+1].x), (patchPolygonList[i][j+1].y), (patchPolygonList[i][j+1].z));
          endShape(CLOSE);
          popMatrix();
      }
    }

  }
  
  public PVector calculateBP(PVector p0, PVector p1, PVector p2, PVector p3, float t) {
     float b1 = (1-t) * (1-t) * (1-t);
     float b2 = 3* t * (1-t) * (1-t);
     float b3 = 3 * t * t * (1-t);
     float b4 = t * t * t;
     PVector bAdd1 = PVector.add(PVector.mult(p0, b1),PVector.mult(p1, b2));
     PVector bAdd2 = PVector.add(PVector.mult(p2, b3),PVector.mult(p3, b4));
     PVector sum = PVector.add(bAdd1, bAdd2);
     
     return sum;
  }
  
}
