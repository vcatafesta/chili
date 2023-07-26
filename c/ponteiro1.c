#include "protype.h"

int main()
{
  int i;
  int *v;
  v = (int*)malloc(sizeof(int)*10);  // 'v' é um ponteiro para uma área que
                                     // tem 10 inteiros.
                                     // 'v' funciona exatamente como um vetor
  v[0] = 10;
  v[1] = 11;
  v[2] = 12;
  // continua...
  v[9] = 19;

  for(i = 0; i < 10; i++)
    printf("v[%d]: %d\n", i, v[i]);

  printf("Endereço de 'v': %p\n", v);  // imprime o endereço da área alocada para 'v'
  free(v);
}
