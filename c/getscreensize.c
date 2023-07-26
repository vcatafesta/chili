// getscreensize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h> // ioctl, TIOCGWINSZ
#include <err.h>       // err
#include <fcntl.h>     // open
#include <unistd.h>    // close
#include <termios.h>   // don't remember, but it's needed

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN    "\033[36m"
#define RESET   "\033[0m"

size_t* get_screen_size() {
	size_t* result = malloc(sizeof(size_t) * 2);
	if(!result) err(1, "Memory Error");

	struct winsize ws;
	int fd;

	fd = open("/dev/tty", 0_RDWR);
	if(fd < 0 || ioctl(fd, TIOCGWINSZ, &ws) < 0) err(8, "/dev/tty");

	result[0] = ws.ws_row;
	result[1] = ws.ws_col;
	close(fd);

	return result;
}


int main(int argc, char **argv) {
   printf("%sgetscreensize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
   printf("%sHello World\n%s", GREEN, RESET);
   return EXIT_SUCCESS;
}

