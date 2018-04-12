import controlP5.*;
ControlP5 cp5;

int toolboxY = 200;


void setup()
{
  cp5 = new ControlP5(this);
  
  size(1000,1000);
  colorMode(HSB, width, 100, 100);
  picker(20,20,0,10);
  
  cp5.addButton("pencil")
    .setPosition(5, toolboxY)
    .setSize(60, 19)
    ;
  
}

void draw()
{
  if (mouseX > 0 && mouseX < 160 && mouseY > 0 && mouseY < 170)
  {
    if (mousePressed == true)
    {
      getColor();
    }
  }
  
}

void getColor()
{
  color c = get(mouseX, mouseY);
  fill(c);
  rect(0,220,40,40);
}

void picker(int x, int y, int state, float step) {
  noStroke();
  float max = step*16;
  colorMode(HSB, max);
  fill(.6*max);
  //rect(x-20, y-20, max+40, max+50);
  noFill();
  float s = 0;
  if (state == 0)
  {
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
      stroke(h,  s, max-b);
      point(h,b);
      } 
  }
  
  for (float i = 0; i < max; i = i + 1)
  {
    noStroke();
    fill(0,0,i);
    rect(i, max, 1, step);
  } 
  
  }
  else {
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
  }
}