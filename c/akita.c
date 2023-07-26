#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

struct Person {
   char nome[10];
   uint8_t age;
   uint8_t height;
   void(*show)(struct Person *);
};

void person_print(struct Person *person) {
   printf("nome: %s age: %d height: %d\n", person->nome, person->age, person->height);
}

void f2(char hello[]) {
   printf("from f2: %d\n", &hello);
}

void f1(char hello[]) {
   printf("from f1: %d\n", &hello);
   f2(hello);
}

int main() {
   struct Person p;
   char hello[] = "Hello World";
   strcpy(p.nome,"VILMAR");
   p.age    = 55;
   p.height = 93;
   person_print(&p);
   printf("sizeof Person : %lu\n", sizeof(struct Person));
   printf("from main: %d\n", &hello);
   f1(hello);
}
