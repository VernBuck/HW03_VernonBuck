# 1 "drawing.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "drawing.c"
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
# 2 "drawing.c" 2
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
# 3 "drawing.c" 2





void drawPlayer(BOX* b) {
 drawRect(b->oldRow, b->oldCol, b->height, b->width, 0);
 drawRect(b->row, b->col, b->height, b->width, ((0) | (0)<<5 | (31)<<10));
}


void drawBox(BOX* b) {

 drawRect(b->oldRow, b->oldCol, b->height, b->width, 0);
 drawRect(b->row, b->col, b->height, b->width, b -> color);
}
