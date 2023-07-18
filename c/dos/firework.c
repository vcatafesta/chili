#include <stdio.h>
#include <graphics.h>
#include <dos.h>
#include <stdlib.h>
#include <conio.h>
#include <bios.h>

#define SPECIAL_KEY bioskey

void firework(int maxx){
	int x,y,color, i;
      while(!kbhit()){
	x=maxx/2-random(40)+20;
	y=random(270)+50; color=random(7)+9;
	/*Firework one*/
	for(i=0;i<100;i++){
		putpixel(x+i,y+random(4)+10,color);
		putpixel(x+i,y-i/3+random(4)+10,color);
		putpixel(x+i/2,y-i/2+random(4)+10,color);
		putpixel(x+i/2,y+i/2+random(4)+10,color);
		putpixel(x+i,y+i/4+random(4)+10,color);
		delay(3);
			 }
	x=x-160; y=random(270)+50;
	/*Firework two*/
	for(i=0;i<100;i++){
		putpixel(x+random(4),y-i,color-3);
		putpixel(x+2*i/3+random(4),y-2*i/3,color-3);
		putpixel(x-2*i/3+random(4),y-2*i/3,color-3);
		putpixel(x-i/3+random(4),y-i,color-3);
		putpixel(x-i+random(4),y-i/10,color-3);
		delay(3);
		}
	x=x+350; y=random(270)+30;
	/*Firework three*/
	for(int j=0;j<100;j++){
		putpixel(x+j/3+random(4),y+j/2,color-2);
		putpixel(x+10+j/2+random(4),y-10+j/6,color-2);
		putpixel(x+10+j/3+random(4),y-10-j/2,color-2);
		putpixel(x-j/3+random(4),y-10-j/2,color-2);
		putpixel(x-10-j/3+random(4),y-10+j/2,color-2);
		putpixel(x-10-j+random(4),y-20-j/2,color-2);
		putpixel(x+10+j+random(4),y-10-j/2,color-2);
		putpixel(x+10+random(4),y-10-j,color-2);
		putpixel(x+j/10+random(4),y+10+j/2,color-2);
		putpixel(x-10-j/2+random(4),y-10+j/20,color-2);
		delay(5);
		}
	x=x-250; y=random(270)+30;
	for(i=0;i<150;i++){
		putpixel(x-i/2+random(i),y-i/2+random(i),color+1);
		putpixel(x+2-i/2+random(i),y+2-i/2+random(i),color+1);
		delay(3);
			}
	delay(50);cleardevice();
		}
	}

void main()
{
	int gdriver=0, gmode, gderr, maxx;

	randomize();

	initgraph(&gdriver,&gmode,"C:\\TC\\BGI");
	gderr = graphresult();
	if (gderr != grOk)  /* an error occurred */
	  {
	   printf("Graphics error: %s\n", grapherrormsg(gderr));
	   printf("Press any key to halt:");
	   getch();  exit(1);             /* return with error code */
	  }
	maxx=getmaxx();

	firework(maxx);
}