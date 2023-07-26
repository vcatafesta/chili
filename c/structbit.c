#include "funcoes.c"

#define VECSIZE 2

struct status {
	int ligado	:1;
	int valor	:4;
	int 			:3;
};

typedef struct {
	int dia;
	int mes;
	int ano;
}DNASC;

typedef struct {
	char 	nome[100];
	char 	sexo[3];
	int 	idade;
	DNASC	dnasc;
	struct status status;
}TPESSOA;

int main(){
	TPESSOA pessoa[VECSIZE];
	int i;

	for(i=0;i<VECSIZE;i++){
		p("\n");
		p("%s\n", replicate("-", 80));
		p("%s\n", padc("CADASTRO", 80, 32));
		p("%s\n", replicate("-", 80));
		GETSTR("Nome       : ", pessoa[i].nome);
		GETSTR("Sexo       : ", pessoa[i].sexo);
		GETNUM("Idade      : ", &pessoa[i].idade);
//		printf("Nascimento : "); fflush(stdin); scanf("%d%d%d", &pessoa[i].dnasc.dia, &pessoa[i].dnasc.mes, &pessoa[i].dnasc.ano);
	}
	return 0;
}
