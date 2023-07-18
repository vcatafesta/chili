// ponteiro4.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include "color.h"

#define sizeof_array(ARRAY)   (sizeof(ARRAY)/sizeof(ARRAY[0]))
#define arraylenght(ARRAY)    (sizeof(ARRAY)/sizeof(int*))
#define COUNTOF(x)            (sizeof(x)/sizeof(*x))
#define arraylen(x)           (sizeof(x)/sizeof(int))
#define arraylenint(x)        (sizeof(x)/sizeof(x[0]));

/* Em C, é possível calcular o tamanho de um array de inteiros dentro de uma função utilizando o operador sizeof.
 * No entanto, é importante notar que, quando um array é/ passado como argumento para uma função, ele é convertido
 * em um ponteiro para o primeiro elemento do array.
 *
 * Assim, se quisermos calcular o tamanho de um array de inteiros dentro de uma função, precisamos passar o tamanho
 * do array como um parâmetro adicional para a função.
 */

void print(int *v, int nlen) {
	printf("%d\n", nlen);

	for(int i = 0; i < nlen; i++) {
		printf("%d => %c\t", *(v + i), *(v + i));
	}
	puts("");
	return;
}

void incluirvetor(int *v, int nlen) {
	for(int i = 0; i < nlen; i++) {
		printf("Entre com um valor (%d/%d): ", i+1, nlen);
		scanf("%d", v+i);
	}
}

int main(int argc, char **argv) {
	int vet[10] = {0,1,2,3,4,5,6,7,8,9};
	int let[10] = {'a','b','c','d','e','f','g','h','i','j'};
	int *p;

	printf("%sponteiro4.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
	printf("%p\t%p\n", vet, vet[0]);
	printf("%p\t%p\n", vet, &vet[0]);

//	incluirvetor(vet, 10);
//	print(vet,arraylen(vet));
//	print(let,arraylen(let));

	printf("%d\n", sizeof(int));
	printf("%d\n", sizeof(p));

   return EXIT_SUCCESS;
}

