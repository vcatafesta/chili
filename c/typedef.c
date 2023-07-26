// typedef.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

typedef struct {
    int x;
    float y;
    char c;
} MyStruct;

typedef struct {
	int dia;
	int mes;
	int ano;
} TDNASC;

typedef struct {
	TDNASC nasc;
	int idade;
	char sexo;
	char nome[100];
} TPESSOA;

struct TOUTRAPESSOA {
	int idade;
	char sexo;
	char nome[100];
};

void print_pessoa(TPESSOA p) {
	printf("Nome  : %s\n", p.nome);
	printf("Idade : %d\n", p.idade);
	printf("Sexo  : %c\n", p.sexo);
	printf("Nasc  : %02d/%02d/%04d\n", p.nasc.dia, p.nasc.mes, p.nasc.ano);
}

TPESSOA read_pessoa() {
	TPESSOA p;
	strcpy(p.nome, "Vilmar Catafesta");
	p.idade    = 56;
	p.sexo     = 'M';
	p.nasc.dia = 18;
	p.nasc.mes = 9;
	p.nasc.ano = 1966;
	return p;
}

int main(int argc, char **argv) {
//	TPESSOA pessoa;
//	struct TOUTRAPESSOA pessoa1;

   printf("typedef.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	print_pessoa(read_pessoa());

	MyStruct* ptr = (MyStruct*) malloc(sizeof(MyStruct));
	if (ptr == NULL) {
		printf("Falha ao alocar memória!\n");
		exit(1);
	}
	ptr->x = 10;
	ptr->y = 3.14;
	ptr->c = 'a';
	printf("x = %d, y = %f, c = %c\n", ptr->x, ptr->y, ptr->c);
	free(ptr);
   return EXIT_SUCCESS;
}

