class Ellipsoid { 
  public float x;
  public float y;
  public float z;
  public float rx;
  public float ry;
  public float rz;
  PVector ellipsoidCenter;
  public float Cdr, Cdg, Cdb, Car, Cag, Cab, Csr, Csg, Csb, P, K;
  SurfaceMaterial surface;
  
  Ellipsoid(){}
  
  Ellipsoid(float x, float y, float z, float rx, float ry, float rz){
    this.x = x;
    this.y = y;
    this.z = z;
    this.rx = rx; 
    this.ry = ry;
    this.rz = rz;
    this.ellipsoidCenter = new PVector(x,y,z);
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
}
