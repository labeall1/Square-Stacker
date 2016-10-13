# 1 "myLib.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "myLib.c"
# 1 "myLib.h" 1
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
# 24 "myLib.h"
extern u16 *videoBuffer;
# 43 "myLib.h"
void setPixel(int, int, unsigned short);
void drawRect(int row, int col, int height, int width, volatile unsigned short color);
void waitForVblank();
void goToStart();
void goToGame();
void goToLose();
void goToWin();
void goToPause();

void start();
void game();
void lose();
void win();
void pause();

void initialize();
void initializeGame();
void draw();
void update();

void fillScreen(unsigned short color);

void drawPlayer();
void checkPaddleCollision();
void checkStackCollision();
void checkSideCollision();

void drawCaughtSquares();
void drawFallingSquares();
void deleteSquares();
# 107 "myLib.h"
typedef struct
{
 const volatile void *src;
 const volatile void *dst;
 u32 cnt;
} DMA_CONTROLLER;



void DMANow(int channel, volatile const void* source, volatile const void* destination, unsigned int control);
# 141 "myLib.h"
typedef struct
{
 int row;
 int col;
 int oldRow;
 int oldCol;
 int width;
 int height;
 int rightCol;
 int leftCol;
 u16 color;
} PLAYER;

typedef struct
{
 int row;
 int col;
 int oldRow;
 int oldCol;
 int width;
 int height;
 int rightCol;
 int leftCol;
 u16 color;
} SQUARE;

typedef struct
{
 int row;
 int col;
 int oldRow;
 int oldCol;
} CAUGHT_SQUARE;
# 2 "myLib.c" 2

unsigned short *videoBuffer = (u16 *)0x6000000;

void setPixel(int row, int col, unsigned short color)
{
 videoBuffer[((row)*(240)+(col))] = color;

}

void DMANow(int channel, volatile const void* source, volatile const void* destination, unsigned int control)
{
 ((volatile DMA_CONTROLLER *) 0x040000B0)[channel].src = source;
 ((volatile DMA_CONTROLLER *) 0x040000B0)[channel].dst = destination;
 ((volatile DMA_CONTROLLER *) 0x040000B0)[channel].cnt = (1 << 31) | control;
}

void drawRect(int row, int col, int height, int width, unsigned short color)
{
 volatile unsigned short c = color;
 for(int r = 0; r < height; r++) {
  DMANow(3, &c, (&videoBuffer[((row+r)*(240)+(col))]), (2 << 23) | width);
 }

}

void fillScreen(unsigned short color)
{
 volatile unsigned short c = color;
 DMANow(3, &c, videoBuffer, (2 << 23) | (240*160));
}

void waitForVblank()
{
 while((*(volatile unsigned short *)0x4000006) > 160);
 while((*(volatile unsigned short *)0x4000006) < 160);
}
