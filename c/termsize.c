// termsize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termcap.h>
#include <error.h>

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN    "\033[36m"
#define RESET   "\033[0m"

static char termbuf[2048];

int main(int argc, char **argv) {
	char *termtype = getenv("TERM");

   printf("%stermsize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
   printf("%sHello World\n%s", GREEN, RESET);

	if (tgetent(termbuf, termtype) < 0) {
		error(EXIT_FAILURE, 0, "Could not access the termcap data base.\n");
	}
	int lines = tgetnum("li");
	int columns = tgetnum("co");

	printf("lines = %d; columns = %d.\n", lines, columns);
	return EXIT_SUCCESS;
}

