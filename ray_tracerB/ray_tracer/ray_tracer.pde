//Anum Bhamani

// The most important part of this code is the interpreter, which will help
// you parse the scene description (.cli) files.
import java.lang.Math;
import java.util.ArrayList;

boolean debug_flag;  // help to print information for just one pixel

//instantiating scene class;
Scene scene;

Disk hitDisk; 

//diffuse color variables
float newCdr;
float newCdg;
float newCdb;


//creating arrayList for light
ArrayList<Light> lightArray;

//creating arrayList for ellipsoid. I may need it in part B
//ArrayList<Ellipsoid> ellipsoidArray;

//creating arraylist for disk
ArrayList<Disk> diskArray;

//already instantiated in given code but just to make it global I am declaring it here
float fov;

 //book keeping of light hitting variables
 boolean hit; 
 PVector hitOrigin;
 PVector hitNormal;
 PVector hitSurface;
 
void setup() {
  size(500, 500);  
  noStroke();
  colorMode(RGB);
  background(0, 0, 0);
}

void reset_scene() {
  //reset the global scene variables here
  scene = new Scene();
  lightArray = new ArrayList<Light>();
  diskArray = new ArrayList<Disk>();
  fov = 0;
  newCdr = 0;
  newCdg = 0;
  newCdb = 0;
}

void keyPressed() {
  reset_scene();
  switch(key) {
    case '1':  interpreter("01.cli"); break;
    case '2':  interpreter("02.cli"); break;
    case '3':  interpreter("03.cli"); break;
    case '4':  interpreter("04.cli"); break;
    case '5':  interpreter("05.cli"); break;
    case '6':  interpreter("06.cli"); break;
    case '7':  interpreter("07.cli"); break;
    case '8':  interpreter("08.cli"); break;
    case '9':  interpreter("09.cli"); break;
    case '0':  interpreter("10.cli"); break;
    case '-':  interpreter("11.cli"); break;
    case 'q':  exit(); break;
  }
}

// this routine helps parse the text in the scene description files
void interpreter(String filename) {
  
  println("Parsing '" + filename + "'");
  String str[] = loadStrings(filename);
  if (str == null) println("Error! Failed to read the cli file.");
  
  for (int i = 0; i < str.length; i++) {
    
    String[] token = splitTokens(str[i], " ");  // Get a line and parse the tokens
    
    if (token.length == 0) continue; // Skip blank lines
    
    if (token[0].equals("fov")) {
      fov = float(token[1]);
      // call routine to save the field of view
    }
    else if (token[0].equals("background")) {
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      // call routine to save the background color
      scene.setBg(r,g,b);
    }
    else if (token[0].equals("eye")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      // call routine to save the eye position
      scene.setEye(x, y, z);
    }
    else if (token[0].equals("uvw")) {
      float ux = float(token[1]);
      float uy = float(token[2]);
      float uz = float(token[3]);
      float vx = float(token[4]);
      float vy = float(token[5]);
      float vz = float(token[6]);
      float wx = float(token[7]);
      float wy = float(token[8]);
      float wz = float(token[9]);
      // call routine to save the camera's values for u,v,w
      scene.setCamera(ux, uy, uz, vx, vy, vz, wx, wy, wz);
    }
    else if (token[0].equals("light")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float r = float(token[4]);
      float g = float(token[5]);
      float b = float(token[6]);
      // call routine to save lighting information
      Light light = new Light(x,y,z,r,g,b);
      lightArray.add(light);
    }
    else if (token[0].equals("surface")) {
      float Cdr = float(token[1]);
      float Cdg = float(token[2]);
      float Cdb = float(token[3]);
      float Car = float(token[4]);
      float Cag = float(token[5]);
      float Cab = float(token[6]);
      float Csr = float(token[7]);
      float Csg = float(token[8]);
      float Csb = float(token[9]);
      float P = float(token[10]);
      float K = float(token[11]);
      // call routine to save the surface material properties
      //as per instrution for this part we are only using diffuse colors.
      newCdr = Cdr;
      newCdg = Cdg;
      newCdb = Cdb;
    }    
    else if (token[0].equals("ellipsoid")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float rx = float(token[4]);
      float ry = float(token[5]);
      float rz = float(token[6]);
      // call routine to save ellipsoid here
      //creating an object of ellipsoid so I can instantiate to diffuse color 
      //and add it to the list of ellipsoidlist
      //Ellipsoid ellipsoid = new Ellipsoid(x,y,z,rx,ry,rz);
      //ellipsoid.diffuse(newCdr, newCdg, newCdb);
      //ellipsoidArray.add(ellipsoid);
    }
    else if (token[0].equals("disk")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float nx = float(token[4]);
      float ny = float(token[5]);
      float nz = float(token[6]);
      float radius = float(token[7]);
      // call routine to save disk here
      Disk disk = new Disk(x,y,z,nx,ny,nz, radius);
      disk.diffuse(newCdr, newCdg, newCdb);
      diskArray.add(disk);
    }
    else if (token[0].equals("write")) {
      draw_scene();   // here is where you actually perform the ray tracing
      println("Saving image to '" + token[1] + "'");
      save(token[1]); // this saves your ray traced scene to a .png file
    }
    else if (token[0].equals("#")) {
      // comment symbol (ignore this line)
    }
    else {
      println ("cannot parse this line: " + str[i]);
    }
  }
}

// This is where you should place your code for creating the eye rays and tracing them.
void draw_scene() {
  float a, b, c,d;
  float diskX, diskY, diskZ;
  
  float u, v;
  float deye;
  float radius;
  float dist;
  
  PVector origin;      //eye vector 
  PVector originRay;
  PVector direction;  //FROM EYE to DISK
  PVector directionRay;
  PVector center;     //center vector of disk
  PVector normal;     //normal of disk
  
  Ray currentRay;    
  
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      boolean ifHit = false;
      float neart = Integer.MAX_VALUE;
      float t;
      // maybe turn on a debug flag for a particular pixel (so you can print ray information)
      if (x == 3000 && y == 3000)
        debug_flag = true;
      else
        debug_flag = false;
      
      // create and cast an eye ray here
      u = ((2.0 * x) / width) - 1.0;
      v = ((2.0 * y) / height) - 1.0;
      deye = (1 / tan(radians(fov) / 2.0));
      originRay = scene.eye;
      
     //PVector p = PVector.sub(center, originRay);
     
      ArrayList<PVector> cameraArray = scene.getCamera();
      currentRay = new Ray (originRay, cameraArray);
      
      directionRay = currentRay.RayCalculation(deye, u, v);

      for (Disk disk: diskArray) {
        direction = directionRay;
        origin = originRay;
        center = disk.center;
        radius = disk.diskRadius;
        normal = disk.normalVector;     
      
        //equations for a,b,c from notes
        a = normal.x; 
        b = normal.y;
        c = normal.z;
      
      
        //center of disk
        diskX = center.x;
        diskY = center.y;
        diskZ = center.z;
      
        d = (-(a*diskX)-(b*diskY)-(c*diskZ));
      
      //this is for reminder for me for next part/
      //origin.x = x0
      //direction.x = dx
            
      float numerator = -((a * origin.x) + (b * origin.y)+ (c * origin.z) + d);
      float denominator = ((a * direction.x) + (b * direction.y) + (c * direction.z)); 
       
      //dist = sqrt(((originRay.x- diskX)*(originRay.x- diskX))+((originRay.y- diskY)*(originRay.y- diskY))+((originRay.z- diskZ)*(originRay.z- diskZ)));
      
      if (denominator != 0) { 
        t = numerator / denominator;
        
        
        if (t >= 0 && t < neart) {
          PVector mul = PVector.mult(direction,t); 
          hitOrigin = PVector.add(origin, mul);
          dist = PVector.dist(hitOrigin, center);
          if (dist <= radius) {
            ifHit = true;
            hitDisk = disk;
            hitNormal = normal;
            neart = t;
          }          
        }
      }
     }
      //if ifHit then  do light calculations
      if(ifHit) {
          PVector colors = new PVector(0, 0, 0);
          PVector newLight;
          for (Light light : lightArray) {
              newLight = (PVector.sub(light.origin, hitOrigin)).normalize();
              
              float maxo = max(0, (PVector.dot(newLight, hitNormal)));
              colors.x += light.r * maxo;
              colors.y += light.g * maxo;
              colors.z += light.b * maxo;
          }
          colors.x = colors.x * hitDisk.Cdr;
          colors.y = colors.y * hitDisk.Cdg;
          colors.z = colors.z * hitDisk.Cdb;

          fill(colors.x *255, colors.y *255, colors.z *255);
          rect(x, y, 1, 1);
      }
      else{
          fill(scene.background.x*255, scene.background.y*255, scene.background.z*255);
          rect(x, y, 1, 1);
      }
    }
  }
}

void draw() {
  // nothing should be put here for this project
}

// use this routine to find the coordinates of a particular pixel (for debugging)
void mousePressed()
{
  println ("Mouse pressed at location: " + mouseX + " " + mouseY);
}
