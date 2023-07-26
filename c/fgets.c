#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	char s1[20];
	char s2[20];
	char buff[20]; //buffer de leituras
	int escolha = 1;

	printf("*****************************\n");
	printf("*Menu de opções para strings*\n");
	printf("*****************************\n\n");
	printf("Primeiro informe seu nome por favor: ");
	fgets(s1,20,stdin);
	s1[strlen(s1)-1] = '\0'; //remover o \n que ficou da leitura com fgets

	do {
	    printf("\n(1) Quer saber o tamanho de seu nome?\n");
	    printf("(2) Que tal comparar seu nome com outro nome?\n");
	    printf("(3) Quer unir seu nome com outro nome?\n");
	    printf("(4) O que acha de seu nome invertido?\n");
	    printf("(5) Quer saber quantas vezes a mesma letra aparece em seu nome?\n");
	    fgets(buff, 20, stdin); //agora fgets
	    sscanf(buff, "%d", &escolha); //leitura do numero com sscanf
	    system("clear");

	    switch(escolha) {
	    case 1:
	        printf("A quantidade de caracters de seu nome é: %d", (int)strlen(s1));
	        break;
	    case 2:
	        printf("Digite um novo nome para comparar: ");
	        fgets(s2, 20, stdin);
	        s2[strlen(s2)-1] = '\0'; //remover o \n também
	        break;
	    default:
	        printf("Opção inválida");
	    }

	} while(escolha);
}
