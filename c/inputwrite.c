// inputwrite.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int main() {
    FILE *arquivo;
    char linha[100];

    // Abrir o arquivo para escrita
    arquivo = fopen("arquivo.txt", "w");
    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo.");
        return 1;
    }

    // Entrar com os dados
    printf("Digite uma linha de texto:\n");
    fgets(linha, 100, stdin);

    // Gravar no arquivo
    fputs(linha, arquivo);

    // Fechar o arquivo
    fclose(arquivo);

    return 0;
}
