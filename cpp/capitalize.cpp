// capitalize.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include <cstring>
#include <cctype>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include "color.h"

using namespace std;

int main(int argc, char **argv) {
	string str;

	std::cout << RED   << "capitalize.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';
	std:cout << "Digite uma string  : ";
	getline(std::cin, str);

	for (auto& c : str) {
		c = toupper(c);
	}

	std::cout << "String capitalizada: " << str << std::endl;

   return EXIT_SUCCESS;
}
