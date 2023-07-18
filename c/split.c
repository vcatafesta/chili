// split.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>

#define BLACK        "\033[30m"
#define RED          "\033[31m"
#define GREEN        "\033[32m"
#define YELLOW       "\033[33m"
#define BLUE         "\033[34m"
#define MAGENTA      "\033[35m"
#define CYAN         "\033[36m"
#define WHITE        "\033[37m"
#define GRAY         "\033[90m"
#define LIGHTWHITE   "\033[97m"
#define LIGHTGRAY    "\033[37m"
#define LIGHTRED     "\033[91m"
#define LIGHTGREEN   "\033[92m"
#define LIGHTYELLOW  "\033[93m"
#define LIGHTBLUE    "\033[94m"
#define LIGHTMAGENTA "\033[95m"
#define LIGHTCYAN    "\033[96m"
#define RESET        "\033[0m"
#define BOLD         "\033[1m"
#define FAINT        "\033[2m"
#define ITALIC       "\033[3m"
#define UNDERLINE    "\033[4m"
#define BLINK        "\033[5m"
#define INVERTED     "\033[7m"
#define HIDDEN       "\033[8m"

#define MAX_SUBSTRINGS 10   // define o número máximo de substrings permitido
#define MAX_SUBSTRING_LENGTH 20  // define o tamanho máximo de cada substring permitido

int split(char *str, char delimiter, char **substrings) {
    int count = 0;  // conta o número de substrings encontradas
    char *token;    // ponteiro para o token encontrado

    // encontra o primeiro token
    token = strtok(str, &delimiter);

    // percorre a string enquanto houver tokens
    while (token != NULL) {
        substrings[count] = token;  // armazena o token na matriz de substrings
        count++;  // incrementa o contador de substrings encontradas

        if (count == MAX_SUBSTRINGS) {
            break;  // atingiu o limite máximo de substrings permitido
        }

        // encontra o próximo token
        token = strtok(NULL, &delimiter);
    }

    return count;  // retorna o número de substrings encontradas
}

int main(int argc, char **argv) {
   printf("%ssplit.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
    char str[] = "hello,world,how,are,you";  // a string a ser dividida
    char delimiter = ',';  // o caractere delimitador
    char *substrings[MAX_SUBSTRINGS];  // a matriz de substrings
    int count;  // o número de substrings encontradas

    count = split(str, delimiter, substrings);  // chama a função para fazer o split da string

    // imprime as substrings encontradas
    for (int i = 0; i < count; i++) {
        printf("%s\n", substrings[i]);
    }

   return EXIT_SUCCESS;
}
