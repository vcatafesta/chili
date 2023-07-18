// recursivestring.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

void print_recursive(char str[], int ini, int fim, int tam) {
	if (fim < tam ) {
		for (int i = ini; i <= fim; i++) {
			printf("%c", str[i]);
		}
		printf(", ");
   	print_recursive(str, ini, fim + 1, tam);
	}
	else if (ini < fim) {
   	print_recursive(str, ini + 1, ini + 1, tam);
	}
}

int main(int argc, char **argv) {
	char str[]	= {"vcatafesta@gmail.com"};
	int tam 		= strlen(str);

   printf("recursivestring.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
   print_recursive(str, 0, 0, tam);
   return EXIT_SUCCESS;
}

