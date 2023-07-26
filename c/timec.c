// timec.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int main(int argc, char **argv) {
	struct tm *data_hora_atual;
	struct tm *t;
	time_t segundos;
	time(&segundos);
	data_hora_atual = localtime(&segundos);

   printf("Dia : %d\n", data_hora_atual->tm_mday);
   printf("Dia : %s\n", asctime(localtime(t)));
   printf("Dia : %s\n", ctime(t));
   return EXIT_SUCCESS;
}

