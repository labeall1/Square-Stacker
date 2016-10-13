#include "myLib.h"

unsigned short *videoBuffer = (u16 *)0x6000000;

void setPixel(int row, int col, unsigned short color)
{
	videoBuffer[OFFSET(row, col, SCREEN_WIDTH)] = color;

}

void DMANow(int channel, volatile const void* source, volatile const void* destination, unsigned int control)
{
	DMA[channel].src = source;
	DMA[channel].dst = destination;
	DMA[channel].cnt = DMA_ON | control;
}

void drawRect(int row, int col, int height, int width, unsigned short color)
{
	volatile unsigned short c = color;
	for(int r = 0; r < height; r++) {
		DMANow(3, &c, (&videoBuffer[OFFSET(row+r, col, 240)]), DMA_SOURCE_FIXED | width);
	}

}

void fillScreen(unsigned short color)
{
	volatile unsigned short c = color;
	DMANow(3, &c, videoBuffer, DMA_SOURCE_FIXED | (240*160));
}

void waitForVblank()
{
	while(SCANLINECOUNTER > 160);
	while(SCANLINECOUNTER < 160);
}