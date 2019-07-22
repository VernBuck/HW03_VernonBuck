#include "myLib.h"

unsigned short *videoBuffer = VIDBUFADR;

void setPixel(int row, int col, unsigned short color) {
	videoBuffer[OFFSET(row, col, 240)]  = color;
}

//drawing boxes
void drawRect(int row, int col, int height, int width, unsigned short color) {
	for(int r = 0; r < height; r++) {
		for(int c = 0; c < width; c++) {
			setPixel(row + r, col + c, color);
		}
	}
}

//prevents screen flickering 
void waitForVblank() {
	while(SCANLINECOUNTER > 160);
	while(SCANLINECOUNTER < 160);
}

//Checks collision of first box against second box
//return 0 for top collision, 1 for right, 2 for bottom, and 3 for left
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