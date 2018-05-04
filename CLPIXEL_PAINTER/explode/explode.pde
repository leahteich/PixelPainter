
PImage img;       // The source image
int cellsize = 2; // Dimensions of each cell in the grid
int columns, rows;   // Number of columns and rows in our system
int explodeVar = 100;
import controlP5.*;

ControlP5 cp5;

void setup() {
  size(640, 360, P3D); 
  img = loadImage("desktop/moon.jpg");  // Load the image
  cp5 = new ControlP5(this);
  columns = img.width / cellsize;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
  
  cp5.addSlider("cellsize")
    .setPosition(100, 20)
    .setSize(200, 19)
    .setRange(1, 5)
    .setValue(0)
    ;
 cp5.addSlider("explode")
    .setPosition(100, 50)
    .setSize(200, 19)
    .setRange(0, 1000)
    .setValue(0)
    ;
}

void cellsize(int val)
{
  cellsize = val;
  columns = img.width / cellsize;  // Calculate # of columns
  rows = img.height / cellsize;  // Calculate # of rows
}

void explode(int val)
{
   explodeVar = val;
}

void draw() {
  background(0);
  // Begin loop for columns
  for ( int i = 0; i < columns; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2;  // x position
      int y = j*cellsize + cellsize/2;  // y position
      int loc = x + y*img.width;  // Pixel array location
      color c = img.pixels[loc];  // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (explodeVar / float(width)) * brightness(img.pixels[loc]) - 20.0;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x + 200, y + 100, z);
      fill(c, 204);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
}