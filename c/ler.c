// ler.c, Copyright (c) 1991,2024 Vilmar Catafesta <vcatafesta@gmail.com>
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


int main(int argc, char **argv) {
	printf("%sler.c, Copyright (c) 1991,2024 Vilmar Catafesta <vcatafesta@gmail.com>%s\n", YELLOW, RESET);

	const int BUFFER = 1024;
	char *cfilename = "arquivo.txt";
	char conteudo[BUFFER];
	int line = 1;

	if(access(cfilename, R_OK)) {
		fprintf(stderr, "Erro: arquivo 'arquivo.txt' não existe\n");
      return EXIT_FAILURE;
	}


	if(argc > 1) {
		if(strcmp(argv[1], "-n") == 0 || strcmp(argv[1], "--number") == 0) {
			FILE *file = fopen("arquivo.txt", "r");
			while(fgets(conteudo, BUFFER, file)) {
				printf("%d %s", line, conteudo);
				line++;
			}
			fclose(file);
		} else {
			printf("%sErro nos parâmetros\n%s", RED, RESET);
			return 1;
		}
	}else {
	   fprintf( stderr,"use: ler <filename>\n" );
      return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;
}

