// box.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <locale.h>
#include <wchar.h>
#include "color.h"

// Single-line
//#define B_SINGLE        ( Chr( 218 ) + Chr( 196 ) + Chr( 191 ) + Chr( 179 ) + ; /* "┌ ─ ┐│┘─└│" */
//                          Chr( 217 ) + Chr( 196 ) + Chr( 192 ) + Chr( 179 ) + hb_UTF8ToStrBox("┬┴├┤"))

int main(int argc, char **argv) {
	printf("%sbox.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	//	setlocale(LC_ALL, "");  // Necessário para que o sistema saiba qual o conjunto de caracteres a usar.
	int width  = 20;
	int height = 10;

	int decimal_value = 219; // Exemplo de valor decimal
	wchar_t unicode_value = decimal_value; // Conversão para Unicode
	printf("%lc\n", unicode_value);
	wprintf(L"Valor decimal: %d\nValor Unicode: %lc\n", decimal_value, unicode_value);
	return 0;
	
   // Imprime a linha superior do box
	printf("176=\u00b0\n");
	printf("176=\u2591\u2592\u2593\n");
	printf("\u264D\n");
	printf("\u26D4\n");
	printf("\u000A");
	printf("\u256d");
	for (int i = 0; i < width - 2; i++) {
		printf("\u2500");
	}
	printf("\u256e\n");

    // Imprime as linhas do meio do box
    for (int i = 0; i < height - 2; i++) {
        printf("|");
        for (int j = 0; j < width - 2; j++) {
            printf("\u2574");
        }
        printf("|\n");
    }

    // Imprime a linha inferior do box
    printf("+");
    for (int i = 0; i < width - 2; i++) {
        printf("-");
    }
    printf("+\n");

   return EXIT_SUCCESS;
}

