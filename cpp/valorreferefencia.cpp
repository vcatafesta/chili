// valorreferefencia.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include "color.h"

using namespace std;

void print_by_valor(int num) {
	std::cout << "Idade by_valor :" << num << '\n';
	num = 80;
	std::cout << "Idade by_valor :" << num << '\n';
	std::cout << "Endereço by_valor :" << &num << '\n';
	return;
}

void print_by_ref(int *num) {
	std::cout << "Idade by_ref :"    << num << '\n'; // irá imprimir o endereço de memória
	*num = 80;
	std::cout << "Idade by_ref:"     << *num << '\n';
	std::cout << "Endereço by_ref :" << num << '\n'; // irá imprimir o endereço de memória
	return;
}

int main(int argc, char **argv) {
   std::cout << RED   << "valorreferefencia.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
   std::cout << GREEN << "Hello, World!" << RESET << '\n';

	auto idade = 56;
	print_by_valor(idade);
	std::cout << "Em main() idade by_valor :" << idade << '\n';
	std::cout << std::endl;
	print_by_ref(&idade);
	std::cout << "Em main() idade by_ref   :" << idade << '\n';

   return EXIT_SUCCESS;
}

