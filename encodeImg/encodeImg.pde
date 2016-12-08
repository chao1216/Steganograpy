/*
Chao Lin
CS 276 - Project 1
Professor Carl
October 24, 2016

********EXTRA CREDIT*******
encodeImg:
this sketch hides an image within another img
basis idea: replace least significant 4 bits of cover image
with the most significant 4 bits of hidden imga
*/

PImage coverImg, hiddenImg;

void setup(){
  coverImg = loadImage("chao.png");
  hiddenImg = loadImage("rabbit.png");
  size(coverImg.width, coverImg.height/2);
  
  //cover image before encoding
  image(coverImg, 0, 0, coverImg.width/2, coverImg.height/2);
  
  encodeImage(coverImg, hiddenImg);
  
  //cover image encoded with a hidden image
  image(coverImg, coverImg.width/2, 0, coverImg.width/2, coverImg.height/2);
  
}

void encodeImage(PImage coverImg, PImage secretImg){
  coverImg.loadPixels();
  secretImg.loadPixels();
  
  if(secretImg.width*secretImg.height > coverImg.width*coverImg.height){
    throw new Error("hidden image is too big!");
  }else{
    for(int x = 0; x < secretImg.width; x++){
      for(int y = 0; y < secretImg.height; y++){
        color c1 = coverImg.get(x,y); //color for cover Image
        color c2 = secretImg.get(x,y); //color for hidden Image
   
        //set the least significant 4 bits of cover image to 0
        int red1 = getRed(c1) & 0xF0;
        int green1 = getGreen(c1) & 0xF0;
        int blue1 = getBlue(c1) & 0xF0;
        
        //shift the most significant 4 bits of hidden image to right 4 places
        int red2 = getRed(c2) >> 4;
        int green2 = getGreen(c2) >> 4;
        int blue2 = getBlue(c2) >> 4;
      
        //add the two modified color values to combine them
        int newRed = red1 + red2;
        int newGreen = green1 + green2;
        int newBlue = blue1 + blue2;
      
        c1 = color(newRed, newGreen, newBlue);
        
        coverImg.set(x,y,c1); 
      }
    }
    coverImg.updatePixels();
    coverImg.save("hiddenImg.png");
  }
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
