#include "myLib.h"
#include "main.h"



//Player drawing function
//draws new player box and colors over old one
void drawPlayer(BOX* b) {
	drawRect(b->oldRow, b->oldCol, b->height, b->width, BLACK);
	drawRect(b->row, b->col, b->height, b->width, BLUE);
}

//Draws box that bounces around
void drawBox(BOX* b) {
	//clear the box, then draw the box
	drawRect(b->oldRow, b->oldCol, b->height, b->width, BLACK);
	drawRect(b->row, b->col, b->height, b->width, b -> color);
}