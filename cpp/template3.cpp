// template3.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

template <class T>
T imprime(T v){
	std::cout << "tipo(" << typeid(v).name() << ") = " <<	v << '\n';
	return v;
}

template <class T>
void show(T v){
	std::cout << v << '\n';
}

int main(int argc, char **argv) {
   std::cout << RED   << "template3.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';

	imprime(123);
	imprime<int>(65);
	imprime<char>('A');
	imprime<char>(65);
	imprime(4.5);
	imprime("casa");
	imprime<std::string>("casa");
	imprime('a');
	show('a');
	show<int>(10);

   return EXIT_SUCCESS;
}

