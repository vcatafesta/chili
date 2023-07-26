#include <stdio.h>
#include <stdlib.h>

int soma10(int x) {
   return(x += 10);
}

void soma10p(int *x) {
   *x += 10;
   return;
}

int main(int argc, char *argv[]) {
   int numero;
   printf("Digite um numero     : ");
   scanf("%d", &numero);

   printf("O numero digitado foi: %d \n", numero);
   soma10p(&numero);
   printf("Agora o numero vale  : %d \n", soma10(numero));
   return 0;

}
