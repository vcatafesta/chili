#include <stdio.h>

int main() {
   int 		account;
   char 		name[30];
   double	balance;
   FILE 		*cfPtr;

   if (( cfPtr = fopen("clients.dat","w")) == NULL ) {
      printf("File could not be opened.\n");
   } else {
      printf("Enter the account, name and the balance:\n");
      printf("Enter EOF to end input.\n");
      printf("? ");
      scanf("%d%s%lf",&account, name, &balance);
      while(!feof(stdin)) {
         fprintf(cfPtr,"%d %s %.2f\n",account, name, balance);
         printf("? ");
         scanf("%d%s%lf",&account,name,&balance);
      }
      fclose(cfPtr);
   }
   return 0;
}
