// substr.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

int contar_palavras(const char *str) {
    int count = 0;
    int inside_word = 0;

    while (*str != '\0') {
        if (isspace(*str) || ispunct(*str)) {
            inside_word = 0;
        } else if (!inside_word) {
            inside_word = 1;
            count++;
        }
        str++;
    }

    return count;
}

char *substr(const char *str, int start, int length) {
    int str_len = strlen(str);

    if (start >= str_len || length < 1) {
        return NULL;
    }

    if (start + length > str_len) {
        length = str_len - start;
    }

    char *sub = (char *) malloc(length + 1);
    if (sub == NULL) {
        return NULL;
    }

    memcpy(sub, &str[start], length);
    sub[length] = '\0';

    return sub;
}

int main() {
   printf("%ssubstr.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
   printf("%sHello World\n%s", GREEN, RESET);
    char str[] = "Hello, world!";
    char *sub1 = substr(str, 0, 5);  // extrai "Hello"
    char *sub2 = substr(str, 7, 5);  // extrai "world"
    char *sub3 = substr(str, 14, 3); // extrai "!"

    printf("sub1 = %s\n", sub1);
    printf("sub2 = %s\n", sub2);
    printf("sub3 = %s\n", sub3);

    free(sub1);
    free(sub2);
    free(sub3);

   return EXIT_SUCCESS;
}

