#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>

char *space(int x, char ch=32) {
	char *buff = (char*)malloc(x * sizeof(char *));
	if(buff != 0)
		memset(buff, ch, x);
	buff[x] = '\0';
	return buff;
}

void info() {
	printf("\narray.c");
	printf("\n(c) 2021, Vilmar Catafesta\n");
}

size_t _strlen(char *p) {
	size_t nlen = 0;
	while(*p) {  // aqui é possivel usar o array como ponteiro, em vista do decaimento 
//		*(p++);
		p++;
		nlen++;
	}
	return nlen;
}

void ex2(char *name, char *nome) {
	int i;
	printf("%s, %ld, %ld\n", name, sizeof(name), strlen(name));
	printf("%s, %ld, %ld\n", nome, sizeof(nome), strlen(nome));

	for(i=0;i<strlen(name);i++){
		printf("%c, %ld, %ld\n", name[i], name[i], &name[i]);
	}

	printf("\n");

	for(i=0;i<strlen(nome);i++){
		printf("%c, %ld, %ld\n", nome[i], nome[i], &nome[i]);
	}

	printf("\n");

	i = 0;
	while(name[i]) {
		printf("%c, %ld, %ld\n", name[i], name[i], &name[i]);
		i++;
	}

	printf("\n");

	i = 0;
	while((*nome++)) {
		printf("%c, %ld, %ld\n", *nome, nome[i], &nome[i]);
		i++;
	}
}

void ex1(char *p) {
	size_t nlen = _strlen(p);
	size_t i;

	for (init-statement; condition; inc-expression) {
	
	}

	for(i=0;i<nlen;i++) {
		printf("{%c}{%c} {%ld} {%ld}\n", p[i], p[i], *(p+i), *(p+i));
	}
	printf("\n");

	while(*p) {
//		printf("%c, %ld\n", *p, *(p++));
		printf("%c, %ld\n", *p, *p);
		p++;
	}
}

int main() {
	info();
	int i;
	char p0[] = "VILMAR";
//	char *p1  = "CATAFESTA";
	char *p1  = space(10);

	strcpy(p1, "CATAFESTA");	
	ex1(p0); // decaimento para ponteiro

	// nao é possivel incrementar tipo char, não é ponteiro
	//	while(*p0) {
	//		printf("%c, %ld\n", *p0, *(p0++));
	//	}

	printf("\n");
	while(*p1) { // uso normal do ponteiro
//		printf("%c, %ld\n", *p1, *(p1++));
		printf("%c, %ld\n", *p1, *p1);
		p1++;
	}

	return 0;
}
