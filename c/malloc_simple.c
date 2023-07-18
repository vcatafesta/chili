// malloc_simple.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int main(int argc, char **argv) {
	int *x    = malloc(sizeof(int));
	int *y    = calloc(1, sizeof(int));
	char *str = calloc(1, sizeof(char));

   printf("malloc_simple.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	if (x == NULL) {
	   printf("malloc_simple.c, Erro de alocação de memória");
	   return EXIT_FAILURE;
	}
	memset(x, 0, sizeof(int));
   printf("str, Memoria alocada -> value = %d\n", *str);
   printf("x, Memoria alocada -> value = %d\n", *x);
   printf("x, Memoria alocada -> size  = %d\n", sizeof(x));
   printf("y, Memoria alocada -> value = %d\n", *y);
   printf("y, Memoria alocada -> size  = %d\n", sizeof(y));
   return EXIT_SUCCESS;
}

