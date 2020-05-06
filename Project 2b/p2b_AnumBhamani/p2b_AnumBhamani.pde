// Anum Bhamani
//I am replicating monkey using instancing
//For effort I have added background music and I am also importing background images.
//I have camera motion in the first two scenes. 
//I am using spotlight at the very end of my animated scene
//I am rotating, scaling, and transforming my both monkeys. 
//After I have added background music, it shows white screen for a while in the beginning,
//and takes a little while to display my actual scenes but it works though.

import processing.sound.*;
SoundFile file;

String audioName = "music.mp3";
String path;

float time = 0;  // keep track of the passing of time
float time2, time3, time4, time5, time6;
float mov;
float back = 85;
float newBack;

float movz = 60;
float movy = -35;

float monkey1 = 10;
float monkey2 = 20;

float entryMonkey1 = -35;
float entryMonkey2 = -35;

float newMonkey1;
float newMonkey2;

PImage img;

void setup() {
  size(800, 800, P3D);  // must use 3D here!
  noStroke();           // do not draw the edges of polygons
  
  print("Loading background music");
  //background music
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
  print("Finished loading background music");
}

// Draw a scene with a cylinder, a box and a sphere
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(135, 206, 235);  // clear the screen to white

  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);

  // place the camera in the scene
  camera (0.0, 0.0, 85.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  
  // create an ambient light source
  ambientLight (102, 102, 102);

  // create two directional light sources
  lightSpecular (204, 204, 204);
  if (time < 10.9) { 
    directionalLight (102, 102, 102, -0.7, -0.7, -1);
    directionalLight (152, 152, 152, 0, 0, -1);
  } else {
    spotLight(0, 0, 0, 0, -100, 105, 0, 1, 0, 90, 4);
  }
  
  // step forward the time
  time += 0.01;
 
  if (time <= 1.0) {  //camera moving first monkey back 
    camera (0.0, 0.0, back, 45.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    back += 1;
    pushMatrix();
    monkey();
    popMatrix();
    
    newBack = back;
    time2 = time;
 
  } else if(time > 1.0 && time <= 2.0) {  //camera moving first monkey forward
    camera (0.0, 0.0, newBack, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    newBack -= 1;
    pushMatrix();
    monkey();
    popMatrix();
    time2 = time2 + time;
    
  } else if(time > 2.0 && time <= 7.0) {  //rotate first monkey
    time3 = time - time2;
    rotateZ(time3);
    pushMatrix();
    monkey();
    popMatrix(); 
    
  } else if (time >= 7.0 && time <= 8.22) {  // first monkey going to left
    pushMatrix();
    mov = (time*60) % 200;
    translate(-mov,0,0);
    monkey();
    popMatrix();
    
  } else if (time > 8.20 && time <= 8.51){  //introducing second monkey, going to planet
    img = loadImage("sky.jpg");
    background(img);
    
    movz -= 5;
    pushMatrix();
    translate(0,0,movz);
    rotateX(1);
    rotateY(3);
    scale(0.5,0.5,0.5);
    monkey();
    popMatrix();
    
  } else if (time > 8.51 && time <= 9.3) { //second monkey moving
    img = loadImage("sky1.jpg");
    background(img);
    movy += 1.0;
    pushMatrix();
    translate(0,movy,0);
    scale(0.5,0.5,0.5);
    monkey();
    popMatrix();
    
  } else if (time > 9.3 && time < 9.5) { //display both monkey
    img = loadImage("forest.jpg");
    background(img);
    
    entryMonkey1+=2;
    entryMonkey2+=2;
    
    pushMatrix();
    translate(-10,entryMonkey1,0);
    monkey();
    popMatrix();
    
    pushMatrix();
    translate(10, entryMonkey1, 0);
    scale(0.5,0.5,0.5);
    monkey();
    popMatrix();
    
    time4 = time4 + time;
    
  } else if (time >= 9.5 && time <= 10.3) {    //rotate first monkey 
    time5 = time * 8;
    
    img = loadImage("forest.jpg");
    background(img);
    
    pushMatrix();
    translate(-22,26,-45);
    rotateY(time5);
    monkey();
    popMatrix();
    
    pushMatrix();
    rotateY(-0.7);
    translate(21,15,5);
    scale(0.5,0.5,0.5);
    monkey();
    popMatrix();
   
  } else if (time > 10.3 && time <= 10.8) { //rotate second monkey
    img = loadImage("forest.jpg");
    background(img);
    
    time6 = time * 11;
    
    pushMatrix();
    rotateY(0.7);
    translate(10,25,-45);
    monkey();
    popMatrix();
    
    pushMatrix();
    //rotateY(-0.7);
    translate(15,15,15);
    scale(0.5,0.5,0.5);
    rotateY(time6);
    monkey();
    popMatrix();
    
  } else if (time > 10.8 && time < 10.9){  //monkey comes to center
    img = loadImage("forest.jpg");
    background(img);
    
    monkey1++;
    monkey2--;
    newMonkey1 = monkey1;
    newMonkey2 = monkey2;
    
    pushMatrix();
    rotateY(0.7);
    translate(monkey1,25,-45);
    monkey();
    popMatrix();
    
    pushMatrix();
    rotateY(-0.7);
    translate(monkey2,15,6);
    scale(0.5,0.5,0.5);
    monkey();
    popMatrix();
    
  } else {    //last scene
    img = loadImage("forest.jpg");
    background(img);
    
    pushMatrix();
    rotateY(0.7);
    translate(newMonkey1,25,-45);
    monkey();
    popMatrix();
    
    pushMatrix();
    rotateY(-0.7);
    translate(newMonkey2,15,6);
    scale(0.5,0.5,0.5);
    monkey();
    popMatrix();
  }
}





//Drawing Monkey
void monkey() {
  head();
  body();
  arms();
  legs();
  tail();
}
void head() {
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
}

void body() {
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
}

void arms() {
  
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
  
}

void legs() {
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
