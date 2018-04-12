
//import controlP5 and create an object to add buttons
import controlP5.*;
PGraphics circles;
int x;
int y;

ControlP5 cp5; //declaring it up here makes it global


void setup() {
  ellipseMode(CORNERS);
  size(400, 400);
  
  //buffer
  circles = createGraphics(width, height); 
  circles.beginDraw();
  circles.background(255);
  circles.endDraw();
  noCursor();
}

void draw()
{
  image(circles, 0, 0);
  if (mousePressed)
  {
    noFill();
    ellipse(x, y, mouseX, mouseY);
  }
  stroke(0);
  line(mouseX, mouseY + 5, mouseX, mouseY - 5);
  line(mouseX + 5, mouseY, mouseX - 5, mouseY);
  fill(0);

}

void mousePressed() {
  x = mouseX;
  y = mouseY;

}

void mouseReleased() {
  circles.beginDraw();
  circles.ellipseMode(CORNERS);
  circles.noFill();
  circles.ellipse(x, y, mouseX, mouseY);
  circles.endDraw();
}