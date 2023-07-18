// strok.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

void *spaceset(size_t size, char ch) {
	return(memset((char *)malloc(size * sizeof(char *)), ch, size));
}

void display(char *str) {
	int x = 0;
	int max = strlen(str);

	printf("%s\n", spaceset(80, '='));
	printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tPOINTER \tVALUE\n");
	printf("%s\n", spaceset(80, '-'));
	for(x=0; x < max; x++){
		printf("str[%03d] \t%c \t%d \t%o \t%x \t%p \t%s \n", x, str[x], str[x], str[x],str[x], &str[x], &str[x]);
	}
}

char *replicate(char ch, size_t x) {
	char *buff = (char*)malloc(x * sizeof(char *));
	if(buff != 0)
		memset(buff, ch, x);
	buff[x] = '\0';
	return buff;
}

char *space(int x, char ch) {
	char *buff = (char*)malloc(x * sizeof(char *));
	if(buff != 0)
		memset(buff, ch, x);
	buff[x] = '\0';
	return buff;
}

char *v_padr(char *str, size_t nwidth, char cfill) {
   size_t nlen   = strlen(str);
   size_t nsp    = (nwidth - nlen);
   char *buffer  = space(nwidth, 32);
   strcpy(buffer, str);
	printf("buffer: %s\n", buffer);
   strcat(buffer, space(nsp,cfill));
   return buffer;
}

int main(int argc, char **argv) {
	const char web[80] = "This is - www.chililinux.com - website";
   const char s[2]    = "-";
	char *str          = "This is - www.chililinux.com - website";
   char *token;

   /* get the first token */
   token = strtok(web, s);

   /* walk through other tokens */
   while( token != NULL ) {
      printf( " %s\n", token );
      token = strtok(NULL, s);
   }

	printf("%s\n", str);
	printf("%d\n", strlen(str));
	printf("%s\n", v_padr(str, 80, '#'));
	printf("%s\n", space(100, '='));
	printf("%s\n", replicate('=',20));
	display(str);
   return EXIT_SUCCESS;
}

