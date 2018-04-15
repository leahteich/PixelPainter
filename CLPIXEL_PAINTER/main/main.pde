import controlP5.*;
PGraphics buffer; 

int x; 
int y;

boolean circleCreateNow = false;
boolean rectCreateNow = false;
boolean lineCreateNow = false;
boolean colorSelectNow = false;

ControlP5 cp5; //declaring it up here makes it global

int state = 0; //start on nothing
int r1 = 100; 
int g1 = 100; //color 1 settings
int b1 = 100;

int r2 = 255;
int g2 = 255; //color2 settings 
int b2 = 255;

int strokesize = 3;
int toolboxY = 205;
color c;

String letters = ""; //for text tool
int sizeFont = 20;


void setup() {

 size(1100, 700);
 
 ellipseMode(CORNERS);
 rectMode(CORNERS);
 buffer = createGraphics(width, height); 
 buffer.beginDraw();
 buffer.background(r2,g2,b2); //white by default

 buffer.fill(255);
 buffer.colorMode(RGB);
 //picker(20,20,0,10);
 rectMode(CORNERS);

 buffer.strokeWeight(3);
 buffer.background(255); 

 buffer.endDraw();

 cp5 = new ControlP5(this);
 cp5.addButton("pencil")
   .setPosition(15, toolboxY-6)
    .setImage(loadImage("icons/pencil.png"))
   .updateSize()
   ;
 cp5.addButton("erase")
   .setPosition(50, toolboxY-6)
   .setImage(loadImage("icons/eraser.png"))
   .updateSize()
   ;  
 cp5.addButton("spraypaint")
  .setPosition(85, toolboxY-6)
  .setImage(loadImage("icons/spray.png"))
  .updateSize()
  ; 
 cp5.addButton("clear")
   .setPosition(15,toolboxY+92)
   .setImage(loadImage("icons/clear.png"))
   .updateSize()
   ;  
  cp5.addButton("circle")
   .setImage(loadImage("icons/circle.png"))
   .setPosition(15, toolboxY+60)
   .updateSize()
   ;
  cp5.addButton("rectangle")
   .setPosition(15, toolboxY+28)
   .setImage(loadImage("icons/rect.png"))
   .updateSize();
   ;
  cp5.addButton("line")
   .setPosition(50, toolboxY+28)
   .setImage(loadImage("icons/line.png"))
   .updateSize();
   ;
  cp5.addButton("droplet")
   .setPosition(50, toolboxY+60)
   .setImage(loadImage("icons/dropper.png"))
   .updateSize();
   ;
 cp5.addButton("saveImg")
  .setPosition(50, toolboxY+92)
  .setImage(loadImage("icons/save.png"))
  .updateSize();
  ; 
 cp5.addButton("textbox")
  .setPosition(84, toolboxY+26)
  .setImage(loadImage("icons/text.png"))
  .updateSize();
  ; 
 cp5.addSlider("thickness")
   .setPosition(5, toolboxY+160)
   .setSize(60, 19)
   .setRange(0, 20)
   .setValue(5)
   ;
 cp5.addSlider("red1")
   .setPosition(5, toolboxY-190)
   .setSize(60, 15)
   .setRange(0, 255)
   .setValue(100)
   ;
 cp5.addSlider("green1")
   .setPosition(5, toolboxY-174)
   .setSize(60, 15)
   .setRange(0, 255)
   .setValue(100)
   ;
 cp5.addSlider("blue1")
   .setPosition(5, toolboxY-158)
   .setSize(60,15)
   .setRange(0, 255)
   .setValue(100)
   ; 

 cp5.addSlider("red2")
   .setPosition(5, toolboxY-100)
   .setSize(60, 15)
   .setRange(0, 255)
   .setValue(255)
   ;
   
 cp5.addSlider("green2")
   .setPosition(5, toolboxY-84)
   .setSize(60, 15)
   .setRange(0, 255)
   .setValue(255)
   ;
 cp5.addSlider("blue2")
   .setPosition(5, toolboxY-68)
   .setSize(60, 15)
   .setRange(0, 255)
   .setValue(255)
   ; 

}


void mouseDragged() {

  if (mouseX > 160 && state == 7) {
    float sprayx;
    float sprayy;
    float sd = strokesize;
    for (int m = 0; m<100; m++) {
        sprayx=randomGaussian(); 
        sprayy=randomGaussian(); 
        sprayx = sprayx * sd; 
        sprayy = sprayy * sd;
        buffer.beginDraw();
        buffer.stroke(r1,g1,b1); 
        buffer.point(mouseX+sprayx, mouseY+sprayy);
      }
      buffer.endDraw();
 }
 
 if (mouseButton == LEFT) { 
   buffer.beginDraw();

   if (state == 1) {
     buffer.colorMode(RGB);
     buffer.stroke(r1,g1,b1);
     buffer.strokeWeight(strokesize);
  
     buffer.endDraw();
   }
   
   if (mouseX > 160 && pmouseX > 160 && state == 1) {
     buffer.beginDraw();
     buffer.line(pmouseX, pmouseY, mouseX, mouseY);
     buffer.endDraw();
   }
     
   if (state == 2) {
     buffer.beginDraw();
     buffer.stroke(r2,g2,b2);
     buffer.strokeWeight(strokesize);
     if (mouseX > 160 && pmouseX > 160) {
        buffer.line(pmouseX, pmouseY, mouseX, mouseY);
      }
     buffer.endDraw();
    }
  }
   
  if (state == 1 && mouseButton == RIGHT) {
    buffer.beginDraw();
    buffer.stroke(r2,g2,b2);
    buffer.strokeWeight(strokesize);
    if (mouseX > 160 && pmouseX > 160) {
       buffer.line(pmouseX, pmouseY, mouseX, mouseY);
     }
    buffer.endDraw();
  }
   
 if (state == 3 || circleCreateNow == true) { //circle draw
   buffer.beginDraw();
   buffer.stroke(r1,g1,b1);
   buffer.fill(r2,g2,b2);
   buffer.strokeWeight(strokesize);
   buffer.endDraw();
 } 
 
 if (rectCreateNow || state == 4) {
   buffer.beginDraw();
   buffer.stroke(r1,g1,b1);
   buffer.fill(r2,g2,b2);
   buffer.strokeWeight(strokesize);
   buffer.endDraw();
 }
 
 if (lineCreateNow || state == 5) {
   buffer.beginDraw();
   buffer.stroke(r1,g1,b1);
   buffer.strokeWeight(strokesize);
   buffer.endDraw();
 }
}

void pencil() {
 buffer.beginDraw();
 buffer.stroke(r1,g1,b1);
 state = 1;
 buffer.strokeWeight(strokesize);
 circleCreateNow = false;
 rectCreateNow = false;
 lineCreateNow = false;
 colorSelectNow = false;

 buffer.endDraw();
}

void erase() {
 buffer.beginDraw();
 state = 2;
 buffer.strokeWeight(strokesize);
 buffer.stroke(r2, g2, b2);
 circleCreateNow = false;
 rectCreateNow = false;
 lineCreateNow = false;
 colorSelectNow = false;

 buffer.endDraw();
}

void spraypaint() {
  buffer.beginDraw();
  state = 7;
  lineCreateNow = false;
  circleCreateNow = false;
  rectCreateNow = false;
  colorSelectNow = false;

  buffer.stroke(r1,g1,b1);
  buffer.endDraw();
}

void droplet() {
  buffer.beginDraw();
  state = 6;
  lineCreateNow = false;
  circleCreateNow = false;
  rectCreateNow = false;
  colorSelectNow = true;
  
  c = get(mouseX, mouseY);
  buffer.fill(c);
  
  buffer.endDraw();
}

void textbox() {
  lineCreateNow = false;
  circleCreateNow = false;
  rectCreateNow = false;
  colorSelectNow = false;
  state = 8;
  
}

void red1(int theValue) {
 r1 = theValue;
} void green1(int theValue) {
 g1 = theValue;
} void blue1(int theValue) {
 b1 = theValue;
}

void red2(int theValue) {
 r2 = theValue;
} void green2(int theValue) {
 g2 = theValue;
} void blue2(int theValue) {
 b2 = theValue;
}

void thickness(int theValue) {
 strokesize = theValue;
}

void circle() {
 circleCreateNow = true;
 rectCreateNow = false;
 lineCreateNow = false;
 colorSelectNow = false;
 state = 3;
 ellipseMode(CORNERS);
}

void rectangle() {
  circleCreateNow = false;
  lineCreateNow = false;
  rectCreateNow = true;
  colorSelectNow = false;
  state = 4;
  rectMode(CORNERS);
}

void line() {
  circleCreateNow = false;
  rectCreateNow = false;
  lineCreateNow = true;
  colorSelectNow = false;
  state = 5;
}

void saveImg() {  //save image
  save("drawing"+random(1000)+".jpg");
}

void draw() {

 image(buffer, 0, 0);

 cursor(ARROW);
 buffer.beginDraw();
 buffer.stroke(c);
 
 buffer.rectMode(CORNER);
 buffer.fill(0,0,244); //drawing blue toolbar
 buffer.noStroke();
 buffer.rect(0,0,160,1000); // blue toolbar
 
 if (mouseX > 160) {
   buffer.rect(10,510,60,30);
   buffer.fill(255);
   buffer.textSize(15);
   buffer.text(mouseX - 160 +" , "+mouseY, 10,590);
   }
 
 buffer.strokeWeight(1);
 buffer.stroke(255);
 buffer.fill(r1,g1,b1);
 buffer.rect(125,30,30,30);

 buffer.fill(r2,g2,b2);
 buffer.rect(125,115,30,30);

 buffer.fill(255);
 buffer.rect(13,295,28,28,5); //clear
 buffer.rect(47,295,28,28,5); //save
 buffer.rect(13,262,28,28,5); //circle
 buffer.rect(47,262,28,28,5); //dropper
 buffer.rect(13,229,28,28,5); //rect
 buffer.rect(47,229,28,28,5); //line
 buffer.rect(13,196,28,28,5); //pencil
 buffer.rect(47,196,28,28,5); //eraser
 buffer.rect(81,196,28,28,5); //spraypaint
 buffer.rect(81,229,28,28,5); //text

 rectMode(CORNERS);
 buffer.endDraw();
 if (mousePressed && circleCreateNow && mouseX > 160) {
    strokeWeight(strokesize);
    stroke(r1,g1,b1);
    fill(r2,g2,b2);
    ellipse(x,y,mouseX, mouseY);
 }
 
  if (state == 8) {
    fill(0);
    float cursorPosition = textWidth(letters);
    strokeWeight(3);
    
    line(cursorPosition+textposX,textposY-(2*strokesize), cursorPosition+textposX,textposY+(2*strokesize)); //cursor for text
  
    fill(r1,g1,b1);
    stroke(r1,g1,b1);
    textSize(strokesize * 4);
    text(letters, textposX, textposY); //preview text

  }
  
  
 if (mousePressed && lineCreateNow && mouseX > 160) {
   strokeWeight(strokesize);
   stroke(r1,g1,b1);
   line(x,y,mouseX,mouseY);
 }
 
  if (mousePressed && rectCreateNow && mouseX > 160) {
    rectMode(CORNERS);
    stroke(r1,g1,b1);
    fill(r2,g2,b2);
    strokeWeight(strokesize);
    rect(x,y,mouseX,mouseY);
  }
  
  if (mouseX > 160) {
    if (rectCreateNow || circleCreateNow || lineCreateNow) {
      cursor(CROSS);
    }
    else if (colorSelectNow) {
      cursor(HAND);
    }
    else if (state == 8) {
      cursor(TEXT);
    }
  }
  else {
    cursor(ARROW);
  }
  
   //if (mouseX > 0 && mouseX < 160 && mouseY > 0 && mouseY < 170) {
     //if (mousePressed) {
   //  getColor();
//   }
// }
}

float textposX;
float textposY;

void keyPressed() {
  if (key == BACKSPACE) {
    if (letters.length() > 0) {
      letters = letters.substring(0, letters.length()-1);
    }
  } else if (textWidth(letters+key) < width) {
    if (keyCode != SHIFT && keyCode != ENTER) {
    letters = letters + key;
    } else if (keyCode == ENTER) {
       buffer.beginDraw();
       buffer.fill(r1,g1,b1);
       buffer.stroke(r1,g1,b1);
       buffer.textSize(strokesize * 4);
       buffer.text(letters, textposX, textposY);
       buffer.endDraw();
       state = 0;
       letters = "";
    }
  }
}

void mousePressed() {
 x = mouseX;
 y = mouseY;

 if (mouseX > 160) {
   if (state == 8) {
     textposX = mouseX;
     textposY = mouseY;
   }
   
   
   if (colorSelectNow && mouseButton == LEFT ) {
     c = get(mouseX, mouseY);
     r1=(c>>16)&255;
     g1=(c>>8)&255;
     b1=c&255; 
     println("Color 1("+r1+","+g1+","+b1+")");
     buffer.fill(r1,g1,b1);
    }
    
   if (colorSelectNow && mouseButton == RIGHT ) {
     c = get(mouseX, mouseY);
     r2=(c>>16)&255;
     g2=(c>>8)&255;
     b2=c&255; 
     println("Color 2 ("+r2+","+g2+","+b2+")");
     buffer.fill(r2,g2,b2);
    }
  }
}

void mouseReleased() {
 if (circleCreateNow){
   buffer.beginDraw();
   buffer.ellipseMode(CORNERS);
   buffer.stroke(r1,g1,b1);
   buffer.strokeWeight(strokesize);
   buffer.fill(r2,g2,b2);
   
   if (mouseX > 160) {
     buffer.ellipse(x, y, mouseX, mouseY);
     }
   buffer.endDraw();
  }
 
 if (rectCreateNow) {
  buffer.beginDraw();
  buffer.rectMode(CORNERS);
  buffer.stroke(r1,g1,b1);
  buffer.strokeWeight(strokesize);
  buffer.fill(r2,g2,b2);
   
  if (mouseX > 160) {
    buffer.rect(x, y, mouseX, mouseY);
  }
 }
  if (lineCreateNow) {
    buffer.beginDraw();
    buffer.stroke(r1,g1,b1);
    buffer.strokeWeight(strokesize);
  
    if (mouseX > 160) {
      buffer.line(x, y, mouseX, mouseY);
    }
  }
  buffer.endDraw();
 }

void clear() { //doesn't work
   buffer.beginDraw();
   buffer.noStroke();
   
   buffer.fill(r2, g2, b2);
   buffer.rect(160,0,1000, 1000);
   buffer.endDraw();
   }




/*
color getColor() {
 color c = get(mouseX, mouseY);
 stroke(c);
 fill(c);
 rect(40,400,40,40);
 return c;
}

void picker(int x, int y, int state, float step) {
 noStroke();
 float max = step*16;
 colorMode(HSB, max);
 fill(.6*max);
 noFill();
 float s = 0;
 if (state == 0)
 {
 for (float h = 0; h < max; h = h + 1) 
 {
     for(float b= 0; b<max; b = b+1)
     { if (b < .4*max) {
       s = b*3;
     } else {
       s = max;
     }
     stroke(h,  s, max-b);
     point(h,b);
     } 
 }

 for (float i = 0; i < max; i = i + 1) {
   noStroke();
   fill(0,0,i);
   rect(i, max, 1, step);

   } 

 }
 /*else {
   for (float h = 0; h < max; h = h + 1) 
 {
     for(float b= 0; b<max; b = b+1)
     {
     if (b < .4*max)
     {
       s = b*3;
     }
     else {
       s = max;
     }
     fill(h,  s, max-b);
     if (b%step == 0 && h%step == 0)
     {
     stroke(0);
     rect(x + h, y + b, step, step);
     //point(x + h, y + b);`
     }
     } 
 } 
 for (float i = 0; i < max; i = i + 1)
 {
   fill(0,0,i);
   if (i%step == 0 && i%step == 0)
   {
   rect(x+i, y + max + 10, step, step);
   }
 }
 } */

  