// tabelaascii.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <locale.h>

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN    "\033[36m"
#define RESET   "\033[0m"

int main(int argc, char **argv) {
	int i;
	setlocale(LC_ALL, "Portuguese");

	printf("%stabelaascii.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
   printf("%sHello World\n%s", GREEN, RESET);
	printf("+------------+------------+------------------+\n");
	printf("| Decimal    | Hexadecimal| Caractere        |\n");
	printf("+------------+------------+------------------+\n");

	for (i = 0; i <= 255; i++) {
		printf("| %10d | 0x%08x | %s%c%s                |\n",i, i, RED, i, RESET);
	}

	printf("+------------+------------+------------------+\n");
	return EXIT_SUCCESS;
}
