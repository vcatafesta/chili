#include <stdio.h>

int LenArray(char *a[])
{
   int nlen = 0;
	//while(*(a+nlen)){
   while( a[nlen] ){
     nlen++;
   }
   return nlen;
}

void main(void)
{
   char *menu[] = {"Incluir", "Remover", "Listar", "Imprimir", 0};
	printf("Tamanho do Array: %d\n", LenArray(menu));
}
