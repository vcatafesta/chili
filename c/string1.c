#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* space(int x, char ch) {
   char* buff = (char*)malloc(x * sizeof(char *));
   if(buff != 0)
      memset(buff, ch, x);
   buff[x] = '\0';
   return buff;
}

struct _tharic {
   char *nome;
   char *ende;
   char *bair;
   char *cida;
   char *esta;
   char *cep;
};
typedef struct _tharic THARIC;

THARIC alocaporparametro(THARIC T) {
   T.nome = space(40,32);
   T.ende = space(40,32);
   T.cida = space(40,32);
   T.esta = space(40,32);
   T.cep  = space(40,32);
   return T;
}

void alocaporreferencia(THARIC *T) {
   T->nome = space(40,32);
   T->ende = space(40,32);
   T->cida = space(40,32);
   T->esta = space(40,32);
   T->cep  = space(40,32);
}

void imprime(THARIC T) {
   printf("%s\n", T.nome);
   printf("%s\n", T.ende);
   printf("%s\n", T.cida);
   printf("%s\n", T.esta);
   printf("%s\n", T.cep);
}

void preenche(THARIC T) {
   strcpy(T.nome, "THARIC VINICIUS");
   strcpy(T.ende, "Av Castelo Branco, 693");
   strcpy(T.cida, "PIMENTA BUENO");
   strcpy(T.esta, "RO");
   strcpy(T.cep,  "76970-000");
}

int main() {
   THARIC T;
   //T = alocaporparametro(T);
   alocaporreferencia(&T);
   if(T.nome) {
      preenche(T);
      imprime(T);
   } else {
      printf("Erro de memoria");
      return(EXIT_FAILURE);

   }
   return(EXIT_SUCCESS);
}
