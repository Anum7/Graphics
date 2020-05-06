/******************************************************************************
Draw your initials here in perspective.
******************************************************************************/
//Anum Bhamani
//Initials: AB

void persp_initials()
{
  Init_Matrix();
  Perspective (35.0, 0.0, 0.0);
  Translate (0.0, 0.0, -12.0);
  RotateZ (20);
  myInitials();
}

void myInitials()
{
  BeginShape();
  
  // / of Letter A
  Vertex (-1.0, 1.0, -8.0);
  Vertex (-1.0, -1.5, 0.0);

  // \ of A
  Vertex (-1.0, 1.0, -8.0);
  Vertex ( 0.0, -2.5, -5.0);

  // - of A
  Vertex (-1.5, -1.3, -8.0);
  Vertex (-0.2, -1.3, -5.0);
  
  // | of B
  Vertex (0.25, 1.0, 1.0);
  Vertex (0.25, -1.0, 0.0);
  
  // top - of upper B
  Vertex (0.25, 1, 1.0);
  Vertex (1.25, 1, 0.0);
  
  // | of upper B
  Vertex (1.25, 0.9, 0.9);
  Vertex (1.26, 0.0, 0.0);

  // middle - of upper B
  Vertex (0.25, 0, 2.0);
  Vertex (1.25, 0, 0.0);

  
  // | of lower B
  Vertex (1.2, 0.0, 0.9);
  Vertex (1.2, -0.9, 0.0);

  // lower - of lower B
  Vertex (0.25, -1, 0.0);
  Vertex (1.26, -1, -1.0);
  
  EndShape();
}
