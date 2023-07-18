// tabuada.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>

#define LIN 10
#define COL 10
int x;
int y;
int tabela[LIN][COL];

void preenche_tabela() {
	for(y=0; y < LIN; y++)
		for(x=0; x < COL; x++)
			tabela[y][x] = y*x;
}

int main(int argc, char **argv) {
	printf("\n         Tabela de Multiplicacao\n");
	preenche_tabela();

	// Imprime o numero das colunas
	printf("%6d", 0);
	for (x=1; x < COL; x++)
		printf("%3d", x);
	printf("\n");

	// Imprime uma linha horizontal
	printf("   ");
	for (x=0; x < 3*COL; x++)
		printf("=");
	printf("\n");

	//	Imprime as linhas da tabela. Cada linha a precedida pelo indice de linha e uma barra vertical
	for (y=0; y < LIN; y++) {
		printf("%2d|", y);
		for(x=0; x < COL; x++)
			printf("%3d", tabela[y][x]);
		printf("\n");
	}
	return 0;
}
