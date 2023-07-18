#include "protype.h"

typedef struct {
	char	nome[20];
	int 	idade;
}REG;
REG dados;

void regadd(REG *dados){
	strcpy(dados->nome, "VILMAR");
	dados->idade = 55;
}

void regprint(REG *dados){
	printf("Nome  : %s\n", dados->nome);
	printf("Idade : %d\n", dados->idade);
}

int main(){
	regadd(&dados);	
	regprint(&dados);	
	return 0;

}
