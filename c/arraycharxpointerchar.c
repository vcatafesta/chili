#include <stdio.h>
#include <stdlib.h>

typedef struct Person {
    char name[256];
    char *apelido;
} person;

void insere_person_name(person *p){
	printf("insira um nome: ");
   scanf(" %s", p->name);
}

void insere_person_apelido(person *p){
	p->apelido = (char *)malloc(sizeof(char*));
	printf("insira um apelido: ");
   scanf(" %s", p->apelido);
}

void string_person(person *p){
    printf("person{nome:%s, apelido:%s}\n", p->name, p->apelido);
}

int main()
{
    person p;
    //person p = {"Fulano", "Lano"};

    insere_person_name(&p);
    insere_person_apelido(&p);

    string_person(&p);

    return 0;
}
