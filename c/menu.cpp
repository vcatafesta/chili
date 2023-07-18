/******************************************
 * The Program demonstrate about math and *
 * c programming forcomputer of year one  *
 ***************************************** */
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<dos.h>
#include<string.h>
#include<graphics.h>
#include<ctype.h>
#include<math.h>
#define tc textcolor
#define setc setcolor
#define tb textbackground
#define setb setbkcolor
/* ===============Prototype declaretion================= */
void arith();
void Arrangement();
void discount();
void grade();
void help();
void lin();
void pascal_tri();
void positive();
long PPCM();
long Pr(int);
void product();
void run();
void run2();
void setha();
void star();
void sum1();
void sum2();
void sum3();
void sys();
void sys1();
void sys2();
void sys3();

PGCD(int x, int y) {
	while (x != y) {
		if (x > y)
			x = x - y;
		else
			y = y - x;
	}
	return x;
}
/* =========Global declaretion========== */
int ab = 0, cd, i, year, font, m, y, q, co, post, pos[22], l, n, p, old, score, k, k1;
int j, a, b, c, E[100], A[24], M1, M2, M3, temp, d[33][33], e[33][33], g[33][33];
float D, f, x1, x2, s[44], x;
double S, S4;
long L, C, S1, S2, P, S3, B[33];
char ch, tha, *name, *sex, *str;
char st[] = "Please input the year you want to know:", sw[] =
	"The program is about pascal triangle", se[] = "Please input the decimal number n:";

/* ==========================Function definition=========================== */
/* Factoriel */
long fact(int x) {
	int i, p = 1;
	if (x == 0)
		return (1);
	else
		for (i = 1; i <= x; i++)
			p = p * i;
	return (p);
} /* End factoriel */

/* run1 */
/* Function year_1; */
void year_1() {
	tc(11);
	gotoxy(15, 4);
	cprintf("The program is about the name of day on date:01/01/year");
	tc(10);
	gotoxy(15, 7);
	cprintf("%s", st);
	_setcursortype(_NORMALCURSOR);
	gotoxy(55, 7);
	cscanf("%d", &year);
	C = 0;
	for (y = 1899; y <= year - 1; y++) {
		if (y % 4 == 0)
			p = 366;
		else
			p = 365;
		C = C + p;
	}
	switch (C % 7) {
	case 2:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Monday");
		break;
	case 3:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Tuesday");
		break;
	case 4:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Wednesday");
		break;
	case 5:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Thursday");
		break;
	case 6:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Friday");
		break;
	case 0:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Saturday");
		break;
	case 1:
		tc(11);
		gotoxy(20, 10);
		cprintf("The day of 01/01/%d is ", year);
		tc(14 + 128);
		gotoxy(46, 10);
		cprintf("Sunday");
		break;
	default:
		gotoxy(20, 10);
		cprintf("I don't know");
		break;
	}
	tc(3);
	gotoxy(20, 18);
	cprintf("Would you like to countinue[N/Y]");
} /* End function year_1 */

/* Function physique */
void physiq() {
	initgraph(&ab, &cd, "c:\\tc\\bgi");
	setbkcolor(co);
	line(200, 150, 250, 150);
	line(270, 150, 320, 150);
	line(200, 150, 200, 180);
	line(320, 150, 320, 180);
	line(164, 184, 196, 184);
	line(204, 184, 220, 184);
	line(238, 184, 256, 184);
	line(264, 184, 280, 184);
	line(300, 184, 316, 184);
	line(324, 184, 336, 184);
	line(340, 188, 340, 210);
	line(320, 188, 320, 205);
	line(340, 230, 340, 250);
	line(260, 188, 260, 210);
	line(260, 230, 260, 250);
	line(336, 254, 264, 254);
	line(256, 254, 164, 254);
	line(260, 205, 290, 205);
	line(290, 205, 295, 200);
	line(300, 205, 320, 205);
	rectangle(250, 145, 270, 155);
	rectangle(220, 180, 238, 189);
	rectangle(280, 180, 300, 189);
	rectangle(336, 210, 344, 230);
	rectangle(256, 210, 264, 230);
	setcolor(14);
	setfillstyle(1, 14);
	fillellipse(200, 184, 4, 4);
	setfillstyle(1, 14);
	fillellipse(320, 184, 4, 4);
	setfillstyle(1, 14);
	fillellipse(160, 184, 4, 4);
	setfillstyle(1, 14);
	fillellipse(260, 184, 4, 4);
	setfillstyle(1, 14);
	fillellipse(320, 184, 4, 4);
	setfillstyle(1, 14);
	fillellipse(340, 184, 4, 4);
	setfillstyle(1, 14);
	fillellipse(340, 254, 4, 4);
	setfillstyle(1, 14);
	fillellipse(260, 254, 4, 4);
	setfillstyle(1, 14);
	fillellipse(160, 254, 4, 4);
	settextstyle(3, 0, 1);
	setcolor(10);
	outtextxy(255, 120, "R");
	outtextxy(225, 155, "R");
	outtextxy(285, 155, "R");
	outtextxy(325, 207, "R");
	outtextxy(245, 207, "R");
	settextstyle(7, 0, 1);
	setcolor(13);
	outtextxy(185, 160, "a");
	outtextxy(325, 160, "c");
	outtextxy(255, 160, "b");
	outtextxy(245, 230, "d");
	setcolor(3);
	outtextxy(160, 205, "U");
	setcolor(14);
	outtextxy(290, 205, "K");
	settextstyle(7, 0, 2);
	for (i = -70; i <= 130; i++) {
		setcolor(11 + i);
		outtextxy(5*i, 10, "ROYAL UNIVERSITY PHNOM PENH");
		setcolor(13 + i);
		outtextxy(5*i + 2, 11, "ROYAL UNIVERSITY PHNOM PENH");
		delay(3);
		setcolor(0);
		outtextxy(5*i, 10, "ROYAL UNIVERSITY PHNOM PENH");
		outtextxy(5*i + 2, 11, "ROYAL UNIVERSITY PHNOM PENH");
	}
	for (i = 130; i >= 25; i--) {
		setcolor(1 + i);
		outtextxy(5*i, 10, "ROYAL UNIVERSITY PHNOM PENH");
		setcolor(12 + i);
		outtextxy(5*i + 2, 11, "ROYAL UNIVERSITY PHNOM PENH");
		delay(3);
		setcolor(0);
		outtextxy(5*i + 2, 11, "ROYAL UNIVERSITY PHNOM PENH");
		outtextxy(5*i, 10, "ROYAL UNIVERSITY PHNOM PENH");
	}
	setcolor(15);
	outtextxy(125, 10, "ROYAL UNIVERSITY PHNOM PENH");
	setcolor(9);
	outtextxy(125, 11, "ROYAL UNIVERSITY PHNOM PENH");
	for (i = 1; i <= 190; i++) {
		sound(300 + i*5);
		putpixel(123 + i*2, 40, 14);
		putpixel(123 + i*2, 43, 14);
		delay(3);
	}
	nosound();
	settextstyle(1, 0, 4);
	for (i = 0; i <= 290; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "S");
		delay(2);
		setcolor(0);
		outtextxy(i, 50, "S");
	}
	setcolor(14);
	outtextxy(290, 50, " S ");
	for (i = 0; i <= 270; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "C");
		delay(2);
		setcolor(0);
		outtextxy(i, 50, "C");
	}
	setcolor(14);
	outtextxy(270, 50, " C ");
	for (i = 0; i <= 255; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "I");
		delay(3);
		setcolor(0);
		outtextxy(i, 50, "I");
	}
	setcolor(14);
	outtextxy(255, 50, " I ");
	for (i = 0; i <= 235; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "S");
		delay(3);
		setcolor(0);
		outtextxy(i, 50, "S");
	}
	setcolor(14);
	outtextxy(235, 50, " S ");
	for (i = 0; i <= 215; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "Y");
		delay(3);
		setcolor(0);
		outtextxy(i, 50, "Y");
	}
	setcolor(14);
	outtextxy(215, 50, " Y ");
	for (i = 0; i <= 195; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "H");
		delay(3);
		setcolor(0);
		outtextxy(i, 50, "H");
	}
	setcolor(14);
	outtextxy(195, 50, " H ");
	for (i = 0; i <= 175; i++) {
		setcolor((int)random(16));
		outtextxy(i, 50, "P");
		delay(3);
		setcolor(0);
		outtextxy(i, 50, "P");
	}
	setcolor(14);
	outtextxy(175, 50, " P ");
	for (i = 1; i <= 132; i++) {
		sound(500 + i*10);
		sound(500 + 5*i);
		putpixel(190 + i, 87, 12);
		putpixel(190 + i, 89, 12);
		delay(7);
	}
	nosound();
	for (i = 164; i <= 196; i++) {
		putpixel(i, 184, 12);
		settextstyle(5, 0, 3);
		setcolor(14 + i);
		outtextxy(175, 175, "i");
		delay(30);
	}
	for (i = 180; i >= 150; i--) {
		putpixel(200, i, 12);
		delay(20);
	}
	for (i = 200; i <= 250; i++) {
		putpixel(i, 150, 12);
		delay(20);
	}
	for (i = 270; i <= 320; i++) {
		putpixel(i, 150, 12);
		delay(20);
	}
	for (i = 150; i <= 180; i++) {
		putpixel(320, i, 12);
		delay(20);
	}
	for (i = 204; i <= 220; i++) {
		putpixel(i, 184, 12);
		delay(10);
	}
	for (i = 238; i <= 256; i++) {
		putpixel(i, 184, 12);
		delay(20);
	}
	for (i = 264; i <= 280; i++) {
		putpixel(i, 184, 12);
		delay(20);
	}
	for (i = 300; i <= 316; i++) {
		putpixel(i, 184, 12);
		delay(20);
	}
	for (i = 188; i <= 205; i++) {
		putpixel(320, i, 12);
		delay(20);
	}
	for (i = 320; i >= 300; i--) {
		putpixel(i, 205, 12);
		delay(20);
	}
	for (i = 324; i <= 336; i++) {
		putpixel(i, 184, 12);
		delay(20);
	}
	for (i = 188; i <= 210; i++) {
		putpixel(340, i, 12);
		delay(20);
	}
	for (i = 230; i <= 250; i++) {
		putpixel(340, i, 12);
		delay(20);
	}
	for (i = 336; i >= 264; i--) {
		putpixel(i, 254, 12);
		delay(20);
	}
	for (i = 188; i <= 210; i++) {
		putpixel(260, i, 12);
		delay(10);
	}
	for (i = 260; i <= 290; i++) {
		putpixel(i, 205, 12);
		delay(20);
	}
	i = 290;
	for (j = 205; j >= 200; j--) {
		putpixel(i, j, 12);
		delay(10);
		i++;
	}
	for (i = 230; i <= 250; i++) {
		putpixel(260, i, 12);
		delay(20);
	}
	for (i = 256; i >= 164; i--) {
		putpixel(i, 254, 12);
		delay(20);
	}
	settextstyle(1, 0, 1);
	for (i = -40; i <= 105; i++) {
		setcolor(1 + i);
		outtextxy(2*i - 5, 360, "Prepared by :");
		outtextxy(-2*i + 550, 360, "Iech Setha");
		delay(5);
		setcolor(0);
		outtextxy(2*i - 5, 360, "Prepared by :");
		setcolor(0);
		outtextxy(-2*i + 550, 360, "Iech Setha");
	}
	setcolor(10);
	outtextxy(205, 360, "Prepared by :");
	setcolor(12);
	outtextxy(340, 360, "Iech Setha");
	settextstyle(1, 0, 3);
	for (i = -50; i <= 50; i++) {
		setcolor(10);
		outtextxy(2*i, 400, "Taught by lecturer:");
		setcolor(1 + i);
		outtextxy(340, 500 - 2*i, "Kean Tak");
		delay(8);
		setcolor(0);
		outtextxy(2*i, 400, "Taught by lecturer:");
		setcolor(0);
		outtextxy(340, 500 - 2*i, "Kean Tak");
	}
	setcolor(10);
	outtextxy(100, 400, "Taught by lecturer:");
	setcolor(14);
	outtextxy(340, 400, "Kean Tak");
	settextstyle(7, 1, 3);
	settextstyle(3, 0, 2);
	for (i = -20; i <= 100; i++) {
		setcolor(i + 1);
		outtextxy(i*2, 450, "Press Alt+F5 to exit");
		delay(5);
		setcolor(0);
		outtextxy(i*2, 450, "Press Alt+F5 to exit");
	}
	setcolor(15);
	outtextxy(200, 450, "Press Alt+F5 to exit");
} /* End function physique */

/* Equa_1 */
void equa_1() {
	tc(14 + 128);
	gotoxy(15, 4);
	cprintf("Find the root of ax+b <0");
	gotoxy(15, 6);
	tc(11);
	cprintf("If a=      and b=");
	_setcursortype(_NORMALCURSOR);
	gotoxy(20, 6);
	tc(12);
	scanf("%d", &a);
	gotoxy(32, 6);
	scanf("%d", &b);
	S = (float) - b / a;
	tc(14);
	gotoxy(20, 8);
	if (b >= 0)
		cprintf("Then ax+b<0 => %dx+%d<0", a, b);
	else
		cprintf("Then ax+b<0 => %dx-%d<0", a, -b);
	gotoxy(20, 10);
	if (a < 0) {
		cprintf("=> x>%d/(%d)", -b, a);
		gotoxy(20, 12);
		cprintf("x>%.2f", S);
	}
	else if (a > 0) {
		cprintf("=> x<%d/%d", -b, a);
		gotoxy(20, 12);
		cprintf("x<%.2f", S);
	}
	else {
		gotoxy(20, 12);
		tc(10 + 128);
		if (b < 0)
			cprintf("Have many root");
		else
			cprintf("No root");
	}
	tc(6);
	gotoxy(20, 20);
	cprintf("Do you want to continue?[n/y]");
} /* End equa_1 */

/* equa_2 */
void equa_2() {
	tc(14 + 128);
	gotoxy(15, 4);
	cprintf("Find the root of ax+b >0");
	gotoxy(15, 6);
	tc(11);
	cprintf("If a=      and b=");
	_setcursortype(_NORMALCURSOR);
	gotoxy(20, 6);
	tc(12);
	scanf("%d", &a);
	gotoxy(32, 6);
	scanf("%d", &b);
	S = (float) - b / a;
	tc(14);
	gotoxy(20, 8);
	if (b >= 0)
		cprintf("Then ax+b>0 => %dx+%d>0", a, b);
	else
		cprintf("Then ax+b>0 => %dx-%d>0", a, -b);
	gotoxy(20, 10);
	if (a < 0) {
		cprintf("=> x<%d/(%d)", -b, a);
		gotoxy(20, 12);
		cprintf("x<%.2f", S);
	}
	else if (a > 0) {
		cprintf("=> x>%d/%d", -b, a);
		gotoxy(20, 12);
		cprintf("x>%.2f", S);
	}
	else {
		gotoxy(20, 12);
		tc(10 + 128);
		if (b > 0)
			cprintf("Have many root");
		else
			cprintf("No root");
	}
	tc(6);
	gotoxy(20, 20);
	cprintf("Do you want to continue?[n/y]");
} /* End equa_2 */

/* line */
void line() {
	tb(co);
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(1, 2);
	cprintf("ÉÍ[ ]");
	gotoxy(4, 2);
	tc(10);
	putch('þ');
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(80, 2);
	cprintf("»");
	gotoxy(37, 2);
	cprintf("SETHA.CPP");
	for (i = 1; i <= 29; i++) {
		gotoxy(i + 5, 2);
		cprintf("Í");
	}
	for (i = 48; i <= 79; i++) {
		gotoxy(i, 2);
		cprintf("Í");
	}
	for (i = 3; i <= 24; i++) {
		gotoxy(1, i);
		cprintf("º");
	}
	gotoxy(1, 24);
	cprintf("ÈÍ");
	gotoxy(3, 24);
	cprintf(":");
	gotoxy(6, 24);
	putch(15);
	gotoxy(7, 24);
	putch(15);
	tc(10);
	gotoxy(79, 24);
	cprintf("ÄÙ");
	tc(15);
	gotoxy(8, 24);
	cprintf("ÍÍ");
	tb(3);
	tc(1);
	gotoxy(10, 24);
	putch(17);
	gotoxy(11, 24);
	putch('þ');
	tb(co);
	tb(3);
	tc(1);
	for (i = 12; i <= 77; i++) {
		gotoxy(i, 24);
		cprintf("²");
	}
	tb(3);
	tc(1);
	gotoxy(78, 24);
	cprintf("");
	tb(co);
	for (i = 4; i <= 22; i++) {
		tb(3);
		tc(1);
		gotoxy(80, i);
		cprintf("²");
	}
	tb(3);
	tc(1);
	gotoxy(80, 3);
	cprintf("");
	gotoxy(80, 23);
	cprintf("");
} /* End line */

/* line2 */
void line2() {
	tb(7);
	tc(4);
	gotoxy(5, 1);
	cprintf("F");
	tc(0);
	gotoxy(6, 1);
	cprintf("ile");
	tb(co);
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(6, 2);
	cprintf("ÍÍÍÍÍÍÍÍÍÍ");
	gotoxy(1, 2);
	cprintf("ÉÍ[ ]");
	gotoxy(4, 2);
	tc(10);
	putch('þ');
	tb(co);
	for (i = 1; i <= 6; i++) {
		gotoxy(1, i + 2);
		cprintf("                 ");
	}
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(1, 8);
	cprintf("º");
	for (i = 1; i <= 5; i++) {
		gotoxy(1, i + 2);
		cprintf("º");
	}
} /* End line2 */

/* sort_num */
void sort_num() {
	tc(11);
	gotoxy(20, 4);
	cprintf("The program of sort number.");
	tc(14);
	gotoxy(20, 5);
	cprintf("How many elements you want to sort?");
	tc(10);
	gotoxy(32, 6);
	cprintf("elements.");
	tc(15);
	gotoxy(1, 6);
	cprintf("º");
	_setcursortype(_NORMALCURSOR);
	gotoxy(28, 6);
	scanf("%d", &n);
	gotoxy(20, 7);
	cprintf("Please input the value of elements:");
	for (i = 0; i < n; i++) {
		tc(14);
		gotoxy(20 + 4*i, 8);
		scanf("%d", &A[i]);
	}
	gotoxy(20, 9);
	cprintf("The number befor sorting is:");
	for (i = 0; i < n; i++) {
		tc(14);
		gotoxy(20 + 4*i, 10);
		cprintf("%d", A[i]);
	}
	_setcursortype(_NOCURSOR);
	gotoxy(20, 12);
	tc(14);
	cprintf("The number after sorting is:");
	tc(15);
	gotoxy(20, 14);
	cprintf("Sort from lower to upper (ascending):");
	gotoxy(20, 18);
	cprintf("Sort from upper to lower (descending):");
	for (i = 0; i < n - 1; i++)
		for (j = 1 + i; j < n; j++) {
			if (A[i] > A[j]) {
				temp = A[i];
				A[i] = A[j];
				A[j] = temp;
			}
			else
				continue;
		}
	for (i = 0; i < n; i++) {
		gotoxy(20 + 4*i, 16);
		cprintf("%d", A[i]);
	}
	for (i = n - 1; i >= 0; i--) {
		gotoxy(20 + 4*(n - 1 - i), 20);
		cprintf("%d", A[i]);
	}
aa1:
	tc(11);
	gotoxy(20, 22);
	cprintf("Do you want to continue?[y/n]");
} /* End sort_num */

/* line3 */
void line3() {
	tb(15);
	tc(4);
	gotoxy(19, 1);
	cprintf("M");
	tc(0);
	gotoxy(20, 1);
	cprintf("ath");
	tb(co);
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(15, 2);
	cprintf("ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ");
	for (i = 1; i <= 8; i++) {
		gotoxy(15, i + 2);
		cprintf("                     ");
	}
} /* End line3 */

/* line7 */
void line7() {
	tb(co);
	for (i = 1; i <= 6; i++) {
		gotoxy(40, i + 3);
		cprintf("                       ");
	}
	for (i = 1; i <= 3; i++) {
		tb(0);
		gotoxy(40, i + 3);
		cprintf("  ");
	}
} /* End line7 */

/* line14 */
void line14() {
	tb(co);
	for (i = 1; i <= 21; i++) {
		gotoxy(2, i + 2);
		cprintf("                                       ");
		gotoxy(40, i + 2);
		cprintf("                                        ");
	}
} /* End line14 */

/* line4 */
void line4() {
	tb(7);
	tc(4);
	gotoxy(30, 1);
	cprintf("C");
	tc(0);
	gotoxy(31, 1);
	cprintf("alculate");
	tb(co);
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(25, 2);
	cprintf("ÍÍÍÍÍÍÍÍÍÍÍ SET");
	for (i = 1; i <= 4; i++) {
		gotoxy(25, i + 2);
		cprintf("                    ");
	}
} /* End line4 */

/* line6 */
void line6() {
	tb(15);
	tc(4);
	gotoxy(45, 1);
	cprintf("W");
	tc(0);
	gotoxy(46, 1);
	cprintf("indow");
	tb(co);
	if (co == 7)
		tc(0);
	else
		tc(15);
	gotoxy(40, 2);
	cprintf("HA.CPP  ÍÍÍÍÍÍÍÍÍÍÍ");
	for (i = 1; i <= 10; i++) {
		gotoxy(40, i + 2);
		cprintf("                     ");
	}
} /* End line6 */

/* line10 */
void line10() {
	tb(co);
	for (i = 1; i <= 6; i++) {
		gotoxy(34, i + 5);
		cprintf("                                   ");
	}
	for (i = 1; i <= 5; i++) {
		tb(0);
		gotoxy(34, i + 5);
		cprintf("  ");
	}
} /* line10 */

/* line8 */
void line8() {
	tb(co);
	for (i = 1; i <= 20; i++) {
		gotoxy(17, i + 3);
		cprintf("                                                   ");
	}
} /* End line8 */

/* line12 */
void line12() {
	tb(15);
	gotoxy(70, 1);
	tc(4);
	cprintf("P");
	tc(0);
	gotoxy(71, 1);
	cprintf("hysique");
	tb(co);
	tc(15);
	gotoxy(60, 2);
	cprintf("ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ");
	for (i = 2; i <= 4; i++) {
		gotoxy(60, i + 1);
		cprintf("                    ");
	}
} /* End line12 */

/* line5 */
void line5() {
	for (i = 1; i <= 8; i++) {
		tb(co);
		gotoxy(34, i + 3);
		cprintf("                               ");
		tb(8);
		gotoxy(34, i + 2);
		cprintf("  ");
	}
} /* End line5 */

/* line9 */
void line9() {
	for (i = 1; i <= 6; i++) {
		tb(co);
		gotoxy(40, i + 2);
		cprintf("                                        ");
		tb(0);
		gotoxy(40, i + 1);
		cprintf("  ");
		tb(co);
		gotoxy(40, 7);
		cprintf("  ");
		tc(15);
		gotoxy(40, 2);
		cprintf("HA");
	}
} /* End line9 */

/* func1 */
void func1() {
	tb(15);
	tc(4);
	gotoxy(1, 1);
	cprintf(" ð  ");
	tc(4);
	gotoxy(5, 1);
	cprintf("F");
	tc(0);
	gotoxy(6, 1);
	cprintf("ile          ");
	tc(4);
	gotoxy(19, 1);
	cprintf("M");
	tc(0);
	gotoxy(20, 1);
	cprintf("ath           ");
	tc(4);
	gotoxy(30, 1);
	cprintf("C");
	tc(0);
	gotoxy(31, 1);
	cprintf("alculate       ");
	tc(4);
	gotoxy(45, 1);
	cprintf("W");
	tc(0);
	gotoxy(46, 1);
	cprintf("indow          ");
	tc(4);
	gotoxy(60, 1);
	cprintf("H");
	tc(0);
	gotoxy(61, 1);
	cprintf("elp             ");
	tc(4);
	gotoxy(70, 1);
	cprintf("P");
	tc(0);
	gotoxy(71, 1);
	cprintf("hysics    ");
	tb(15);
	tc(4);
	gotoxy(60, 25);
	cprintf("Alt+c  ");
	gotoxy(47, 25);
	cprintf(" Alt+m ");
	gotoxy(33, 25);
	cprintf("Alt+w ");
	gotoxy(1, 25);
	cprintf(" F3");
	gotoxy(24, 25);
	cprintf("F1 ");
	gotoxy(10, 25);
	cprintf("  Alt+x");
	tc(0);
	gotoxy(4, 25);
	cprintf(" Open ");
	gotoxy(17, 25);
	cprintf(" Quit  ");
	gotoxy(26, 25);
	cprintf(" Help  ");
	gotoxy(39, 25);
	cprintf("Window  ");
	gotoxy(54, 25);
	cprintf("Math  ");
	gotoxy(66, 25);
	cprintf(" Caculate     ");
} /* End func1 */

/****** =================main====================***** */
void main() {
	setha();
	co = 1;
start:
	tb(co);
	window(0, 0, 80, 25);
	clrscr();
	/* funtion call */
	line();
	_setcursortype(_NOCURSOR);
	func1();
lp1:
	tb(2);
	tc(4);
	gotoxy(5, 1);
	cprintf("F");
	tc(0);
	gotoxy(6, 1);
	cprintf("ile");
	while (1) {
		ch = getch();
		switch (ch) {
		case 45:
			exit(9);
		case 13:
		case 80:
		case 33:
			tha = 'f';
			goto nn;
		case 50:
			tb(15);
			tc(4);
			gotoxy(5, 1);
			cprintf("F");
			tc(0);
			gotoxy(6, 1);
			cprintf("ile");
			tha = 'm';
			goto nn;
		case 61:
			tha = 'o';
			goto nn1;
		case 59:
		case 35:
			tha = 'h';
			goto nn;
		case 17:
			tb(15);
			tc(4);
			gotoxy(5, 1);
			cprintf("F");
			tc(0);
			gotoxy(6, 1);
			cprintf("ile");
			tha = 'w';
			goto nn;
		case 25:
			physiq();
		rupp:
			ch = getch();
			if (ch == 108) {
				closegraph();
				goto start;
			}
			else
				goto rupp;
		case 46:
			tb(15);
			tc(4);
			gotoxy(5, 1);
			cprintf("F");
			tc(0);
			gotoxy(6, 1);
			cprintf("ile");
			tha = 'c';
			goto nn;
		case 75:
			tb(15);
			tc(4);
			gotoxy(5, 1);
			cprintf("F");
			tc(0);
			gotoxy(6, 1);
			cprintf("ile");
			goto lp6;
		case 77:
			lp2 : tb(15);
			tc(4);
			gotoxy(5, 1);
			cprintf("F");
			tc(0);
			gotoxy(6, 1);
			cprintf("ile");
			tb(2);
			tc(4);
			gotoxy(19, 1);
			cprintf("M");
			tc(0);
			gotoxy(20, 1);
			cprintf("ath");
			ch = getch();
			switch (ch) {
			case 33:
				tha = 'f';
				goto nn;
			case 13:
			case 80:
			case 50:
				tha = 'm';
				goto nn;
			case 61:
				tha = 'o';
				goto nn1;
			case 59:
			case 35:
				tha = 'h';
				goto nn;
			case 17:
				tb(15);
				tc(4);
				gotoxy(19, 1);
				cprintf("M");
				tc(0);
				gotoxy(20, 1);
				cprintf("ath");
				tha = 'w';
				goto nn;
			case 25:
				physiq();
			rupp5:
				ch = getch();
				if (ch == 108) {
					closegraph();
					goto start;
				}
				else
					goto rupp5;
			case 46:
				tb(15);
				tc(4);
				gotoxy(19, 1);
				cprintf("M");
				tc(0);
				gotoxy(20, 1);
				cprintf("ath");
				tha = 'c';
				goto nn;
			case 45:
				exit(9);
			case 75:
				tb(15);
				tc(4);
				gotoxy(19, 1);
				cprintf("M");
				tc(0);
				gotoxy(20, 1);
				cprintf("ath");
				goto lp1;
			case 77:
				lp3 : tb(15);
				tc(4);
				gotoxy(19, 1);
				cprintf("M");
				tc(0);
				gotoxy(20, 1);
				cprintf("ath");
				tb(2);
				tc(4);
				gotoxy(30, 1);
				cprintf("C");
				tc(0);
				gotoxy(31, 1);
				cprintf("alculate");
				ch = getch();
				switch (ch) {
				case 45:
					exit(9);
				case 61:
					tha = 'o';
					goto nn1;
				case 59:
				case 35:
					tha = 'h';
					goto nn;
				case 33:
					tb(15);
					tc(4);
					gotoxy(30, 1);
					cprintf("C");
					tc(0);
					gotoxy(31, 1);
					cprintf("alculate");
					tha = 'f';
					goto nn;
				case 50:
					tb(15);
					tc(4);
					gotoxy(30, 1);
					cprintf("C");
					tc(0);
					gotoxy(31, 1);
					cprintf("alculate");
					tha = 'm';
					goto nn;
				case 17:
					tb(15);
					tc(4);
					gotoxy(30, 1);
					cprintf("C");
					tc(0);
					gotoxy(31, 1);
					cprintf("alculate");
					tha = 'w';
					goto nn;
				case 25:
					physiq();
				rupp6:
					ch = getch();
					if (ch == 108) {
						closegraph();
						goto start;
					}
					else
						goto rupp6;
				case 13:
				case 80:
				case 46:
					tha = 'c';
					goto nn;
				case 75:
					tb(15);
					tc(4);
					gotoxy(30, 1);
					cprintf("C");
					tc(0);
					gotoxy(31, 1);
					cprintf("alculate");
					goto lp2;
				case 77:
					lp4 : tb(15);
					tc(4);
					gotoxy(30, 1);
					cprintf("C");
					tc(0);
					gotoxy(31, 1);
					cprintf("alculate");
					tb(2);
					tc(4);
					gotoxy(45, 1);
					cprintf("W");
					tc(0);
					gotoxy(46, 1);
					cprintf("indow");
					ch = getch();
					switch (ch) {
					case 13:
					case 80:
					case 17:
						tha = 'w';
						goto nn;
					case 59:
					case 35:
						tha = 'h';
						goto nn;
					case 33:
						tb(15);
						tc(4);
						gotoxy(45, 1);
						cprintf("W");
						tc(0);
						gotoxy(46, 1);
						cprintf("indow");
						tha = 'f';
						goto nn;
					case 50:
						tb(15);
						tc(4);
						gotoxy(45, 1);
						cprintf("W");
						tc(0);
						gotoxy(46, 1);
						cprintf("indow");
						tha = 'm';
						goto nn;
					case 25:
						physiq();
					rupp2:
						ch = getch();
						if (ch == 108) {
							closegraph();
							goto start;
						}
						else
							goto rupp2;
					case 46:
						tb(15);
						tc(4);
						gotoxy(45, 1);
						cprintf("W");
						tc(0);
						gotoxy(46, 1);
						cprintf("indow");
						tha = 'c';
						goto nn;
					case 45:
						exit(9);
					case 61:
						tha = 'o';
						goto nn1;
					case 75:
						tb(15);
						tc(4);
						gotoxy(45, 1);
						cprintf("W");
						tc(0);
						gotoxy(46, 1);
						cprintf("indow");
						goto lp3;
					case 77:
						lp5 : tb(15);
						tc(4);
						gotoxy(45, 1);
						cprintf("W");
						tc(0);
						gotoxy(46, 1);
						cprintf("indow");
						tb(2);
						tc(4);
						gotoxy(60, 1);
						cprintf("H");
						tc(0);
						gotoxy(61, 1);
						cprintf("elp");
						ch = getch();
						switch (ch) {
						case 45:
							exit(9);
						case 17:
							tb(15);
							tc(4);
							gotoxy(60, 1);
							cprintf("H");
							tc(0);
							gotoxy(61, 1);
							cprintf("elp");
							tb(2);
							tc(4);
							gotoxy(45, 1);
							cprintf("W");
							tc(0);
							gotoxy(46, 1);
							cprintf("indow");
							tha = 'w';
							goto nn;
						case 59:
						case 35:
						case 13:
							tha = 'h';
							goto nn;
						case 33:
							tb(15);
							tc(4);
							gotoxy(60, 1);
							cprintf("H");
							tc(0);
							gotoxy(61, 1);
							cprintf("elp");
							tha = 'f';
							goto nn;
						case 50:
							tb(15);
							tc(4);
							gotoxy(60, 1);
							cprintf("H");
							tc(0);
							gotoxy(61, 1);
							cprintf("elp");
							tha = 'm';
							goto nn;
						case 61:
							tha = 'o';
							goto nn1;
						case 25:
							physiq();
						rupp3:
							ch = getch();
							if (ch == 108) {
								closegraph();
								goto start;
							}
							else
								goto rupp3;
						case 46:
							tb(15);
							tc(4);
							gotoxy(60, 1);
							cprintf("H");
							tc(0);
							gotoxy(61, 1);
							cprintf("elp");
							tha = 'c';
							goto nn;
						case 75:
							tb(15);
							tc(4);
							gotoxy(60, 1);
							cprintf("H");
							tc(0);
							gotoxy(61, 1);
							cprintf("elp");
							goto lp4;
						case 77:
							lp6 : tb(15);
							tc(4);
							gotoxy(60, 1);
							cprintf("H");
							tc(0);
							gotoxy(61, 1);
							cprintf("elp");
							tb(2);
							tc(4);
							gotoxy(70, 1);
							cprintf("P");
							tc(0);
							gotoxy(71, 1);
							cprintf("hysics");
							ch = getch();
							switch (ch) {
							case 75:
								tb(15);
								tc(4);
								gotoxy(70, 1);
								cprintf("P");
								tc(0);
								gotoxy(71, 1);
								cprintf("hysics");
								goto lp5;
							case 77:
								tb(15);
								tc(4);
								gotoxy(70, 1);
								cprintf("P");
								tc(0);
								gotoxy(71, 1);
								cprintf("hysics");
								goto lp1;
							case 45:
								exit(9);
							case 61:
								tha = 'o';
								goto nn1;
							case 59:
							case 35:
								tha = 'h';
								goto nn;
							case 17:
								tb(15);
								tc(4);
								gotoxy(70, 1);
								cprintf("P");
								tc(0);
								gotoxy(71, 1);
								cprintf("hysics");
								tha = 'w';
								goto nn;
							case 33:
								tb(15);
								tc(4);
								gotoxy(70, 1);
								cprintf("P");
								tc(0);
								gotoxy(71, 1);
								cprintf("hysics");
								tha = 'f';
								goto nn;
							case 50:
								tb(15);
								tc(4);
								gotoxy(70, 1);
								cprintf("P");
								tc(0);
								gotoxy(71, 1);
								cprintf("hysics");
								tha = 'm';
								goto nn;
							case 46:
								tb(15);
								tc(4);
								gotoxy(70, 1);
								cprintf("P");
								tc(0);
								gotoxy(71, 1);
								cprintf("hysics");
								tha = 'c';
								goto nn;
							case 13:
							case 25:
								physiq();
							rupp4:
								ch = getch();
								if (ch == 108) {
									closegraph();
									goto start;
								}
								else
									goto rupp4;
							default:
								goto lp6;
							}
						default:
							goto lp5;
						}
					default:
						goto lp4;
					}
				default:
					goto lp3;
				}
			default:
				goto lp2;
			}
		default:
			goto lp1;
		}
	}
nn:
	switch (tha) {
	case 'h':
		help();
	ee:
		ch = getch();
		if (ch == 27)
			goto start;
		else
			goto ee;
	loop9:
	case 'f':
		lion : tb(2);
		tc(4);
		gotoxy(5, 1);
		cprintf("F");
		tc(0);
		gotoxy(6, 1);
		cprintf("ile");
		tb(8);
		for (i = 1; i <= 6; i++) {
			gotoxy(2, i + 2);
			cprintf("                ");
		}
		tb(15);
		tc(4);
		gotoxy(2, 3);
		cprintf("N");
		gotoxy(2, 4);
		cprintf("O");
		tc(0);
		gotoxy(3, 3);
		cprintf("ew           ");
		gotoxy(3, 4);
		cprintf("pen       F3 ");
		gotoxy(1, 2);
		cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
		gotoxy(1, 5);
		cprintf("ÃÄÄÄÄÄÄÄÄÄÄÄÄÄ´");
		gotoxy(1, 6);
		cprintf("³             ³");
		gotoxy(2, 6);
		cprintf("Quit   Alt+x ");
		for (i = 1; i <= 2; i++) {
			gotoxy(1, i + 2);
			putch(179);
		}
		for (i = 1; i <= 2; i++) {
			gotoxy(15, i + 2);
			putch(179);
		}
		gotoxy(1, 7);
		cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
		while (2) {
			ch = getch();
			switch (ch) {
			case 75:
				line2();
				goto lp6;
			case 78:
			case 110:
				line2();
				line14();
				goto lp1;
			case 79:
			case 111:
				line2();
				tha = 'o';
				goto nn1;
			case 77:
				line2();
				goto tiger;
			case 45:
				exit(2);
			case 61:
				line2();
				tha = 'o';
				goto nn1;
			case 27:
				line2();
				goto lp1;
			case 72:
				goto loop8;
			case 80:
				loop6 : tb(2);
				tc(4);
				gotoxy(2, 3);
				cprintf("N");
				tc(0);
				gotoxy(3, 3);
				cprintf("ew          ");
				ch = getch();
				switch (ch) {
				case 75:
					line2();
					goto lp6;
				case 13:
					line2();
					line14();
					goto lp1;
				case 61:
					line2();
					tha = 'o';
					goto nn1;
				case 77:
					line2();
					goto tiger;
				case 27:
					line2();
					goto lp1;
				case 45:
					exit(2);
				case 72:
					tb(7);
					tc(4);
					gotoxy(2, 3);
					cprintf("N");
					tc(0);
					gotoxy(3, 3);
					cprintf("ew          ");
					goto loop8;
				case 80:
					loop7 : tb(7);
					tc(4);
					gotoxy(2, 3);
					cprintf("N");
					tc(0);
					gotoxy(3, 3);
					cprintf("ew          ");
					tb(2);
					tc(4);
					gotoxy(2, 4);
					cprintf("O");
					tc(0);
					gotoxy(3, 4);
					cprintf("pen       F3");
					ch = getch();
					switch (ch) {
					case 13:
						line2();
						tha = 'o';
						goto nn1;
					case 75:
						line2();
						goto lp6;
					case 77:
						line2();
						goto tiger;
					case 27:
						line2();
						goto lp1;
					case 45:
						exit(2);
					case 61:
						line2();
						tha = 'o';
						goto nn1;
					case 72:
						tb(7);
						tc(4);
						gotoxy(2, 4);
						cprintf("O");
						tc(0);
						gotoxy(3, 4);
						cprintf("pen       F3");
						goto loop6;
					case 80:
						loop8 : tb(7);
						tc(4);
						gotoxy(2, 4);
						cprintf("O");
						tc(0);
						gotoxy(3, 4);
						cprintf("pen       F3");
						tb(2);
						tc(0);
						gotoxy(2, 6);
						cprintf("Quit   Alt+x ");
						ch = getch();
						switch (ch) {
						case 75:
							line2();
							goto lp6;
						case 77:
							line2();
							goto tiger;
						case 27:
							line2();
							goto lp1;
						case 72:
							tb(7);
							tc(0);
							gotoxy(2, 6);
							cprintf("Quit   Alt+x ");
							goto loop7;
						case 80:
							tb(7); ;
							tc(0);
							gotoxy(2, 6);
							cprintf("Quit   Alt+x ");
							goto loop6;
						case 13:
						case 45:
							exit(2);
						case 61:
							line2();
							tha = 'o';
							goto nn1;
						default:
							goto loop8;
						}
					default:
						goto loop7;
					}
				default:
					goto loop6;
				}
			default:
				goto loop9;
			}
		}
	nn1:
		switch (tha) {
		case 'o':
			tb(8);
			for (i = 1; i <= 19; i++) {
				gotoxy(19, i + 4);
				cprintf("                                                 ");
			}
			tb(15);
			gotoxy(17, 4);
			tc(15);
			cprintf("ÉÍ[ ]");
			tc(10);
			gotoxy(20, 4);
			putch('þ');
			tc(15);
			gotoxy(22, 4);
			cprintf("ÍÍÍÍÍÍÍÍÍÍÍÍÍ ");
			gotoxy(36, 4);
			cprintf("Open a file ");
			gotoxy(48, 4);
			cprintf("ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ");
			gotoxy(65, 4);
			cprintf("»");
			gotoxy(18, 5);
			cprintf("                                               ");
			gotoxy(18, 19);
			cprintf("                                               ");
			tb(7);
			gotoxy(18, 6);
			cprintf("                                               ");
			tb(7);
			gotoxy(18, 8);
			cprintf("                                               ");
			gotoxy(18, 9);
			cprintf("                                               ");
			for (i = 1; i <= 12; i++) {
				gotoxy(18, i + 6);
				cprintf("  ");
			}
			for (i = 1; i <= 17; i++) {
				gotoxy(17, i + 4);
				putch('º');
			}
			for (i = 1; i <= 17; i++) {
				gotoxy(65, i + 4);
				putch('º');
			}
			gotoxy(17, 22);
			cprintf("È");
			gotoxy(65, 22);
			cprintf("¼");
			gotoxy(18, 22);
			cprintf("ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ");
			tc(14);
			gotoxy(20, 6);
			cprintf("N");
			gotoxy(20, 9);
			cprintf("F");
			tc(15);
			gotoxy(21, 6);
			cprintf("ame");
			gotoxy(21, 9);
			cprintf("iles");
			for (i = 1; i <= 12; i++) {
				gotoxy(51, i + 6);
				cprintf("              ");
			}
			for (i = 1; i <= 9; i++) {
				tb(3);
				gotoxy(20, i + 9);
				cprintf("                               ");
			}
			for (i = 1; i <= 8; i++) {
				tb(3);
				tc(1);
				gotoxy(35, i + 9);
				cprintf("³");
			}
			tb(1);
			for (i = 1; i <= 2; i++) {
				gotoxy(18, 19 + i);
				cprintf("                                               ");
			}
			tb(1);
			tc(11);
			gotoxy(20, 7);
			cprintf(" C:\\TC\\BIN\\*.CPP            ");
			gotoxy(21, 7);
			tb(2);
			tc(11);
			cprintf("C:\\TC\\BIN\\*.CPP");
			gotoxy(48, 7);
			cprintf("   ");
			tc(0);
			gotoxy(49, 7);
			putch(25);
			tb(1);
			tc(3);
			gotoxy(21, 18);
			putch(17);
			gotoxy(49, 18);
			cprintf("");
			gotoxy(19, 20);
			tc(7);
			cprintf("C:\\TC\\BIN\\.*CPP");
			tb(3);
			tc(1);
			gotoxy(22, 18);
			cprintf("þ");
			gotoxy(23, 18);
			cprintf("±±±±±±±±±±±±±±±±±±±±±±±±±±");
			tb(3);
			tc(14);
			gotoxy(21, 10);
			cprintf("MENU1.CPP");
			tc(0);
			gotoxy(21, 11);
			cprintf("YEAR.CPP");
			gotoxy(21, 13);
			cprintf("LEAP.CPP");
			gotoxy(21, 12);
			cprintf("DECI_NUM.CPP");
			gotoxy(21, 14);
			cprintf("SORT_NUM.CPP");
			gotoxy(21, 15);
			cprintf("LETTER.CPP");
			gotoxy(21, 16);
			cprintf("PASCAL_TRI.CPP");
			gotoxy(21, 17);
			cprintf("GRADE_STU.CPP");
			gotoxy(36, 10);
			cprintf("STAR.CPP");
			gotoxy(36, 11);
			cprintf("DISCOUNT.CPP");
			gotoxy(36, 12);
			cprintf("POSITIVE.CPP");
			gotoxy(36, 13);
			cprintf("SYSTEM.CPP");
			gotoxy(36, 14);
			cprintf("MULTIPLICAT.CPP");
			tb(1);
			tc(7);
			gotoxy(19, 21);
			cprintf("MENU1.CPP");
			gotoxy(38, 21);
			cprintf("1428 Feb 28,2002   4:03pm");
			while (9) {
			xx:
				ch = getch();
				switch (ch) {
				case 45:
					exit(9);
				case 27:
					line8();
					goto lp1;
				case 9:
				case 13:
				case 80:
					tb(1);
					tc(11);
					gotoxy(21, 7);
					cprintf("C:\\TC\\BIN\\*.CPP");
					goto ll1;
				ll:
					ch = getch();
					switch (ch) {
					case 27:
						line8();
						goto lp1;
					case 45:
						exit(1);
					case 72:
						goto ll11;
					case 80:
					case 77:
						ll1 : tb(2);
						tc(15);
						gotoxy(20, 10);
						cprintf(" MENU1.CPP     ");
						tb(1);
						tc(7);
						gotoxy(19, 21);
						cprintf("MENU1.CPP");
						gotoxy(38, 21);
						cprintf("1428  Feb 28,2002   4:03pm ");
						ch = getch();
						switch (ch) {
						case 27:
							line8();
							goto lp1;
						case 45:
							exit(1);
						case 13:
							tha = 'm';
							goto wi;
						case 77:
							tb(3);
							tc(0);
							gotoxy(20, 10);
							cprintf(" MENU1.CPP     ");
							goto ll9;
						case 80:
							ll2 : tb(3);
							tc(0);
							gotoxy(20, 10);
							cprintf(" MENU1.CPP     ");
							tb(2);
							tc(15);
							gotoxy(20, 11);
							cprintf(" YEAR.CPP      ");
							tb(1);
							tc(7);
							gotoxy(19, 21);
							cprintf("YEAR.CPP      ");
							tb(1);
							tc(7);
							gotoxy(38, 21);
							cprintf("1198  Mar 21,2002   8:01pm ");
							ch = getch();
							switch (ch) {
							case 27:
								line8();
								goto lp1;
							case 13:
								tha = 'y';
								goto wi;
							case 45:
								exit(1);
							case 77:
								tb(3);
								tc(0);
								gotoxy(20, 11);
								cprintf(" YEAR.CPP      ");
								goto ll10;
							case 72:
								tb(3);
								tc(0);
								gotoxy(20, 11);
								cprintf(" YEAR.CPP      ");
								goto ll1;
							case 80:
								ll3 : tb(3);
								tc(0);
								gotoxy(20, 11);
								cprintf(" YEAR.CPP      ");
								tb(2);
								tc(15);
								gotoxy(20, 12);
								cprintf(" DECI_NUM.CPP  ");
								tb(1);
								tc(7);
								gotoxy(19, 21);
								cprintf("DECI_NUM.CPP ");
								tb(1);
								tc(7);
								gotoxy(38, 21);
								cprintf(" 458  Mar 7,2002    3:27pm ");
								ch = getch();
								switch (ch) {
								case 27:
									line8();
									goto lp1;
								case 45:
									exit(1);
								case 13:
									tha = 'c';
									goto wi;
								case 77:
									tb(3);
									tc(0);
									gotoxy(20, 12);
									cprintf(" DECI_NUM.CPP  ");
									goto ll11;
								case 72:
									tb(3);
									tc(0);
									gotoxy(20, 12);
									cprintf(" DECI_NUM.CPP  ");
									goto ll2;
								case 80:
									ll4 : tb(3);
									tc(0);
									gotoxy(20, 12);
									cprintf(" DECI_NUM.CPP  ");
									tb(2);
									tc(15);
									gotoxy(20, 13);
									cprintf(" LEAP.CPP      ");
									tb(1);
									tc(7);
									gotoxy(19, 21);
									cprintf("LEAP.CPP     ");
									tb(1);
									tc(7);
									gotoxy(38, 21);
									cprintf(" 340  Mar 7,2002    3:30pm ");
									ch = getch();
									switch (ch) {
									case 27:
										line8();
										goto lp1;
									case 13:
										tha = 'p';
										goto wi;
									case 45:
										exit(1);
									case 77:
										tb(3);
										tc(0);
										gotoxy(20, 13);
										cprintf(" LEAP.CPP      ");
										goto ll12;
									case 72:
										tb(3);
										tc(0);
										gotoxy(20, 13);
										cprintf(" LEAP.CPP      ");
										goto ll3;
									case 80:
										ll5 : tb(3);
										tc(0);
										gotoxy(20, 13);
										cprintf(" LEAP.CPP      ");
										tb(2);
										tc(15);
										gotoxy(20, 14);
										cprintf(" SORT_NUM.CPP  ");
										tb(1);
										tc(7);
										gotoxy(19, 21);
										cprintf("SORT_NUM.CPP ");
										tb(1);
										tc(7);
										gotoxy(38, 21);
										cprintf("1111  Mar 17,2002   4:33pm ");
										ch = getch();
										switch (ch) {
										case 27:
											line8();
											goto lp1;
										case 45:
											exit(1);
										case 13:
											tha = 's';
											goto wi;
										case 77:
											tb(3);
											tc(0);
											gotoxy(20, 14);
											cprintf(" SORT_NUM.CPP  ");
											goto ll13;
										case 72:
											tb(3);
											tc(0);
											gotoxy(20, 14);
											cprintf(" SORT_NUM.CPP  ");
											goto ll4;
										case 80:
											ll6 : tb(3);
											tc(0);
											gotoxy(20, 14);
											cprintf(" SORT_NUM.CPP  ");
											tb(2);
											tc(15);
											gotoxy(20, 15);
											cprintf(" LETTER.CPP    ");
											tb(1);
											tc(7);
											gotoxy(19, 21);
											cprintf("LETTER.CPP   ");
											tb(1);
											tc(7);
											gotoxy(38, 21);
											cprintf(" 864  Mar 7,2002    3:22pm ");
											ch = getch();
											switch (ch) {
											case 27:
												line8();
												goto lp1;
											case 45:
												exit(1);
											case 13:
												tha = 'l';
												goto wi;
											case 72:
												tb(3);
												tc(0);
												gotoxy(20, 15);
												cprintf(" LETTER.CPP    ");
												goto ll5;
											case 80:
												ll7 : tb(3);
												tc(0);
												gotoxy(20, 15);
												cprintf(" LETTER.CPP    ");
												tb(2);
												tc(15);
												gotoxy(20, 16);
												cprintf(" PASCAL_TRI.CPP");
												tb(1);
												tc(7);
												gotoxy(19, 21);
												cprintf("PASCA_TRI.CPP");
												tb(1);
												tc(7);
												gotoxy(38, 21);
												cprintf("1392  Apr 2,2002    7:46am ");
												ch = getch();
												switch (ch) {
												case 45:
													exit(9);
												case 13:
													tha = 'a';
													goto wi;
												case 27:
													line8();
													goto lp1;
												case 72:
													tb(3);
													tc(0);
													gotoxy(20, 16);
													cprintf(" PASCAL_TRI.CPP");
													goto ll6;
												case 80:
													ll8 : tb(3);
													tc(0);
													gotoxy(20, 16);
													cprintf(" PASCAL_TRI.CPP");
													tb(2);
													tc(15);
													gotoxy(20, 17);
													cprintf(" GRADE_STU.CPP ");
													tb(1);
													tc(7);
													gotoxy(19, 21);
													cprintf("GRADE_STU.CPP");
													tb(1);
													tc(7);
													gotoxy(38, 21);
													cprintf("1930  Apr 1,2002    3:59pm ");
													ch = getch();
													switch (ch) {
													case 45:
													 exit(9);
													case 13:
													 tha = 'g';
													 goto wi;
													case 27:
													 line8();
													 goto lp1;
													case 72:
													 tb(3);
													 tc(0);
													 gotoxy(20, 17);
													 cprintf(" GRADE_STU.CPP ");
													 goto ll7;
													case 80:
													 ll9 : tb(3);
													 tc(0);
													 gotoxy(20, 17);
													 cprintf(" GRADE_STU.CPP ");
													 tb(2);
													 tc(15);
													 gotoxy(36, 10);
													 cprintf("STAR.CPP       ");
													 tb(1);
													 tc(7);
													 gotoxy(19, 21);
													 cprintf("STAR.CPP      ");
													 tb(1);
													 tc(7);
													 gotoxy(38, 21);
													 cprintf("1136  Jan 15,2002   3:59pm ");
													 ch = getch();
													 switch (ch) {
													 case 45:
													 exit(9);
													 case 13:
													 tha = 'S';
													 goto wi;
													 case 27:
													 line8();
													 goto lp1;
													 case 72:
													 tb(3);
													 tc(0);
													 gotoxy(36, 10);
													 cprintf("STAR.CPP       ");
													 goto ll8;
													 case 75:
													 tb(3);
													 tc(0);
													 gotoxy(36, 10);
													 cprintf("STAR.CPP       ");
													 goto ll1;
													 case 80:
													 ll10 : tb(3);
													 tc(0);
													 gotoxy(36, 10);
													 cprintf("STAR.CPP       ");
													 tb(2);
													 tc(15);
													 gotoxy(36, 11);
													 cprintf("DISCOUNT.CPP   ");
													 tb(1);
													 tc(7);
													 gotoxy(19, 21);
													 cprintf("DISCOUNT.CPP   ");
													 tb(1);
													 tc(7);
													 gotoxy(38, 21);
													 cprintf("3482  Jan 18,2002   5:47pm ");
													 ch = getch();
													 switch (ch) {
													 case 45:
													 exit(9);
													 case 13:
													 tha = 'd';
													 goto wi;
													 case 27:
													 line8();
													 goto lp1;
													 case 72:
													 tb(3);
													 tc(0);
													 gotoxy(36, 11);
													 cprintf("DISCOUNT.CPP   ");
													 goto ll9;
													 case 75:
													 tb(3);
													 tc(0);
													 gotoxy(36, 11);
													 cprintf("DISCOUNT.CPP   ");
													 goto ll2;
													 case 80:
													 ll11 : tb(3);
													 tc(0);
													 gotoxy(36, 11);
													 cprintf("DISCOUNT.CPP   ");
													 tb(2);
													 tc(15);
													 gotoxy(36, 12);
													 cprintf("POSITIVE.CPP   ");
													 tb(1);
													 tc(7);
													 gotoxy(19, 21);
													 cprintf("POSITIVE.CPP   ");
													 tb(1);
													 tc(7);
													 gotoxy(38, 21);
													 cprintf(" 494  Apr  4,2002   9:34pm ");
													 ch = getch();
													 switch (ch) {
													 case 45:
													 exit(9);
													 case 13:
													 tha = 'i';
													 goto wi;
													 case 27:
													 line8();
													 goto lp1;
													 case 72:
													 tb(3);
													 tc(0);
													 gotoxy(36, 12);
													 cprintf("POSITIVE.CPP   ");
													 goto ll10;
													 case 75:
													 tb(3);
													 tc(0);
													 gotoxy(36, 12);
													 cprintf("POSITIVE.CPP   ");
													 goto ll3;
													 case 80:
													 ll12 : tb(3);
													 tc(0);
													 gotoxy(36, 12);
													 cprintf("POSITIVE.CPP   ");
													 tb(2);
													 tc(15);
													 gotoxy(36, 13);
													 cprintf("SYSTEM.CPP     ");
													 tb(1);
													 tc(7);
													 gotoxy(19, 21);
													 cprintf("SYSTEM.CPP     ");
													 tb(1);
													 tc(7);
													 gotoxy(38, 21);
													 cprintf(" 882  Apr 28,2002   1:36pm ");
													 ch = getch();
													 switch (ch) {
													 case 45:
													 exit(9);
													 case 13:
													 tha = 'w';
													 goto wi;
													 case 27:
													 line8();
													 goto lp1;
													 case 72:
													 tb(3);
													 tc(0);
													 gotoxy(36, 13);
													 cprintf("SYSTEM.CPP     ");
													 goto ll11;
													 case 75:
													 tb(3);
													 tc(0);
													 gotoxy(36, 13);
													 cprintf("SYSTEM.CPP     ");
													 goto ll4;
													 case 80:
													 ll13 : tb(3);
													 tc(0);
													 gotoxy(36, 13);
													 cprintf("SYSTEM.CPP     ");
													 tb(2);
													 tc(15);
													 gotoxy(36, 14);
													 cprintf("MULTIPLICAT.CPP");
													 tb(1);
													 tc(7);
													 gotoxy(19, 21);
													 cprintf("MULTIPLICAT.CPP");
													 tb(1);
													 tc(7);
													 gotoxy(38, 21);
													 cprintf(" 870  Apr 30,2002   7:57pm ");
													 ch = getch();
													 switch (ch) {
													 case 45:
													 exit(9);
													 case 13:
													 tha = 'M';
													 goto wi;
													 case 27:
													 line8();
													 goto lp1;
													 case 72:
													 tb(3);
													 tc(0);
													 gotoxy(36, 14);
													 cprintf("MULTIPLICAT.CPP");
													 goto ll12;
													 case 75:
													 tb(3);
													 tc(0);
													 gotoxy(36, 14);
													 cprintf("MULTIPLICAT.CPP");
													 goto ll5;
													 default:
													 goto ll13;
													 }
													 default:
													 goto ll12;
													 }
													 default:
													 goto ll11;
													 }
													 default:
													 goto ll10;
													 }
													 default:
													 goto ll9;
													 }
													default:
													 goto ll8;
													}
												default:
													goto ll7;
												}
											default:
												goto ll6;
											}
										default:
											goto ll5;
										}
									default:
										goto ll4;
									}
								default:
									goto ll3;
								}
							default:
								goto ll2;
							}
						default:
							goto ll1;
						}
					default:
						goto ll;
					}
				default:
					goto xx;
				}
			}
		wi:
			switch (tha) {
			case 'd':
				sr2 : tb(co);
				line14();
				line8();
				line2();
				discount();
			tt:
				_setcursortype(_NOCURSOR);
				tha = getch();
				tc(9);
				switch (tha) {
				case 'A':
				case 'a':
					tb(2);
					tc(10);
					gotoxy(24, 15);
					cprintf("<< >> Again");
					tc(11 + 128);
					gotoxy(26, 15);
					cprintf("A");
					delay(1000);
					goto sr2;
				case 'W':
				case 'w':
					tb(2);
					tc(10);
					gotoxy(24, 16);
					cprintf("<< >> written by");
					tc(10 + 128);
					gotoxy(26, 16);
					cprintf("W");
					delay(900);
					tb(co);
					tc(10);
					gotoxy(24, 16);
					cprintf("<< >> written by");
					tc(10 + 128);
					gotoxy(26, 16);
					cprintf("W");
					tc(14);
					strcpy(str, " Write by Mr Iech Setha.");
					for (i = 1; i <= 24; i++) {
						sound(random(700 + i*i*i + 9*i));
						gotoxy(27 + i, 20);
						cprintf("%c", str[i]);
						delay(50);
						nosound();
					}
					goto tt;
				case 'T':
				case 't':
					tb(2);
					tc(10);
					gotoxy(24, 17);
					cprintf("<< >> taught by");
					tc(9 + 128);
					gotoxy(26, 17);
					cprintf("T");
					delay(900);
					tb(co);
					tc(10);
					gotoxy(24, 17);
					cprintf("<< >> taught by");
					tc(9 + 128);
					gotoxy(26, 17);
					cprintf("T");
					tc(14);
					strcpy(str, " Taught by Mr Kean Tak. ");
					for (i = 1; i <= 24; i++) {
						sound(random(700 + i*i*i + 9*i));
						gotoxy(27 + i, 20);
						cprintf("%c", str[i]);
						delay(50);
						nosound();
					}
					goto tt;
				case 'Q':
				case 'q':
					goto lp1;
				default:
					gotoxy(28, 20);
					tc(5 + 128);
					cprintf(" You are crazy!        ");
					goto tt;
				}
			case 'S':
				sr1 : tb(co);
				line14();
				line8();
				line2();
				star();
			aaig:
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto sr1;
				else if (ch == 'n' || ch == 'N')
					goto lp1;
				else
					goto aaig;
			case 'i':
				sr3 : tb(co);
				line14();
				line8();
				line2();
				positive();
			bc:
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto sr3;
				else if (ch == 'n' || ch == 'N')
					goto lp1;
				else
					goto bc;
			case 'a':
				we : tb(co);
				line14();
				line8();
				line2();
				pascal_tri();
			we1:
				ch = getch();
				if (ch == 'n' || ch == 'N')
					goto lp1;
				else if (ch == 'y' || ch == 'Y')
					goto we;
				else
					goto we1;
			case 'g':
				sts : tb(co);
				line14();
				line8();
				line2();
				grade();
			v7:
				ch = getch();
				if (ch == 'n' || ch == 'N')
					goto lp1;
				else if (ch == 'y' || ch == 'Y')
					goto sts;
				else
					goto v7;
			case 'y':
				sr : tb(co);
				line14();
				line8();
				line2();
				year_1();
			aai:
				ch = getch();
				gotoxy(54, 18);
				if (ch == 'y' || ch == 'Y')
					goto sr;
				else if (ch == 'N' || ch == 'n')
					goto lp1;
				else
					goto aai;
			case 's':
				l : tb(co);
				line14();
				line8();
				line2();
				sort_num();
			aa1:
				gotoxy(50, 22);
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto l;
				else if (ch == 'n' || ch == 'N')
					goto lp1;
				else
					goto aa1;
			case 'w':
				tb(co);
				line14();
				line8();
				line2();
				sys();
				goto lp1;
			case 'M':
				tb(co);
				line14();
				line8();
				line2();
				arith();
				goto lp1;
			case 'm':
				line8();
				line2();
				tb(co);
				tc(14);
				line4();
				gotoxy(15, 4);
				cprintf("ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸");
				gotoxy(15, 5);
				cprintf("³      CHOOSE THE FOLLOWING       ³");
				gotoxy(15, 6);
				cprintf("³");
				gotoxy(49, 6);
				cprintf("³");
				gotoxy(15, 7);
				cprintf("³ 1:Factoriel of a number         ³");
				gotoxy(15, 8);
				cprintf("³ 2:Prime or not                  ³");
				gotoxy(15, 9);
				cprintf("³ 3:Odd or even                   ³");
				gotoxy(15, 10);
				cprintf("³ 4:Exit                          ³");
				gotoxy(15, 11);
				cprintf("ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾");
				_setcursortype(_NORMALCURSOR);
			ag:
				tc(14);
				gotoxy(15, 13);
				cprintf("Please choice one:   ");
				gotoxy(33, 13);
				tc(11);
				scanf("%d", &i);
				while (1) {
					switch (i) {
					case 1:
						tb(co);
						gotoxy(15, 17);
						cprintf("                                               ");
						gotoxy(15, 19);
						cprintf("                                               ");
						gotoxy(15, 15);
						cprintf("                                                  ");
						gotoxy(15, 17);
						printf("Please input n from the keyboard:");
						scanf("%d", &n);
						gotoxy(15, 19);
						printf("Factoriel of n is:%d!=1*2*....*%d=%ld", n, n, fact(n));
						goto ag;
					case 2:
						tb(co);
						gotoxy(15, 17);
						cprintf("                                               ");
						gotoxy(15, 19);
						cprintf("                                               ");
						tc(12);
						gotoxy(15, 15);
						cprintf("Please input the number :     ");
						gotoxy(41, 15);
						scanf("%d", &n);
						if (n == 2 || n == 3) {
							gotoxy(15, 17);
							tc(10 + 128);
							cprintf("%d is Pime number", n);
						}
						else if (n % 6 == 1 || n % 6 == 5) {
							gotoxy(15, 17);
							tc(10 + 128);
							cprintf("%d is Pime number", n);
						}
						else {
							gotoxy(15, 17);
							tc(10 + 128);
							cprintf("%d is not the Pime number", n);
						}
						goto ag;
					case 3:
						tb(co);
						gotoxy(15, 17);
						cprintf("                                               ");
						gotoxy(15, 19);
						cprintf("                                               ");
						tc(11);
						gotoxy(15, 15);
						cprintf("Please input the number :     ");
						gotoxy(41, 15);
						scanf("%d", &n);
						if (n == 0) {
							gotoxy(15, 17);
							tc(10 + 128);
							cprintf("%d is the not odd or even number ", n);
						}
						else if (n % 2 == 0) {
							gotoxy(15, 17);
							tc(10 + 128);
							cprintf("%d is the even number ", n);
						}
						else {
							gotoxy(15, 17);
							tc(10 + 128);
							cprintf("%d is the odd number ", n);
						}
						goto ag;
					case 4:
						tb(1);
						line14();
						goto lp1;
					default:
						goto ag;
					}
				}
			case 'l':
				line8();
				line2();
				line14();
				tb(co);
				_setcursortype(_NORMALCURSOR);
				tc(11);
				gotoxy(33, 5);
				cprintf("The program is about");
				gotoxy(18, 6);
				cprintf("small letter,capital letter,digit and special symbol");
			strt:
				textcolor(14);
				gotoxy(15, 8);
				cprintf("The character input from the keybord is:");
				tc(12 + 128);
				gotoxy(25, 22);
				cprintf("Press <<Esc>> to quit ");
				tc(15);
				gotoxy(57, 8);
				cscanf("%c", &ch);
				tc(14);
				if (ch >= 65 && ch <= 90) {
					gotoxy(30, 10);
					cprintf("Capital letter    ");
				}
				else if (ch >= 97 && ch <= 122) {
					gotoxy(30, 10);
					cprintf("small letter     ");
				}
				else if (ch >= 48 && ch <= 57) {
					gotoxy(30, 10);
					cprintf("digit             ");
				}
				else if (ch >= 0 && ch <= 47 && ch != 27) {
					gotoxy(30, 10);
					cprintf("special symbol    ");
				}
				else if (ch >= 58 && ch <= 64) {
					gotoxy(30, 10);
					cprintf("special symbol    ");
				}
				else if (ch >= 91 && ch <= 96) {
					gotoxy(30, 10);
					cprintf("special symbol    ");
				}
				else if (ch == 27) {
					sound(2000);
					delay(900);
					nosound();
					goto lp1;
				}
				goto strt;
			case 'c':
				line14();
				line8();
				line2();
				_setcursortype(_NORMALCURSOR);
				tb(co);
				for (i = 1; i <= 9; i++) {
					gotoxy(18, i + 6);
					cprintf("                                       ");
				}
				gotoxy(20, 4);
				cprintf("The program is about the decimal number of key");
				gotoxy(19, 5);
				cprintf(" If you want to know you should press any key to see.");
				tc(4);
				gotoxy(30, 7);
				cprintf("The code of key");
				tc(11);
				gotoxy(28, 14);
				cprintf("Press \"Esc\" for exit");
			bb:
				tc(14);
				gotoxy(38, 10);
				ch = getch();
				gotoxy(38, 10);
				printf("%d   ", ch);
				if (ch == 27) {
					sound(1000);
					delay(999);
					nosound();
					goto lp1;
				}
				else
					goto bb;
			case 'p':
				a4 : line8();
				line2();
				line14();
				tb(co);
				_setcursortype(_NORMALCURSOR);
				tc(11);
				gotoxy(22, 5);
				cprintf("Please input the year you want to know: ");
				tc(10);
				scanf("%d", &year);
				if (year % 4 == 0) {
					tc(14);
					gotoxy(25, 8);
					cprintf("This year is the leap year.");
				}
				else {
					tc(14);
					gotoxy(25, 8);
					cprintf("This year is not the leap year.");
				}
			a5:
				tc(12);
				gotoxy(23, 20);
				cprintf("Do you want to continue?[n/y]");
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto a4;
				else if (ch == 'n' || ch == 'N')
					goto lp1;
				else
					goto a5;
			}
		}
	case 'w':
		ti : tb(2);
		tc(4);
		gotoxy(45, 1);
		cprintf("W");
		tc(0);
		gotoxy(46, 1);
		cprintf("indow");
		tb(0);
		for (i = 1; i <= 10; i++) {
			gotoxy(41, i + 2);
			cprintf("                    ");
		}
		tb(15);
		tc(0);
		gotoxy(40, 2);
		cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
		gotoxy(40, 11);
		cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
		for (i = 1; i <= 8; i++) {
			gotoxy(58, i + 2);
			putch(179);
		}
		gotoxy(40, 3);
		cprintf(" Black       ( )  ");
		gotoxy(40, 4);
		cprintf(" Blue        ( )  ");
		gotoxy(40, 5);
		cprintf(" Green       ( )  ");
		gotoxy(40, 6);
		cprintf(" Blue sky    ( )  ");
		gotoxy(40, 7);
		cprintf(" Red         ( )  ");
		gotoxy(40, 8);
		cprintf(" Purple      ( )  ");
		gotoxy(40, 9);
		cprintf(" Brown       ( )  ");
		gotoxy(40, 10);
		cprintf(" White       ( )  ");
		for (i = 1; i <= 8; i++) {
			gotoxy(40, i + 2);
			putch('³');
		}
		tc(4);
		gotoxy(54, 3);
		cprintf("0");
		gotoxy(54, 4);
		cprintf("1");
		gotoxy(54, 5);
		cprintf("2");
		gotoxy(54, 6);
		cprintf("3");
		gotoxy(54, 7);
		cprintf("4");
		gotoxy(54, 8);
		cprintf("5");
		gotoxy(54, 9);
		cprintf("6");
		gotoxy(54, 10);
		cprintf("7");
		while (1) {
		lo:
			ch = getch();
			switch (ch) {
			case 45:
				exit(9);
			case 48:
				tha = '0';
				goto nn2;
			case 49:
				tha = '1';
				goto nn2;
			case 50:
				tha = '2';
				goto nn2;
			case 51:
				tha = '3';
				goto nn2;
			case 52:
				tha = '4';
				goto nn2;
			case 53:
				tha = '5';
				goto nn2;
			case 54:
				tha = '6';
				goto nn2;
			case 55:
				tha = '7';
				goto nn2;
			case 27:
				line6();
				goto lp4;
			case 72:
				goto lo8;
			case 61:
				line6();
				tha = 'o';
				goto nn1;
			case 77:
				line6();
				goto lp5;
			case 75:
				line6();
				goto rabbit;
			case 80:
				lo1 : tb(2);
				tc(0);
				gotoxy(41, 3);
				cprintf("Black       ( )  ");
				tc(4);
				gotoxy(54, 3);
				cprintf("0");
				ch = getch();
				switch (ch) {
				case 13:
					tha = '0';
					goto nn2;
				case 45:
					exit(9);
				case 61:
					line6();
					tha = 'o';
					goto nn1;
				case 27:
					line6();
					goto lp4;
				case 72:
					tb(15);
					tc(0);
					gotoxy(41, 3);
					cprintf("Black       ( )  ");
					tc(4);
					gotoxy(54, 3);
					cprintf("0");
					goto lo8;
				case 77:
					line6();
					goto lp5;
				case 75:
					line6();
					goto rabbit;
				case 80:
					lo2 : tb(15);
					tc(0);
					gotoxy(41, 3);
					cprintf("Black       ( )  ");
					tc(4);
					gotoxy(54, 3);
					cprintf("0");
					tb(2);
					tc(0);
					gotoxy(41, 4);
					cprintf("Blue        ( )  ");
					tc(4);
					gotoxy(54, 4);
					cprintf("1");
					ch = getch();
					switch (ch) {
					case 13:
						tha = '1';
						goto nn2;
					case 72:
						tb(15);
						tc(0);
						gotoxy(41, 4);
						cprintf("Blue        ( )  ");
						tc(4);
						gotoxy(54, 4);
						cprintf("1");
						goto lo1;
					case 27:
						line6();
						goto lp4;
					case 45:
						exit(9);
					case 61:
						line6();
						tha = 'o';
						goto nn1;
					case 77:
						line6();
						goto lp5;
					case 75:
						line6();
						goto rabbit;
					case 80:
						lo3 : tb(15);
						tc(0);
						gotoxy(41, 4);
						cprintf("Blue        ( )  ");
						tc(4);
						gotoxy(54, 4);
						cprintf("1");
						tb(2);
						tc(0);
						gotoxy(41, 5);
						cprintf("Green       ( )  ");
						tc(4);
						gotoxy(54, 5);
						cprintf("2");
						ch = getch();
						switch (ch) {
						case 13:
							tha = '2';
							goto nn2;
						case 72:
							tb(15);
							tc(0);
							gotoxy(41, 5);
							cprintf("Green       ( )  ");
							tc(4);
							gotoxy(54, 5);
							cprintf("2");
							goto lo2;
						case 45:
							exit(9);
						case 61:
							line6();
							tha = 'o';
							goto nn1;
						case 27:
							line6();
							goto lp4;
						case 77:
							line6();
							goto lp5;
						case 75:
							line6();
							goto rabbit;
						case 80:
							lo4 : tb(15);
							tc(0);
							gotoxy(41, 5);
							cprintf("Green       ( )  ");
							tc(4);
							gotoxy(54, 5);
							cprintf("2");
							tb(2);
							tc(0);
							gotoxy(41, 6);
							cprintf("Blue sky    ( )  ");
							tc(4);
							gotoxy(54, 6);
							cprintf("3");
							ch = getch();
							switch (ch) {
							case 13:
								tha = '3';
								goto nn2;
							case 72:
								tb(15);
								tc(0);
								gotoxy(41, 6);
								cprintf("Blue sky    ( )  ");
								tc(4);
								gotoxy(54, 6);
								cprintf("3");
								goto lo3;
							case 27:
								line6();
								goto lp4;
							case 45:
								exit(9);
							case 61:
								line6();
								tha = 'o';
								goto nn1;
							case 77:
								line6();
								goto lp5;
							case 75:
								line6();
								goto rabbit;
							case 80:
								lo5 : tb(15);
								tc(0);
								gotoxy(41, 6);
								cprintf("Blue sky    ( )  ");
								tc(4);
								gotoxy(54, 6);
								cprintf("3");
								tb(2);
								tc(0);
								gotoxy(41, 7);
								cprintf("Red         ( )  ");
								tc(4);
								gotoxy(54, 7);
								cprintf("4");
								ch = getch();
								switch (ch) {
								case 13:
									tha = '4';
									goto nn2;
								case 72:
									tb(15);
									tc(0);
									gotoxy(41, 7);
									cprintf("Red         ( )  ");
									tc(4);
									gotoxy(54, 7);
									cprintf("4");
									goto lo4;
								case 27:
									line6();
									goto lp4;
								case 45:
									exit(9);
								case 61:
									line6();
									tha = 'o';
									goto nn1;
								case 77:
									line6();
									goto lp5;
								case 75:
									line6();
									goto rabbit;
								case 80:
									lo6 : tb(15);
									tc(0);
									gotoxy(41, 7);
									cprintf("Red         ( )  ");
									tc(4);
									gotoxy(54, 7);
									cprintf("4");
									tb(2);
									tc(0);
									gotoxy(41, 8);
									cprintf("Purple      ( )  ");
									tc(4);
									gotoxy(54, 8);
									cprintf("5");
									ch = getch();
									switch (ch) {
									case 13:
										tha = '5';
										goto nn2;
									case 72:
										tb(15);
										tc(0);
										gotoxy(41, 8);
										cprintf("Purple      ( )  ");
										tc(4);
										gotoxy(54, 8);
										cprintf("5");
										goto lo5;
									case 27:
										line6();
										goto lp4;
									case 45:
										exit(9);
									case 61:
										line6();
										tha = 'o';
										goto nn1;
									case 77:
										line6();
										goto lp5;
									case 75:
										line6();
										goto rabbit;
									case 80:
										lo7 : tb(15);
										tc(0);
										gotoxy(41, 8);
										cprintf("Purple      ( )  ");
										tc(4);
										gotoxy(54, 8);
										cprintf("5");
										tb(2);
										tc(0);
										gotoxy(41, 9);
										cprintf("Brown       ( )  ");
										tc(4);
										gotoxy(54, 9);
										cprintf("6");
										ch = getch();
										switch (ch) {
										case 13:
											tha = '6';
											goto nn2;
										case 72:
											tb(15);
											tc(0);
											gotoxy(41, 9);
											cprintf("Brown       ( )  ");
											tc(4);
											gotoxy(54, 9);
											cprintf("6");
											goto lo6;
										case 45:
											exit(9);
										case 61:
											line6();
											tha = 'o';
											goto nn1;
										case 27:
											line6();
											goto lp4;
										case 77:
											line6();
											goto lp5;
										case 75:
											line6();
											goto rabbit;
										case 80:
											lo8 : tb(15);
											tc(0);
											gotoxy(41, 9);
											cprintf("Brown       ( )  ");
											tc(4);
											gotoxy(54, 9);
											cprintf("6");
											tb(2);
											tc(0);
											gotoxy(41, 10);
											cprintf("White       ( ) ");
											tc(4);
											gotoxy(54, 10);
											cprintf("7");
											ch = getch();
											switch (ch) {
											case 13:
												tha = '7';
												goto nn2;
											case 72:
												tb(15);
												tc(0);
												gotoxy(41, 10);
												cprintf("White       ( ) ");
												tc(4);
												gotoxy(54, 10);
												cprintf("7");
												goto lo7;
											case 45:
												exit(9);
											case 61:
												line6();
												tha = 'o';
												goto nn1;
											case 27:
												line6();
												goto lp4;
											case 77:
												line6();
												goto lp5;
											case 75:
												line6();
												goto rabbit;
											case 80:
												tb(15);
												tc(0);
												gotoxy(41, 10);
												cprintf("White       ( ) ");
												tc(4);
												gotoxy(54, 10);
												cprintf("7");
												goto lo1;
											default:
												goto lo8;
											}
										default:
											goto lo7;
										}
									default:
										goto lo6;
									}
								default:
									goto lo5;
								}
							default:
								goto lo4;
							}
						default:
							goto lo3;
						}
					default:
						goto lo2;
					}
				default:
					goto lo1;
				}
			default:
				goto lo;
			}
		nn2:
			switch (tha) {
			case '0':
				co = 0;
				goto start;
			case '1':
				co = 1;
				goto start;
			case '2':
				co = 2;
				goto start;
			case '3':
				co = 3;
				goto start;
			case '4':
				co = 4;
				goto start;
			case '5':
				co = 5;
				goto start;
			case '6':
				co = 6;
				goto start;
			case '7':
				co = 7;
				goto start;
			}
		}
	case 'm':
		tiger : tb(2);
		tc(4);
		gotoxy(19, 1);
		cprintf("M");
		tc(0);
		gotoxy(20, 1);
		cprintf("ath");
		tb(0);
		for (i = 1; i <= 8; i++) {
			gotoxy(16, i + 2);
			cprintf("                    ");
		}
		tb(15);
		tc(0);
		gotoxy(15, 2);
		cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
		gotoxy(15, 3);
		cprintf("  ax+b<0     ( )   ");
		tc(4);
		gotoxy(29, 3);
		cprintf("1");
		tc(0);
		gotoxy(15, 4);
		cprintf("  ax+b>0     ( )   ");
		tc(4);
		gotoxy(29, 4);
		cprintf("2");
		tc(0);
		gotoxy(16, 5);
		cprintf(" Product_ atrice ");
		tc(4);
		gotoxy(25, 5);
		cprintf("m");
		tc(4);
		gotoxy(15, 6);
		cprintf("  P");
		tc(0);
		gotoxy(18, 6);
		cprintf("PCM             ");
		tc(4);
		gotoxy(15, 7);
		cprintf("  A");
		tc(0);
		gotoxy(18, 7);
		cprintf("rrangment       ");
		tc(4);
		gotoxy(15, 8);
		cprintf("  S");
		tc(0);
		gotoxy(18, 8);
		cprintf("ystem          ");
		for (i = 1; i <= 6; i++) {
			gotoxy(15, i + 2);
			putch('³');
		}
		for (i = 1; i <= 6; i++) {
			gotoxy(33, i + 2);
			putch('³');
		}
		gotoxy(15, 9);
		cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
		while (2) {
		jj:
			ch = getch();
			switch (ch) {
			case 27:
				line3();
				goto lp2;
			case 75:
				line3();
				goto lion;
			case 49:
				line3();
				tha = '1';
				goto ww;
			case 50:
				line3();
				tha = '2';
				goto ww;
			case 109:
				line3();
				tha = '3';
				goto ww;
			case 112:
				line3();
				tha = '4';
				goto ww;
			case 97:
				tha = 'a';
				goto ww;
			case 115:
				tha = 's';
				goto ww;
			case 77:
				line3();
				goto rabbit;
			case 72:
				goto jj6;
			case 45:
				exit(1);
			case 61:
				line3();
				tha = 'o';
				goto nn1;
			case 80:
				jj1 : tb(2);
				tc(0);
				gotoxy(17, 3);
				cprintf("ax+b<0     ( ) ");
				tc(4);
				gotoxy(29, 3);
				cprintf("1");
				ch = getch();
				switch (ch) {
				case 27:
					line3();
					goto lp2;
				case 13:
					line3();
					tha = '1';
					goto ww;
				case 77:
					line3();
					goto rabbit;
				case 72:
					tb(15);
					tc(0);
					gotoxy(17, 3);
					cprintf("ax+b<0     ( ) ");
					tc(4);
					gotoxy(29, 3);
					cprintf("1");
					goto jj6;
				case 75:
					line3();
					goto lion;
				case 45:
					exit(1);
				case 61:
					line3();
					tha = 'o';
					goto nn1;
				case 80:
					jj2 : tb(15);
					tc(0);
					gotoxy(17, 3);
					cprintf("ax+b<0     ( ) ");
					tc(4);
					gotoxy(29, 3);
					cprintf("1");
					tb(2);
					tc(0);
					gotoxy(17, 4);
					cprintf("ax+b>0     ( ) ");
					tc(4);
					gotoxy(29, 4);
					cprintf("2");
					ch = getch();
					switch (ch) {
					case 72:
						tb(15);
						tc(0);
						gotoxy(17, 4);
						cprintf("ax+b>0     ( ) ");
						tc(4);
						gotoxy(29, 4);
						cprintf("2");
						goto jj1;
					case 27:
						line3();
						goto lp2;
					case 77:
						line3();
						goto rabbit;
					case 13:
						line3();
						tha = '2';
						goto ww;
					case 75:
						line3();
						goto lion;
					case 45:
						exit(1);
					case 61:
						line3();
						tha = 'o';
						goto nn1;
					case 80:
						jj3 : tb(15);
						tc(0);
						gotoxy(17, 4);
						cprintf("ax+b>0     ( ) ");
						tc(4);
						gotoxy(29, 4);
						cprintf("2");
						tb(2);
						tc(0);
						gotoxy(17, 5);
						cprintf("Product_ atrice");
						tc(4);
						gotoxy(25, 5);
						cprintf("m");
						ch = getch();
						switch (ch) {
						case 27:
							line3();
							goto lp2;
						case 13:
							tha = '3';
							goto ww;
						case 72:
							tb(15);
							tc(0);
							gotoxy(17, 5);
							cprintf("Product_ atrice");
							tc(4);
							gotoxy(25, 5);
							cprintf("m");
							goto jj2;
						case 77:
							line3();
							goto rabbit;
						case 75:
							line3();
							goto lion;
						case 45:
							exit(1);
						case 61:
							line3();
							tha = 'o';
							goto nn1;
						case 80:
							jj4 : tb(15);
							tc(0);
							gotoxy(17, 5);
							cprintf("Product_ atrice");
							tc(4);
							gotoxy(25, 5);
							cprintf("m");
							tb(2);
							tc(4);
							gotoxy(17, 6);
							cprintf("P");
							tc(0);
							gotoxy(18, 6);
							cprintf("PCM           ");
							ch = getch();
							switch (ch) {
							case 27:
								line3();
								goto lp2;
							case 13:
								tha = '4';
								goto ww;
							case 72:
								tb(15);
								tc(4);
								gotoxy(17, 6);
								cprintf("P");
								tc(0);
								gotoxy(18, 6);
								cprintf("PCM           ");
								goto jj3;
							case 77:
								line3();
								goto rabbit;
							case 75:
								line3();
								goto lion;
							case 45:
								exit(1);
							case 61:
								line3();
								tha = 'o';
								goto nn1;
							case 80:
								jj5 : tb(15);
								tc(4);
								gotoxy(17, 6);
								cprintf("P");
								tc(0);
								gotoxy(18, 6);
								cprintf("PCM           ");
								tb(2);
								tc(4);
								gotoxy(17, 7);
								cprintf("A");
								tc(0);
								gotoxy(18, 7);
								cprintf("rrangment     ");
								ch = getch();
								switch (ch) {
								case 27:
									line3();
									goto lp2;
								case 13:
									tha = 'a';
									goto ww;
								case 72:
									tb(15);
									tc(4);
									gotoxy(17, 7);
									cprintf("A");
									tc(0);
									gotoxy(18, 7);
									cprintf("rrangment     ");
									goto jj4;
								case 77:
									line3();
									goto rabbit;
								case 75:
									line3();
									goto lion;
								case 45:
									exit(1);
								case 61:
									line3();
									tha = 'o';
									goto nn1;
								case 80:
									jj6 : tb(15);
									tc(4);
									gotoxy(17, 7);
									cprintf("A");
									tc(0);
									gotoxy(18, 7);
									cprintf("rrangment     ");
									tb(2);
									tc(4);
									gotoxy(17, 8);
									cprintf("S");
									tc(0);
									gotoxy(18, 8);
									cprintf("ystem        ");
									ch = getch();
									switch (ch) {
									case 27:
										line3();
										goto lp2;
									case 72:
										tb(15);
										tc(4);
										gotoxy(17, 8);
										cprintf("S");
										tc(0);
										gotoxy(18, 8);
										cprintf("ystem        ");
										goto jj5;
									case 13:
									case 77:
										tha = 's';
										goto ww;
									case 75:
										line3();
										goto lion;
									case 45:
										exit(1);
									case 61:
										line3();
										tha = 'o';
										goto nn1;
									case 80:
										tb(15);
										tc(4);
										gotoxy(17, 8);
										cprintf("S");
										tc(0);
										gotoxy(18, 8);
										cprintf("ystem        ");
										goto jj1;
									default:
										goto jj6;
									}
								default:
									goto jj5;
								}
							default:
								goto jj4;
							}
						default:
							goto jj3;
						}
					default:
						goto jj2;
					}
				default:
					goto jj1;
				}
			default:
				goto jj;
			}
		ww:
			switch (tha) {
			case 'a':
				arr : tb(co);
				line3();
				line14();
				Arrangement();
			kl:
				ch = getch();
				if (ch == 'n' || ch == 'N') {
					_setcursortype(_NOCURSOR);
					goto lp2;
				}
				else if (ch == 'y' || ch == 'Y')
					goto arr;
				else
					goto kl;
			case '1':
				aa4 : tb(co);
				line14();
				equa_1();
			aa5:
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto aa4;
				else if (ch == 'n' || ch == 'N') {
					_setcursortype(_NOCURSOR);
					goto lp2;
				}
				else
					goto aa5;
			case '2':
				bb4 : tb(co);
				line14();
				equa_2();
			bb5:
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto bb4;
				else if (ch == 'n' || ch == 'N') {
					_setcursortype(_NOCURSOR);
					goto lp2;
				}
				else
					goto bb5;
			case '3':
				mat : tb(co);
				line3();
				line14();
				product();
			ij:
				ch = getch();
				if (ch == 'n' || ch == 'N') {
					goto lp2;
				}
				else if (ch == 'y' || ch == 'Y')
					goto mat;
				else
					goto ij;
			case '4':
				pp : tb(co);
				line3();
				line14();
				PPCM();
			jk:
				ch = getch();
				if (ch == 'y' || ch == 'Y')
					goto pp;
				else if (ch == 'n' || ch == 'N') {
					_setcursortype(_NOCURSOR);
					goto lp2;
				}
				else
					goto jk;
			case 's':
				sys : tb(0);
				for (i = 1; i <= 5; i++) {
					gotoxy(36, i + 6);
					cprintf("                        ");
				}
				tb(15);
				tc(0);
				gotoxy(34, 6);
				cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
				gotoxy(34, 10);
				cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
				for (i = 1; i <= 3; i++) {
					gotoxy(34, i + 6);
					cprintf("³");
					gotoxy(57, i + 6);
					cprintf("³");
				}
				gotoxy(35, 7);
				cprintf("Decimal to Binary     ");
				gotoxy(35, 8);
				cprintf("Decimal to Octal      ");
				gotoxy(35, 9);
				cprintf("Decimal to Hexadecimal");
				while (9) {
				h:
					ch = getch();
					switch (ch) {
					case 27:
					case 75:
						line10();
						goto jj6;
					case 72:
						goto h3;
					case 80:
						h1 : tb(2);
						tc(0);
						gotoxy(35, 7);
						cprintf("Decimal to Binary     ");
						ch = getch();
						switch (ch) {
						case 27:
						case 75:
							line10();
							goto jj6;
						case 72:
							tb(15);
							tc(0);
							gotoxy(35, 7);
							cprintf("Decimal to Binary     ");
							goto h3;
						case 13:
							tha = '1';
							goto hh;
						case 80:
							h2 : tb(15);
							tc(0);
							gotoxy(35, 7);
							cprintf("Decimal to Binary     ");
							tb(2);
							tc(0);
							gotoxy(35, 8);
							cprintf("Decimal to Octal      ");
							ch = getch();
							switch (ch) {
							case 27:
							case 75:
								line10();
								goto jj6;
							case 13:
								tha = '2';
								goto hh;
							case 72:
								tb(15);
								tc(0);
								gotoxy(35, 8);
								cprintf("Decimal to Octal      ");
								goto h1;
							case 80:
								h3 : tb(15);
								tc(0);
								gotoxy(35, 8);
								cprintf("Decimal to Octal      ");
								tb(2);
								tc(0);
								gotoxy(35, 9);
								cprintf("Decimal to Hexadecimal");
								ch = getch();
								switch (ch) {
								case 27:
								case 75:
									line10();
									goto jj6;
								case 13:
									tha = '3';
									goto hh;
								case 72:
									tb(15);
									tc(0);
									gotoxy(35, 9);
									cprintf("Decimal to Hexadecimal");
									goto h2;
								case 80:
									tb(15);
									tc(0);
									gotoxy(35, 9);
									cprintf("Decimal to Hexadecimal");
									goto h1;
								default:
									goto h3;
								}
							default:
								goto h2;
							}
						default:
							goto h1;
						}
					default:
						goto h;
					}
				hh:
					switch (tha) {
					case '1':
						sys1 : tb(co);
						line14();
						line3();
						sys1();
					j:
						ch = getch();
						if (ch == 'n' || ch == 'N')
							goto lp2;
						else if (ch == 'y' || ch == 'Y')
							goto sys1;
						else
							goto j;
					case '2':
						sys2 : tb(co);
						line14();
						line3();
						sys2();
					j1:
						ch = getch();
						if (ch == 'n' || ch == 'N')
							goto lp2;
						else if (ch == 'y' || ch == 'Y')
							goto sys2;
						else
							goto j1;
					case '3':
						sys3 : tb(co);
						line14();
						line3();
						sys3();
					j2:
						ch = getch();
						if (ch == 'n' || ch == 'N')
							goto lp2;
						else if (ch == 'y' || ch == 'Y')
							goto sys3;
						else
							goto j2;
					}
				}
			}
		}
	case 'c':
		rabbit : tb(2);
		tc(4);
		gotoxy(30, 1);
		cprintf("C");
		tc(0);
		gotoxy(31, 1);
		cprintf("alculate");
		tb(8);
		for (i = 1; i <= 4; i++) {
			gotoxy(27, i + 2);
			cprintf("               ");
		}
		tb(15);
		tc(4);
		gotoxy(26, 3);
		cprintf("S");
		gotoxy(26, 4);
		cprintf("P");
		tc(0);
		gotoxy(27, 3);
		cprintf("um         ");
		gotoxy(27, 4);
		gotoxy(27, 4);
		cprintf("roduct     ");
		gotoxy(25, 2);
		cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
		for (i = 1; i <= 2; i++) {
			gotoxy(25, i + 2);
			putch(179);
		}
		for (i = 1; i <= 2; i++) {
			gotoxy(39, i + 2);
			putch(179);
		}
		gotoxy(25, 5);
		cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
		while (5) {
		loop21:
			ch = getch();
			switch (ch) {
			case 112:
				tha = '2';
				goto ta;
			case 115:
				tha = '1';
				goto ta;
			case 75:
				line4();
				tb(2);
				tc(4);
				gotoxy(19, 1);
				cprintf("M");
				tc(0);
				gotoxy(20, 1);
				cprintf("ath");
				goto tiger;
			case 77:
				line4();
				tb(2);
				tc(4);
				gotoxy(45, 1);
				cprintf("W");
				tc(0);
				gotoxy(46, 1);
				cprintf("indow");
				goto ti;
			case 45:
				exit(2);
			case 61:
				line4();
				tha = 'o';
				goto nn1;
			case 27:
				line4();
				goto lp3;
			case 72:
				goto loop23;
			case 80:
				loop22 : tb(2);
				tc(4);
				gotoxy(26, 3);
				cprintf("S");
				tc(0);
				gotoxy(27, 3);
				cprintf("um         ");
				ch = getch();
				switch (ch) {
				case 75:
					line4();
					tb(2);
					tc(4);
					gotoxy(19, 1);
					cprintf("M");
					tc(0);
					gotoxy(20, 1);
					cprintf("ath");
					goto tiger;
				case 13:
				case 77:
					tha = '1';
					goto ta;
				case 45:
					exit(2);
				case 61:
					line4();
					tha = 'o';
					goto nn1;
				case 27:
					line4();
					goto lp3;
				case 80:
				case 72:
					loop23 : tb(7);
					tc(4);
					gotoxy(26, 3);
					cprintf("S");
					tc(0);
					gotoxy(27, 3);
					cprintf("um         ");
					tb(2);
					tc(4);
					gotoxy(26, 4);
					cprintf("P");
					tc(0);
					gotoxy(27, 4);
					cprintf("roduct     ");
					ch = getch();
					switch (ch) {
					case 75:
						line4();
						tb(2);
						tc(4);
						gotoxy(19, 1);
						cprintf("M");
						tc(0);
						gotoxy(20, 1);
						cprintf("ath");
						goto tiger;
					case 13:
					case 77:
						tha = '2';
						goto ta;
					case 45:
						exit(9);
					case 27:
						line4();
						goto lp3;
					case 72:
					case 80:
						tb(7);
						tc(4);
						gotoxy(26, 4);
						cprintf("P");
						tc(0);
						gotoxy(27, 4);
						cprintf("roduct     ");
						goto loop22;
					default:
						goto loop23;
					}
				default:
					goto loop22;
				}
			default:
				goto loop21;
			}
		ta:
			switch (tha) {
			case '1':
				tb(0);
				for (i = 1; i <= 5; i++) {
					gotoxy(42, i + 3);
					cprintf("                                      ");
				}
				tb(15);
				tc(0);
				gotoxy(40, 3);
				cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
				for (i = 1; i <= 3; i++) {
					gotoxy(40, i + 3);
					putch(179);
				}
				for (i = 1; i <= 3; i++) {
					gotoxy(77, i + 3);
					putch(179);
				}
				gotoxy(40, 7);
				cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
				gotoxy(41, 4);
				cprintf("S=1(1!)+2(2!)+3(3!)+.......+n(n!)   ");
				gotoxy(41, 5);
				cprintf("S=C(n,1)-C(n,2)+...+(-1)^(p+1)C(n,p)");
				gotoxy(41, 6);
				cprintf("S=1^3+2^3+3^3+........+n^3          ");
				while (1) {
				cc:
					ch = getch();
					switch (ch) {
					case 27:
					case 75:
						line9();
						goto loop22;
					case 72:
						goto cc3;
					case 80:
						cc1 : tb(2);
						tc(0);
						gotoxy(41, 4);
						cprintf("S=1(1!)+2(2!)+3(3!)+.......+n(n!)   ");
						ch = getch();
						switch (ch) {
						case 27:
						case 75:
							line9();
							goto loop22;
						case 13:
							tha = '1';
							goto ccc;
						case 72:
							tb(15);
							tc(0);
							gotoxy(41, 4);
							cprintf("S=1(1!)+2(2!)+3(3!)+.......+n(n!)   ");
							goto cc3;
						case 80:
							cc2 : tb(15);
							tc(0);
							gotoxy(41, 4);
							cprintf("S=1(1!)+2(2!)+3(3!)+.......+n(n!)   ");
							tb(2);
							tc(0);
							gotoxy(41, 5);
							cprintf("S=C(n,1)-C(n,2)+...+(-1)^(p+1)C(n,p)");
							ch = getch();
							switch (ch) {
							case 27:
							case 75:
								line9();
								goto loop22;
							case 13:
								tha = '2';
								goto ccc;
							case 72:
								tb(15);
								tc(0);
								gotoxy(41, 5);
								cprintf("S=C(n,1)-C(n,2)+...+(-1)^(p+1)C(n,p)");
								goto cc1;
							case 80:
								cc3 : tb(15);
								tc(0);
								gotoxy(41, 5);
								cprintf("S=C(n,1)-C(n,2)+...+(-1)^(p+1)C(n,p)");
								tb(2);
								tc(0);
								gotoxy(41, 6);
								cprintf("S=1^3+2^3+3^3+........+n^3          ");
								ch = getch();
								switch (ch) {
								case 27:
								case 75:
									line9();
									goto loop22;
								case 13:
									tha = '3';
									goto ccc;
								case 72:
									tb(15);
									tc(0);
									gotoxy(41, 6);
									cprintf("S=1^3+2^3+3^3+........+n^3          ");
									goto cc2;
								case 80:
									tb(15);
									tc(0);
									gotoxy(41, 6);
									cprintf("S=1^3+2^3+3^3+........+n^3          ");
									goto cc1;
								default:
									goto cc3;
								}
							default:
								goto cc2;
							}
						default:
							goto cc1;
						}
					default:
						goto cc;
					}
				ccc:
					switch (tha) {
					case '1':
						so : tb(co);
						line9();
						line14();
						line4();
						sum1();
					taa:
						ch = getch();
						if (ch == 'n' || ch == 'N')
							goto lp3;
						else if (ch == 'Y' || ch == 'y')
							goto so;
						else
							goto taa;
					case '2':
						so1 : tb(co);
						line9();
						line14();
						line4();
						sum2();
					taa1:
						ch = getch();
						if (ch == 'n' || ch == 'N')
							goto lp3;
						else if (ch == 'Y' || ch == 'y')
							goto so1;
						else
							goto taa1;
					case '3':
						so2 : tb(co);
						line9();
						line14();
						line4();
						sum3();
					taa2:
						ch = getch();
						if (ch == 'n' || ch == 'N')
							goto lp3;
						else if (ch == 'Y' || ch == 'y')
							goto so2;
						else
							goto taa2;
					}
				}
			case '2':
				tb(2);
				tc(4);
				gotoxy(30, 1);
				cprintf("C");
				tc(0);
				gotoxy(31, 1);
				cprintf("alculate");
				tb(8);
				for (i = 1; i <= 5; i++) {
					gotoxy(42, i + 4);
					cprintf("                     ");
				}
				tb(15);
				tc(0);
				gotoxy(41, 5);
				cprintf("P=1*5*9*...........");
				gotoxy(41, 6);
				cprintf("P=1*2*3*...........");
				gotoxy(41, 7);
				cprintf("P=nü=n*n*n*......*n");
				gotoxy(40, 4);
				cprintf("ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿");
				for (i = 1; i <= 3; i++) {
					gotoxy(40, i + 4);
					putch(179);
				}
				for (i = 1; i <= 3; i++) {
					gotoxy(60, i + 4);
					putch(179);
				}
				gotoxy(40, 8);
				cprintf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ");
				while (1) {
				g:
					ch = getch();
					switch (ch) {
					case 27:
					case 75:
						line7();
						goto loop23;
					case 45:
						exit(9);
					case 72:
						goto g3;
					case 80:
						g1 : tb(2);
						tc(0);
						gotoxy(41, 5);
						cprintf("P=1*5*9*...........");
						ch = getch();
						switch (ch) {
						case 27:
						case 75:
							line7();
							goto loop23;
						case 72:
							tb(15);
							tc(0);
							gotoxy(41, 5);
							cprintf("P=1*5*9*...........");
							goto g3;
						case 13:
							tha = '2';
							goto gg;
						case 45:
							exit(9);
						case 80:
							g2 : tb(15);
							tc(0);
							gotoxy(41, 5);
							cprintf("P=1*5*9*...........");
							tb(2);
							tc(0);
							gotoxy(41, 6);
							cprintf("P=1*2*3*...........");
							ch = getch();
							switch (ch) {
							case 27:
							case 75:
								line7();
								goto loop23;
							case 72:
								tb(15);
								tc(0);
								gotoxy(41, 6);
								cprintf("P=1*2*3*...........");
								goto g1;
							case 13:
								tha = '1';
								goto gg;
							case 45:
								exit(9);
							case 80:
								g3 : tb(15);
								tc(0);
								gotoxy(41, 6);
								cprintf("P=1*2*3*...........");
								tb(2);
								tc(0);
								gotoxy(41, 7);
								cprintf("P=nü=n*n*n*......*n");
								ch = getch();
								switch (ch) {
								case 27:
								case 75:
									line7();
									goto loop23;
								case 72:
									tb(15);
									tc(0);
									gotoxy(41, 7);
									cprintf("P=nü=n*n*n*......*n");
									goto g2;
								case 13:
									tha = '3';
									goto gg;
								case 45:
									exit(9);
								case 80:
									tb(15);
									tc(0);
									gotoxy(41, 7);
									cprintf("P=nü=n*n*n*......*n");
									goto g1;
								default:
									goto g3;
								}
							default:
								goto g2;
							}
						default:
							goto g1;
						}
					default:
						goto g;
					}
				gg:
					switch (tha) {
					case '1':
						g4 : tb(co);
						line14();
						line4();
						tc(12 + 128);
						gotoxy(20, 4);
						cprintf("The program calculate the product of P");
						_setcursortype(_NORMALCURSOR);
						gotoxy(23, 6);
						tc(11);
						cprintf("P=1*2*3*..........*n");
					cd:
						gotoxy(20, 8);
						cprintf("Please input n:       ");
						gotoxy(36, 8);
						scanf("%d", &n);
						if (n <= 0) {
							sound(1000);
							gotoxy(20, 20);
							cprintf("Please input again ,are you crazy!");
							delay(1000);
							gotoxy(20, 20);
							cprintf("                                                  ");
							nosound();
							goto cd;
						}
						else {
							gotoxy(15, 12);
							tc(14);
							cprintf("Factoriel of n is:%d!=1*2*....*%d=%ld", n, n, fact(n));
							tc(11 + 128);
							gotoxy(20, 20);
							cprintf("Do you want to continue?[n/y]");
						gg1:
							ch = getch();
							if (ch == 'n' || ch == 'N')
								goto lp3;
							else if (ch == 'y' || ch == 'Y')
								goto g4;
							else
								goto gg1;
						}
					case '2':
						g5 : tb(co);
						line14();
						line4();
						tc(12 + 128);
						gotoxy(20, 4);
						cprintf("The program calculate the product of P");
						_setcursortype(_NORMALCURSOR);
						gotoxy(23, 6);
						tc(10);
						cprintf("P=1*5*9*..........*n");
					cd1:
						gotoxy(20, 8);
						cprintf("Please input n:       ");
						gotoxy(36, 8);
						scanf("%d", &n);
						if (n <= 0) {
							sound(1000);
							gotoxy(20, 20);
							cprintf("Please input again ,are you crazy!");
							delay(1000);
							gotoxy(20, 20);
							cprintf("                                                  ");
							nosound();
							goto cd1;
						}
						else {
							gotoxy(15, 12);
							tc(14);
							cprintf("The product of P is P=1*5*....*%d=%ld", (4*n - 3), Pr(n));
							tc(11 + 128);
							gotoxy(20, 20);
							cprintf("Do you want to continue?[n/y]");
						gg2:
							ch = getch();
							if (ch == 'n' || ch == 'N')
								goto lp3;
							else if (ch == 'y' || ch == 'Y')
								goto g5;
							else
								goto gg2;
						}
					case '3':
						g6 : tb(co);
						line14();
						line4();
						tc(12 + 128);
						gotoxy(20, 4);
						cprintf("The program calculate the power of n");
						_setcursortype(_NORMALCURSOR);
						gotoxy(23, 6);
						tc(10);
						cprintf("P=n*n*n*..........*n=nü");
					cd2:
						gotoxy(20, 8);
						cprintf("Please input n:      ");
						gotoxy(36, 8);
						scanf("%d", &n);
						if (n <= 0) {
							sound(1000);
							gotoxy(20, 20);
							cprintf("Please input again ,are you crazy!");
							delay(1000);
							gotoxy(20, 20);
							cprintf("                                                  ");
							nosound();
							goto cd2;
						}
						else {
							P = pow(n, n);
							gotoxy(15, 12);
							tc(14);
							cprintf("The product of P is P=%d*%d*....*%d=%ld", n, n, n, P);
							tc(11 + 128);
							gotoxy(20, 20);
							cprintf("Do you want to continue?[n/y]");
						gg3:
							ch = getch();
							if (ch == 'n' || ch == 'N')
								goto lp3;
							else if (ch == 'y' || ch == 'Y')
								goto g6;
							else
								goto gg3;
						}
					}
				}
			}
		}
	}
}

/* +++++++++++++++==================End main=========================++++++++++++++ */
/* pr */
long Pr(int x) {
	C = 1;
	for (i = 1; i <= x; i++) {
		C = C * (4 * i - 3);
	}
	return (C);
}

/* Function star */
void star() {
	tb(co);
	gotoxy(20, 5);
	tc(10 + 128);
	cprintf("Please input the value of n:");
	tc(12 + 128);
	gotoxy(50, 5);
	scanf("%d", &n);
	tc(15);
	for (i = 1; i <= n; i++) {
		gotoxy(40 - i, 6 + i);
		for (j = 1; j <= 2 * i - 1; j++) {
			sound(random(155 + i*321));
			putch('*');
			delay(100);
			nosound();
		}
	}
	for (i = 1; i <= n; i++) {
		gotoxy(5, 6 + i);
		for (j = 1; j <= i; j++) {
			sound(random(i*219 + 241));
			putch('*');
			delay(100);
			nosound();
		}
	}
	for (i = 1; i <= n; i++) {
		gotoxy(75 - i, 6 + i);
		for (j = 1; j <= i; j++) {
			sound(random(i*219 + 241));
			putch('*');
			delay(100);
			nosound();
		}
	}
	tc(6);
	gotoxy(25, 23);
	cprintf("Do you want to continue?[n/y]");
} /* End function star */

/* product */
void product() {
	int l[8][6], m1, s1, n1, h[6][4], k[5][9], t;
	char sss[] = "Can not product,because column of A are not equal the row of B";
stt:
	tb(co);
	_setcursortype(_NORMALCURSOR);
	tc(12 + 128);
	gotoxy(20, 3);
	cprintf("Find the multiplication of matrices");
	tc(10);
	gotoxy(10, 4);
	cprintf("The first matrices A have:");
	tc(11);
	gotoxy(8, 5);
	cprintf("Row:");
	scanf("%d", &m);
	gotoxy(29, 5);
	cprintf("Column:");
	scanf("%d", &n);
	if (n < 0 || m < 0) {
		gotoxy(29, 23);
		cprintf("Please input again.Are you crazy!");
		delay(500);
		gotoxy(29, 23);
		cprintf("                                          ");
		goto stt;
	}
	else if (m < 2) {
		gotoxy(5, 7);
		cprintf("Ú");
		gotoxy(5, 8);
		cprintf("³");
		gotoxy(7 + 3*n, 9);
		cprintf("Ù");
		gotoxy(7 + 3*n, 7);
		cprintf("¿");
		gotoxy(7 + 3*n, 8);
		cprintf("³");
		gotoxy(5, 9);
		cprintf("À");
		for (i = 1; i <= n; i++) {
			gotoxy(4 + 3*i, 8);
			scanf("%d", &d[1][i]);
		}
		tc(10);
		gotoxy(50, 4);
		cprintf("The second matrices B have:");
	again:
		tc(11);
		gotoxy(48, 5);
		cprintf("Row:  ");
		gotoxy(52, 5);
		scanf("%d", &m1);
		gotoxy(71, 5);
		cprintf("Column:  ");
		gotoxy(78, 5);
		scanf("%d", &n1);
		if (n1 < 0 || m1 < 0) {
			sound(1000);
			gotoxy(29, 23);
			cprintf("Please input again,it impossible!");
			delay(2000);
			gotoxy(29, 23);
			cprintf("                                           ");
			nosound();
			goto again;
		}
		if (m1 != n) {
			for (j = 1; j <= 7; j++) {
				tc(j + 8);
				for (i = 0; i <= strlen(sss); i++) {
					sound(134 + 20*i*j);
					gotoxy(15 + i, 23);
					cprintf("%c", sss[i]);
					delay(10);
				}
			}
			nosound();
			delay(1000);
			gotoxy(15, 23);
			cprintf("                                                              ");
			goto again;
		}
		else {
			if (m1 < 2) {
				tc(11);
				gotoxy(48, 7);
				cprintf("Ú");
				gotoxy(48, 8);
				cprintf("³");
				gotoxy(50 + 3*n1, 9);
				cprintf("Ù");
				gotoxy(50 + 3*n1, 7);
				cprintf("¿");
				gotoxy(50 + 3*n1, 8);
				cprintf("³");
				gotoxy(48, 9);
				cprintf("À");
				for (i = 1; i <= n1; i++) {
					gotoxy(47 + 3*i, 8);
					scanf("%d", &e[1][i]);
				}
				tc(10);
				gotoxy(20, 14);
				cprintf("The multiplication of A and B is A*B:");
				gotoxy(28, 16);
				cprintf("Ú");
				gotoxy(28, 17);
				cprintf("³");
				gotoxy(30 + 3*n1, 18);
				cprintf("Ù");
				gotoxy(30 + 3*n1, 16);
				cprintf("¿");
				gotoxy(30 + 3*n1, 17);
				cprintf("³");
				gotoxy(28, 18);
				cprintf("À");
				_setcursortype(_NOCURSOR);
				for (i = 1; i <= n1; i++) {
					S1 = d[1][1] * e[1][i];
					gotoxy(27 + 3*i, 17);
					cprintf("%d", S1);
					delay(200);
				}
			}
			else if (n1 < 2) {
				tc(11);
				gotoxy(48, 7);
				cprintf("Ú");
				gotoxy(50 + 3*n1, 6 + m1);
				cprintf("Ù");
				gotoxy(50 + 3*n1, 7);
				cprintf("¿");
				gotoxy(48, 6 + m1);
				cprintf("À");
				for (i = 1; i <= m1 - 2; i++) {
					gotoxy(48, 7 + i);
					cprintf("³");
					gotoxy(50 + 3*n1, 7 + i);
					cprintf("³");
				}
				for (j = 1; j <= m1; j++) {
					for (i = 1; i <= n1; i++) {
						gotoxy(47 + 3*i, 6 + j);
						scanf("%d", &e[j][i]);
					}
				}
				tc(10);
				gotoxy(20, 14);
				cprintf("The multiplication of A and B is A*B:");
				gotoxy(28, 16);
				cprintf("Ú");
				gotoxy(33, 18);
				cprintf("Ù");
				gotoxy(33, 16);
				cprintf("¿");
				gotoxy(28, 18);
				cprintf("À");
				gotoxy(28, 17);
				cprintf("³");
				gotoxy(33, 17);
				cprintf("³");
				_setcursortype(_NOCURSOR);
				S1 = 0;
				for (i = 1; i <= n; i++) {
					S1 = S1 + d[1][i] * e[i][1];
				}
				gotoxy(30, 17);
				cprintf("%d", S1);
			}
			else {
				gotoxy(48, 7);
				cprintf("Ú");
				gotoxy(50 + 3*n1, 6 + m1);
				cprintf("Ù");
				gotoxy(50 + 3*n1, 7);
				cprintf("¿");
				gotoxy(48, 6 + m1);
				cprintf("À");
				for (i = 1; i <= m1 - 2; i++) {
					gotoxy(48, 7 + i);
					cprintf("³");
					gotoxy(50 + 3*n1, 7 + i);
					cprintf("³");
				}
				for (j = 1; j <= m1; j++) {
					for (i = 1; i <= n1; i++) {
						gotoxy(47 + 3*i, 6 + j);
						scanf("%d", &e[j][i]);
					}
				}
				tc(10);
				gotoxy(20, 14);
				cprintf("The multiplication of A and B is A*B:");
				gotoxy(28, 16);
				cprintf("Ú");
				gotoxy(30 + 3*n1, 18);
				cprintf("Ù");
				gotoxy(30 + 3*n1, 16);
				cprintf("¿");
				gotoxy(28, 18);
				cprintf("À");
				gotoxy(28, 17);
				cprintf("³");
				gotoxy(30 + 3*n1, 17);
				cprintf("³");
				_setcursortype(_NOCURSOR);
				for (j = 1; j <= n1; j++) {
					S1 = 0;
					for (i = 1; i <= n; i++) {
						S1 = S1 + d[1][i] * e[i][j];
					}
					gotoxy(27 + 3*j, 17);
					cprintf("%d", S1);
				}
			}
		}
	}
	else {
		gotoxy(5, 7);
		cprintf("Ú");
		gotoxy(7 + 3*n, 6 + m);
		cprintf("Ù");
		gotoxy(7 + 3*n, 7);
		cprintf("¿");
		gotoxy(5, 6 + m);
		cprintf("À");
		for (i = 1; i <= m - 2; i++) {
			gotoxy(7 + 3*n, 7 + i);
			cprintf("³");
			gotoxy(5, 7 + i);
			cprintf("³");
		}
		for (j = 1; j <= m; j++) {
			for (i = 1; i <= n; i++) {
				gotoxy(4 + 3*i, 6 + j);
				scanf("%d", &d[j][i]);
			}
		}
		tc(2);
		gotoxy(50, 4);
		cprintf("The second matrices B have:");
	again1:
		tc(11);
		gotoxy(48, 5);
		cprintf("Row:  ");
		gotoxy(52, 5);
		scanf("%d", &m1);
		gotoxy(71, 5);
		cprintf("Column:  ");
		gotoxy(78, 5);
		scanf("%d", &n1);
		if (n1 < 0 || m1 < 0) {
			sound(1000);
			gotoxy(29, 23);
			cprintf("Please input again, it impossible!");
			delay(2000);
			gotoxy(29, 23);
			cprintf("                                           ");
			nosound();
			goto again1;
		}
		if (m1 != n) {
			for (j = 1; j <= 7; j++) {
				tc(j + 8);
				for (i = 0; i <= strlen(sss); i++) {
					sound(134 + 20*i*j);
					gotoxy(15 + i, 23);
					cprintf("%c", sss[i]);
					delay(10);
				}
			}
			nosound();
			delay(1000);
			gotoxy(15, 23);
			cprintf("                                                              ");
			goto again1;
		}
		else {
			if (m1 < 2) {
				gotoxy(48, 7);
				cprintf("Ú");
				gotoxy(48, 8);
				cprintf("³");
				gotoxy(50 + 3*n1, 9);
				cprintf("Ù");
				gotoxy(50 + 3*n1, 7);
				cprintf("¿");
				gotoxy(50 + 3*n1, 8);
				cprintf("³");
				gotoxy(48, 9);
				cprintf("À");
				for (i = 1; i <= n1; i++) {
					gotoxy(47 + 3*i, 8);
					scanf("%d", &e[1][i]);
				}
			}
			else {
				gotoxy(48, 7);
				cprintf("Ú");
				gotoxy(50 + 3*n1, 6 + m1);
				cprintf("Ù");
				gotoxy(50 + 3*n1, 7);
				cprintf("¿");
				gotoxy(48, 6 + m1);
				cprintf("À");
				for (i = 1; i <= m1 - 2; i++) {
					gotoxy(48, 7 + i);
					cprintf("³");
					gotoxy(50 + 3*n1, 7 + i);
					cprintf("³");
				}
				for (j = 1; j <= m1; j++) {
					for (i = 1; i <= n1; i++) {
						gotoxy(47 + 3*i, 6 + j);
						scanf("%d", &e[j][i]);
					}
				}
			}
			tc(10);
			gotoxy(20, 14);
			cprintf("The multiplication of A and B is A*B:");
			gotoxy(28, 16);
			cprintf("Ú");
			gotoxy(30 + 3*n1, 15 + m);
			cprintf("Ù");
			gotoxy(30 + 3*n1, 16);
			cprintf("¿");
			gotoxy(28, 15 + m);
			cprintf("À");
			for (i = 1; i <= m - 2; i++) {
				gotoxy(28, 16 + i);
				cprintf("³");
				gotoxy(30 + 3*n1, 16 + i);
				cprintf("³");
			}
			_setcursortype(_NOCURSOR);
			for (i = 1; i <= m; i++)
				for (t = 1; t <= n1; t++) {
					l[i][t] = 0;
					for (j = 1; j <= n; j++) {
						l[i][t] = d[i][j] * e[j][t] + l[i][t];
					}
				}
			for (i = 1; i <= m; i++)
				for (t = 1; t <= n1; t++) {
					gotoxy(27 + 3*t, 15 + i);
					cprintf("%d", l[i][t]);
					delay(100);
				}
		}
	}
	tc(15);
	gotoxy(20, 23);
	cprintf("Do you want to continue?[n/y]");
} /* End function product */

/* Function grade */
void grade() {
	int sc1, sc2, sc3, sc4, sc5, sc6, s5;
	float ave;
	char *stu, tt[] = "The program is about the average of 6 score of student ";
	_setcursortype(_NORMALCURSOR);
	tb(co);
	tc(15);
	gotoxy(10, 4);
	cprintf("%s", tt);
	for (i = 2; i <= 10; i++) {
		tc(10);
		gotoxy(i, 6);
		cprintf(" Write the name of student:");
		delay(200);
	}
	tc(14);
	gotoxy(38, 6);
	gets(stu);
	tc(13);
	gotoxy(20, 8);
	cprintf("Please input the score for each subject");
v1:
	tc(14);
	gotoxy(10, 9);
	cprintf("Math:    ");
	gotoxy(15, 9);
	scanf("%d", &sc1);
	if (sc1 > 100 || sc1 < 0)
		goto v1;
v2:
	tc(14);
	gotoxy(10, 10);
	cprintf("Physics:     ");
	gotoxy(18, 10);
	scanf("%d", &sc2);
	if (sc2 > 100 || sc2 < 0)
		goto v2;
v3:
	tc(12);
	gotoxy(10, 11);
	cprintf("Fundamental:    ");
	gotoxy(22, 11);
	scanf("%d", &sc3);
	if (sc3 > 100 || sc3 < 0)
		goto v3;
v4:
	tc(12);
	gotoxy(10, 12);
	cprintf("C programming:    ");
	gotoxy(24, 12);
	scanf("%d", &sc4);
	if (sc4 > 100 || sc4 < 0)
		goto v4;
v5:
	tc(11);
	gotoxy(10, 13);
	cprintf("English:    ");
	gotoxy(18, 13);
	scanf("%d", &sc5);
	if (sc5 > 100 || sc5 < 0)
		goto v5;
v6:
	tc(11);
	gotoxy(10, 14);
	cprintf("Account:     ");
	gotoxy(18, 14);
	scanf("%d", &sc6);
	if (sc6 > 100 || sc6 < 0)
		goto v6;
	s5 = sc1 + sc2 + sc3 + sc4 + sc5 + sc6;
	ave = (float)s5 / 6;
	tc(10);
	gotoxy(15, 16);
	cprintf("The student name:");
	tc(12 + 128);
	gotoxy(33, 16);
	cprintf("%s", stu);
	tc(14);
	gotoxy(15, 18);
	cprintf("The average of score is:%.2f", ave);
	tc(10);
	gotoxy(20, 20);
	cprintf("Mention :");
	tc(12 + 128);
	gotoxy(30, 20);
	if (ave < 50)
		cprintf("Grade D");
	else if (ave < 65)
		cprintf("Grade C");
	else if (ave < 85)
		cprintf("Grade B");
	else
		cprintf("Grade A");
	tc(4);
	gotoxy(20, 23);
	cprintf("Do you want to continue?[n/y]");
} /* End function grade */

/* Function pascal_tri */
void pascal_tri() {
we:
	_setcursortype(_NOCURSOR);
	gotoxy(23, 3);
	cprintf("Written by Iech Setha");
	gotoxy(15, 4);
	cprintf("%s", sw);
	for (i = 2; i <= 18; i++) {
		gotoxy(i, 6);
		tc(i);
		cprintf(" Please input n (1-14):      ");
		delay(100);
	}
aa:
	gotoxy(41, 6);
	cprintf("    ");
	tc(14 + 128);
	gotoxy(41, 6);
	scanf("%d", &n);
	if (n <= 0 || n > 14) {
		tc(12);
		gotoxy(20, 23);
		cprintf("You must input again!");
		delay(900);
		gotoxy(20, 23);
		cprintf("                             ");
		goto aa;
	}
	else if (n == 1) {
		gotoxy(40, 8);
		cprintf("1");
	}
	else {
		for (i = 1; i <= n; i++) {
			d[i][1] = 1;
			d[i][i] = 1;
		}
		for (i = 2; i < n; i++) {
			for (j = 2; j < n; j++) {
				d[i + 1][j] = d[i][j - 1] + d[i][j];
			}
		}
		tc(14);
		gotoxy(40, 8);
		cprintf("1");
		gotoxy(37, 9);
		cprintf("1");
		gotoxy(43, 9);
		cprintf("1");
		for (i = 2; i < n; i++) {
			for (j = 1; j <= i + 1; j++) {
				gotoxy(31 + 6*j - 3*(i - 1), 8 + i);
				tc(14);
				cprintf("%d", d[i + 1][j]);
			}
		}
	}
	tc(14);
	gotoxy(25, 23);
	cprintf("Do you want to continue?[n/y]");
} /* End pascal_tri */

/* Function sum1 */
void sum1() {
	tc(12 + 128);
	gotoxy(20, 4);
	cprintf("The program calculate the sumination of :");
	tc(14);
	gotoxy(23, 6);
	cprintf("S=1(1!)+2(2!)+3(3!)+.......+n(n!)");
ll1:
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(15, 8);
	cprintf("If the value of n is :     ");
	gotoxy(38, 8);
	scanf("%d", &n);
	if (n <= 0) {
		sound(1000);
		gotoxy(20, 20);
		cprintf("Please input again ,are you crazy!");
		delay(1000);
		gotoxy(20, 20);
		cprintf("                                                  ");
		nosound();
		goto ll1;
	}
	else {
		tc(14);
		gotoxy(18, 10);
		cprintf("Then S=1(1!)+2(2!)+3(3!)+.......+%d(%d!)", n, n);
		S1 = 0;
		P = 1;
		for (i = 1; i <= n; i++) {
			P = P * i;
			S1 = S1 + i * P;
		}
		tc(11);
		gotoxy(20, 12);
		cprintf("The result of sumination is:");
		tc(10 + 128);
		gotoxy(49, 12);
		cprintf("%ld", S1);
		gotoxy(25, 20);
		tc(4);
		cprintf("Do you want to continue?[n/y]");
	}
} /* End function sum1 */

/* Function sum2 */
void sum2() {
	tc(12 + 128);
	gotoxy(20, 4);
	cprintf("The program calculate the sumination of :");
	tc(14);
	gotoxy(23, 6);
	cprintf("S=C(n,1)-C(n,2)+C(n,3)+......+(-1)^(p+1)C(n,p)");
ll:
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(15, 8);
	cprintf("If the value of n is :     and p is :      ");
	gotoxy(38, 8);
	scanf("%d", &n);
	gotoxy(54, 8);
	scanf("%d", &p);
	tc(14);
	if (n <= 0 || p <= 0 || p > n) {
		sound(1000);
		gotoxy(20, 20);
		cprintf("Please input again ,are you crazy!");
		delay(1000);
		gotoxy(20, 20);
		cprintf("                                                  ");
		nosound();
		goto ll;
	}
	else if (n == 1) {
		S1 = 1;
		gotoxy(15, 10);
		cprintf("S=C(1,1)");
	}
	else if (n == 2) {
		if (p == 2) {
			S1 = 1;
			gotoxy(15, 10);
			cprintf("S=C(2,1)-C(2,2)");
		}
		else {
			S1 = 2;
			gotoxy(15, 10);
			cprintf("S=C(2,1)");
		}
	}
	else if (n == 3) {
		if (p == 3) {
			S1 = 1;
			gotoxy(15, 10);
			cprintf("S=C(3,1)-C(3,2)+C(3,3)");
		}
		else if (p == 2) {
			S1 = 0;
			gotoxy(15, 10);
			cprintf("S=C(3,1)-C(3,2)");
		}
		else {
			S1 = 3;
			gotoxy(15, 10);
			cprintf("S=C(3,1)");
		}
	}
	else {
		j = pow((-1), (p + 1));
		if (j > 0) {
			gotoxy(15, 10);
			cprintf("Then S=C(%d,1)-C(%d,2)+C(%d,3)-......+C(%d,%d)", n, n, n, n, p);
		}
		else {
			gotoxy(15, 10);
			cprintf("Then S=C(%d,1)-C(%d,2)+C(%d,3)-......-C(%d,%d)", n, n, n, n, p);
		}
		S1 = 0;
		C = 1;
		for (i = 1; i <= p; i++) {
			C = C * (n - i + 1) / i;
			P = pow((-1), (i + 1));
			S1 = S1 + P * C;
		}
	}
	tc(11);
	gotoxy(20, 12);
	cprintf("The result of sumination is:");
	tc(10 + 128);
	gotoxy(49, 12);
	cprintf("%ld", S1);
	gotoxy(25, 23);
	tc(4);
	cprintf("Do you want to continue?[n/y]");
} /* End function sum2 */

/* Function sum3 */
void sum3() {
	tc(12 + 128);
	gotoxy(20, 4);
	cprintf("The program calculate the sumination of :");
	tc(14);
	gotoxy(23, 6);
	cprintf("S=1^3+2^3+3^3+.........+n^3");
ll:
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(15, 8);
	cprintf("If the value of n is :      ");
	gotoxy(38, 8);
	scanf("%d", &n);
	tc(14);
	if (n <= 0) {
		sound(1000);
		gotoxy(20, 20);
		cprintf("Please input again ,are you crazy!");
		delay(1000);
		gotoxy(20, 20);
		cprintf("                                                  ");
		nosound();
		goto ll;
	}
	else if (n == 1) {
		S1 = 1;
		gotoxy(15, 10);
		cprintf("S=1^3");
	}
	else if (n == 2) {
		S1 = 9;
		gotoxy(15, 10);
		cprintf("S=1^3+2^3");
	}
	else if (n == 3) {
		S1 = 36;
		gotoxy(15, 10);
		cprintf("S=1^3+2^3+3^3");
	}
	else {
		gotoxy(15, 10);
		cprintf("Then S=1^3+2^3+3^3+........+%d^3", n);
		S1 = 0;
		C = 1;
		for (i = 1; i <= n; i++) {
			C = pow(i, 3);
			S1 = S1 + C;
		}
	}
	tc(11);
	gotoxy(20, 12);
	cprintf("The result of sumination is:");
	tc(10 + 128);
	gotoxy(49, 12);
	cprintf("%ld", S1);
	gotoxy(25, 23);
	tc(4);
	cprintf("Do you want to continue?[n/y]");
} /* End function sum3 */

/* Arrangment */
void Arrangement() {
	tc(9);
	gotoxy(19, 4);
	cprintf(" The program calculate about arrangement ");
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(20, 6);
	cprintf("A(n,p)=n!/p!");
	tc(14);
	gotoxy(20, 8);
	cprintf("A(n,p)=C(n,p)*(p-1)!");
ll:
	gotoxy(18, 10);
	tc(14);
	cprintf("Please input the value of n:       and p :     ");
	tc(12);
	gotoxy(47, 10);
	scanf("%d", &n);
	gotoxy(61, 10);
	scanf("%d", &p);
	if (n <= 0 || p <= 0 || p > n) {
		sound(1000);
		gotoxy(20, 20);
		cprintf("Please input again ,it invalid!");
		delay(1000);
		gotoxy(20, 20);
		cprintf("                                                  ");
		nosound();
		goto ll;
	}
	else {
		C = 1;
		for (i = 1; i <= n; i++) {
			C = C * i;
		}
		P = 1;
		for (i = 1; i <= p; i++) {
			P = P * i;
		}
		L = C / P;
		tc(14);
		gotoxy(20, 15);
		cprintf("The result of A(%d,%d) is : ", n, p);
		tc(10 + 128);
		gotoxy(46, 15);
		cprintf("%ld", L);
	}
	tc(12);
	gotoxy(25, 20);
	cprintf("Do you want to cotinue?[n/y]");
} /* End Arrangmen */

/* sys1 */
void sys1() {
	tc(12);
	gotoxy(25, 5);
	cprintf("WRITTEN BY IECH SETHA");
	tc(14);
	gotoxy(30, 6);
	cprintf("ÍÍÍÍÍÍÍÍÍÍ");
	tc(11);
	gotoxy(20, 9);
	cprintf("Please input the decimal number:");
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(54, 9);
	scanf("%ld", &L);
	tc(9);
	gotoxy(25, 13);
	cprintf("The decimal number is:%ld", L);
	j = 1;
	while (L != 0) {
		A[j] = L % 2;
		L = L / 2;
		j++;
	}
	tc(14);
	gotoxy(23, 15);
	cprintf("The binary number is:");
	gotoxy(45, 15);
	tc(10);
	for (i = 1; i < j; i++)
		cprintf("%d", A[j - i]);
	gotoxy(22, 20);
	cprintf("Do you want to continue?[n/y]");
} /* sys1 */

/* sys2 */
void sys2() {
	tc(12);
	gotoxy(25, 5);
	cprintf("WRITTEN BY IECH SETHA");
	tc(14);
	gotoxy(30, 6);
	cprintf("ÍÍÍÍÍÍÍÍÍÍ");
	tc(11);
	gotoxy(20, 9);
	cprintf("Please input the decimal number:");
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(54, 9);
	scanf("%ld", &L);
	tc(9);
	gotoxy(23, 13);
	cprintf("The decimal number is:%ld", L);
	j = 1;
	while (L != 0) {
		A[j] = L % 8;
		L = L / 8;
		j++;
	}
	tc(14);
	gotoxy(23, 15);
	cprintf("The octal number is:");
	gotoxy(45, 15);
	tc(10);
	for (i = 1; i < j; i++)
		cprintf("%d", A[j - i]);
	gotoxy(22, 20);
	cprintf("Do you want to continue?[n/y]");
} /* End sys2 */

/* sys3 */
void sys3() {
	tc(12);
	gotoxy(25, 5);
	cprintf("WRITTEN BY IECH SETHA");
	tc(14);
	gotoxy(30, 6);
	cprintf("ÍÍÍÍÍÍÍÍÍÍ");
	tc(11);
	gotoxy(20, 9);
	cprintf("Please input the decimal number:");
	_setcursortype(_NORMALCURSOR);
	tc(11);
	gotoxy(54, 9);
	scanf("%ld", &L);
	tc(9);
	gotoxy(23, 13);
	cprintf("The decimal number is:%ld", L);
	j = 1;
	while (L != 0) {
		A[j] = L % 16;
		L = L / 16;
		j++;
	}
	tc(14);
	gotoxy(20, 15);
	cprintf("The hexadecimal number is:");
	gotoxy(47, 15);
	tc(10);
	for (i = 1; i < j; i++) {
		if (A[j - i] >= 10 && A[j - i] <= 15) {
			if (A[j - i] == 10)
				A[j - i] = 65;
			else if (A[j - i] == 11)
				A[j - i] = 66;
			else if (A[j - i] == 12)
				A[j - i] = 67;
			else if (A[j - i] == 13)
				A[j - i] = 68;
			else if (A[j - i] == 14)
				A[j - i] = 69;
			else if (A[j - i] == 15)
				A[j - i] = 70;
			cprintf("%c", A[j - i]);
		}
		else
			cprintf("%d", A[j - i]);
	}
	gotoxy(22, 20);
	cprintf("Do you want to continue?[n/y]");
} /* End sys3 */

/* lin */
void lin() {
	tb(3);
	tc(15);
	gotoxy(1, 2);
	cprintf("ÉÍ[ ]");
	gotoxy(4, 2);
	tc(10);
	putch('þ');
	tc(15);
	gotoxy(80, 2);
	cprintf("»");
	gotoxy(37, 2);
	cprintf(" Help ");
	for (i = 1; i <= 31; i++) {
		gotoxy(i + 5, 2);
		cprintf("Í");
	}
	for (i = 43; i <= 79; i++) {
		gotoxy(i, 2);
		cprintf("Í");
	}
	for (i = 3; i <= 24; i++) {
		gotoxy(1, i);
		cprintf("º");
	}
	gotoxy(1, 24);
	cprintf("ÈÍ");
	gotoxy(3, 24);
	cprintf(":");
	gotoxy(6, 24);
	putch(15);
	gotoxy(7, 24);
	putch(15);
	tc(10);
	gotoxy(79, 24);
	cprintf("ÄÙ");
	tc(15);
	gotoxy(8, 24);
	cprintf("ÍÍ");
	tb(3);
	tc(1);
	gotoxy(10, 24);
	putch(17);
	gotoxy(11, 24);
	putch('þ');
	tb(3);
	tc(1);
	for (i = 12; i <= 77; i++) {
		gotoxy(i, 24);
		cprintf("²");
	}
	tb(3);
	tc(1);
	gotoxy(78, 24);
	cprintf("");
	tb(3);
	for (i = 4; i <= 22; i++) {
		tb(3);
		tc(1);
		gotoxy(80, i);
		cprintf("²");
	}
	tb(3);
	tc(1);
	gotoxy(80, 3);
	cprintf("");
	gotoxy(80, 23);
	cprintf("");
} /* End lin */

/* help */
void help() {
	tb(3);
	window(1, 1, 80, 25);
	clrscr();
	lin();
	func1();
	tb(3);
	tc(0);
	gotoxy(4, 3);
	cprintf("ÜÜÜÜÜÜÜÜÜÜÜÜ");
	gotoxy(4, 5);
	cprintf("ßßßßßßßßßßßß");
	gotoxy(6, 4);
	cprintf("Pro_Setha");
	gotoxy(3, 6);
	cprintf(" Choose ");
	tc(14);
	cprintf("  file  math   sum   caculate   window   help  physics  ");
	tc(0);
	gotoxy(4, 8);
	cprintf("- You can use the arrow keys ");
	tc(14);
	putch(26);
	tc(0);
	cprintf(" and ");
	tc(14);
	putch(27);
	tc(0);
	cprintf(" to select it. If you want to use one");
	gotoxy(3, 9);
	cprintf("menu you must press");
	tc(14);
	cprintf(" Enter");
	tc(0);
	cprintf(", then the box is show below (or not). In the box ");
	gotoxy(3, 10);
	cprintf("below you use arrow keys ");
	tc(14);
	putch(24);
	tc(0);
	cprintf(" and ");
	tc(14);
	putch(25);
	tc(0);
	cprintf(" to select then press ");
	tc(14);
	cprintf("Enter");
	tc(0);
	cprintf(" ,or when you see");
	gotoxy(3, 11);
	cprintf("the box below you should press the red letter to choose.");
	gotoxy(4, 13);
	cprintf("- Another way you can choose like below:");
	gotoxy(5, 14);
	cprintf("file ");
	tc(14);
	cprintf("Alt+f");
	tc(0);
	cprintf("  math ");
	tc(14);
	cprintf("Alt+m");
	tc(0);
	cprintf("  sum ");
	tc(14);
	cprintf("Alt+s");
	tc(0);
	cprintf("  caculate ");
	tc(14);
	cprintf("Alt+c");
	tc(0);
	cprintf("  window ");
	tc(14);
	cprintf("Alt+w");
	gotoxy(3, 15);
	tc(0);
	cprintf("  help ");
	tc(14);
	cprintf("Alt+h or F1");
	tc(0);
	cprintf("  Physics  ");
	tc(14);
	cprintf("Alt+p");
	gotoxy(10, 17);
	tc(0);
	cprintf("Example: the red letter ");
	gotoxy(7, 18);
	tc(0);
	cprintf("We select on math and press  Enter we see the box with the red letter ");
	gotoxy(7, 19);
	tc(14);
	cprintf("1  2  M  P  A  and S .");
	tc(0);
	cprintf("If you want to process in letter S ");
	gotoxy(7, 20);
	cprintf("you should press ");
	tc(14);
	cprintf("s.");
} /* End help */

/* discount */
void discount() {
	float spent, pay, disc;
sart:
	tc(11);
	gotoxy(31, 7);
	cprintf("DISCOUNT ON PAYMENT");
	tc(9);
	gotoxy(14, 9);
	_setcursortype(_NORMALCURSOR);
	cprintf("spent:");
	tc(7);
	gotoxy(14, 11);
	cprintf("discount:");
	tc(10);
	gotoxy(14, 13);
	cprintf("payment:");
	tc(6);
	gotoxy(14, 15);
	cprintf("choose:");
	gotoxy(24, 15);
	cprintf("<<A>> Again");
	gotoxy(24, 16);
	cprintf("<<W>> written by");
	gotoxy(24, 17);
	cprintf("<<T>> taught by");
	gotoxy(24, 18);
	cprintf("<<Q>> quit");
	tb(14);
	tc(11);
	gotoxy(24, 9);
	cprintf("$                   ");
	gotoxy(24, 11);
	cprintf("                    ");
	gotoxy(24, 13);
	cprintf("                    ");
	gotoxy(26, 9);
	scanf("%f", &spent);
	if (spent < 50)
		disc = 5 * spent / 100;
	else if (spent < 200)
		disc = 10 * spent / 100;
	else if (spent < 500)
		disc = 25 * spent / 100;
	else
		disc = 40 * spent / 100;
	pay = spent - disc;
	gotoxy(26, 11);
	cprintf("$%2f", disc);
	gotoxy(26, 13);
	cprintf("$%2f", pay);
	tb(co);
	tc(10);
	gotoxy(14, 15);
	cprintf("choose:");
	gotoxy(24, 15);
	cprintf("<< >> Again");
	gotoxy(24, 16);
	cprintf("<< >> written by");
	gotoxy(24, 17);
	cprintf("<< >> taught by");
	gotoxy(24, 18);
	cprintf("<< >> quit");
	tc(11 + 128);
	gotoxy(26, 15);
	cprintf("A");
	tc(10 + 128);
	gotoxy(26, 16);
	cprintf("W");
	tc(9 + 128);
	gotoxy(26, 17);
	cprintf("T");
	tc(7 + 128);
	gotoxy(26, 18);
	cprintf("Q");
} /* End discount */

/* PPCM */
long PPCM() {
	for (i = 2; i <= 19; i++) {
		gotoxy(i, 4);
		cprintf(" The program about PPCM of n number ");
		delay(100);
	}
	tc(14);
	gotoxy(15, 6);
	cprintf("Please input n and then input the number below :   ");
	_setcursortype(_NORMALCURSOR);
	gotoxy(63, 6);
	scanf("%d", &n);
	for (i = 1; i <= n; i++) {
		gotoxy(15 + 5*i, 8);
		scanf("%d", &A[i]);
	}
	S2 = A[1];
	for (i = 2; i <= n; i++) {
		S1 = PGCD(S2, A[i]);
		S2 = (S2 * A[i]) / S1;
	}
	gotoxy(20, 15);
	cprintf("The PPCM of %d number is :", n);
	tc(10);
	gotoxy(46, 15);
	cprintf("%ld", S2);
	tc(12 + 128);
	gotoxy(20, 20);
	cprintf("Do you want to continue?[y/n]");
	return S2;
} /* End PPCM */

/* sys */
void sys() {
	int i, j, l, n, m, a[23];
	long S, k;
	char ch;
sta:
	tb(co);
	gotoxy(15, 7);
	cprintf("                                               ");
	gotoxy(15, 9);
	cprintf("                                               ");
	gotoxy(15, 11);
	cprintf("                                               ");
	gotoxy(20, 19);
	cprintf("                                               ");
	tc(15);
	_setcursortype(_NORMALCURSOR);
	gotoxy(20, 3);
	cprintf("Please input the system number which");
	gotoxy(20, 4);
	cprintf("you want to convert to decimal system:     ");
	gotoxy(59, 4);
	scanf("%d", &l);
	tc(10);
	gotoxy(15, 7);
	cprintf("Please input lengh of number:");
	scanf("%d", &n);
	tc(14);
	gotoxy(15, 9);
	cprintf("Please input the number:");
	for (i = 1; i <= n; i++) {
		gotoxy(40 + i, 9);
		scanf("%d", &a[n - i]);
	}
	S = 0;
	k = 0;
	for (i = 1; i <= n; i++) {
		S = k + a[n - i];
		k = l * S;
	}
	gotoxy(15, 11);
	cprintf("Decimal number is :%ld", S);
	tc(4);
	gotoxy(20, 19);
	cprintf("Do you want to continue?[y/n]");
ag:
	ch = getch();
	if (ch == 'n' || ch == 'N')
		goto tt;
	else if (ch == 'y' || ch == 'Y')
		goto sta;
	else
		goto ag;
tt: }

/* End sys */
/* ==== arith ======= */
void arith() {
	int s, l;
	tb(co);
	_setcursortype(_NOCURSOR);
	while (!kbhit()) {
		for (j = 1; j <= 12; j++) {
			sound(100 + j*j + j*120);
			if (k > 32)
				k = 0;
			else if (k > 19) {
				if (k == co || k == 15 + co)
					k++;
				else
					k = k;
				tc(k + 128);
			}
			else {
				if (k == co || k % 16 == co)
					k++;
				else
					k = k;
				tc(k);
			}
			for (i = 1; i <= 10; i++) {
				s = i * j;
				l = 10 * j;
				if (j <= 6) {
					gotoxy(13*j - 11, 2 + i);
					if (i <= 9)
						cprintf("%d*%d =%d", j, i, s);
					else
						cprintf("%d*10=%d", j, l);
				}
				else {
					gotoxy(13*(j - 6) - 11, 13 + i);
					if (i <= 9)
						cprintf("%d*%d =%d", j, i, s);
					else
						cprintf("%d*10=%d", j, l);
				}
			}
			delay(20);
			nosound();
			sound(100 + j*j*127);
			delay(200);
			nosound();
			k++;
		}
	}
} /* End arith */

/* Positive */
void positive() {
	_setcursortype(_NORMALCURSOR);
	tc(14);
	gotoxy(20, 5);
	cprintf("Please input number of elements:");
	scanf("%d", &n);
	tc(10);
	gotoxy(15, 7);
	cprintf("The elements is :");
	for (i = 1; i <= n; i++) {
		gotoxy(10 + 5*i, 9);
		scanf("%d", &A[i]);
	}
	j = 0;
	for (i = 1; i <= n; i++) {
		if (A[i] > 0) {
			j++;
			pos[j] = A[i];
		}
		else
			continue;
	}
	tc(11);
	gotoxy(20, 13);
	cprintf("The positive number is:");
	for (i = 1; i <= j; i++) {
		gotoxy(15 + 5*i, 15);
		cprintf("%d", pos[i]);
	}
	tc(12 + 128);
	gotoxy(20, 20);
	cprintf("Do you want to continue?[n/y]");
} /* End positive */

/* setha */
void setha() {
	initgraph(&ab, &cd, "c:\\tc\\bgi");
	font = installuserfont("kh02.chr");
	settextstyle(font, 0, 4);
	setb(8);
	k = 0;
	for (i = 0; i <= 200; i++) {
		setc(11);
		ellipse(320, 240, 0, 360, 2*i, 400);
		delay(2);
	}
	while (!kbhit()) {
		for (i = 1; i <= 300; i++) {
			if (k > 15)
				k = 1;
			putpixel(320 - 2*i, 240 - 2*i, k);
			putpixel(322 - 2*i, 240 - 2*i, k);
			putpixel(324 - 2*i, 240 - 2*i, k);
			putpixel(320 + 2*i, 240 + 2*i, k);
			putpixel(322 + 2*i, 240 + 2*i, k);
			putpixel(324 + 2*i, 240 + 2*i, k);
			if (i < 50)
				setc(k + 6);
			else if (i < 100)
				setc(k + 14);
			else if (i < 150)
				setc(k + 11);
			else if (i < 200)
				setc(k + 3);
			else if (i < 250)
				setc(k + 9);
			else if (i < 300)
				setc(k + 15);
			circle(320, 240, 2 + i);
			delay(1);
		}
		k++;
	}
	setc(8);
	for (i = 1; i <= 400; i++) {
		circle(320, 240, 402 - i);
		delay(5);
	}
	setc(1);
	for (i = 1; i <= 200; i++) {
		ellipse(320, 240, 0, 360, 400, 2*i);
		delay(2);
	}
	setcolor(15);
	outtextxy(109, 109, "saklviTüal½yPU");
	outtextxy(330, 109, "minÞPñMeBj");
	outtextxy(69, 49, "´)aTeQµaH");
	outtextxy(230, 49, "eGoc");
	outtextxy(310, 49, "esdæa");
	outtextxy(380, 49, "CanisSitén");
	setcolor(13);
	outtextxy(70, 50, "´)aTeQµaH");
	outtextxy(231, 50, "eGoc");
	outtextxy(311, 50, "esdæa");
	outtextxy(381, 50, "CanisSitén");
	setcolor(9);
	outtextxy(110, 110, "saklviTüal½yPU");
	outtextxy(331, 110, "minÞPñMeBj");
	settextstyle(font, 0, 4);
	setcolor(12);
	outtextxy(80, 180, "sU");
	outtextxy(100, 180, "msVaKmn_nU");
	outtextxy(240, 180, "vkarmkdl;kmµviFI´");
	setcolor(15);
	outtextxy(82, 182, "sU");
	outtextxy(102, 182, "msVaKmn_nU");
	outtextxy(242, 182, "vkarmkdl;kmµviFI´");
	settextstyle(1, 0, 4);
	setcolor(13);
	outtextxy(100, 261, "TEACHER : KEAN TAK");
	setcolor(10);
	outtextxy(102, 260, "TEACHER : KEAN TAK");
	setcolor(7);
	outtextxy(102, 312, "TEACHER : CHOR CHANDARA");
	setcolor(14);
	outtextxy(100, 310, "TEACHER : CHOR CHANDARA");
	setcolor(9);
	outtextxy(100, 360, "TEACHER : PENG KUN");
	setcolor(11);
	outtextxy(101, 362, "TEACHER : PENG KUN");
	setcolor(11);
	outtextxy(101, 410, "TEACHER : CHHEM BUNTHOEUN");
	setcolor(13);
	outtextxy(100, 412, "TEACHER : CHHEM BUNTHOEUN");
	setcolor(15);
	outtextxy(50, 10, "ROYAL UNIVERSITY PHNOM PENH");
	setcolor(12);
	outtextxy(51, 11, "ROYAL UNIVERSITY PHNOM PENH");
	setcolor(1);
	outtextxy(53, 13, "ROYAL UNIVERSITY PHNOM PENH");
	setcolor(9);
	outtextxy(52, 12, "ROYAL UNIVERSITY PHNOM PENH");
	getch();
	getch();
	closegraph();
}
/* ================End of program====================== */
