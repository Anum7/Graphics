// Anum Bhamani

float time = 0;  // keep track of the passing of time

void setup() {
  size(800, 800, P3D);  // must use 3D here!
  noStroke();           // do not draw the edges of polygons
}

// Draw a scene with a cylinder, a box and a sphere
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(255, 255, 255);  // clear the screen to white

  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);

  // place the camera in the scene
  camera (0.0, 0.0, 85.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  
  // create an ambient light source
  ambientLight (102, 102, 102);

  // create two directional light sources
  lightSpecular (204, 204, 204);
  directionalLight (102, 102, 102, -0.7, -0.7, -1);
  directionalLight (152, 152, 152, 0, 0, -1);
  //rotateY(.5*time);
  
  monkey();
  //tail();
  //banana();

  // step forward the time
  time += 0.02;
}
void banana(){
  pushMatrix();
  fill(255, 225, 53);
  rotateZ(-1.3);
  translate(0,0,0);
  
  pushMatrix();
  translate(0,-8,0);
  cylinder(1.5, 6, 30);
  popMatrix();
  
  pushMatrix();
  sphere(3);
  popMatrix();
  
  pushMatrix();
  cylinder(3, 10, 30);
  popMatrix();
  
  pushMatrix();
  translate(0,9,0);
  sphere(3);
  popMatrix();
  
  popMatrix();
  
  pushMatrix();
  fill(255, 225, 53);
  rotateZ(1.5);
  translate(3.3,-19.5,0);
  
  pushMatrix();
  translate(0,10,0);
  sphere(3);
  popMatrix();
  
  pushMatrix();
  cylinder(3, 10, 30);
  popMatrix();
  
  pushMatrix();
  translate(0,0,0);
  sphere(3);
  popMatrix();
  
  popMatrix();
  
  
  
}
void monkey() {
  //head
  pushMatrix();
  fill(139,69,19);
  translate(0, -16, 0.95);
  scale(1.30, 1.4, 1.3);
  sphere(5.5);
  popMatrix();
  
  //inner head
  pushMatrix();
  fill(255,228,196);
  translate(0, -14, 6);
  scale(1.0, 0.9, 0.5);
  sphere(5);
  popMatrix();
  
  //head-eye left
  pushMatrix();
  fill(255,228,196);
  translate(-1.05, -15, 5.73);
  scale(0.80, 0.9, 0.5);
  rotateY(0.9);
  sphere(5);
  popMatrix();
  
   //head-eye right
  pushMatrix();
  fill(255,228,196);
  translate(1.15, -15, 5.75);
  scale(0.80, 0.9, 0.5);
  rotateY(0.9);
  sphere(5);
  popMatrix();
  
  //left eyes
  pushMatrix();
  fill(0,0,0);
  translate(-1.7, -15, 7.75);
  scale(0.5,0.5,0.5);
  sphere(2.2);
  popMatrix();
  
  //inner left eye
  pushMatrix();
  fill(256,256,256);
  translate(-1.5, -15, 8.75);
  scale(0.25,0.25,0.25);
  sphere(1.6);
  popMatrix();
  
  //right eye
  pushMatrix();
  fill(0,0,0);
  translate(1.7, -15, 7.75);
  scale(0.5,0.5,0.5);
  sphere(2.2);
  popMatrix();
  
  //inner right eye
  pushMatrix();
  fill(256,256,256);
  translate(1.6, -15, 8.75);
  scale(0.25,0.25,0.25);
  sphere(1.6);
  popMatrix();
  
  //nose
  pushMatrix();
  fill(139,69,19);
  //fill(138, 30, 30);
  translate(0, -13, 7.7);
  scale(1.1,0.7,1.0);
  sphere(1);
  popMatrix();
  
  //mouth
  pushMatrix();
  fill(139,69,19);
  translate(0, -11, 7.7);
  scale(2.6,0.9,1.0);
  sphere(0.5);
  popMatrix();
  
  
  //left ear
  pushMatrix();
  fill(139,69,19);
  translate(-6.5, -15, 1.5);
  scale(1.5, 1.75, 1);
  sphere(1.9);
  popMatrix();
  
  //inner left ear
  pushMatrix();
  fill(255,228,196);
  translate(-6.5, -15, 2.5);
  scale(1.5, 1.75, 1);
  sphere(1.3);
  popMatrix();
  
  //right ear
  pushMatrix();
  fill(139,69,19);
  translate(6.5, -15, 1.5);
  scale(1.5, 1.75, 1);
  sphere(1.9);
  popMatrix();
  
   //inner right ear
  pushMatrix();
  fill(255,228,196);
  translate(6.5, -15, 2.5);
  scale(1.5, 1.75, 1);
  sphere(1.3);
  popMatrix();
  
  //body
  pushMatrix();
  fill(139,69,19);
  ambient (50, 50, 50);      
  specular (155, 155, 155);   
  shininess (6.0);
  scale(1.15, 1.4, 0.9);
  sphere(8);
  popMatrix();
  
  //light brown body area
  pushMatrix();
  fill(255,228,196);
  translate(0, -1.0, 3.8);
  scale(0.85, 1.1, 0.5);
  sphere(8);
  popMatrix();
  
   //right arm
  pushMatrix();
  fill(139,69,19);
  translate(3.9, -9.0, 0.8);
  rotateZ(5.5);
  rotateY(1.0);
  scale(1.5, 1.8, 1);
  cylinder(1.3, 7, 3);
  popMatrix();
  
  //right hand
  pushMatrix();
  fill(139,69,19);
  translate(13, 0.75, 0.8);
  rotateZ(1);
  scale(1.5, 1, 1);
  sphere(1);
  popMatrix();
  
  //left arm
  pushMatrix();
  fill(139,69,19);
  translate(-3.6, -9, 0.95);
  rotateZ(-5.5);
  rotateY(-1.0);
  scale(1.45, 1.8, 1);
  cylinder(1.3, 7, 3);
  popMatrix();
  
  //left hand
  pushMatrix();
  fill(139,69,19);
  translate(-13.5, 0.75, 0.8);
  rotateZ(-1);
  scale(1.5, 1, 1);
  sphere(1);
  popMatrix();
  
   //right leg
  pushMatrix();
  fill(139,69,19);
  translate(4, 9, 0.7);
  rotateZ(6);
  scale(1.5, 1.75, 1);
  cylinder(1.3, 4.0, 3);
  popMatrix();
 
  //rigth foot
  pushMatrix();
  fill(139,69,19);
  translate(6.5, 15, 0.7);
  scale(1.5, 1, 1);
  sphere(2);
  popMatrix();
  
  //left leg
  pushMatrix();
  fill(139,69,19);
  translate(-4.5, 9, 0.75);
  rotateZ(-6);
  scale(1.5, 1.75, 1);
  cylinder(1.3, 4.0, 3);
  popMatrix();
  
  //left foot
  pushMatrix();
  fill(139,69,19);
  translate(-6.0, 15, 0.7);
  scale(1.5, 1, 1);
  sphere(2);
  popMatrix();
  
  tail();
}

void tail(){
  pushMatrix();
  fill(139,69,19);
  rotateY(-1.2);
  rotateZ(0.05);
  scale(2,2,2);
  translate(-6,-1,-0.5);
  
  pushMatrix();
  rotateZ(-0.18);
  translate(0,0,0);
  sphere(0.5);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.18);
  translate(0, 0, 0);
  cylinder(0.5,3, 30);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.18);
  translate(0,2.9,0);
  sphere(0.5);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.25);
  translate(-0.21,2.9,0);
  cylinder(0.5,2,30);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.23);
  translate(-0.09,4.9,0);
  sphere(0.5);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.52);
  translate(-1.46,4.6,0);
  cylinder(0.5,2,30);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.52);
  translate(-1.40,6.4,0);
  sphere(0.5);
  popMatrix();
  
  pushMatrix();
  translate(1.74,6.3,0);
  rotateZ(-1.55);
  cylinder(0.5,2,30);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.75);
  translate(-1.6,7.1,0);
  sphere(0.5);
  popMatrix();
  
  pushMatrix();
  translate(3.45,6.5,0);
  rotateZ(-2.4);
  cylinder(0.5,2,30);
  popMatrix();
  
  pushMatrix();
  rotateZ(-0.75);
  translate(0,6.95,0);
  sphere(0.5);
  popMatrix();
  
  popMatrix();

}

// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}
