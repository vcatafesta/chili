// char_ex.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

void print(char *cStr) {
	int count = 0;

	printf("count \tChar \tDecimal\n");
	while(*cStr){
		printf("%d \t%c \t%d\n", ++count, *cStr, *cStr);
		cStr++;
	}
	printf("\n");
}

int main(int argc, char **argv) {
	char *pStr    = "Vilmar, o gatinho";
	char cStr[20] = "Hello";
	char nome[]   = "Gato";

	printf("char_ex.c, Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	print(cStr);
	print(pStr);
	print(nome);
	return EXIT_SUCCESS;
}
