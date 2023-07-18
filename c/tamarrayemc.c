#include <stdio.h>
#include <stdlib.h>

#define lenvetor(vetor)    (sizeof(vetor)/sizeof(vetor[0]))
#define VECSIZE            19
/*----------------------------------------------------------------------------*/
int lenarraychar(char *a[]) {
   int nlen = 0;
   while(*(a++)) {
      //while(*(a+nlen)){
      //while(a[nlen]){
      nlen++;
   }
   return nlen;
}
/*----------------------------------------------------------------------------*/
int lenarrayint(int p[]) {
   int nlen = 0;

   while(*(p++) || *p == 0 ) {
      //printf("vetor[%d] = %02d\n", nlen, *p);
      nlen++;
   }
   return(nlen);
}
/*----------------------------------------------------------------------------*/
int vec_len(int *arr) {
   int len = 0;
   while(*(arr++))
      len++;
   return len;
}
/*----------------------------------------------------------------------------*/
int main() {
   char *menustatic[VECSIZE] = {"Incluir", "Remover", "Listar", "Imprimir", 0};
   char *menudinamic[]       = {"Incluir", "Remover", "Listar", "Imprimir", 0};
   int vetorstatic[VECSIZE]  = {5,25,7,10,13,33,45,11,60,-1};
   int vetordinamic[]        = {5,25,7,10,13,33,45,11,60,-1};
   int lenstatic             = vec_len(vetorstatic);
   int lendinamic            = vec_len(vetordinamic);
   int i;

   for(i=0; i<VECSIZE; i++)
      printf("vetor[%d] = %02d\n", i, vetorstatic[i]);

   printf("============================\n");
   printf("TAMANHO menustatic   = %d\n",  lenarraychar(menustatic));
   printf("TAMANHO menustatic   = %d\n",  lenvetor(menustatic));
   printf("============================\n");
   printf("TAMANHO vetorstatic  = %d\n",  sizeof(vetorstatic)/sizeof(vetorstatic[0]));
   printf("TAMANHO vetorstatic  = %d\n",  lenvetor(vetorstatic));
   printf("TAMANHO vetorstatic  = %d\n",  lenarrayint(vetorstatic));
   printf("TAMANHO vetorstatic  = %d\n",  lenstatic);
   printf("============================\n");
   printf("TAMANHO vetordinamic = %d\n",  sizeof(vetordinamic)/sizeof(vetordinamic[0]));
   printf("TAMANHO vetordinamic = %d\n",  lenvetor(vetordinamic));
   printf("TAMANHO vetordinamic = %d\n",  lenarrayint(vetordinamic));
   printf("TAMANHO vetordinamic = %d\n",  lendinamic);

   return 0;
}
/*----------------------------------------------------------------------------*/
