#include <stdio.h>
#include <stdlib.h>

int particiona(int *vetor, int inicio, int final){
	int esq  = inicio;
	int dir  = final;
	int pivo = vetor[inicio];
	int aux;

	while(esq < dir){
		while(vetor[esq] <= pivo)
			esq++;
		while(vetor[dir] > pivo)
			dir--;
		if(esq < dir){
			aux        = vetor[esq];
			vetor[esq] = vetor[dir];
			vetor[dir] = aux;
		}
	}
	vetor[inicio] = vetor[dir];
	vetor[dir]    = pivo;
	return dir;
}

int dividir(int vetor[], int esq, int dir){
	int aux;
	int cont = esq;
	int i;

	for(i = esq+1; i < dir; i++){
		if(vetor[i] < vetor[esq]){
			cont++;
			aux         = vetor[i];
			vetor[i]    = vetor[cont];
			vetor[cont] = aux;
		}
	}
	aux         = vetor[esq];
	vetor[esq]  = vetor[cont];
	vetor[cont] = aux;
	return cont;			
}

void quick(int vetor[], int esq, int dir){
	int pos;	
	
	if(esq < dir){
//		pos = dividir(vetor, esq, dir);
		pos = particiona(vetor, esq, dir);
		quick(vetor, esq, pos-1);
		quick(vetor, pos+1, dir);
	}
}

int main(){
	int vetor[] = {50,25,36,3,5,8,1,9,2,4,7,0,6};
	int n       = sizeof(vetor)/sizeof(vetor[0]);
	int i;

	quick(vetor, 0, n);
	for(i = 0; i < n; i++){
		printf("%d\n", vetor[i]);
	}	
	return 0;
}
