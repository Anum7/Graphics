class Disk {
  public float x,y,z,nx,ny,nz,diskRadius;
  public float Cdr, Cdg, Cdb;
  PVector normalVector; 
  PVector center;
  
  Disk() {}
  
  Disk(float x, float y, float z, float nx, float ny, float nz, float diskRadius) {
    this.x = x;
    this.y = y;
    this.z= z;
    this.nx = nx; 
    this.ny = ny;
    this.nz= nz; 
    this.diskRadius = diskRadius;
    
    //CHECK NORMAL
    normalVector = new PVector(nx,ny,nz);
    normalVector = normalVector.normalize();
    
    this.center = new PVector(x,y,z);
  }
  
  //MAY HAVE TO ADD OTHER PARAMS
  public void surface(float Cdr, float Cdg, float Cdb){
    this.Cdr = Cdr;
    this.Cdg = Cdg;
    this.Cdb = Cdb;
  }
  
  public void diffuse(float Cdr, float Cdg, float Cdb) {
    this.Cdr = Cdr;
    this.Cdg = Cdg;
    this.Cdb = Cdb;
  }
  
}
