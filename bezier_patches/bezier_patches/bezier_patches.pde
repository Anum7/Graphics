// Anum Bhamani

int display_option = 1;  // 1 = four corners, 2 = nine quads, 3 = detailed polygons

float time = 0;                 // keep track of passing of time

boolean rotate_flag = true;     // automatic rotation of model?
boolean normal_flag = false;    // use smooth surface normals?  (optional)
boolean color_flag = false;     // random colors?

// object-specific translation and scaling
PVector obj_center = new PVector (0,0,0);
float obj_scale = 1.0;

ArrayList<Patch> patchList = new ArrayList<Patch>();

// initialize stuff
void setup() {
  size(750, 750, OPENGL);
}

// Draw the scene
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity

  background (100, 100, 230);  // clear the screen to sky blue
  
  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
  
  // place the camera in the scene
  camera (0.0, 0.0, 5.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    
  // create an ambient light source
  ambientLight (102, 102, 102);
  
  // create two directional light sources
  lightSpecular (204, 204, 204);
  directionalLight (102, 102, 102, -0.7, -0.7, -1);
  directionalLight (152, 152, 152, 0, 0, -1);
  
  pushMatrix();

  // set the material color
  fill (200, 200, 200);
  ambient (200, 200, 200);
  specular(0, 0, 0);
  shininess(1.0);
  noStroke();
  
  // rotate based on time
  rotate (time, 0.0, 1.0, 0.0);
  
  translate (0.0, 0.8, 0.0);
  rotate (PI * 0.5, 1.0, 0.0, 0.0);

  // translate and scale on a per-object basis
  scale (obj_scale);
  translate (-obj_center.x, -obj_center.y, -obj_center.z);
  strokeWeight (1.0 / obj_scale);  // make sure lines don't change thickness
  
  // THIS IS WHERE YOU SHOULD DRAW THE PATCHES
  
  // placeholder square
  //beginShape();
  //normal (0.0, 0.0, 1.0);
  //vertex (-1.0, -1.0, 0.0);
  //vertex ( 1.0, -1.0, 0.0);
  //vertex ( 1.0,  1.0, 0.0);
  //vertex (-1.0,  1.0, 0.0);
  //endShape(CLOSE);
  
  //4 corners
  if (display_option == 1) {
    //4 points from patchList
    for(int i = 0; i < patchList.size(); i++) {
      patchList.get(i).drawPatch(); //<>//
    }
  }
  
    
  //9 quads
  if (display_option == 2) {
    for(int i = 0; i < patchList.size(); i++) {
      patchList.get(i).drawQuad(); //<>//
    }
  }
  
  // Detailed polygons
  if (display_option == 3) {
    for(int i = 0; i < patchList.size(); i++) {
      if (color_flag) {
        fill (patchList.get(i).c);
      } else {
        fill(256, 256, 256);
      }
      patchList.get(i).drawPolygon(); //<>//
    }
  }

  popMatrix();
 
  // maybe step forward in time (for object rotation)
  if (rotate_flag )
    time += 0.02;
}

// handle keystroke inputs
void keyPressed() {
  if (key == '1') {
    set_obj_center_and_scale (1, 1.5, 1.5, 0);
    read_patches ("simple.txt");
  }
  else if (key == '2') {
    set_obj_center_and_scale (1.5, 0, 0, -0.75);
    read_patches ("sphere.txt");
  }
  else if (key == '3') {
    set_obj_center_and_scale (0.6, 0, 0, 0);
    read_patches ("teapot.txt");
  }
  else if (key == '4') {
    set_obj_center_and_scale (0.15, 10.0, 7.0, 4.0);
    read_patches ("gumbo.txt");
  }
  else if (key == 'a') {
    // set the display of each patch to an outline of one quad
    display_option = 1;
  }
  else if (key == 's') {
    // set the display of each patch to outlines of nine quads
    display_option = 2;
  }
  else if (key == 'd') {
    // set the display of each patch to be a detailed set of filled polygons (10 x 10 or more)
    display_option = 3;
  }
  else if (key == 'r') {
    // toggle random color here
    color_flag = !color_flag;
  }
  else if (key == 'n') {
    // toggle surface normals (optional)
    normal_flag = !normal_flag;
  }
  else if (key == ' ') {
    // rotate the model?
    rotate_flag = !rotate_flag;
  }
  else if (key == 'q' || key == 'Q') {
    exit();
  }
}

// adjust the size and position of an object when it is drawn
void set_obj_center_and_scale (float sc, float x, float y, float z)
{
  obj_scale = sc;
  obj_center = new PVector (x, y, z);
}

// Read Bezier patches from a text file
//
// You should modify this routine to store all of the patch data
// into your data structure instead of printing it to the screen.
void read_patches (String filename)
{
  int i,j,k;
  String[] words;
    
  String lines[] = loadStrings(filename);
  
  words = split (lines[0], " ");
  int num_patches = int(words[0]);
  println ("number of patches = " + num_patches);
  
  // which line of the file are we reading?
  int count = 1;
  
  //Emptying ArrayList
    patchList = new ArrayList<Patch>();
    
  // read in the patches
  for (i = 0; i < num_patches; i++) {
    println ();
    println ("patch number " + i + ":");
    
     //creating a patch class object
      Patch patch = new Patch(); //<>//
      
    count += 1;  // skip over the lines that say "3 3"
    for (j = 0; j < 4; j++) {
      for (k = 0; k < 4; k++) {
        words = split (lines[count], " ");
        count += 1;
        float x = float(words[0]);
        float y = float(words[1]);
        float z = float(words[2]);        
        
        // store the point the in your list of points that you have in your patch class
        PVector points = new PVector(x,y,z);
        patch.patchArrayList[j][k] = points;
        
        println (" control point " + j + " " + k + " " + x + " " + y + " " + z); 
      }
    }
      // Add this patch to your global list of patches.
      patchList.add(patch); //<>//
    
  }

}
