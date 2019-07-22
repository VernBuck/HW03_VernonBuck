#include "myLib.h"
#include "main.h"
#include "drawing.h"
#include "update.h"
#include <stdlib.h>

BOX player;
BOX boxes[NUMBOXES];

unsigned int oldButtons, buttons;
/**
* What is currently needed, collision check for paddle against the walls
* Randomly moving pixels on the screen to bounce back
* A collision checker for paddle and randomly moving pixels on the screen
*/
int main() {

	init();

	while (1) {
			oldButtons = buttons;
			buttons = BUTTONS;
			update();
			waitForVblank();
			draw();
	}

}

//Sets up initial values of boxes and mode 3 stuff
//Creates one boxes in random positions
void init() {
	REG_DISPCTL = MODE3 | BG2_ENABLE;

	//this for loop can create multiple boxes howeverm I set it to create only one box
	for(int i = 1; i < NUMBOXES; i++) {
		boxes[i].row =	30;
		boxes[i].col =	rand()%120+10;
		if(rand()%2) {
			boxes[i].rowDel = -1;
		} else {
			boxes[i].rowDel = 1;
		}

		if(rand()%2) {
			boxes[i].colDel = -1;
		} else {
			boxes[i].colDel = 1;
		}

		boxes[i].width = 5;
		boxes[i].height = 5;
		boxes[i].color = GREEN;
	}

	//initialize player box
	player.row = 150;
	player.col = 120;
	player.rowDel = 0;
	player.colDel = 0;
	player.width = 30;
	player.height = 8;
}

//checks to see if the player is in a new position as well as the bouncing box and checks to see whether or not they meet
//the final check is for when the box hits the sides or another box however I reduced the number of bouncing boxes to one for this game
void update() {
	updatePlayer(&player);

	for(int i = 1; i < NUMBOXES; i++) {
		updateBox(&boxes[i]);
		collisionCheckObstaclePlayer(&boxes[i], &player);
	}

	checkAllCollisions(boxes);

}

//general draw function
void draw() {
	for(int i = 0; i < NUMBOXES; i++) {
		drawBox(&boxes[i]);
	}
	drawPlayer(&player);
}