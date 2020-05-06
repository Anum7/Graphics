class Scene {
  PVector background;
  PVector eye;
  PVector camU;
  PVector camV;
  PVector camW;
  //creating arrayList for camera
  //LOOK AT THIS
  //in the end try to make cameraArray global and remove getCamera
  ArrayList<PVector> cameraArray;
  
  Scene(){}
  
  public void setBg(float r, float g, float b) {
    this.background = new PVector(r,g,b);
  }
  public PVector setEye(float x, float y, float z) {
    this.eye = new PVector(x,y,z);
    return eye;
  }
  public ArrayList<PVector> getCamera() { return cameraArray; }
  public void setCamera(float ux, float uy, float uz, float vx, float vy, float vz, float wx, float wy, float wz) {
    cameraArray = new ArrayList<PVector>(0);
    this.camU = new PVector(ux,uy,uz);
    cameraArray.add(camU);
    this.camV = new PVector(vx,vy,vz);
    cameraArray.add(camV);
    this.camW = new PVector(wx,wy,wz);
    cameraArray.add(camW);
  }
  
}

class Light {
  float x;
  float y;
  float z; 
  float r;
  float g;
  float b;
  
  PVector origin;
  PVector ligthColor;
  
  //constructor
  Light(float x, float y, float z, float r, float g, float b) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
    this.g = g;
    this.b = b;
    this.origin = new PVector(x,y,z);
    this.ligthColor = new PVector(r,g,b);
  }
}

class Hit{
  float xt;
  float yt;
  float zt;
  float t;
  
  Disk disk; 
  
  //I am not sure if normalVector is needed or not.
  PVector normalVector;
  PVector hitPositionVector;
  
  Hit(){}
  
  Hit(float t, float xt, float yt, float zt, Disk disk, PVector normalVector){
  this.xt = xt;
  this.yt = yt;
  this.zt = zt;
  this.t = t;
  this.disk = disk;
  
  //check
  this.normalVector = normalVector;
  
  hitPositionVector = new PVector(xt, yt, zt);
  }
}


class Ray {
  float dx, dy, dz;
  float xt, yt, zt;
  //float nx, ny, nz;
  
  PVector origin;  //eye 
  PVector direction; //direction from eye to disk
  
  //if I made it global then I don't have to define it here
  ArrayList<PVector> cameraArray;
  
  Ray(PVector origin,  ArrayList<PVector> cameraArray) {
    this.origin = origin;
    this.cameraArray = cameraArray;
  }

  //check this calculation
  public PVector RayCalculation(float d, float u, float v) {
    PVector uVector = cameraArray.get(0);
    PVector vVector = cameraArray.get(1);
    PVector wVector = cameraArray.get(2);
    
    dx = ((-d * wVector.x) + (u * uVector.x) - (v * vVector.x));
    dy = ((-d * wVector.y) + (u * uVector.y) - (v * vVector.y));
    dz = ((-d * wVector.z) + (u * uVector.z) - (v * vVector.z));
    
    this.direction = new PVector(dx, dy, dz);
    return direction;
  }
  
}
