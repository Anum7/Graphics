//Anum Bhamani
//Project 1A: Transformation Matrices

import java.util.LinkedList;

LinkedList<Float[][]> list;

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
