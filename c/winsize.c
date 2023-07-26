// winsize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN    "\033[36m"
#define RESET   "\033[0m"

int main(int argc, char **argv) {
   printf("%swinsize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
   printf("%sTamanho terminal corrente:\n%s", GREEN, RESET);
	struct winsize size;

	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &size) == -1) {
		perror("Erro ao obter tamanho do terminal");
		return EXIT_FAILURE;
	}

	printf("%sLinhas : %s%d\n", RED, RESET, size.ws_row);
	printf("%sColunas: %s%d\n", RED, RESET, size.ws_col);
	printf("%sxPixel : %s%d\n", RED, RESET, size.ws_xpixel);
	printf("%syPixel : %s%d\n", RED, RESET, size.ws_ypixel);
	printf("Screen width: %i  Screen height: %i\n", size.ws_col, size.ws_row);
	return EXIT_SUCCESS;
}

