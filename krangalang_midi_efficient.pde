import processing.video.*;
import processing.opengl.*;
import themidibus.*;

MidiBus myBus;
MovieMaker mm;
PImage img;
PImage img2;
Capture myMovie;
int iOffsetA=0;
int iOffsetB=0;
int iOffsetC=0;
int iOffsetD=1;
int iBlackness=0;
int iShift;
int iVLines=10;
int iHLines=10;
boolean bReflectA=false;
boolean bReflectB=false;

void setup()
{
  size(800,600,OPENGL);
  background(0);
  colorMode(RGB, 255);
  myBus = new MidiBus(this, "nanoKONTROL", "");
  myMovie = new Capture(this, width,height);
}

void draw()
{
  if(myMovie.available())
  {   
    myMovie.read();
    myMovie.loadPixels();}
    loadPixels();

    color c;
    int i=0;
    while(i<myMovie.pixels.length)
    {       
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255); 
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);      
      i+=1;
      
      colorMode(RGB, 255);
      c = myMovie.pixels[i];
      pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC))& 0xFF);
      colorMode(HSB, 255);
      pixels[i] = color((((hue(pixels[i])+iShift%256)%256)*iOffsetD)%256,saturation(pixels[i])*2-50,255);

      i+=1;
    }
    
    for(int j=0;j<pixels.length;)
    {
      int iLoc;
      
      iLoc=(j+(width-j%width))-j%width;
      iLoc=iLoc>=pixels.length?pixels.length-1:iLoc;
      pixels[j]=pixels[iLoc];
      j+=1;
      
      iLoc=(j+(width-j%width))-j%width;
      iLoc=iLoc>=pixels.length?pixels.length-1:iLoc;
      pixels[j]=pixels[iLoc];
      j+=1;
      
      iLoc=(j+(width-j%width))-j%width;
      iLoc=iLoc>=pixels.length?pixels.length-1:iLoc;
      pixels[j]=pixels[iLoc];
      j+=1;
      
      iLoc=(j+(width-j%width))-j%width;
      iLoc=iLoc>=pixels.length?pixels.length-1:iLoc;
      pixels[j]=pixels[iLoc];
      j+=1;
    }
    
    for(int j=0;j<pixels.length;)
    {
      pixels[j]=pixels[pixels.length-1-j];
      j+=1;
      
      pixels[j]=pixels[pixels.length-1-j];
      j+=1;
      
      pixels[j]=pixels[pixels.length-1-j];
      j+=1;
      
      pixels[j]=pixels[pixels.length-1-j];
      j+=1;    
    }

    updatePixels();
    System.gc();
}

void controllerChange(int channel, int number, int value)
{
  if (number==2)
  {
    iOffsetA=value/4;
  }
  else if (number==3)
  {
    iOffsetB=value/4;
  }
  else if (number==4)
  {
    iOffsetC=value/4;
  }
  else if (number==5)
  {
    iShift=value*2;
  }  
  else if (number==6)
  {
    iOffsetD=value/32+1;//iVLines=value/16+2;
  }    
  else if (number==8)
  {
    iBlackness=value;//iHLines=value/16+2;
  }
  else if (number==23)
  {
    bReflectA=value>0?true:false;
  }
  else if (number==24)
  {
    bReflectB=value>0?true:false;
  }
}

