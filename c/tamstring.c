// tamstring.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int tamanhoString(char *string) {
    int tamanho = 0;
    while (string[tamanho] != '\0') {
        tamanho++;
    }
    return tamanho;
}

int main() {
    char yourString[200];
    char minhaString[] = "Hello, world!";
    int tamanho        = tamanhoString(minhaString);
    int tam            = tamanhoString(yourString);
    printf("O tamanho da string '%s' é: %d\n", minhaString, tamanho);
    printf("O tamanho da string '%s' é: %d\n", yourString, tam);
    return 0;
}
