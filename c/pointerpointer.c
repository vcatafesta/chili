#include "funcoes.c"

int main() {
	int x = 0;
	int *ptrx, **pptrx;
	
	printf("Valor    de x = %d\n", x);
	printf("Endereco de x = %x\n", &x);

	// atribuindo os enderecos para os ponteiros
	ptrx  = &x;
	pptrx = &ptrx;

	printf("Valor de x                           = %d\n", x);
	printf("Endereco apontado por ptrx           = %x\n", ptrx);
	printf("Endereco de memoria de variavel ptrx = %x\n", &ptrx);

	return 0;
}
