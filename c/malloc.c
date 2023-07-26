#include <stdio.h>
#include <stdlib.h>

// static
int my_variavel = 80;

int main(int argc, char **argv) {
	// dynamic
	int *x 	= malloc(sizeof(int));			// Espaco para 1 inteiro
	int *arr	= malloc(sizeof(int));			// Espaco para 100 inteiros

	*x 		= 120;
	arr[90] 	= 0xFEEDBEEF;
	arr[101] = 8; 									// BAD

	free(arr);
	arr = NULL;

	double *darr;
	darr = calloc(sizeof(double),100);
	darr = realloc(darr, sizeof(double)*500);

	return 0;
}
