// sizewin.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <err.h>       // err
#include <fcntl.h>     // open
#include <unistd.h>    // close
//#include <termios.h>   // doesnt seem to be needed for this 
#include "nos_utils.h"

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN    "\033[36m"
#define RESET   "\033[0m"

/*
 * @return  struct winsize
 * unsigned short int ws_row;
 * unsigned short int ws_col;
 * unsigned short int ws_xpixel;
 * unsigned short int ws_ypixel;
 */

struct winsize get_screen_size() {
	struct winsize ws;
	int fd;

	fd = open("/dev/tty", O_RDWR);
	if (fd < 0 || ioctl(fd, TIOCGWINSZ, &ws) < 0) err(8, "/dev/tty");
	close(fd);
	return ws;
}

ushort get_screen_width() {
	struct winsize ws = get_screen_size();
	return ws.ws_col;
}

ushort get_screen_height() {
	struct winsize ws = get_screen_size();
	return ws.ws_row;
}

void test_screen_size() {
	struct winsize ws = get_screen_size();
	ushort h = ws.ws_row;
	ushort w = ws.ws_col;

   printf("%sThe Terminal Size is:\n%s", GREEN, RESET);
	printf("rows: %zu in %upx\n", h, ws.ws_ypixel);
	printf("cols: %zu in %upx\n", w, ws.ws_xpixel);

	h = get_screen_height();
	w = get_screen_width();
	h-= 4;

	for (ushort  i = 0; i < h; i++) {
		for (ushort  j = 0; j < w; j++) {
			if      (j == w - 1) 							{ printf(" \n"); }
			else if (i == 0 || i == h - 1 || j == 0) 	{ printf("%s ", RED); }
			else if (i == 1) 									{ printf("%s^", GREEN); }
			else if (i == h - 2) 							{ printf("%sv", YELLOW); }
			else if (j == 1) 									{ printf("%s<", CYAN); }
			else if (j == w - 2) 							{ printf("%s>", BLUE); }
			else 													{ printf("%s▒", MAGENTA); }
		}
	}
}

/*
▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒
▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓
▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒▓░▒░▒░░▓░▓▒▓▒▓▓▒▒░▒▓▒
*/
int main(int argc, char **argv) {
   printf("%ssizewin.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	test_screen_size();
	int lines = atoi(getenv("LINES"));
	int columns = atoi(getenv("COLUMNS"));
   printf("%srows  : %d\n", RED, lines);
   printf("%scols  : %d\n", RED, columns);
   return EXIT_SUCCESS;
}

