import controlP5.*;
ControlP5 cp5;

PImage img;

float x = 8;
float y = 11;

void setup() {
  size(770,590);
  cp5 = new ControlP5(this);
  
  img = loadImage("Tiger.jpeg");
  background(255);
  //smooth();

  cp5.addSlider("DETAIL")
   .setPosition(10,20)
   .setSize(100,15)
   .setRange(2,20)
   .setValue(8)
   ;
  cp5.addSlider("SHAPE")
   .setPosition(10,40)
   .setSize(100,15)
   .setRange(0,20)
   .setValue(10)
   ; 
   

}

void DETAIL(float theValue) {
  pixelRound(x,y);
  x = theValue;

}

void SHAPE(float theValue) {
  y =  theValue;
  pixelRound(x,y);


}

void draw() {}

void pixelRound(float detail, float shape) {
    int i = 0;
    while (i < (21 - detail)*img.width) {
      i++;
      int x = int(random(img.width));
      int y = int(random(img.height));
      int loc = x + y*img.width;
      
      img.loadPixels();
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      noStroke();
      
      fill(r,g,b,100);
      rect(x,y,detail*2,detail*2,shape);
    }
}