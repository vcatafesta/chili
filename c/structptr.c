#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <locale.h>

void copyright()
{
	setlocale(LC_ALL, "Portuguese");
  printf("Macrosoft structPtr.c, Copyright(c), 2021 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
}

typedef struct {
	uint8_t dia;
	uint8_t mes;
	uint16_t ano;
}DATA;

typedef struct _estudante_ {
	int nMatricula;
	char nome[30];
	float vMensalidade;
	DATA dataBacharelado;
} ESTUDANTE, *PTR_ESTUDANTE;

int main()
{
	copyright();
	ESTUDANTE stud1;

	printf("Matricula   : ");   fflush(stdin); scanf(" %d", &stud1.nMatricula);
	printf("Nome        : ");   fflush(stdin); scanf(" %30[^\n]", &stud1.nome);
	printf("Mensalidade : ");   fflush(stdin); scanf(" %f", &stud1.vMensalidade);
	printf("Data        : ");   fflush(stdin); scanf(" %d/%d/%d", &stud1.dataBacharelado.dia, &stud1.dataBacharelado.mes, &stud1.dataBacharelado.ano);

	printf("\n");
	printf("Matricula   : %d\n", stud1.nMatricula);
	printf("Nome        : %s\n", stud1.nome);
	printf("Mensalidade : %9.2f\n", stud1.vMensalidade);
	printf("Bacharelado : %02d/%02d/%04d\n", stud1.dataBacharelado.dia, stud1.dataBacharelado.mes, stud1.dataBacharelado.ano);
	return 0;
}

