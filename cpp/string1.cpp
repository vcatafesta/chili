// string1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <sstream>
#include <string>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"

using namespace std;

int main(int argc, char **argv) {
	std::cout << RED   << "string1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';

	char s[10];
	printf("Ex 1: Entre com um texto (vai dar pau no fim): ");
	scanf("%s", s);
	printf("%s\n", s);

	printf("Ex 2: Entre com um texto (funciona mas o texto é cortado): ");
	scanf("%10s", s);
	printf("%s\n", s);

	std::string v;
	std::cout << "Ex 3: Entre com um texto: ";
	std::cin >> v;
	printf("%s\n", v.c_str());

	v[0] = 'X';
	printf("%s\n", v.c_str());

	v = "Goiaba";
	printf("%s\n", v.c_str());

	v += " Vilmar";
	printf("%s\n", v.c_str());

	v = " Evili " + v + " Soares";
	printf("%s\n", v.c_str());

	v = v.assign(100, '#');
	printf("%s\n", v.c_str());

	std::string copia = v;
	printf("%s\n", copia.c_str());

	std::cout << "Tamanho da string s     : " << strlen(s) << '\n';
	std::cout << "Tamanho da string v     : " << v.size() << '\n';
	std::cout << "Tamanho da string copia : " << copia.size() << '\n';

	std::string s1,s2;
	std::cout << "Ex 4: Entre com 1st string : ";
	std::cin >> s1;
	std::cout << "Ex 4: Entre com 2nd string : ";
	std::cin >> s2;
	
	if (s1 == s2 )
		std::cout << "Iguais\n";
	else
		 std::cout << "Diferentes\n";

	if (s1 < s2 )
		std::cout << "Em ordem alfabetica\n";
	else
		 std::cout << "Fora de ordem\n";

	return EXIT_SUCCESS;
}

