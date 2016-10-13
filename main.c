#include <stdlib.h>
#include <stdio.h>
#include "myLib.h"
#include "text.h"

//How fast the square falls
int speed;
//The bottom row of the falling square
int bottom_row;
//Variable need to center the stack on the paddle
int difference;
//How many squares were caught/stacked
//Score - keeps track of total stack count
int stack;
int score;

//Game state
int state;

//STATES
enum { STARTSCREEN, GAMESCREEN, LOSESCREEN, WINSCREEN, PAUSESCREEN };

PLAYER player;
SQUARE square;
CAUGHT_SQUARE caught_square;

//oldButtons set in previous frame
volatile unsigned int buttons, oldButtons;

int main()
{
	initialize();
	goToStart();

	while(1)
	{
		oldButtons = buttons;
		buttons = BUTTONS;

        switch(state) {
	    	case STARTSCREEN:
	        	start();
	        	break;
	    	case GAMESCREEN:
	        	game();
	        	break;
	    	case LOSESCREEN:
	        	lose();
	        	break;
	    	case WINSCREEN:
	    		win();
	    		break;
	    	case PAUSESCREEN:
	    		pause();
	    		break;		
        }

	}

	return 0;
}

void start()
{
	if(BUTTON_PRESSED(BUTTON_START)) {
		goToGame(); //Go play a game
	}
}

void game()
{
	
	update(&player, &square, &caught_square);
	waitForVblank();
	draw();

	if(BUTTON_PRESSED(BUTTON_START)) {
    	goToPause();
    }
    if(BUTTON_PRESSED(BUTTON_A)) {
    	goToWin(); //Treat like go to continue
    }
}

void pause()
{
    if(BUTTON_PRESSED(BUTTON_START)) {
    	goToGame(); //Go back to current game
    }
    if(BUTTON_PRESSED(BUTTON_B)) {
    	score = 0;
    	goToStart(); //Restart game
    }
}

void win()
{
    if(BUTTON_PRESSED(BUTTON_START)) {
    	goToStart(); //Continue game (restart game but score not changed)
    }
    if(BUTTON_PRESSED(BUTTON_B)) {
    	score = 0;
    	goToStart(); //Restart game and score back at zero
    }
}

void lose()
{
    if(BUTTON_PRESSED(BUTTON_START)) {
    	goToStart(); //Restart game
    }
}

void initialize()
{
	REG_DISPCTL = MODE3 | BG2_ENABLE;
	state = STARTSCREEN;
	//Score is set here because I only want to erase it when I lose
	score = 0;
}


void initializeGame()
{
	//A small section of the screen is not erased since the score is stored
	//drawRect(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH, BLACK);

	player.row = 145;
	player.col = 120;
	player.width = 26;
	player.height = 10;

	square.row = 10;
	square.col = 70;
	square.width = 16;
	square.height = 10;

	//Stack is the amount of squares piled up
	//It starts at 1 bc I am using it as a multiplier
	stack = 1;

	caught_square.col = 0;
	caught_square.row = 132 - square.height;
	
}

//Update Logic
//Player moved here
void update(PLAYER* p, SQUARE* s, CAUGHT_SQUARE* cs)
{
	p->oldRow = p->row;
	p->oldCol = p->col;

	s->oldRow = s->row;
	s->oldCol = s->col;

	cs->oldRow = cs->row;
	cs->oldCol = cs->col;

	//The bounds check for player side collisions
	//The button moves the player and the stack
	//Added and subtracted 5 since my player can only move in increments of 5
	if(BUTTON_HELD(BUTTON_LEFT) && (p->col - (p->width/2) - 5) > 0) {
		p->col-=5;
		if(stack > 0) {
			cs->col-=5;
		}
	}

	if(BUTTON_HELD(BUTTON_RIGHT) && (p->col + (p->width/2) + 5) < 220) {
		p->col+=5;
		if(stack > 0) {
			cs->col+=5;
		}
	}

	//Pauses/stops the game and adds score to score bar on right
	//A is pressed when player wants to collect their points
	if(BUTTON_PRESSED(BUTTON_A))
	{
		score = score + 10*(stack-1);
		goToWin(); //Treat like a continue
	}
}

//Update Screen/drawing
//Draw player here
void draw()
{
	drawPlayer();

	for(int i = 0; i < 3; i++) //the bigger i the faster it falls
	{
		waitForVblank();
		checkPaddleCollision(&player, &square);	
	}
	//Checks in the caught squares need to be drawn
	if(stack > 1)
	{
		drawCaughtSquares(&caught_square, &square, &player);
		
	}
	
}


//Checking for falling square side/bottom collisions
void checkSideCollision(SQUARE* s)
{
	bottom_row = s->row + s->height;

	//Checks to make sure the square has not gone past the "bottom" of the screen
	//If it has the sqaure is deleted/erased so it does not keep falling
	if(bottom_row <= 145)
	{
		drawFallingSquares(s);

	} else {
		//If the sqaures are past row 155 they are erased
		deleteSquares(s);

		//The values are reset so the process begins again
		s->row = 10;
		s->col = (rand() % 185) + 5;

		s->oldRow = s->row;
		s->oldCol = s->col;
	}
}

//Checking for player/paddle and square collisions
void checkPaddleCollision(PLAYER* p, SQUARE* s)
{ 
	//Below are basic calculations to calculate when the bottom of the square meets the player
	bottom_row = s->row + s->height;
	s->leftCol = s->col;
	s->rightCol = s->col + s->width;

	p->leftCol = p->col - (p->width)/2;
	p->rightCol = p->col + (p->width)/2;

	//This is the "bottom" of the paddle
	//The bottom gets taller as the squares are stacked
	int new_bottom_row = 132 - (s->height)*(stack-1);

	//This checks if the bottom of the falling square has hit the top of the stack
	if(bottom_row == new_bottom_row  && (s->leftCol > p->leftCol) && (s->rightCol < p->rightCol)) 
	{
		//The old square gets deleted and the stack count increases
		deleteSquares(s);
		stack++;

		//The values are reset and the process continues
		s->row = 10;
		s->col = (rand() % 185) + 5;

		s->oldRow = s->row;
		s->oldCol = s->col;

		drawFallingSquares(s);	

	} else {
		//Collisions are checked in the square is not caught
		checkStackCollision(s, p);
		checkSideCollision(s);
	}	
}

//This draws the red player/paddle on the bottom
void drawPlayer(PLAYER* p)
{
	drawRect(p->oldRow - (p->width)/2, p->oldCol - (p->width)/2 , p->height, p->width, BLACK);
	drawRect(p->row - (p->width)/2, p->col - (p->width)/2 , p->height, p->width, RED);
}

//This draws the blue squares that fall from above
void drawFallingSquares(SQUARE *s)
{
	drawRect(s->oldRow, s->oldCol, s->height, s->width, BLACK);
	s->row++;
	drawRect(s->row, s->col, s->height, s->width, BLUE);
}

void deleteSquares(SQUARE* s)
{
	drawRect(s->row, s->col, s->height, s->width, BLACK);
}

//This draws the squares that are "caught"
//The number is based on the number in the stack
void drawCaughtSquares(CAUGHT_SQUARE* cs, SQUARE* s, PLAYER* p)
{
	//The difference is calculated just to stack the squares in the center
	//Similar logic is used to draw the squares
	difference = (p->width - s->width)/2;
	cs->col= p->leftCol + difference;
	cs->row = 132 - (s->height)*(stack-1);

	drawRect(cs->oldRow, cs->oldCol, (s->height)*(stack-1), s->width, BLACK);
	drawRect(cs->row, cs->col, (s->height)*(stack-1), s->width, GREEN);
}

void checkStackCollision(SQUARE* s, PLAYER* p)
{
	//Similar logic as above
	//Finding dimensions to indicate a collision
	int stack_top_row = 132 - s->height*(stack-1);
	int falling_square_bottom = s->row + s->height;

	//Calculations for the falling square
	s->leftCol = s->col;
	s->rightCol = s->col + s->width;

	//Takes care of right side of stack
	//2 is subtracted since the stack of squares and player/paddle are different widths
	if(falling_square_bottom > stack_top_row && s->rightCol > (p->rightCol - 2)
		&& s->leftCol < p->rightCol - 2)
	{
		goToLose();
		score = 0;
		
		
	}

	//Takes care of left side of stack
	//2 is added since the stack of squares and player/paddle are different widths
	if(falling_square_bottom > stack_top_row && s->leftCol < (p->leftCol + 2)
		&& s->rightCol > p->leftCol + 2)
	{
		goToLose();
		score = 0;
	}

}

void goToStart() {
	fillScreen(BLACK);
	initializeGame();

	char buffer[41];
	sprintf(buffer, "PRESS ENTER TO START");
	drawString(10, 20, buffer, BLUE);

	state = STARTSCREEN;

}

void goToGame() {
	fillScreen(BLACK);
	state = GAMESCREEN;
}

void goToPause() {
	fillScreen(BLACK);

	char buffer[41];
	sprintf(buffer, "PAUSE");
	drawString(80, 100, buffer, RED);
	state = PAUSESCREEN;
}

void goToWin() {
	fillScreen(BLACK);
	
	char buffer[41];
	sprintf(buffer, "Score: %d", score);
	drawString(10, 20, buffer, GREEN);

	sprintf(buffer, "PRESS START TO CONTINUE");
	drawString(20, 20, buffer, GREEN);

	sprintf(buffer, "PRESS B TO RESTART");
	drawString(30, 20, buffer, GREEN);
	state = WINSCREEN;
}

void goToLose() {
	fillScreen(BLACK);
	
	char buffer[41];
	sprintf(buffer, "Score: %d", score);
	drawString(10, 20, buffer, GREEN);

	sprintf(buffer, "GAME OVER");
	drawString(20, 20, buffer, GREEN);

	sprintf(buffer, "PRESS START TO PLAY AGAIN");
	drawString(30, 20, buffer, GREEN);

	state = LOSESCREEN;
}



