//Anum Bhamani

// The most important part of this code is the interpreter, which will help
// you parse the scene description (.cli) files.
import java.lang.Math;
import java.util.ArrayList;

boolean debug_flag;  // help to print information for just one pixel

//instantiating scene class;
Scene scene;

Disk hitDisk; 
Ellipsoid hitEllipsoid;

//diffuse color variables
float newCdr;
float newCdg;
float newCdb;

//ambient color variables
float newCar;
float newCag;
float newCab;

//specular color variables
float newCsr;
float newCsg;
float newCsb;

//k, p
float newP;
float newK;

//creating arrayList for light
ArrayList<Light> lightArray;

//creating arrayList for ellipsoid. I may need it in part B
//ArrayList<Ellipsoid> ellipsoidArray;

//creating arraylist for disk
ArrayList<Disk> diskArray;

//creating arraylist for ellipsoid
ArrayList<Ellipsoid> ellipsoidArray;

//already instantiated in given code but just to make it global I am declaring it here
float fov;

//book keeping of light hitting variables
boolean hit; 

PVector hitOrigin;
PVector hitNormal;
PVector hitSurface;

PVector ellipsoidHitOrigin;
PVector ellipsoidHitNormal;
PVector ellipsoidHitSurface;

Hit finalDisk;
Hit finalEllipsoid;
Hit hitFinal;

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
  ellipsoidArray = new ArrayList<Ellipsoid>();

  fov = 0;
  newCdr = 0;
  newCdg = 0;
  newCdb = 0;
}

void keyPressed() {
  reset_scene();
  switch(key) {
  case '1':  
    interpreter("01.cli"); 
    break;
  case '2':  
    interpreter("02.cli"); 
    break;
  case '3':  
    interpreter("03.cli"); 
    break;
  case '4':  
    interpreter("04.cli"); 
    break;
  case '5':  
    interpreter("05.cli"); 
    break;
  case '6':  
    interpreter("06.cli"); 
    break;
  case '7':  
    interpreter("07.cli"); 
    break;
  case '8':  
    interpreter("08.cli"); 
    break;
  case '9':  
    interpreter("09.cli"); 
    break;
  case '0':  
    interpreter("10.cli"); 
    break;
  case '-':  
    interpreter("11.cli"); 
    break;
  case 'q':  
    exit(); 
    break;
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
    } else if (token[0].equals("background")) {
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      // call routine to save the background color
      scene.setBg(r, g, b);
    } else if (token[0].equals("eye")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      // call routine to save the eye position
      scene.setEye(x, y, z);
    } else if (token[0].equals("uvw")) {
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
    } else if (token[0].equals("light")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float r = float(token[4]);
      float g = float(token[5]);
      float b = float(token[6]);
      // call routine to save lighting information
      Light light = new Light(x, y, z, r, g, b);
      lightArray.add(light);
    } else if (token[0].equals("surface")) {
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
      newCar = Car;
      newCag = Cag;
      newCab = Cab;
      newCsr = Csr;
      newCsg = Csg;
      newCsb = Csb;
      newP = P;
      newK = K;
    } else if (token[0].equals("ellipsoid")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float rx = float(token[4]);
      float ry = float(token[5]);
      float rz = float(token[6]);
      // call routine to save ellipsoid here      
      Ellipsoid ellipsoid = new Ellipsoid(x, y, z, rx, ry, rz);
      ellipsoid.surface(newCdr, newCdg, newCdb, newCar, newCag, newCab, newCsr, newCsg, newCsb, newP, newK);
      ellipsoidArray.add(ellipsoid);
    } else if (token[0].equals("disk")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float nx = float(token[4]);
      float ny = float(token[5]);
      float nz = float(token[6]);
      float radius = float(token[7]);
      // call routine to save disk here
      Disk disk = new Disk(x, y, z, nx, ny, nz, radius);
      disk.surface(newCdr, newCdg, newCdb, newCar, newCag, newCab, newCsr, newCsg, newCsb, newP, newK);
      diskArray.add(disk);
    } else if (token[0].equals("write")) {
      draw_scene();   // here is where you actually perform the ray tracing
      println("Saving image to '" + token[1] + "'");
      save(token[1]); // this saves your ray traced scene to a .png file
    } else if (token[0].equals("#")) {
      // comment symbol (ignore this line)
    } else {
      println ("cannot parse this line: " + str[i]);
    }
  }
}

// This is where you should place your code for creating the eye rays and tracing them.
void draw_scene() {
  float u, v;
  float deye;

  PVector origin;      //eye vector 
  PVector originRay;
  PVector direction;  //FROM EYE to DISK
  PVector directionRay;
  PVector center;     //center vector of disk
  PVector normal;     //normal of disk

  Ray currentRay;    

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      // maybe turn on a debug flag for a particular pixel (so you can print ray information)      
      if (x == 260 & y == 323)
        debug_flag = true;
      else
        debug_flag = false;

      // create and cast an eye ray here
      u = ((2.0 * x) / width) - 1.0;
      v = ((2.0 * y) / height) - 1.0;
      deye = (1.0 / tan(radians(fov) / 2.0));
      originRay = scene.eye;

      ArrayList<PVector> cameraArray = scene.getCamera();

      currentRay = new Ray (originRay, cameraArray);      
      directionRay = currentRay.RayCalculation(deye, u, v);
      Ray eyeRay = new Ray(originRay, directionRay);

      hitFinal = shapeClosest(eyeRay, 0);

      Hit hitI = new Hit();
      boolean checkHit;
      if (hitFinal != null) {
        hitI = hitFinal;
        checkHit = true;
      } else {
        hitI = null;
        checkHit = false;
      }
      if (checkHit) {
        PVector finalColor = colorCalculation(hitI, 0);
        fill(finalColor.x *255, finalColor.y *255, finalColor.z *255);
        rect(x, y, 1, 1);
      } else {
        fill(scene.background.x*255, scene.background.y*255, scene.background.z*255);
        rect(x, y, 1, 1);
      }
    }
  }
}

Hit shadowCalculation (Ray r, float depth, Light light) {
  Light l1 = light;
  //Disk 
  PVector direction = r.direction;
  PVector origin = r.origin;  //eye

  PVector center;
  PVector normal;
  float t;
  float radius;
  float neart = Integer.MAX_VALUE;
  boolean ifHit = false;

  Hit finalHit;

  for (Disk disk : diskArray) {
    center = disk.center;
    radius = disk.diskRadius;
    normal = disk.normalVector;     
    
    float adisk = normal.x; 
    float bdisk = normal.y;
    float cdisk = normal.z;

    //center of disk
    float diskX = center.x;
    float diskY = center.y;
    float diskZ = center.z;

    float d = (-(adisk*diskX)-(bdisk*diskY)-(cdisk*diskZ));

    //this is for reminder for me for next part/
    //origin.x = x0
    //direction.x = dx

    float numerator = -((adisk * origin.x) + (bdisk * origin.y)+ (cdisk * origin.z) + d);
    float denominator = ((adisk * direction.x) + (bdisk * direction.y) + (cdisk * direction.z)); 

    if (denominator != 0) { 
      t = numerator / denominator;


      if (t >= 0 && t < neart && t < 1) {
        PVector mul = PVector.mult(direction, t); 
        hitOrigin = PVector.add(origin, mul);
        float dist = PVector.dist(hitOrigin, center);
        if (dist <= radius) {
          ifHit = true;
          hitDisk = disk;
          hitSurface = new PVector(disk.x, disk.y, disk.z);
          hitNormal = normal;
          neart = t;
          finalDisk = new Hit(t, hitOrigin, hitNormal, hitDisk);
          finalDisk.setDepth(depth);
          finalDisk.setEye(r);
        }
      }
    }
  }

  PVector ellipsoidCenter;
  float ellipsoidRx;
  float ellipsoidRy;
  float ellipsoidRz;
  float ellipsoidT;
  float ellipsoidPartT;
  float ellipNearT = Float.MAX_VALUE;
  boolean ellipsoidIfHit = false;

  for (Ellipsoid e : ellipsoidArray) {
    ellipsoidCenter = e.ellipsoidCenter;
    ellipsoidRx = e.rx;
    ellipsoidRy = e.ry;
    ellipsoidRz = e.rz;


    PVector newOrigin = PVector.sub(origin, ellipsoidCenter);
    float a = ((direction.x * direction.x) / (ellipsoidRx * ellipsoidRx)) + ((direction.y * direction.y) / (ellipsoidRy * ellipsoidRy)) 
      + ((direction.z * direction.z) / (ellipsoidRz * ellipsoidRz));

    float b = 2 * (((newOrigin.x * direction.x)/(ellipsoidRx * ellipsoidRx)) + ((newOrigin.y * direction.y)/(ellipsoidRy * ellipsoidRy)) 
      + ((newOrigin.z * direction.z)/(ellipsoidRz * ellipsoidRz)));

    float c = (((newOrigin.x * newOrigin.x)/(ellipsoidRx * ellipsoidRx)) + ((newOrigin.y * newOrigin.y)/(ellipsoidRy * ellipsoidRy)) 
      + ((newOrigin.z * newOrigin.z)/(ellipsoidRz * ellipsoidRz)) - 1);

    ellipsoidPartT = b*b - 4.0*a*c;

    if (ellipsoidPartT >= 0) {
      float t1 = (-b + sqrt(ellipsoidPartT))/(2*a);
      float t2 = (-b - sqrt(ellipsoidPartT))/(2*a);

      if (t1 > 0 && t2 > 0) {
        ellipsoidT = min(t1, t2);
      } else if (t1 < 0 && t2 > 0) {
        ellipsoidT = t2;
      } else if (t2 < 0 && t1 > 0) {
        ellipsoidT = t1;
      } else {
        ellipsoidT = -1;
      }

      if (ellipsoidT >= 0 && ellipsoidT < 1 && ellipsoidT < ellipNearT) {
        ellipsoidIfHit = true;
        hitEllipsoid = e;
        ellipsoidHitSurface = new PVector(e.x, e.y, e.z);
        float eXHit = origin.x + (ellipsoidT * direction.x);
        float eYHit = origin.y + (ellipsoidT * direction.y);
        float eZHit = origin.z + (ellipsoidT * direction.z);
        ellipsoidHitOrigin = new PVector(eXHit, eYHit, eZHit);
        ellipsoidHitNormal = (PVector.sub(ellipsoidHitOrigin, ellipsoidHitSurface)); //.normalize();
        ellipsoidHitNormal.x = ellipsoidHitNormal.x / (ellipsoidRx * ellipsoidRx);
        ellipsoidHitNormal.y = ellipsoidHitNormal.y / (ellipsoidRy * ellipsoidRy);
        ellipsoidHitNormal.z = ellipsoidHitNormal.z / (ellipsoidRz * ellipsoidRz);
        ellipsoidHitNormal = ellipsoidHitNormal.normalize();

        finalEllipsoid = new Hit(ellipsoidT, ellipsoidHitOrigin, ellipsoidHitNormal, hitEllipsoid);
        finalEllipsoid.setDepth(depth);
        finalEllipsoid.setEye(r);
      }
    }
  }
  finalHit = null;
  if (!ifHit && !ellipsoidIfHit) {
    return finalHit;
  } else if (ifHit && !ellipsoidIfHit) {
    finalHit = finalDisk;
  } else if (!ifHit && ellipsoidIfHit) {
    finalHit = finalEllipsoid;
  } else {
    if (finalDisk.t < finalEllipsoid.t) {
      finalHit = finalDisk;
    } else if (finalDisk.t > finalEllipsoid.t) {
      finalHit = finalEllipsoid;
    }
  }  
  return finalHit;
}


//doesn't bind the t values between light & shadow
Hit shapeClosest (Ray r, float depth) {  
  //Disk 
  PVector direction = r.direction;
  PVector origin = r.origin;

  PVector center;
  float radius;
  PVector normal;
  float t;
  float neart = Integer.MAX_VALUE;
  boolean ifHit = false;

  Hit finalHit;
  for (Disk disk : diskArray) {
    center = disk.center;
    radius = disk.diskRadius;
    normal = disk.normalVector;     

    //equations for a,b,c from notes
    float adisk = normal.x; 
    float bdisk = normal.y;
    float cdisk = normal.z;


    //center of disk
    float diskX = center.x;
    float diskY = center.y;
    float diskZ = center.z;

    float d = (-(adisk*diskX)-(bdisk*diskY)-(cdisk*diskZ));

    //this is for reminder for me for next part/
    //origin.x = x0
    //direction.x = dx

    float numerator = -((adisk * origin.x) + (bdisk * origin.y)+ (cdisk * origin.z) + d);
    float denominator = ((adisk * direction.x) + (bdisk * direction.y) + (cdisk * direction.z)); 

    if (denominator != 0) { 
      t = numerator / denominator;

      if (t >= 0 && t < neart) {
        PVector mul = PVector.mult(direction, t); 
        hitOrigin = PVector.add(origin, mul);
        float dist = PVector.dist(hitOrigin, center);
        if (dist <= radius) {
          ifHit = true;
          hitDisk = disk;
          hitNormal = normal;
          hitSurface = new PVector(disk.x, disk.y, disk.z);
          neart = t;
          finalDisk = new Hit(t, hitOrigin, hitNormal, hitDisk);
          finalDisk.setDepth(depth);
          finalDisk.setEye(r);
        }
      }
    }
  }

  PVector ellipsoidCenter;
  float ellipsoidRx;
  float ellipsoidRy;
  float ellipsoidRz;
  float ellipsoidT;
  float ellipsoidPartT;
  float ellipNearT = Float.MAX_VALUE;
  boolean ellipsoidIfHit = false;

  for (Ellipsoid e : ellipsoidArray) {
    ellipsoidCenter = e.ellipsoidCenter;
    ellipsoidRx = e.rx;
    ellipsoidRy = e.ry;
    ellipsoidRz = e.rz;

    PVector newOrigin = PVector.sub(origin, ellipsoidCenter);
    float a = ((direction.x * direction.x) / (ellipsoidRx * ellipsoidRx)) + ((direction.y * direction.y) / (ellipsoidRy * ellipsoidRy)) 
      + ((direction.z * direction.z) / (ellipsoidRz * ellipsoidRz));

    float b = 2 * (((newOrigin.x * direction.x)/(ellipsoidRx * ellipsoidRx)) + ((newOrigin.y * direction.y)/(ellipsoidRy * ellipsoidRy)) 
      + ((newOrigin.z * direction.z)/(ellipsoidRz * ellipsoidRz)));

    float c = (((newOrigin.x * newOrigin.x)/(ellipsoidRx * ellipsoidRx)) + ((newOrigin.y * newOrigin.y)/(ellipsoidRy * ellipsoidRy)) 
      + ((newOrigin.z * newOrigin.z)/(ellipsoidRz * ellipsoidRz)) - 1);


    ellipsoidPartT = b*b - 4.0*a*c;

    if (ellipsoidPartT >= 0) {
      float t1 = (-b + sqrt(ellipsoidPartT))/(2*a);
      float t2 = (-b - sqrt(ellipsoidPartT))/(2*a);

      if (t1 > 0 && t2 > 0) {
        ellipsoidT = min(t1, t2);
      } else if (t1 < 0 && t2 > 0) {
        ellipsoidT = t2;
      } else if (t2 < 0 && t1 > 0) {
        ellipsoidT = t1;
      } else {
        ellipsoidT = -1;
      }

      if (ellipsoidT >= 0 && ellipsoidT < ellipNearT) {
        ellipNearT = ellipsoidT;
        ellipsoidIfHit = true;
        hitEllipsoid = e;
        ellipsoidHitSurface = new PVector(e.x, e.y, e.z);
        float eXHit = origin.x + (ellipsoidT * direction.x);
        float eYHit = origin.y + (ellipsoidT * direction.y);
        float eZHit = origin.z + (ellipsoidT * direction.z);
        ellipsoidHitOrigin = new PVector(eXHit, eYHit, eZHit);
        ellipsoidHitNormal = (PVector.sub(ellipsoidHitOrigin, ellipsoidHitSurface)); //.normalize();
        ellipsoidHitNormal.x = ellipsoidHitNormal.x / (ellipsoidRx * ellipsoidRx);
        ellipsoidHitNormal.y = ellipsoidHitNormal.y / (ellipsoidRy * ellipsoidRy);
        ellipsoidHitNormal.z = ellipsoidHitNormal.z / (ellipsoidRz * ellipsoidRz);
        ellipsoidHitNormal = ellipsoidHitNormal.normalize();     

        finalEllipsoid = new Hit(ellipsoidT, ellipsoidHitOrigin, ellipsoidHitNormal, hitEllipsoid);
        finalEllipsoid.setDepth(depth);
        finalEllipsoid.setEye(r);        
      }
    }
  }
  finalHit = null;
  if (!ifHit && !ellipsoidIfHit) {
    return finalHit;
  } else if (ifHit && !ellipsoidIfHit) {
    finalHit = finalDisk;
  } else if (!ifHit && ellipsoidIfHit) {
    finalHit = finalEllipsoid;
  } else {
    if (finalDisk.t < finalEllipsoid.t) {
      finalHit = finalDisk;
    } else if (finalDisk.t > finalEllipsoid.t) {
      finalHit = finalEllipsoid;
    }
  }  
  return finalHit;
}

PVector colorCalculation(Hit hit, float d) {
  float depth = d; 

  Hit hitI = hit;
  Hit hitShadow;
  Hit hitReflection;

  PVector colors = new PVector(0, 0, 0);
  PVector diffuse = new PVector();
  PVector ambient = new PVector();
  PVector specular = new PVector();
  PVector reflection = new PVector();
  //PVector shadow = new PVector();

  float kref;
  float p;

  if (hitI != null) {
    PVector newDiffuse = new PVector(0, 0, 0);
    PVector newSpecular = new PVector(0, 0, 0);
    Ray eyeRay = hit.eyeRay;

    SurfaceMaterial sm = hitI.hitSurface;
    PVector hitPositionVector = hitI.hitPositionVector;
    p = hitI.hitSurface.P;
    kref = hitI.hitSurface.K;
    PVector shapeNormal = hitI.normalVector.normalize();

    for (Light light : lightArray) { 
      PVector lightHit = PVector.sub(light.origin, hitPositionVector);

      //shadow rays
      PVector originShadow = hitI.hitPositionVector;
      PVector directionShadow = lightHit ;

      float originShadowX = originShadow.x + (directionShadow.x*0.00001);
      float originShadowY = originShadow.y + (directionShadow.y*0.00001);
      float originShadowZ = originShadow.z + (directionShadow.z*0.00001);

      PVector updatedOriginShadow = new PVector(originShadowX, originShadowY, originShadowZ);
      Ray shadowRay = new Ray(updatedOriginShadow, directionShadow);

      if (debug_flag) {
        println("shadow direction: "+directionShadow);
        println("shadow origin: "+ updatedOriginShadow);
      }
      hitShadow = shadowCalculation(shadowRay, 0, light);

      //if there's no shadow then just regular color
      if (hitShadow == null) {
        PVector lightNormal = PVector.sub(light.origin, hitI.hitPositionVector).normalize();                 
        float maxLight = max(0, (PVector.dot(lightNormal, shapeNormal)));

        //try to recalculate next three using PVector mul & add
        newDiffuse.x += light.r * maxLight;
        newDiffuse.y += light.g * maxLight;
        newDiffuse.z += light.b * maxLight;       

        PVector rayE = PVector.sub(eyeRay.origin, hitI.hitPositionVector).normalize();        
        rayE = PVector.mult((eyeRay.direction), (-1)).normalize(); 

        PVector rayH = PVector.add(lightNormal, rayE).normalize();

        if ((PVector.dot(lightNormal, shapeNormal)) > 0) {
          float specularMax = max(0, (PVector.dot(rayH, shapeNormal)));
          float specP = pow(specularMax, p);


          //change next three lines to pVector functions
          newSpecular.x += specP * sm.Csr * light.r;                   
          newSpecular.y += specP * sm.Csg * light.g;                  
          newSpecular.z += specP * sm.Csb * light.b;
        }
      }
    }
    //update next 9 lines with PVector properties
    diffuse.x = newDiffuse.x * sm.Cdr;
    diffuse.y = newDiffuse.y * sm.Cdg;
    diffuse.z = newDiffuse.z * sm.Cdb;

    specular.x = newSpecular.x;
    specular.y = newSpecular.y;
    specular.z = newSpecular.z;

    ambient.x = sm.Cdr * sm.Car;
    ambient.y = sm.Cdg * sm.Cag;
    ambient.z = sm.Cdb * sm.Cab;


    //Reflection
    if (sm.K > 0 && depth < 10) {
      PVector rayE = PVector.sub(eyeRay.origin, hitI.hitPositionVector);
      rayE = rayE.normalize();

      float reflectionScalar = max(0, PVector.dot(rayE, hitI.normalVector));   
      reflection.x = 2 * reflectionScalar * hitI.normalVector.x - rayE.x;
      reflection.y = 2 * reflectionScalar * hitI.normalVector.y - rayE.y;
      reflection.z = 2 * reflectionScalar * hitI.normalVector.z - rayE.z;

      PVector reflectionOrigin = hitI.hitPositionVector;
      PVector reflectionDirection = new PVector(reflection.x, reflection.y, reflection.z);
      float roX = reflectionOrigin.x + (reflectionDirection.x * 0.0001);
      float roY = reflectionOrigin.y + (reflectionDirection.y * 0.0001);
      float roZ = reflectionOrigin.z + (reflectionDirection.z * 0.0001);
      PVector reflOrigin = new PVector(roX, roY, roZ);

      Ray reflectionRay = new Ray(reflOrigin, reflectionDirection);

      hitReflection = shapeClosest(reflectionRay, depth);
      PVector finalReflColor = colorCalculation(hitReflection, depth + 1);

      reflection.x = finalReflColor.x * kref;
      reflection.y = finalReflColor.y * kref;
      reflection.z = finalReflColor.z * kref;

      if (hitReflection == null && depth < 10) {
        reflection.x = scene.background.x * kref;
        reflection.y = scene.background.y * kref;
        reflection.z = scene.background.z * kref;
      }
    } else {
      reflection.x = scene.background.x * kref;
      reflection.y = scene.background.y * kref;
      reflection.z = scene.background.z * kref;
    }
  }
  colors.x = diffuse.x;
  colors.y = diffuse.y;
  colors.z = diffuse.z;

  colors.x = colors.x + specular.x; 
  colors.y = colors.y + specular.y;
  colors.z = colors.z + specular.z;

  colors.x = colors.x + ambient.x; 
  colors.y = colors.y + ambient.y;
  colors.z = colors.z + ambient.z;

  colors.x = colors.x + reflection.x; 
  colors.y = colors.y + reflection.y;
  colors.z = colors.z + reflection.z;

  return colors;
}

void draw() {
  // nothing should be put here for this project
}

// use this routine to find the coordinates of a particular pixel (for debugging)
void mousePressed()
{
  println ("Mouse pressed at location: " + mouseX + " " + mouseY);
}
