// heap.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>

int main(int argc, char **argv) {
	/* Heap allocated memory.  */
	char *heap1 = (char *)__builtin_malloc( 42 );
	char *heap2 = (char *)__builtin_malloc( 42 );
	if( heap1 > heap2 ) {
		printf("Erro na alocacação da memória heap.\n");
		return 1;
	}
	printf("Alocacação da memória heap OK.\n");
	return 0;
}
