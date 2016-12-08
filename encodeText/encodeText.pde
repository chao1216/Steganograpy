/*
Chao Lin
CS 276 - Project 1
Professor Carl
October 24, 2016

encodeText:
this sketch does the following
1) open a text file containing message to hide
2) open an image file in which to hide the message
3) ensure image file is large enough
4) store length of message in first pixel of the image
5) store rest of the message into the pixel of the image 
6) saves the encoded image
*/

PImage img;
String[] msg;
char[] msgChar;
int msgLength;

void setup(){ 
  
  img = loadImage("chao.png");
  img.loadPixels();
  msg = loadStrings("msg.txt");
  
  size(img.width, img.height);
  image(img,0,0);
  
  msgLength = msg[0].length();
  msgChar = new char[msgLength];
  
  //encodes message to the image
  encode(msgChar, img, msgLength);
}

void encode(char[] msgChar, PImage img, int msgLength){
  //checks if message length is too large
  if(msgLength > img.width){
    throw new Error("message is too long");
  }else{
    color c = img.get(0,0);
    //replace red value of first pixel to message length
    c = color(msgLength, green(c), blue(c)); 
    img.set(0,0,c);
    
    for(int i = 0; i < msgLength; i++){
      msgChar[i] = msg[0].charAt(i);
      
      //i+1 because we want i to be encode the length of message
      c = img.get(i+1,0);
    
      //convert last neceesary bits to 0 for RGB
      c = c & 0xFCF8F8;
    
      int red = getRed(c);
      int green = getGreen(c);
      int blue = getBlue(c);

      int ch1 = getCh1(msgChar[i]);
      int ch2 = getCh2(msgChar[i]);
      int ch3 = getCh3(msgChar[i]);
    
      //combining ch bits with least significant bits of red, green and blue (2:3:3)
      int redCh = red | ch1;
      int greenCh = green | ch2;
      int blueCh = blue | ch3;
   
      //replacing the 2-bit pieces to the end of each RGB bits
      c = color(redCh, greenCh, blueCh);

      img.set(i+1,0,c);
    }
  
    img.updatePixels();
  
    img.save("encodedMe.png");  
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

//getCh functions split each character into 3 pieces (2-bit, 3-bit, 3-bit)
//---------------------//
int getCh1(char ch){
  int ch1 = ch >> 6;
  return ch1;
}

int getCh2(char ch){
  int ch2 = (ch & 0x38) >> 3;
  return ch2;
}

int getCh3(char ch){
  int ch3 = ch & 0x7;
  return ch3;
}
//---------------------//
