#include <stdio.h>
#include <stdlib.h>
#define	p 	printf
#define	w 	printf

struct _str {
   char *nome;
   int idade;
   int *pt;   
};

int main() {
   struct _str data;
   data.nome  = "VILMAR";
   data.idade = 55;
   data.pt 	  = &data.idade;

   w("value : %s\n", data.nome);
   w("value : %p\n", data.nome);
   w("value : %d\n", sizeof(data.nome));
   w("value : %d\n"
     "end   : %pt\n"
     "value : %d", data.idade, data.pt, *data.pt);

   return(EXIT_SUCCESS);
}
