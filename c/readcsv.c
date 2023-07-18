// readcsv.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define BUFFER_SIZE 1024

int main() {
    FILE* arquivo;
    char linha[BUFFER_SIZE];
    char* token;

    // abre o arquivo em modo leitura
    arquivo = fopen("packages-split.csv", "r");

    // verifica se o arquivo foi aberto com sucesso
    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo.\n");
        return 1;
    }

    // lê cada linha do arquivo
    while (fgets(linha, BUFFER_SIZE, arquivo) != NULL) {
        // separa os campos da linha usando vírgula como delimitador
        token = strtok(linha, ",");
        printf("%s \n", token);

        while (token != NULL) {
            printf("%s \n", token);
            token = strtok(NULL, ",");
        }
        printf("\n");
    }

    // fecha o arquivo
    fclose(arquivo);

    return 0;
}
