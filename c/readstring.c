// readstring.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

void print_str(const char *str) {
   int i = 0;

   printf("string     : %s\n", str);
   printf("len string : %d\n", strlen(str));
   printf("char \tascii \tpointer\n");

   while( str[i] ) {
      printf("%c \t%d\t%x\n", str[i], str[i], &str[i]);
      i++;
   }
}
// size_t strcspn(const char *str1, const char *str2)
char *remove_enter(char *str){
	print_str(str);
   printf("remove_enter(%s, %d)\n", str, strlen(str));
	int i = 0;
	while ( str[i] ) {
      if (str[i] == '\n' )
			str[i] = '\0';
		i++;
   }
   printf("remove_enter(%s, %d)\n", str, strlen(str));
	print_str(str);
   return str;
}

size_t lenstr(char *str) {
   int i=0;
   while ( str[i] != '\0' ) {
      i++;
   }
   return i;
}

size_t lenstr1(char *str) {
   int tam=0;
   while ( *str ) {
      tam++;
      *str++;
   }
   return tam;
}

int main(int argc, char **argv) {
	char cvar[20];
	char *str = "Essa é a string";
	char *p   = &str;
	int i     = 0;

   printf("readstring.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
   printf(" string {str}: %s\n", str);
   printf(" strlen {str}: %d\n", strlen(str));
   printf(" lenstr (str): %d\n", lenstr(str));
   printf("lenstr1 {str}: %d\n", lenstr1(str));
   while ( str[i] ) {
	   printf("%c", str[i]);
	   i++;
	}

	printf("\n");
   while ( *str ) {
	   printf("%c", *str);
	   *str++;
	}

	printf("\nDigite algo : ");
	fgets(cvar, 15, stdin);
   printf("%s", cvar);
   remove_enter(cvar);
   return EXIT_SUCCESS;
}

