// color.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN    "\033[36m"
#define RESET   "\033[0m"

int main(int argc, char **argv) {
   printf("color.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	printf("\033[31mTexto em vermelho\n");
	printf("\033[32mTexto em verde\n");
	printf("\033[33mTexto em amarelo\n");
	printf("\033[34mTexto em azul\n");
	printf("\033[35mTexto em magenta\n");
	printf("\033[36mTexto em ciano\n");
	printf("\033[37mTexto em branco\n");

	printf("%sTexto em vermelho%s\n", RED, RESET);
	printf("%sTexto em verde%s\n", GREEN, RESET);
	printf("%sTexto em amarelo%s\n", YELLOW, RESET);
	printf("%sTexto em azul%s\n", BLUE, RESET);
	printf("%sTexto em magenta%s\n", MAGENTA, RESET);
	printf("%sTexto em ciano%s\n", CYAN, RESET);
	return EXIT_SUCCESS;
}

