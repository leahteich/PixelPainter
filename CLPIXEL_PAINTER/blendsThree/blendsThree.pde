import controlP5.*;
ControlP5 cp5;

/* The math behind blending
 
 A = pixels[]
 B = img.pixels[]
 
 ChannelBlend_Normal(A,B)     (A)
 ChannelBlend_Lighten(A,B)    ((B > A) ? B:A)
 ChannelBlend_Darken(A,B)     ((B > A) ? A:B)
 ChannelBlend_Multiply(A,B)   ((A * B) / 255)
 ChannelBlend_Average(A,B)    ((A + B) / 2)
 ChannelBlend_Add(A,B)        (min(255, (A + B)))
 ChannelBlend_Subtract(A,B)   ((A + B < 255) ? 0:(A + B - 255))
 ChannelBlend_Difference(A,B) (abs(A - B))
 ChannelBlend_Negation(A,B)   (255 - abs(255 - A - B))
 ChannelBlend_Screen(A,B)     (255 - (((255 - A) * (255 - B)) >> 8))
 ChannelBlend_Exclusion(A,B)  (A + B - 2 * A * B / 255)
 ChannelBlend_Overlay(A,B)    ((B < 128) ? (2 * A * B / 255):(255 - 2 * (255 - A) * (255 - B) / 255))
 ChannelBlend_SoftLight(A,B)  ((B < 128)?(2*((A>>1)+64))*((float)B/255):(255-(2*(255-((A>>1)+64))*(float)(255-B)/255)))
 ChannelBlend_HardLight(A,B)  (ChannelBlend_Overlay(B,A))
 ChannelBlend_ColorDodge(A,B) ((B == 255) ? B:min(255, ((A << 8 ) / (255 - B))))
 ChannelBlend_ColorBurn(A,B)  ((B == 0) ? B:max(0, (255 - ((255 - A) << 8 ) / B)))
 ChannelBlend_LinearDodge(A,B)(ChannelBlend_Add(A,B))
 ChannelBlend_LinearBurn(A,B) (ChannelBlend_Subtract(A,B))
 ChannelBlend_LinearLight(A,B)(B < 128)?ChannelBlend_LinearBurn(A,(2 * B)):ChannelBlend_LinearDodge(A,(2 * (B - 128)))
 ChannelBlend_VividLight(A,B) (B < 128)?ChannelBlend_ColorBurn(A,(2 * B)):ChannelBlend_ColorDodge(A,(2 * (B - 128)))
 ChannelBlend_PinLight(A,B)   (B < 128)?ChannelBlend_Darken(A,(2 * B)):ChannelBlend_Lighten(A,(2 * (B - 128)))
 ChannelBlend_HardMix(A,B)    ((ChannelBlend_VividLight(A,B) < 128) ? 0:255))
 ChannelBlend_Reflect(A,B)    ((B == 255) ? B:min(255, (A * A / (255 - B))))
 ChannelBlend_Glow(A,B)       (ChannelBlend_Reflect(B,A))
 ChannelBlend_Phoenix(A,B)    (min(A,B) - max(A,B) + 255)
 ChannelBlend_Alpha(A,B,O)    (O * A + (1 - O) * B)
 ChannelBlend_AlphaF(A,B,F,O) (ChannelBlend_Alpha(F(A,B),A,O))
 */

PImage img;
float m;
float sd;
boolean negate = false;
boolean exclusion = false;
boolean phoenix = false;

void setup() {
  size(640, 480);
  cp5 = new ControlP5(this);

  img = loadImage("Tiger.jpg");
  img.resize(img.width / 4, img.height / 4);
  background(255);

  image(img, 0, 0);

  //loadPixels();
  //randomCanvas()
  //randGaussCanvas(200,25)
  //noisyCanvas(.1);
  //updatePixels();
  //img.loadPixels();

  cp5.addButton("RESET")
    .setPosition(10, 60)
    .setSize(100, 15)
    .setValue(10)
    ;
  /*cp5.addButton("randomCanvas")
   .setPosition(10, 80)
   .setSize(100, 15)
   .setValue(10)
   ; */
  cp5.addSlider("m")
    .setPosition(10, 100)
    .setSize(100, 15)
    .setRange(0, 200)
    .setValue(10)
    ;
  cp5.addSlider("sd")
    .setPosition(10, 120)
    .setSize(100, 15)
    .setRange(0, 200)
    .setValue(10)
    ;
  cp5.addButton("negate")
    .setPosition(10, 140)
    .setSize(100, 15)
    .setValue(10)
    ;

  cp5.addButton("exclusion")
    .setPosition(10, 160)
    .setSize(100, 15)
    .setValue(10)
    ;
  cp5.addButton("phoenix")
    .setPosition(10, 180)
    .setSize(100, 15)
    .setValue(10)
    ;
  //negate();
  //blend(img, 0, 0, img.width, img.height, 0, 0, width, height, LIGHTEST);
  //BLEND | DARKEST | LIGHTEST | DIFFERENCE | MULTIPLY| EXCLUSION | SCREEN | REPLACE | OVERLAY | HARD_LIGHT | SOFT_LIGHT | DODGE | BURN | ADD | NORMAL
  negate = false;
  exclusion = false;
  phoenix = false;
}

//((B > A) ? B:A))
//ChannelBlend_Negation(A,B)   (255 - abs(255 - A - B))

void negate() {
  negate = true;
  exclusion = false;
  phoenix = false;
}

//ChannelBlend_Exclusion(A,B)  (A + B - 2 * A * B / 255)
void exclusion() {
  negate = false;
  exclusion = true;
  phoenix = false;
}

void phoenix()
{
  negate = false;
  exclusion = false;
  phoenix = true;
}

void randGaussCanvas(float m, float sd) {

  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color(randomGaussian()*sd + m);
  }
  updatePixels();
}

void m(int val) {
  m = val;
}

void sd(int val) {
  sd = val;
}

void draw() {
  randGaussCanvas(m, sd);
  if (negate)
  {
    loadPixels();
    for (int i = 0; i < pixels.length; i++) {
      color c = 255 - abs(255 - pixels[i] - img.pixels[i]);
      pixels[i] = c;
    }
    updatePixels();
  } else if (exclusion) {
    loadPixels();
    for (int i = 0; i < pixels.length; i++) {
      color c = (pixels[i] + img.pixels[i] - 2 * pixels[i] * img.pixels[i] / 255);
      pixels[i] = c;
    }
    updatePixels();
  } else if (phoenix) { //ChannelBlend_Phoenix(A,B)    (min(A,B) - max(A,B) + 255)
    loadPixels();
    for (int i = 0; i < pixels.length; i++) {
      color c = min(pixels[i], img.pixels[i]) - max(pixels[i], img.pixels[i]) + 255;
      pixels[i] = c;
    }
    updatePixels();
  } else
  {
    RESET();
  }
}

void RESET() {
  negate = false;
  exclusion = false;
  phoenix = false;
  image(img, 0, 0);
  sd = 0;
  m = 0;
}