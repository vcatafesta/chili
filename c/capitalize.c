// capitalize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/select.h>

#include "color.h"
#include "funcoes.c"

#define MAX_LEN 					1024
#define MAX_SUBSTRINGS 			100   	// define o número máximo de substrings permitido
#define MAX_SUBSTRING_LENGTH	200		// define o tamanho máximo de cada substring permitido

void usage() {
	printf("%scapitalize.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
	printf("Uso  capitalize <texto>\n");
	printf("     capitalize -l <linha digitavel\n");
	printf("     capitalize -t <texto texto texto>\n");
	printf("     capitalize -f <arquivo.ext>\n");
	printf("     capitalize <arquivo.ext stdin\n\n");
}

void show(char *str) {
	printf("Saida Capitalizada: %s", capitalize(str));
	return;
}

int main(int argc, char **argv) {
   char *buf   = argv[1];
	char *s     = space(MAX_LEN);
   char *linha = space(200);
   int  n    	= 0;
   int  cont 	= 0;
   int  ntam 	= 0;
   int  c;
   FILE *fp;

	usage();

	if(buf != NULL) {
		if (strcmp(buf, "-l") == 0) {
			cont = 2;
			goto linha;
		}
		else if (strcmp(buf, "-t") == 0) {
			cont = 2;
			goto formatada;
		}
		else if (strcmp(buf, "-f") == 0) {
			if(argv[2]) {
				cont = 2;
				buf  = argv[2];
				goto arquivolinha;
			}
			exit(1);
		}
		cont = 1;
		goto formatada;
	}

	if(argc == 1) {
		fd_set fds;
		FD_ZERO(&fds);
		FD_SET(STDIN_FILENO, &fds);

		struct timeval tv;
		tv.tv_sec = 0;
		tv.tv_usec = 0;

		int ret = select(STDIN_FILENO + 1, &fds, NULL, NULL, &tv);
		if (ret == -1) {
			perror("Erro ao chamar select()");
			return 1;
		} else if (ret == 0) {
			printf("Nenhum dado disponível na entrada padrão (stdin).\n");
			goto entrada;
		} else {
			printf("Dados disponíveis na entrada padrão (stdin).\n");
			goto entrada_stdin;
		}
	}

formatada:
	ntam = amaxstrlen(cont, argc, argv);

	for(; cont < argc; cont++) {
		printf("Entrada #%-2d : %-*s \tSaida capitalizada : %-s\n", cont, ntam, argv[cont], capitalize(argv[cont]));
		/*
		while(*(argv[cont]++) != '\0'){
			printf("Parametro #%d : %s \n", cont, argv[cont]);
		}
		*/
	}
	exit(0);

entrada_stdin:
	char line[MAX_LEN];
	
	while(!feof(stdin)) {
		if (fgets(line, sizeof(line), stdin) != NULL) {
			printf("%s", capitalize(line));
		}
	}
	exit(0);
	
arquivo:
	fp = fopen(buf, "r");
	if(!fp)
		perror("Erro abertura arquivo");
	else {
		do {
			c = fgetc(fp);
			if(feof(fp)) {
				s[n] = '\0';
				printf("\n\n<Saida capitalizada>\n%s\n", capitalize(s));
				printf("\nfeito! (%d) caracteres no texto/arquivo\n", n);
				break;
			}
			s[n] = c;
			//printf("%c", c);
			//printf("%d", c);
			n++;
		} while(1);
		exit(0);
	}
	exit(1);

arquivolinha:
	fp = fopen(buf, "r");
	if(!fp)
		perror("Erro abertura arquivo");
	else {
		while(!feof(fp)) {
			n++;
			if(fgets(linha, 200, fp) != NULL)
				;
				if(linha)
					printf("%-2d: %s", n, capitalize(linha));
        }
        exit(0);
	}
	exit(1);


linha:
	printf("\nEnter uma linha : ");
	fgets(s, MAX_LEN, stdin);
	show(s);
	exit(0);

entrada:
	char  *buffer  = space(MAX_LEN);
	char delimiter = ' ';  					// o caractere delimitador
	char *substrings[MAX_SUBSTRINGS];  	// a matriz de substrings
	int  wordcount = 0;
	int splitcount;  							// o número de substrings encontradas

	printf("Entre com o texto : ");
	fgets(buffer, MAX_LEN, stdin);
	remove_newline(buffer);  				// chama a função para remover o caractere de line feed
	wordcount  = wordstrcount(buffer);

  	if (wordcount == 0) {
   	exit(1);
	}

	printf("Len texto         : %d\n", strlen(buffer));
	printf("Saida Capitalizada: %s\n", capitalize(buffer));
	printf("Palavras          : %d\n", wordcount);

	splitcount = split(buffer, substrings, delimiter);  // chama a função para fazer o split da string
	for (int i = 0; i < splitcount; i++) {
		printf("Entrada #%-2d : %-*s \tSaida : %s\n",
		 							i+1,
		 							strlen(substrings[i]),
		 							substrings[i],
		 							capitalize(substrings[i])
		);
	}
	exit(0);
}
