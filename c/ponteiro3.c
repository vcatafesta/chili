// ponteiro1.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

int main(int argc, char **argv) {
   printf("%sponteiro1.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	int *pidade, idade = ( 2023 - 1966);
	char *pletra, letra = 'g';

	pidade = &idade;
	pletra = &letra;

	printf("int *pidade, idade = ( 2023 - 1966);\n");
	printf("char *pletra, letra = 'g';\n");

	printf("pidade = &idade;\n");
	printf("pletra = &letra;\n\n");
	
   printf("%sVALOR de idade       : %d\n", YELLOW, idade);
   printf("%sENDE  de idade       : %x\n", YELLOW, &idade);
   printf("%sENDE APONTADO pidade : %x\n", YELLOW, pidade);
   printf("%sENDE  pidade         : %x\n", YELLOW, &pidade);
   printf("%sCONTEUDO de pidade   : %d\n", YELLOW, *pidade);
   printf("\n");
   printf("%sVALOR de letra       : %c\n", YELLOW, letra);
   printf("%sENDE  de letra       : %x\n", YELLOW, &letra);
   printf("%sENDE APONTADO pletra : %x\n", YELLOW, pletra);
   printf("%sENDE pletra          : %x\n", YELLOW, &pletra);
   printf("%sCONTEUDO de pletra   : %c\n", YELLOW, *pletra);
   printf("\n");

   return EXIT_SUCCESS;
}

