// readcsvfile.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define BUFSIZE 4096

void print1() {
	char item[BUFSIZE];
	char delim;
	int x = 0;
	int y = 0;
	int item_count = 0;

	while (scanf("%[^,\n]%c", item, &delim) != EOF) {
		item_count++;
		x++;
		printf("item[%d,%d] : %s\n", x, item_count, item);
		if (delim == '\n') {
			x = 0;
			printf("\n");
		}
	}
}

void print2() {
	char item[BUFSIZE];
	char delim;
	int item_count = 0;

	while (scanf("%[^,\n]%c", item, &delim) != EOF) {
		printf("%s, ", item);
		item_count++;
		if (delim == '\n') {
			printf(" (%d items)\n", item_count);
			item_count = 0;
		}
	}
}

int main(int argc, char **argv) {
   printf("readcsvfile.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	print1();
//	print2();
   return EXIT_SUCCESS;
}

