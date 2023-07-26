// fileread.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include "color.h"
#include "funcoes.c"

#define TRUE 			1
#define FALSE 			0
#define BUFFER_SIZE	1024

int ms_file(char *file)
{
	if (access(file, F_OK) != -1)
		return TRUE;
	return FALSE;
}

int readline(char *file, int line=0){
	if (! ms_file(file)) {
		perror("Erro: ");
		return FALSE;
	}

	FILE *fp = fopen(file, "r");
	char buffer[BUFFER_SIZE];

	if (line == 0)
		line = 1;
	// Lendo a linha desejada
   int cont_linha = 1;
   while (fgets(buffer, BUFFER_SIZE, fp) != NULL) {
      if (cont_linha == line) {
         printf("Linha %d: %s", line, buffer);
         break;
      }
      cont_linha++;
   }
	fclose(fp);
	return TRUE;
}

int readfile(char *file){
	if (! ms_file(file)) {
		perror("Erro: ");
		return FALSE;
	}
	FILE *fp = fopen(file, "r");
	char line[BUFFER_SIZE];
  // Lendo o arquivo linha por linha
   while (fgets(line, BUFFER_SIZE, fp) != NULL) {
      printf("%s", line);
   }
	return TRUE;
}

int writefile(char *file, char *psz){
	FILE *fp = fopen(file, "a");

	if(! fp ){
		perror("Erro: ");
		return FALSE;
	}
	fprintf(fp, psz);
	fclose(fp);
	return TRUE;
}

int main(int argc, char **argv) {
   printf("%sfileread.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	char file[] = "vendedor.txt";
	char line[255];

   printf("%swritefile()%s\n", GREEN, RESET);
	writefile(file, "VILMAR CATAFESTA, DevBoy\n");
	writefile(file, "EVILI FRANCIELE, Advocate\n");
	writefile(file, "THARIC VINICIUS, Advocate\n");
	writefile(file, "THALES CEDRIK, Advocate\n");
	writefile(file, "THAINA GABRIELA, Advocate\n");
	writefile(file, "IONICE SOARES, Advocate\n");

   printf("%sreadline(file,5)%s\n", GREEN, RESET);
	readline(file,5);
   printf("%sreadfile(file)%s\n", GREEN, RESET);
	readfile(file);

   return EXIT_SUCCESS;
}
