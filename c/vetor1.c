#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VECSIZE 2

typedef struct TALUNO {
	char nome[50];
	char nota[4];
} TALUNO, *PTALUNO;

int main()
{
	int i;
	TALUNO *aluno = (TALUNO *)malloc(VECSIZE * sizeof(TALUNO));
	TALUNO Vilmar = {"VILMAR CATAFESTA", "100"};

	printf("\n");
	for(i=0;i<VECSIZE;i++){
		strcpy(aluno[i].nome, "Billy Gato");
		strcpy(aluno[i].nota, "010"); 
		printf("%d, %s, %s\n", i, aluno[i].nome, aluno[i].nota);
	}
	printf("%d, %s, %s\n", i, Vilmar.nome, Vilmar.nota);
	return 0;
}
