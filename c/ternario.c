#include "protype.h"

typedef struct client_t client_t, *pno, PERSON;
struct client_t {
   char nome[50];
   char cida[50];
   char esta[3];
   char password[50];
   int idade;
   pid_t pid;
   pno next;
   pno (*AddClient)(client_t *);
};

pno client_t_AddClient(client_t *self) {
   strcpy(self->nome, "VILMAR CATAFESTA");
   strcpy(self->cida, "PIMENTA BUENO");
   strcpy(self->esta, "RO");
   self->idade      =  55;
}

int main() {
   int x = 0;
	char *cSituacao;
   PERSON client;
   client.AddClient = client_t_AddClient; // probably really done in some init fn
   client.AddClient(&client);

   x         = (x            == 0 ) ? 10 : 20;
   cSituacao = (client.idade == 55) ? "Vivido" : "Idoso";
   printf("Nome     : %s\n", client.nome);
   printf("Cidade   : %s\n", client.cida);
   printf("Estado   : %s\n", client.esta);
   printf("Idade    : %d\n", client.idade);
   printf("Situacao : %s, {length : %d}\n", cSituacao,strlen(cSituacao));
   printf("Ternario : %d\n", x);

   return 0;
}

