class Disk {
  public float x,y,z,nx,ny,nz,diskRadius;
  public float Cdr, Cdg, Cdb, Car, Cag, Cab, Csr, Csg, Csb, P, K;
  PVector normalVector; 
  PVector center;
  SurfaceMaterial surface;
  Disk() {}
  
  Disk(float x, float y, float z, float nx, float ny, float nz, float diskRadius) {
    this.x = x;
    this.y = y;
    this.z= z;
    this.nx = nx; 
    this.ny = ny;
    this.nz= nz; 
    this.diskRadius = diskRadius;
    
    normalVector = new PVector(nx,ny,nz);
    normalVector = normalVector.normalize();
    
    this.center = new PVector(x,y,z);
  }
  
  public void surface(float Cdr, float Cdg, float Cdb, float Car, float Cag, float Cab, float Csr, float Csg, float Csb, float P, float K){
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
    surface = new SurfaceMaterial(Cdr, Cdg, Cdb, Car, Cag, Cab, Csr, Csg, Csb, P, K);
  }
  
  public void diffuse(float Cdr, float Cdg, float Cdb) {
    this.Cdr = Cdr;
    this.Cdg = Cdg;
    this.Cdb = Cdb;
  }
  
}
