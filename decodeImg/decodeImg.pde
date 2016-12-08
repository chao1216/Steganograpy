/*
Chao Lin
CS 276 - Project 1
Professor Carl
October 24, 2016

********EXTRA CREDIT*******
decodeImg:
this sketch extracts the hidden image from a cover image
basic idea: extract the least significant 4 bits of each color value
and shift them left 4 bits to get the hidden image.
*/

PImage hiddenImg;

void setup(){
  hiddenImg = loadImage("hiddenImg.png");
  size(hiddenImg.width, hiddenImg.height/2);
  
  //image with hidden img
  image(hiddenImg, 0, 0, hiddenImg.width/2, hiddenImg.height/2);
  
  decodeImage(hiddenImg);
  
  //displays the hidden img
  image(hiddenImg, hiddenImg.width/2, 0, hiddenImg.width/2, hiddenImg.height/2);
}

void decodeImage(PImage img){
  img.loadPixels();
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      color c = img.get(x,y);
      
      //getting the 4 hidden bits of the hidden image
      int hiddenRed = (getRed(c) & 0x0F) << 4;
      int hiddenGreen = (getGreen(c) & 0x0F) << 4;
      int hiddenBlue = (getBlue(c) & 0x0F)<< 4;
      
      c = color(hiddenRed, hiddenGreen, hiddenBlue);
      
      img.set(x,y,c);
    }
  }
  img.updatePixels();
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
