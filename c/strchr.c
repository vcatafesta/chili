// strchr.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

void print_str(const char *str) {
	const char *letra = strchr(str, 'a');
	size_t nlen       = 0;

   printf("string     : %s\n", str);
   printf("len string : %d\n", strlen(str));
   printf("char \tascii \tpointer\n");

   while( str[nlen] ) {
		letra = str[nlen];
//		printf("%c\n", letra);
      nlen++;
	   printf("%c \t%d\t%x\n", *strchr(str, letra), *strchr(str, letra), strchr(str, letra));
	   printf("%c \t%d\t%x\n", letra, letra, &letra);
//	   printf("%c \t%d\t%x\n", *(strchr(str, letra)+1), *(strchr(str, letra)+1), (strchr(str, letra)+1));
	}
}

int main(int argc, char **argv) {
//	const char str[50] = "Tomate";
	const char *str    = "Vilmar Catafesta";

   printf("strchr.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	print_str(str);
   return EXIT_SUCCESS;
}

