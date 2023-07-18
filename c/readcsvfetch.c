// readcsvfetch.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define BUFFER_SIZE 4096

/*
a2ps,4.14-11,11,a2ps-4.14-11-x86_64.chi.zst,a/a2ps-4.14-11-x86_64.chi.zst,a2ps-4.14-11,849836
	   pkg_fullname="${BASH_REMATCH[0]}"
      pkg_base="${BASH_REMATCH[1]}"
      pkg_version_build="${BASH_REMATCH[2]}"
      pkg_version="${BASH_REMATCH[3]}"
      pkg_build="${BASH_REMATCH[4]}"
      pkg_arch="${BASH_REMATCH[5]}"
      pkg_base_version="${pkg_base}-${pkg_version_build}"
*/

typedef struct {
	char pkg_base[512];
	char pkg_version_build[512];
	char pkg_version[3];
 	char pkg_base_version[512];
	char pkg_fullname[512];
   char pkg_build[3];
   char pkg_len[128];
} TPACKAGE;

void read_csv(char* filename, TPACKAGE* list, int* size) {
    FILE* fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("Erro ao abrir o arquivo %s\n", filename);
        exit(EXIT_FAILURE);
    }

	char buffer[BUFFER_SIZE];
   *size = 0;
	char *token;

	while (fgets(buffer, BUFFER_SIZE, fp) != NULL) {
		token = strtok(buffer, ",");
		while (token != NULL) {
      	printf("%s ", token);
         token = strtok(NULL, ",");
      }
        printf("\n");
        char *pkg_base          = strtok(buffer, ",");
        char *pkg_version_build = strtok(NULL, ",");
        char *pkg_version       = strtok(NULL, ",");
        strcpy(list[*size].pkg_base, pkg_base);
        strcpy(list[*size].pkg_version_build, pkg_version_build);
        strcpy(list[*size].pkg_version, pkg_version);
        (*size)++;
    }
    fclose(fp);
}

void print_list(TPACKAGE* list, int size) {
    for (int i = 0; i < size; i++) {
        printf("%s, %d, %s\n", list[i].pkg_base, list[i].pkg_version_build, list[i].pkg_version);
    }
}

int main(int argc, char **argv) {
	TPACKAGE list[5000];
	int size;

   printf("readcsvfetch.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	read_csv("packages-split.csv", list, &size);
	print_list(list, size);

   return EXIT_SUCCESS;
}

