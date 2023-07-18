#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include <stdint.h>

struct Empty {};
struct Base {
   int a;
};
struct Bit {
   unsigned bit: 1;
};

size_t lenchar(char *pchar) {
   size_t nlen = 0;
   while(*pchar) {
      printf("[%c]\n", *(pchar++));
      nlen++;
   }
   return nlen;
}

size_t lenint(int *pvet) {
   size_t nlen = 0;
   while(*pvet) {
      printf("[%d]\n", *(pvet++));
      nlen++;
   }
   return nlen;
}

size_t MS_strlen(char const *s) {
   size_t nlen = 0;
   while(*s) {
      printf("[%c]\n", *s);
      *(s++);
      nlen++;
   }
   return nlen;

};

void var() {
   char  *v = "VILMAR CATAFESTA";
   char 	 a = 'R';
   int  	 b = 2;
   float  c = 4.5f;
   double d = 3.14;
   unsigned int e = 1;
   static char *strings[] = {
      "this is string one",
      "this is string two",
      "this is string three",
   };
   const int string_no = ( sizeof strings ) / ( sizeof strings[0] );

   printf("size(a) = %ld, location(a) = %p\n", sizeof(a), &a);
   printf("size(b) = %ld, location(b) = %p\n", sizeof(b), &b);
   printf("size(c) = %ld, location(c) = %p\n", sizeof(c), &c);
   printf("size(d) = %ld, location(d) = %p\n", sizeof(d), &d);
   printf("size(e) = %ld, location(e) = %p\n", sizeof(e), &e);
   printf("size(v) = %ld, location(v) = %p = len(v) = %ld\n", sizeof(v), &v, MS_strlen(v));
   printf("size(string_no) = %ld, location(string_no) = %p\n", string_no, &string_no);
}


size_t main() {
   int   vet[50] = {1,2,3,4,5,6,7,8,9,10,-11,0};
   char 	nome[]  = "GATO DEV";
   char 	*pnome  = nome;
   int 	i;
   int   size;
   int   sizeint;

   var();

   return 0;
   size    = lenchar(pnome);
   sizeint = lenint(vet);


   printf("\n lenint: %d\n", sizeint);
   for(i=0; nome[i] != '\0'; i++)
      printf("[%c]\n", nome[i]);

   printf("\n lenchar: %d\n", size);
   for(i=0; i <= size; i++)
      printf("[%c]\n", nome[i]);

   printf("\n len: %d\n", size);
   while(*pnome)
      printf("[%c]\n", *(pnome++));

   printf("\n");

   return 0;
}
