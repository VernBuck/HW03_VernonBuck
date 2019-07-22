# 1 "myLib.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "myLib.c"
# 1 "myLib.h" 1
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
# 25 "myLib.h"
extern unsigned short *videoBuffer;
# 41 "myLib.h"
void setPixel(int, int, unsigned short);
void drawRect(int row, int col, int height, int width, volatile unsigned short color);
void waitForVblank();
int genericCollision(int r1, int c1, int w1, int h1, int r2, int c2, int w2, int h2);
void bounds();
# 2 "myLib.c" 2

unsigned short *videoBuffer = ((unsigned short *)0x6000000);

void setPixel(int row, int col, unsigned short color) {
 videoBuffer[((row)*(240)+(col))] = color;
}


void drawRect(int row, int col, int height, int width, unsigned short color) {
 for(int r = 0; r < height; r++) {
  for(int c = 0; c < width; c++) {
   setPixel(row + r, col + c, color);
  }
 }
}


void waitForVblank() {
 while((*(volatile unsigned short *)0x4000006) > 160);
 while((*(volatile unsigned short *)0x4000006) < 160);
}



int genericCollision(int r1, int c1, int w1, int h1, int r2, int c2, int w2, int h2) {
 int topAboveBottom = r1 <= r2+h2 && r1 >= r2;
 int box2VerticalAligned = c1 < c2+w2 && c1+w1 > c2;

 if(topAboveBottom && box2VerticalAligned) return 0;

 int bottomBelowTop = r1+h1 >= r2 && r1+h1 <= r2+h2;

 if(bottomBelowTop && box2VerticalAligned) return 2;

 int box2HorizontalAligned = r1 < r2+h2 && r1+h1 > r2;
 int leftPastRight = c1 <= c2+w2 && c1 >= c2;

 if(box2HorizontalAligned && leftPastRight) return 3;

 int rightPastleft = c1+w1 >= c2 && c1+w1 <= c2+w2;

 if(box2HorizontalAligned && rightPastleft) return 1;

 return -1;
}
