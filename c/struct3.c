#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define lenvetor(vetor) (sizeof(vetor)/sizeof(vetor[0]))

char *space(size_t size);
char *string(char *psz);
size_t _ms_strlen(char *psz);

// Typed of Linked List
// 1 - Single linked list: Navigation is forward only
// 2 - Doubly linked list: Forward and backword navigation is possible
// 3 - Circular linked list: Last element is linked to the first element

struct node { // Single linked list: Navigation is forward only
   char *data;
   size_t a;
   size_t b;
   struct node *next; // contains the address of the next node of the list
};

int *minMax2(int arr[], int len, int *min, int *max) {
   *min = *max = arr[0];
   int i;
   for(i=1; i<len; i++) {
      if(arr[i] > *max)
         *max = arr[i];
      if(arr[i] < *min)
         *min = arr[i];
   }
   int array[] = {min, max};
   return array;
}

int *minMax(int arr[], int len) {
   int min, max, i;
   min = max = arr[0];

   for(i=1; i<len; i++) {
      if(arr[i] > max)
         max = arr[i];
      if(arr[i] < min)
         min = arr[i];
   }
   int array[] = {min, max};
   return array;
}

void displayint(int vet[]) {
   printf("vet[]     : %ld bytes\n",  sizeof(vet));
   printf("vet[0]    : %ld bytes\n",  sizeof(vet[0]));
   printf("vet[]elem : %ld elem\n",   sizeof(vet)/sizeof(vet[0]));
}

void displaychar(char vet[]) {
   printf("vet[]     : %ld bytes\n",  sizeof(vet));
   printf("vet[0]    : %ld bytes\n",  sizeof(vet[0]));
   printf("vet[]elem : %ld elem\n",   sizeof(vet)/sizeof(vet[0]));
}

int main() {
   struct node *head = (struct node *)space(sizeof(struct node));
   head->data   		= string("");
   int  vet_a[] 		= {1,2,3,4,5,6,7,8,9,10};
   char vet_b[] 		= {65,66,67,68,69,70,71,72,73,74};
   char vet_v[] 		= {'V','I','L','M','A','R'};
   char *pvet_v 		= &vet_v;
   int x             = 0, *ptr = &x;
   int *ptrerro;
   char format[] = "%s\n";
   int a[] = {23,45,6,98};
   int min;
   int max;

   int *array = minMax(a, lenvetor(a), &min, &max);
   printf("Min : %d : Max : %d\n",  array[0], array[1]);

   minMax(vet_a, lenvetor(vet_a), &min, &max);
   printf("Min : %d : Max : %d\n",  min, max);

   printf(format, format);
   printf("x           : %ld\n",  *ptr);

   printf("vet_a[]     : %ld bytes\n",  sizeof(vet_a));
   printf("vet_a[0]    : %ld bytes\n",  sizeof(vet_a[0]));
   printf("vet_a[]elem : %ld elem\n",   sizeof(vet_a)/sizeof(vet_a[0]));

   printf("vet_b[]     : %ld bytes\n",  sizeof(vet_b));
   printf("vet_b[0]    : %ld bytes\n",  sizeof(vet_b[0]));
   printf("vet_b[]elem : %ld elem\n",   sizeof(vet_b)/sizeof(vet_b[0]));

   printf("vet_v[]     : %ld bytes\n",  sizeof(vet_v));
   printf("vet_v[0]    : %ld bytes\n",  sizeof(vet_v[0]));
   printf("vet_v[]elem : %ld elem\n",   sizeof(vet_v)/sizeof(vet_v[0]));
   while(*pvet_v) {
      printf("vet_v[%c] : %ld elem\n",   *(pvet_v++), *ptr);
      x++;
   }

   printf("string  : %s\n",  head->data);
   printf("tamanho : %ld bytes\n", _ms_strlen(head->data));
   printf("tamanho : %ld bytes\n", strlen(head->data));

   return 0;
}
char *space(size_t size) {
   char *buf = (char*)calloc(size, sizeof(char*));

   if(buf) {
      //memset(buffer, 32, size);
      return buf;
   }
   fprintf(stderr, "MEM:memory allocation error!\n");
   exit(1);
}

size_t _ms_strlen(char *psz) {
   size_t nlen = 0;

   while(*(psz++)) {
      nlen++;
   }
   return nlen;
}

char *string(char *psz) {
   char *buffer = space(_ms_strlen(psz));

   if(buffer) {
      strcpy(buffer, psz);
      return buffer;
   }
   return NULL;
}
