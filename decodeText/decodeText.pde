/*
Chao Lin
CS 276 - Project 1
Professor Carl
October 24, 2016

decodeText:
this sketch does the following
1)extract the length of the hidden message
2)inverse the steganographic technique to reconstuct the hidden message
3)display the message
*/

PImage img;
char[] msgChar;
String msg = "";
int msgLength;

void setup(){
  img = loadImage("encodedMe.png");
  img.loadPixels();
  size(img.width, img.height);
  
  decode(img);
}

void decode(PImage img){
  color c = img.get(0,0);
  //gets the length of hidden message from first pixel encoded as red value 
  msgLength = (int)red(c);
  
  msgChar = new char[msgLength];
  
  for(int i = 0; i < msgLength; i++){
    c = img.get(i+1,0);
    
    int red = getRed(c);
    int green = getGreen(c);
    int blue = getBlue(c);
    
    int ch1 = (red & 0x3) << 6;
    int ch2 = (green & 0x7) << 3;
    int ch3 = blue & 0x7;
    
    int ch = ch1 + ch2 + ch3;
    
    msgChar[i] = (char)ch;
    
    msg += msgChar[i];
  }
  
  textSize(20);
  fill(0);
  text(msg, 0, height/2);
}

int getRed(color pixel){
  int redValue = (pixel >> 16) & 0xFF;
  return redValue;
}

int getGreen(color pixel){
  int greenValue = (pixel >> 8) & 0xFF;
  return greenValue;
}

int getBlue(color pixel){
  int blueValue = pixel & 0xFF;
  return blueValue;
}
