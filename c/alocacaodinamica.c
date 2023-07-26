#include "funcoes.c"

char *String(int tam, char ch){
 	char *ptr = (char*)malloc(tam * sizeof(char *)+1);
   if(ptr != 0){
		memset(ptr, ch, tam);
   	*(ptr+tam+1) = '\0';
		return ptr;
	}
	return NULL;
}

int main(){
	int tam = 50;
	char *ptr = String(tam, 32);
	p("%d\n", strlen(ptr));
	char vnome[50];
	p("%d\n", sizeof(vnome));
	printf("Entre com o nome: "); fflush(stdin); fgets(vnome, tam, stdin);
	printf("Entre com o nome: "); fflush(stdin); fgets(ptr,  tam, stdin);
	printf("%s\n", vnome);
	printf("%s\n", ptr);
	display(vnome);
	return 0;
}
