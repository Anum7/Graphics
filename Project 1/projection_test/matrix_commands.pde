// Dummy routines for OpenGL commands.
// These are for you to write!
// You should incorporate your transformation matrix routines from part A of this project.
//Anum Bhamani

import java.util.LinkedList;

LinkedList<Float[][]> list;
LinkedList<Float[]> vertexList;

Float[][] array;
Float[][] coordinates;

String check;
float left, right, top, bottom;
float x0, y0, z0;
float k;


void Init_Matrix()
{
  list = new LinkedList<Float[][]>();
  Float[][] identityMatrix = {
    {1.0,0.0,0.0,0.0},
    {0.0,1.0,0.0,0.0},
    {0.0,0.0,1.0,0.0},
    {0.0,0.0,0.0,1.0}
  };
  list.add(identityMatrix);
}

void Translate(float x, float y, float z)
{
  Float[][] translateMatrix = {
    {1.0,0.0,0.0,x},
    {0.0,1.0,0.0,y},
    {0.0,0.0,1.0,z},
    {0.0,0.0,0.0,1.0}
  };
  Float[][] translatedMatrix = multiplication(list.getLast(), translateMatrix);
  list.add(translatedMatrix);
}

void Scale(float x, float y, float z)
{
  Float[][] scaleMatrix = {
    {x,0.0,0.0,0.0},
    {0.0,y,0.0,0.0},
    {0.0,0.0,z,0.0},
    {0.0,0.0,0.0,1.0}
  };
  Float[][] scaledMatrix = multiplication(list.getLast(), scaleMatrix);
  list.add(scaledMatrix);
}

void RotateX(float theta)
{
  Float cos = cos(radians(theta));
  Float sin = sin(radians(theta));
  
  Float[][] rotateXMatrix = {
    {1.0,0.0,0.0,0.0},
    {0.0,cos,-sin,0.0},
    {0.0,sin,cos,0.0},
    {0.0,0.0,0.0,1.0}
  };
  Float[][] rotatedXMatrix = multiplication(list.getLast(), rotateXMatrix); 
  list.add(rotatedXMatrix);
  
}

void RotateY(float theta)
{
  Float cos = cos(radians(theta));
  Float sin = sin(radians(theta));
  
  Float[][] rotateYMatrix = {
    {cos,0.0,sin,0.0},
    {0.0,1.0,0.0,0.0},
    {-sin,0.0,cos,0.0},
    {0.0,0.0,0.0,1.0}
  };
  Float[][] rotatedYMatrix = multiplication(list.getLast(), rotateYMatrix);
  list.add(rotatedYMatrix);
}

void RotateZ(float theta)
{
  Float cos = cos(radians(theta));
  Float sin = sin(radians(theta));
  
  Float[][] rotateZMatrix = {
    {cos,-sin,0.0,0.0},
    {sin,cos,0.0,0.0},
    {0.0,0.0,1.0,0.0},
    {0.0,0.0,0.0,1.0}
  };
  Float[][] rotatedZMatrix = multiplication(list.getLast(), rotateZMatrix); 
  list.add(rotatedZMatrix);
}

void Print_Matrix()
{
  Float[][] printMatrix = list.getLast();
  for (int i = 0; i < printMatrix.length; i++){
    System.out.print("[");
    for (int j = 0; j < printMatrix[i].length; j++) {
      System.out.print(printMatrix[i][j]);
      if (j < printMatrix[i].length - 1) {
        System.out.print(",");
      }
    }
    System.out.println("]");
  }
  System.out.println();
}

Float[][] multiplication(Float[][] identityMatrix, Float[][] multiplicand)
{
  Float[][] resultMatrix = {
    {0.0,0.0,0.0,0.0},
    {0.0,0.0,0.0,0.0},
    {0.0,0.0,0.0,0.0},
    {0.0,0.0,0.0,0.0}
  };
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 4; j++){
      for(int k = 0; k < 4; k++){
        resultMatrix[i][j] += identityMatrix[i][k] * multiplicand[k][j];
      }
    }
  }
  
  return resultMatrix;
}


void Perspective(float fov, float near, float far)
{
  check = "P";
  k = tan((radians(fov))/2.0);
}

void Ortho(float l, float r, float b, float t, float n, float f)
{
  check = "O";
  left = l;
  right = r;
  bottom = b;
  top = t;
  
}

void BeginShape()
{
  vertexList = new LinkedList<Float[]>();
}

void Vertex(float x, float y, float z)
{
  array = new Float[4][1];
  array[0][0] = x;
  array[1][0] = y;
  array[2][0] = z;
  array[3][0] = 1.0;
  
  Float[][] coordinates = multiplyVector(list.getLast(),array);
  x0 = coordinates[0][0];
  y0 = coordinates[1][0];
  z0 = coordinates[2][0];
  
  if (check == "P") {
    float xPrime = (x0 / abs(z0));
    float yPrime = (y0 / -abs(z0));
    
    float xDoublePrime = (xPrime + k) * (width / (2.0 * k));
    float yDoublePrime = (yPrime + k) * (height / (2.0 * k));
    
    Float[] persArray = {xDoublePrime, yDoublePrime, 0.0};    
    vertexList.add(persArray);
    
 } else {
     float xPrime = (x0 - left);
     float yPrime = (y0 - right);
     
     float xDoublePrime = (xPrime / (right - left)) * width;
     float yDoublePrime = (yPrime / (bottom - top)) * height;
     
     Float[] orthoArray = {xDoublePrime, yDoublePrime, 0.0};    
     vertexList.add(orthoArray);
 }
}

void EndShape()
{
  for (int i = 0; i < vertexList.size(); i+=2){
    float x0, x1, y0, y1;
    x0 =vertexList.get(i)[0];
    y0 =vertexList.get(i)[1];
    x1 =vertexList.get(i + 1)[0];
    y1 =vertexList.get(i + 1)[1];
    
    line(x0, y0, x1, y1);
  }
}

Float[][] multiplyVector(Float [][] identityMatrix, Float[][] multiplicand) {
  Float[][] resultMatrix = {
    {0.0},
    {0.0},
    {0.0},
    {0.0}
  };
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 1; j++){
      for(int k = 0; k < 4; k++){
        resultMatrix[i][j] += identityMatrix[i][k] * multiplicand[k][j];
      }
    }
  }
  
  return resultMatrix;
}
