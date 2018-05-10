import controlP5.*;
ControlP5 cp5;

PImage img;
int x = 4;
int colval;

RadioButton options;

void setup() {
  size(757,568);
  cp5 = new ControlP5(this);
  img = loadImage("Tiger.jpeg"); 
  image(img,0,0);

  cp5.addSlider("colors")
   .setPosition(10,20)
   .setSize(100,15)
   .setRange(2,15)
   .setValue(10)
   ;
 cp5.addButton("reset")
   .setPosition(10,110)
   .setSize(100,15)
   ;
 options = cp5.addRadioButton("options")
         .setPosition(10,40)
         .setSize(20,20)
         .setItemsPerRow(1)
         .setSpacingColumn(50)
         .addItem("color",0)
         .addItem("greyscale",1)
         .addItem("threshold",2)
         ;
}

void draw(){}

void colors(int theValue) {
  x = theValue;
  colval = int(options.getValue());
  
  PImage edgeImg = createImage(img.width, img.height, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);
 
    int d = x - 1;
  if (colval == 1) {
    color c = color(0.2126 * r + 0.7152 * g + 0.0722 * b);
    img.pixels[i] = c;
    r = round(d * r / 255) * 255 / d;
    g = round(d * g / 255) * 255 / d;
    b = round(d * b / 255) * 255 / d;
    edgeImg.pixels[i] = color(r, g, b);
    }
 else if (colval == 2){
    r = 0.2126*r;
    g = 0.7152*g;
    b = 0.0722*b;
    float grayVal = r+g+b;
    grayVal = constrain(grayVal,0,255);
    if(grayVal >= theValue*20) 
       edgeImg.pixels[i] = color(0);
    else 
       edgeImg.pixels[i] = color(255);
     }
 else {
    r = round(d * r / 255) * 255 / d;
    g = round(d * g / 255) * 255 / d;
    b = round(d * b / 255) * 255 / d;
    edgeImg.pixels[i] = color(r, g, b);

   }
  }
  image(edgeImg, 0, 0); // Draw the new image
}

void reset() {
  setup();
}

    