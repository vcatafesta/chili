// pointer.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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
using std::cout;
using std::endl;
using std::string;
int valor = 12;  // 'valor' global

template <
	typename T, 
	typename X
>
void p(T var, X var1) {
	std::cout << var << var1 << '\n';
	return ;
}

template<typename T>
T soma1(T a, T b) {
	T res;
	res = a + b;
	return res;
}

template<typename T1, typename T2>
T2 soma2 (T1 a, T2 b) {
	T2 res;
	res = a + b;
	return res;
}

void qout() {
	std::cout << '\n';
}

void Increment_by_value(int a) {
	a = a + 1;
	std::cout << "Address of variable a in increment = " << &a << ", value = " << a << '\n';
}

void Increment_by_reference(int *a) {
	*a = *(a) + 1;
	std::cout << "Address of variable a in increment = " << &a << ", value = " << *a << '\n';
}

void replicate(char ch, size_t tam) {
	std::string replicate;
	replicate.assign(tam, ch);
	std::cout << replicate << '\n';
}

int SumOfElements(int *C) {
	int i;
	int sum = 0;
	int size = sizeof(C)/sizeof(C[0]);

	p("Sizeof C    : ", sizeof(C));
	p("Sizeof C[0] : ", sizeof(C[0]));
	
	std::cout << "SOE - Size of C = " << sizeof(C) << " size of C[0] = " << sizeof(C[0]) <<'\n';
	for(i = 0; i < size; i++) {
		sum += C[i];
	}
	return sum;
}

int main(int argc, char **argv) {
   std::cout << RED   << "pointer.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';

	replicate('#', 100);
	int a;
	int *p;
	p = &a;
	a = 10;
	cout << p << '\n';
	cout << *p << '\n';
	cout << &a << '\n';
	*p = 12; // dereferencing
	replicate('#', 100);
	cout << p << '\n';
	cout << *p << '\n';
	cout << &a << '\n';

	int x    = 5;
	int *xp  = &x;
	*xp      = 6;
	int **q  = &xp;
	int ***r = &q;
	replicate('#', 100);
	cout << "      *xp = " << *xp << '\n';
	cout << "       *q = " << *q << '\n';
	cout << "    *(*q) = " << *(*q) << '\n';
	cout << "    *(*r) = " << *(*r) << '\n';
	cout << "*(*(*r))) = " << *(*(*r)) << '\n';

	replicate('#', 100);
	a = 10;
	Increment_by_value(a);
	std::cout << "Address of variable a in main      = " << &a << ", value = " << a << '\n';
	Increment_by_reference(&a);
	std::cout << "Address of variable a in main      = " << &a << ", value = " << a << '\n';

	replicate('#', 100);
	int A[5] = {2,4,5,8,1};
	std::cout << "Sizeof of variable int A in main   = " << sizeof(A) << '\n';
	std::cout << "Elements of variable A in main     = " << sizeof(A)/sizeof(A[0]) << '\n';
	std::cout << "Address of variable A in main      = " << &A    << ", value = " << A << '\n';
	std::cout << "Address of variable A[0] in main   = " << &A[0] << ", value = " << A[0] << '\n';
	std::cout << "Address of variable A[1] in main   = " << &A[1] << ", value = " << A[1] << '\n';
	std::cout << "Address of variable A[2] in main   = " << &A[2] << ", value = " << A[2] << '\n';
	std::cout << "Address of variable A[3] in main   = " << &A[3] << ", value = " << A[3] << '\n';
	std::cout << "Address of variable A[4] in main   = " << &A[4] << ", value = " << A[4] << '\n';

	replicate('#', 100);
	std::cout << "Address of variable *A in main      = " << &A    << ", value = " << *A << '\n';
	std::cout << "Address of variable *(A+1) in main  = " << &A    << ", value = " << *(A+1) << '\n';
	std::cout << "Address of variable *(A+2) in main  = " << &A    << ", value = " << *(A+2) << '\n';
	std::cout << "Address of variable *(A+3) in main  = " << &A    << ", value = " << *(A+3) << '\n';
	std::cout << "Address of variable *(A+4) in main  = " << &A    << ", value = " << *(A+4) << '\n';

	replicate('#', 100);
	char B[5] = {'a','b','c','d','e'};
	std::cout << "Sizeof of variable char B in main  = " << sizeof(B) << '\n';
	std::cout << "Elements of variable B in main     = " << sizeof(B)/sizeof(B[0]) << '\n';
	std::cout << "Address of variable B in main      = " << &B    << ", value = " << B << '\n';
	std::cout << "Address of variable B[0] in main   = " << &B[0] << ", value = " << B[0] << '\n';
	std::cout << "Address of variable B[1] in main   = " << &B[1] << ", value = " << B[1] << '\n';
	std::cout << "Address of variable B[2] in main   = " << &B[2] << ", value = " << B[2] << '\n';
	std::cout << "Address of variable B[3] in main   = " << &B[3] << ", value = " << B[3] << '\n';
	std::cout << "Address of variable B[4] in main   = " << &B[4] << ", value = " << B[4] << '\n';

	replicate('#', 100);
	int valor = 90;   // 'valor' local
	cout << "O valor local definido eh...: " <<   valor << endl;
	cout << "O valor global definido eh..: " << ::valor << endl;  // :: operador de resolução de escopo
	cout << endl;

	cout << "Somando dois inteiros...................: " << soma1(valor, ::valor) << endl;
	cout << "Agora, somando dois floats..............: " << soma1(3.4, 7.8) << endl;
	cout << "Soma inteiro com float, retornando float: " << soma2(soma1(valor, ::valor), 5.6) << endl;
	cout << endl;

	replicate('#', 100);
	int C[5] = {2,4,5,8,1};
	int total = SumOfElements(C);
	std::cout << "MAIN - Size of C = " << sizeof(B) << " size of C[0] = " << sizeof(C[0]) <<'\n';
	std::cout << "MAIN - Total of C = " << total <<'\n';

	
   std::cout << RED   << "pointer.cpp - terminated!\n" << RESET;
   return EXIT_SUCCESS;
}

