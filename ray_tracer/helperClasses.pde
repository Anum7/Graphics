class Scene {
  PVector background;
  PVector eye;
  PVector camU;
  PVector camV;
  PVector camW;
 
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


//check this
class Hit{
  float xt;
  float yt;
  float zt;
  float t;
  
  Disk disk;
  Ellipsoid ellipsoid;
  SurfaceMaterial hitSurface;
  
  PVector normalVector;
  PVector hitPositionVector;
  
  boolean boolHit;
  Ray eyeRay;
  float depth;
  
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
  
  Hit(float t, PVector hit, PVector normalVector, Disk disk) {
    this.xt = hit.x;
    this.yt = hit.y;
    this.zt = hit.z;
    this.t = t;
    this.normalVector = normalVector;
    this.disk = disk;
    this.hitSurface = disk.surface;
    this.hitPositionVector = hit;
  }
  
  Hit(float t, PVector hit, PVector normalVector, Ellipsoid ellipsoid) {
    this.xt = hit.x;
    this.yt = hit.y;
    this.zt = hit.z;
    this.t = t;
    this.normalVector = normalVector;
    this.ellipsoid = ellipsoid;
    this.hitSurface = ellipsoid.surface;
    this.hitPositionVector = hit;
    
  }
  
  public void foundHit(boolean h) {
    this.boolHit = h;
  }
  
  public void setDepth(float depth) {
    this.depth = depth;
  }
  
  public void setEye(Ray eyeRay) {
    this.eyeRay = eyeRay;
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
  
  Ray(PVector origin,  PVector direction) {
    this.origin = origin;
    this.direction = direction;
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

class SurfaceMaterial {
  public float Cdr, Cdg, Cdb, Car, Cag, Cab, Csr, Csg, Csb, P, K;
  
  SurfaceMaterial(){}
  
  SurfaceMaterial(float Cdr, float Cdg, float Cdb, float Car, float Cag, float Cab, float Csr, float Csg, float Csb, float P, float K){
    this.Cdr = Cdr;
    this.Cdg = Cdg;
    this.Cdb = Cdb;
    this.Car = Car;
    this.Cag = Cag;
    this.Cab = Cab;
    this.Csr = Csr;
    this.Csg = Csg;
    this.Csb = Csb;
    this.P = P;
    this.K = K;    
  }
  
  PVector getDiffuse(){
    return new PVector(Cdr, Cdg, Cdb);
  }
  PVector getAmbient(){
    return new PVector(Car, Cag, Cab);
  }
  PVector getSpecular(){
    return new PVector(Csr, Csg, Csb);
  }
}

class Color{
  public PVector diffuse;
  public PVector ambient;
  public PVector specular;
  public PVector reflection;
  public PVector finalColor;
  
  float depth; 
  
  Color(PVector finalColor) {
    this.finalColor = finalColor;
  }
}
