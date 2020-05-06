// Warm-Up Project
//Anum Bhamani
int level = 5;
void setup()
{
  size (600, 600); 
}

void draw() {
  background (255, 255, 255); 
  noStroke(); 

  translate(300,300);
  
  // draw a center square
  float rectWidth = width / 3;
  float rectHeight = height / 3;
  
  //origin of center square
  float centerX = 0 - (rectWidth/2);
  float centerY = 0 - (rectHeight/2); 
  
  float squareWidth = rectWidth / 2.0;
  float squareHeight = rectHeight / 2.0;
  
  float mX = mouseX - 300;
  float mY = mouseY - 300;
  
  float s = mX - (squareWidth/2);
  float t = mY-(squareHeight/2);
  
  float offsetX = s - centerX;
  float offsetY = t - centerY;
  
  if (level > 1) {
    rect(s, t, squareWidth, squareHeight);  //first square  
    drawSquare(squareWidth,centerX,centerY, offsetX, offsetY, level);
  }
  
  fill(56,25,26);
  rect (0 - (rectWidth/2), 0 - (rectWidth/2), rectWidth, rectHeight);
}
 
void drawSquare(float parentWidth, float originX, float originY, float offX, float offY, int curr){
   if (curr <= 5 && curr > 0){
    float origX0 = originX + offX;
    float origY0 = originY + offY;
    fill(40, 128, 30);
    rect(origX0, origY0, parentWidth, parentWidth);
    
    float origX1 = originX + offY;
    float origY1 = originY - offX + parentWidth;
    fill(247, 247, 84);
    rect(origX1, origY1, parentWidth, parentWidth); 
    
    float origX2 = originX - offX + parentWidth;
    float origY2 = originY - offY + parentWidth;
    fill(30, 43, 128);
    rect(origX2, origY2, parentWidth, parentWidth); 
    
    float origX3 = originX - offY + parentWidth;
    float origY3 = originY + offX;
    fill(128, 30, 43);
    rect(origX3, origY3, parentWidth, parentWidth);
  }
  
  curr--;
  
  //a recursive call on each of the 4 squares.
  if (curr==4 || curr == 2 || curr == 3) {
    float origX0 = originX + offX;
    float origY0 = originY + offY;
    drawSquare(parentWidth/2, origX0, origY0, offX/2, offY/2, curr);
    
    float origX1 = originX + offY;
    float origY1 = originY - offX + parentWidth;
    drawSquare(parentWidth/2, origX1, origY1, offX/2, offY/2, curr);
    
    float origX2 = originX - offX + parentWidth;
    float origY2 = originY - offY + parentWidth;
    drawSquare(parentWidth/2, origX2, origY2, offX/2, offY/2, curr);
    
    float origX3 = originX - offY +parentWidth;
    float origY3 = originY + offX;
    drawSquare(parentWidth/2, origX3, origY3, offX/2, offY/2, curr);
  }
}
