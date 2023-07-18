#include <stdio.h>
#include <stdlib.h>
#define LENVETOR(vetor)		(sizeof(vetor)/sizeof(vetor[0]))

struct self {
   int p;
   struct self *ptr;
};

struct code {
   int i;
   char c;
   struct code *ptr;
};

struct point {
   int x;
   int y;
};

// diferente de arrays, variaveis de struturas não sao ponteiros
void printpointex1(struct point p) {
   printf("printpointex1: %d %d\n", p.x, p.y);
}

// quando passado por referencia, recebe via ponteiro
void printpointex2(struct point *p) {
   printf("printpointex2: %d %d\n", p->x, p->y);
}

void printpointarray(struct point arr[], int nlen) {
   int i;
   for(i=0; i<nlen; i++)
      printf("printpointarray: %d %d\n", arr[i].x, arr[i].y);
}

struct point edit(struct point p) {
   (p.x)++;
   p.y = p.y +5;
   return p;
}

struct point *pointadd(int a, int b) {
   struct point *ptr = (struct point*)malloc(sizeof(struct point));
   ptr->x = a;
   ptr->y = b +5;
   return ptr;
}

struct charset {
   char s;
   int i;
};

// quando passado por referencia, recebe via ponteiro
void keyValue(char *s, int *i) {
   scanf("%c %d", s, i);
}

struct student {
   char name[50];
   int age;
   int roll_no;
   float marks;
};

void print(char name[], int age, int roll, float marks) {
   printf("void print : %s %d %d %.2f\n", name, age, roll, marks);
}

int *fun() {
   int num = 10;
   return &num;
}

int main() {
   int n     = 10;
   void *ptr = &n;
   int *ptr1 = NULL;
   int *ptr2 = (int*)malloc(sizeof(int));
   int *ptr3 = NULL;
   struct charset cs;
   struct student s1 = {"VILMAR CATAFESTA",55,50,72.5};
   struct point p1   = {23,45};
   struct point p2   = {56,90};
   struct point *pt1;
   struct point *pt2;
   struct point arr[] = {{1,2}, {3,4}, {5,6}};
   struct code var1;
   struct code var2;

   var1.i = 65;
   var1.c = 'A';
   var1.ptr = NULL;

   var2.i = 66;
   var2.c = 'B';
   var2.ptr = NULL;

   var1.ptr = &var2;
   printf("Self referential structure : %d %c\n", var1.ptr->i, var1.ptr->c);

   printpointarray(arr, LENVETOR(arr));
   pt1 = pointadd(2,3);
   pt2 = pointadd(6,9);
   printpointex2(pt1);
   printpointex2(pt2);
   free(pt1);
   free(pt2);

   printpointex1(p1);
   printpointex1(p2);
   printpointex2(&p1);
   printpointex2(&p2);
   p1 = edit(p1);
   p2 = edit(p2);
   printpointex1(p1);
   printpointex1(p2);

   print(s1.name, s1.age, s1.roll_no, s1.marks);

   keyValue(&cs.s, &cs.i);  // byreference or address
   printf("%c %d\n", cs.s, cs.i);

   printf("*ptr3 : %d\n", ptr3);
   ptr3 = fun();
   printf("*ptr3 : %d\n", ptr3);

   printf("%d\n", *(int*)ptr);
   printf("%d\n", ptr1);
   printf("%ld\n", sizeof(NULL));
   printf("%ld\n", sizeof(ptr1));

   printf("%d\n", sizeof(ptr2));
   printf("%d\n", *ptr2);

   return 0;
}
