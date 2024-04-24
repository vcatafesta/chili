// sena.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h> 	// srand rand
#include <time.h> 		// time
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
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

int main(int argc, char **argv) {
	printf("%ssena.c, Copyright (c) 2024 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	int jogadas = 60;
	int jogos = 6;
	int array_jogos[jogos];

	srand(time(NULL));

	for(size_t x = 0; x < jogadas; ++x) {
		for(size_t i = 0; i < jogos; ++i) {
			array_jogos[i] = ( rand() % 60 + 1);

			for(size_t j = 0; j < i; ++j) {
				if(array_jogos[i] == array_jogos[j]) {
					--i;
					break;
				}
			}
		}

		for(size_t i = 0; i < jogos; ++i) {
			for(size_t j = i + 1; j < jogos; ++j) {
				if(array_jogos[i] > array_jogos[j]) {
					int temp = array_jogos[i];
					array_jogos[i] = array_jogos[j];
					array_jogos[j] = temp;
				}
			}
		}


		for(size_t i = 0; i < jogos; i++) {
			printf("%s%02d%s ", CYAN, array_jogos[i], RESET);
		}

		putchar('\n');
	}

	return EXIT_SUCCESS;
}

