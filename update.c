#include "main.h"
#include "myLib.h"
#include "update.h"

//Updates the position of the player

//Checks whether or not the bouncing box collides
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

//Changes the position of the player with user input
//Prevents player from moving past 0 and 240 gba width
void updatePlayer(BOX* p) {
	p->oldRow = p->row;
	p->oldCol = p->col;

	if(BUTTON_HELD(BUTTON_RIGHT)) {
		if (p -> col < 240 - p -> width) {
			p->col++;
		}
	}
	if(BUTTON_HELD(BUTTON_LEFT)) {
		if (p -> col > 0) {
			p->col--;
		}
	}
}

//checks if the box collides with the paddle (blue line) 
void collisionCheckObstaclePlayer(BOX* b, BOX* p)
{
	if(b->col <= p->col + p->width && b->col + b->width >= p->col && b->row + b->height >= p->row)
	{
		b->rowDel = -b->rowDel;
	}
}

//Determines whether or not the box collides with something that isn't the paddle (i.e. a wall) and acts based on that
void checkAllCollisions(BOX* arr) {
	for(int i = 0; i < NUMBOXES; i++) {
		for(int j = 0; j < NUMBOXES; j++) {
			//Here we are going to make sure we don't check a box against itself
			//And we are going to ensure that the box's collision hasn't been checked this frame
			if(i != j && !arr[j].collisionChecked) {
				//First return our collision check from the generic function in myLib.c
				int collisionCheck = genericCollision(
					arr[i].row + arr[i].rowDel, arr[i].col + arr[i].colDel, arr[i].width, arr[i].height,
					arr[j].row + arr[j].rowDel, arr[j].col + arr[j].colDel, arr[j].width, arr[j].height);

				//If we collided with the top or bottom
				if(collisionCheck == 0 || collisionCheck == 2) {
					//reverse the vertical direction of both boxes that collided
					arr[i].rowDel = -arr[i].rowDel;
					arr[j].rowDel = -arr[j].rowDel;
					//set the collision checked flag so that we don't "double check" them
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

//changes the box as it moves
void updateBox(BOX* b) {
	//first save the old position of the box (for erasing)
	b->oldRow = b->row;
	b->oldCol = b->col;

	//first we update the row and column by the delta
	b->row += b->rowDel;
	b->col += b->colDel;

	int edgeCollision = checkEdgeCollision(b);

	if(edgeCollision == 0 || edgeCollision == 2) {
		b->rowDel = -b->rowDel;
		if (edgeCollision == 2) {
			// loss condition met here
			b -> color = RED;
		}
	} else if(edgeCollision == 1 || edgeCollision == 3) {
		b->colDel = -b->colDel;
	}

	b->collisionChecked = 0;
}
