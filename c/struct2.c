#include "funcoes.c"

struct Tendereco{
	char rua[40];
	int numero;
	char bairro[40];
	char cidade[40];
	char estado[2];
	int cep;
};

struct Tnascimento{
	int dia;
	int mes;
	int ano;
};

typedef struct {
	char nome[40];
	int idade;
	int telefone;
	struct Tendereco endereco;
	struct Tnascimento nascimento;
}TCLIENTE, *PTCLIENTE;

int main()
{
	TCLIENTE cliente[2];
	int i;
	printf("%s\n", replicate("-", 80));
	printf("%s\n", padc("CADASTRO DE CLIENTE", 80, 32));
	printf("%s\n", replicate("-", 80));

	for(i=0;i<2;i++)
	{
		GETSTR("Nome   : ", cliente[i].nome);
		GETSTR("Cidade : ", cliente[i].endereco.cidade);
		GETNUM("Idade  : ", &cliente[i].idade);

		printf("\n%d %s", i, cliente[i].nome);
		printf("\n%d %s", i, cliente[i].endereco.cidade);
		printf("\n%d %d", i, cliente[i].idade);
		printf("\n\n");
	}
	return 0;
}
