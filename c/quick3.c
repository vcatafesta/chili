#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int compara(const void *x, const void *y){
	return (int) (*(int *)x - *(int *)y);
}

int main(){
	int i;
	int vetor[] = {0,50,50,25,36,3,5,8,1,9,2,4,7,0,6};
	int nlen    = sizeof(vetor)/sizeof(vetor[0]);

	qsort(vetor, nlen, sizeof(int), compara);

   for (i = 0; i < nlen; i++){
   	printf("%d, %d\n", i, vetor[i]);
	}
   exit(EXIT_SUCCESS);
}
