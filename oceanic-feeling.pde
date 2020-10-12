import processing.video.*;
import processing.opengl.*;
import themidibus.*;

MidiBus myBus;
Capture video;
int iOffsetA = 0;
int iOffsetB = 0;
int iOffsetC = 0;
int iOffsetD = 1;
int iBlackness = 0;
int iShift;
int iVLines = 10;
int iHLines = 10;
boolean bReflectA = false;
boolean bReflectB = false;
int halflength;
Preset[] myPresets = new Preset[10];

void setup()
{
	size(screen.width,screen.height,OPENGL);
	background(0);
	colorMode(RGB, 255);
	myBus = new MidiBus(this, "nanoKontrol", "");
	video = new Capture(this, width,height, 30);
	halflength = (width * height) / 2;
}

void draw()
{
	if (video.available())
	 {   
		video.read();
		video.loadPixels();
		loadPixels();
		
		int i = halflength;
		while(i<video.pixels.length)
		{
			colorMode(RGB, 255);
			color c = video.pixels[i];
			pixels[i] = color((c>>iOffsetA) & 0xFF,(c>>(iOffsetB)) & 0xFF,(c>>(iOffsetC)) & 0xFF);
			colorMode(HSB, 255);
			pixels[i] = color((((hue(pixels[i]) + iShift % 256) % 256) * iOffsetD) % 256,saturation(pixels[i]) * 2 - 50,255);
			i +=1;
		}
		
		for (int j = halflength;j < pixels.length;j++)
		 {
			int iLoc = (j + (width - j % width)) - j % width;
			iLoc = iLoc>= pixels.length ? pixels.length - 1 : iLoc;
			pixels[j] = pixels[iLoc];
		}
		
		for (int j = 0;j < halflength;j++)
		 {
			pixels[j] = pixels[pixels.length - 1 - j];
		}
		
		updatePixels();
	}
}

void controllerChange(int channel, int number, int value)
{
	if (number == 97)
	 {
		iOffsetA = value / 4;
	}
	else if (number == 98)
	 {
		iOffsetB = value / 4;
	}
	else if (number == 99)
	 {
		iOffsetC = value / 4;
	}
	else if (number == 100)
	 {
		iShift = value * 2;
	}  
	else if (number == 104)
	 {
		iOffsetD = value / 32 + 1;
	}    
	else if (number == 1)
	 {
		iBlackness = value;
	}
	else if (number == 23)
	 {
		bReflectA = value>0 ? true : false;
	}
	else if (number == 24)
	 {
		bReflectB = value>0 ? true : false;
	}
}

void keyPressed()
{
	print("" + key);
	if (match("" + key,"[1234567890]")!= null)
	 {
		int whichPreset = Integer.parseInt("" + key);
		if (myPresets[whichPreset] == null)
		 {
			myPresets[whichPreset] = new Preset(iOffsetA, iOffsetB,iOffsetC,iShift,iOffsetD,iBlackness);
		}
		else
		 {
			iOffsetA = myPresets[whichPreset].iOffsetA;
			iOffsetB = myPresets[whichPreset].iOffsetB;
			iOffsetC = myPresets[whichPreset].iOffsetC;
			iShift = myPresets[whichPreset].iShift;
			iOffsetD = myPresets[whichPreset].iOffsetD;
			iBlackness = myPresets[whichPreset].iBlackness;
		}
	}
}


