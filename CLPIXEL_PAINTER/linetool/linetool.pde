
import controlP5.*;
PGraphics rect;
int x;
int y;
ControlP5 cp5; 
void setup() {
  size(400, 400);
  rect = createGraphics(width, height); 
  rect.beginDraw();
  rect.background(255);
  rect.endDraw();
}

void draw() {
  image(rect, 0, 0);
  if (mousePressed) {
    line(x, y, mouseX, mouseY);
  }
  stroke(0);
  line(mouseX, mouseY + 5, mouseX, mouseY - 5);
  line(mouseX + 5, mouseY, mouseX - 5, mouseY);
  fill(255);

}

void mousePressed() {
  x = mouseX;
  y = mouseY;

}

void mouseReleased() {
  rect.beginDraw();
  rect.rectMode(CORNERS);
  rect.line(x, y, mouseX, mouseY);
  rect.endDraw();
}