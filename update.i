# 1 "update.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "update.c"
# 1 "main.h" 1



void init();
void update();
void draw();


typedef struct {
 int row, oldRow;
 int col, oldCol;
 int rowDel;
 int colDel;
 int height;
 int width;
 int collisionChecked;
 unsigned short color;
} BOX;
# 2 "update.c" 2
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
# 3 "update.c" 2
# 1 "update.h" 1
void updateBox(BOX* b);
int checkEdgeCollision(BOX* b);
void checkAllCollisions(BOX* arr);
void updatePlayer(BOX* b);
void collisionCheckObstaclePlayer(BOX* b, BOX* p);
# 4 "update.c" 2




int checkEdgeCollision(BOX* b) {
 if(b->row < 0) {
  return 0;
 } else if(b->col < 0) {
  return 3;
 } else if(b->col + b->width + b->colDel > 240) {
  return 1;
 } else if(b->row + b->height + b->rowDel > 160) {
  return 2;
 }
 return -1;
}



void updatePlayer(BOX* p) {
 p->oldRow = p->row;
 p->oldCol = p->col;

 if((~((*(volatile unsigned int *)0x04000130)) & 16)) {
  if (p -> col < 240 - p -> width) {
   p->col++;
  }
 }
 if((~((*(volatile unsigned int *)0x04000130)) & 32)) {
  if (p -> col > 0) {
   p->col--;
  }
 }
}


void collisionCheckObstaclePlayer(BOX* b, BOX* p)
{
 if(b->col <= p->col + p->width && b->col + b->width >= p->col && b->row + b->height >= p->row)
 {
  b->rowDel = -b->rowDel;
 }
}


void checkAllCollisions(BOX* arr) {
 for(int i = 0; i < 2; i++) {
  for(int j = 0; j < 2; j++) {


   if(i != j && !arr[j].collisionChecked) {

    int collisionCheck = genericCollision(
     arr[i].row + arr[i].rowDel, arr[i].col + arr[i].colDel, arr[i].width, arr[i].height,
     arr[j].row + arr[j].rowDel, arr[j].col + arr[j].colDel, arr[j].width, arr[j].height);


    if(collisionCheck == 0 || collisionCheck == 2) {

     arr[i].rowDel = -arr[i].rowDel;
     arr[j].rowDel = -arr[j].rowDel;

     arr[i].collisionChecked = 1;
     arr[j].collisionChecked = 1;
    } else if(collisionCheck == 1 || collisionCheck == 3) {
     arr[i].colDel = -arr[i].colDel;
     arr[j].colDel = -arr[j].colDel;
     arr[i].collisionChecked = 1;
     arr[j].collisionChecked = 1;
    }
   }
  }
 }
}


void updateBox(BOX* b) {

 b->oldRow = b->row;
 b->oldCol = b->col;


 b->row += b->rowDel;
 b->col += b->colDel;

 int edgeCollision = checkEdgeCollision(b);

 if(edgeCollision == 0 || edgeCollision == 2) {
  b->rowDel = -b->rowDel;
  if (edgeCollision == 2) {

   b -> color = ((31) | (0)<<5 | (0)<<10);
  }
 } else if(edgeCollision == 1 || edgeCollision == 3) {
  b->colDel = -b->colDel;
 }

 b->collisionChecked = 0;
}
