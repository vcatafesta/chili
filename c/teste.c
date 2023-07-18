// typedef.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

typedef struct {
    int idade;
    char sexo;
    char nome[100];
} TPESSOA;

struct TPESSOA2 {
    int idade;
    char sexo;
    char nome[100];
};

int
main(int argc, char **argv) {
    TPESSOA pessoa1;
    struct TPESSOA2 pessoa2;

    TPES

    printf("typedef.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
    pessoa1.idade = 56;
    pessoa1.sexo = 'M';
    strcpy(pessoa1.nome, "Vilmar Catafesta");
    printf("Nome  : %s\n", pessoa1.nome);
    printf("Idade : %d\n", pessoa1.idade);
    printf("Sexo  : %c\n", pessoa1.sexo);
    return EXIT_SUCCESS;
}
