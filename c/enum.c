// enum.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

enum registro { incluir = 0, excluir = 1, listar  = 2 } TREGISTRO;

enum Suit {
    club = 0,
    diamonds = 10,
    hearts = 20,
    spades = 3,
    teste = 4
};

enum Day {
	segunda,
	terca,
	quarta,
	quinta,
	sexta,
	sabado,
	domingo
};

enum Sabor {vanilla, chocolate, mente, morango};

int main(int argc, char **argv) {
   printf("%senum.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	TREGISTRO = incluir;
	Suit jogo = club;
	Day hoje  = quinta;
	printf("Size of enum variable = %d bytes\n", sizeof(Suit));	
	printf("Size of enum variable = %d bytes\n", sizeof(TREGISTRO));	
	printf("Value of enum variable = %d\n", excluir);

	switch(hoje) {
		case domingo: printf("Hoje é domingo!\n"); break;
		case segunda: printf("Hoje é segunda!\n"); break;
		case terca:   printf("Hoje é terca!\n"); break;
		case quarta:  printf("Hoje é quarta!\n"); break;
		case quinta:  printf("Hoje é quinta!\n"); break;
		case sexta:   printf("Hoje é sexta!\n"); break;
		case sabado:  printf("Hoje é sabado!\n"); break;
	}

	return EXIT_SUCCESS;
}
