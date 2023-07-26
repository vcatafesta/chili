// ponteiro.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include "protype.h"
#include "color.h"

int main(int argc, char **argv) {
	int *ptr, a         = 50;
	char *pletra, letra = 'v';

	ptr    = &a;
	pletra = &letra;

   printf("%sponteiro.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
	printf("Valor de a               : %d\n", a);
	printf("Endereço de a            : %p\n", &a);
	printf("Endereço de ptr          : %p\n", &ptr);
	printf("Conteudo de ptr          : %p\n", ptr);
	printf("Conteudo apontado por ptr: %d\n", *ptr);
	printf("\n");
	printf("Valor de letra              : %c\n", letra);
	printf("Endereço de letra           : %p\n", &letra);
	printf("Endereço de pletra          : %p\n", &pletra);
	printf("Conteudo de pletra          : %p\n", pletra);
	printf("Conteudo apontado por pletra: %c\n", *pletra);
   return EXIT_SUCCESS;
}
