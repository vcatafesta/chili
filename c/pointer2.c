#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include <stdint.h>

typedef unsigned int NUMERIC;

void *_calloc(size_t nmemb, size_t size) {
   size_t len = size * nmemb;
   void *p = malloc(len);
   memset(p, 32, len);
   return p;
}

void *space(size_t size) {
//   char *buffer = (char*)malloc(size * sizeof(char*));
   char *buffer = (char*)calloc(size, sizeof(char*));
   if(buffer) {
      //memset(buffer, 32, size);
      return buffer;
   }
   return NULL;
}

void *string(const char *psz) {
   size_t size = strlen(psz);
   char *buffer = (char*)calloc(size, sizeof(char*));
   if(buffer) {
      strcat(buffer, psz);
      return buffer;
   }
   return NULL;
}

NUMERIC lenchar(char *pchar) {
   NUMERIC nlen = 0;
   while(*pchar) {
      printf("[%d[%c]\n", nlen, *(pchar++));
      nlen++;
   }
   return nlen;
}

NUMERIC lenint(int *pvet) {
   size_t nlen = 0;
   while(*pvet) {
      printf("[%d]\n", *(pvet++));
      nlen++;
   }
   return nlen;
}

size_t _strlen(char const *s) {
   size_t nlen = 0;
   while(*s) {
      //printf("[%d][%c]\n", nlen, *s);
      *(s++);
      nlen++;
   }
   return nlen;

}

NUMERIC main() {
   char v[] = "VILMAR";
   char *e  = "EVILI";
   char *f  = string("BILLY BOY");
   int  a   = 2;
   int  b   = 4;
   int *pa;
   int *pb;
   void *bozo = (void*)calloc(0, sizeof(void*));

   printf("f = %s, len(f) = %d\n", bozo, strlen(bozo));
   printf("f = %s, len(f) = %d\n", f, _strlen(f));
   printf("v = %s, len(v) = %d\n", e, _strlen(v));
   printf("e = %s, len(e) = %d\n", e, _strlen(e));

   pa  = &a;
   *pa = 5;
   printf("a = %d, b = %d\n", a, b);

   pb  = pa;
   *pb = *pb +1;
   printf("a = %d, b = %d\n", a, b);

   return 0;
}
