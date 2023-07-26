// readwrite.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int main() {
    FILE *arquivo_entrada;
	 FILE *arquivo_saida;
    char c;

    // Abrir o arquivo de entrada para leitura
    arquivo_entrada = fopen("arquivo_de_entrada.txt", "r");
    if (arquivo_entrada == NULL) {
        printf("Erro ao abrir o arquivo de entrada.");
        exit(EXIT_FAILURE);
    }

    // Abrir o arquivo de saída para escrita
    arquivo_saida = fopen("arquivo_de_saida.txt", "w");
    if (arquivo_saida == NULL) {
        printf("Erro ao abrir o arquivo de saída.");
        exit(EXIT_FAILURE);
    }

    // Ler o arquivo de entrada e escrever no arquivo de saída
    while ((c = fgetc(arquivo_entrada)) != EOF) {
        printf("%c", c);
        fputc(c, arquivo_saida);
    }

    // Fechar os arquivos
    fclose(arquivo_entrada);
    fclose(arquivo_saida);

    exit(EXIT_SUCCESS);
}
