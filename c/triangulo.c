// triangulo.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

void desenhaTriangulo(int altura) {
    for (int i = 1; i <= altura; i++) {
        for (int j = 1; j <= altura - i; j++) {
            printf(" ");
        }
        for (int k = 1; k <= 2 * i - 1; k++) {
            printf("%s#", GREEN);
        }
        printf("\n");
    }
}

int main(int argc, char **argv) {
    int altura = 40;
    printf("%striangulo.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
    desenhaTriangulo(altura);
    return EXIT_SUCCESS;
}
