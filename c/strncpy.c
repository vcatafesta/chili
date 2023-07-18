#include <stdio.h>
#include <string.h>

int main () {
   char src[40];
   char dest[12];
  
   memset(dest, '\0', sizeof(dest));
   strcpy(src, "VILMAR CATAFESTA, BILLY GATO");
   strncpy(dest, src, 11);

   printf("Final copied string : %s \n%d chars\n", dest, strlen(dest));
   
   return(0);
}
