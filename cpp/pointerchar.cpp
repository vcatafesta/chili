// pointerchar.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include <cctype>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include "color.h"

using namespace std;

void qout() {
}

template <typename T, typename... Args>
void qout(T arg, Args... args) {
	std::cout << arg << "";
	qout(args...);
}

template <class T, typename X>
std::string replicate(T ch, X tam) {
	std::string replicate;
	replicate.assign(tam, ch);
	return replicate;
}

size_t my_strlen(char *c) {
	size_t i = 0;
	while(*c != NULL) {
		c++;
		i++;
	}
	return i;
}

size_t LenArray(char **a) {
	size_t i = 0;
	//while(*(a+i)){
	while( a[i] ){
		i++;
	}
	return i;
}

void print1(char *c) {
	int i = 0;
	while(c[i] != NULL) {
		qout("char = ", c[i], '\n');
		i++;
	}
	qout('\n');
}

void print2(char *c) {
	int i = 0;
	while(*c != NULL) {
		qout("char = ", *c, '\n');
		c++;
	}
	qout('\n');
}

void print3(char *c) {
	int i = 0;
	while(*(c+i) != NULL) {
		qout("char = ", c[i], '\n');
		i++;
	}
	qout('\n');
}

int main(int argc, char **argv) {
	std::cout << RED   << "pointerchar.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';

	char a[4];
	a[0] = 'J';
	a[1] = 'O';
	a[2] = 'H';
	a[3] = 'N';
	qout(replicate('#', 100),'\n');
	qout("char a = ", a, ", Length = ", strlen(a), ", Size in bytes = ", sizeof(a), '\n');

	char b[5];
	b[0] = 'J';
	b[1] = 'O';
	b[2] = 'H';
	b[3] = 'N';
	b[4] = '\0';
	qout("char b = ", b, ", Length = ", strlen(b), ", Size in bytes = ", sizeof(b), '\n');

	char c[20];
	c[0] = 'J';
	c[1] = 'O';
	c[2] = 'H';
	c[3] = 'N';
	c[4] = '\0';
	qout("char c = ", c, ", Length = ", strlen(c), ", Size in bytes = ", sizeof(c), '\n');

	char d[20] = "JOHN";
	qout("char d = ", d, ", Length = ", strlen(d), ", Size in bytes = ", sizeof(d), '\n');

	char e[] = "JOHN";
	qout("char e = ", e, ", Length = ", strlen(e), ", Size in bytes = ", sizeof(e), '\n');

	char c1[6] = "Hello";
	char *c2;
	c2 = c1;
	qout("char c1 = ", c1, '\n');
	qout("char c2 = ", c2, '\n');
	c2[0] = 'A';
	qout("char c1 = ", c1, '\n');
	qout("char c2 = ", c2, '\n');
	qout("char c1 = ", *(c1), '\n');
	qout("char c1 = ", *(c1+1), '\n');
	qout("char c1 = ", *(c1+2), '\n');
	qout("char c1 = ", *(c1+3), '\n');
	qout("char c1 = ", *(c1+4), '\n');
	qout("char c1 = ", *(c1+5), '\n');
	qout("char c2 = ", *c2++, '\n');
	qout("char c2 = ", *c2++, '\n');
	qout("char c2 = ", *c2++, '\n');
	qout("char c2 = ", *c2++, '\n');
	qout("char c2 = ", *c2++, '\n');

	print1(c1);
	print2(c1);
	print3(c1);
	qout("char c1 = ", c1, ", Length = ", strlen(c1), ", Size in bytes = ", sizeof(c1), '\n');
	qout("char c1 = ", c1, ", Length = ", my_strlen(c1), ", Size in bytes = ", sizeof(c1), '\n');

	char *menu[] = {"Incluir", "Remover", "Listar", "Imprimir", 0};
	char *menu1[] = {"Incluir", "Remover", 0};
	printf("Tamanho do Array: %d\n", LenArray(menu));
	printf("Tamanho do Array: %d\n", LenArray(menu1));
	
	qout(replicate('#', 100),'\n');
	std::cout << RED << "pointerchar.cpp - terminated!\n" << RESET;
	return EXIT_SUCCESS;
}

