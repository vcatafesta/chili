// vector.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <vector>
#include <array>
#include "color.h"

int main(int argc, char **argv) {
	std::cout << RED << "vector.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET;
	std::vector<int> g1;

	for (int i = 1; i <= 5; i++)
		g1.push_back(i);

	std::cout << "Output of begin and end: ";
	for (auto i = g1.begin(); i != g1.end(); ++i)
		std::cout << *i << " ";

	std::cout << "\nOutput of cbegin and cend: ";
	for (auto i = g1.cbegin(); i != g1.cend(); ++i)
		std::cout << *i << " ";

	std::cout << "\nOutput of rbegin and rend: ";
	for (auto ir = g1.rbegin(); ir != g1.rend(); ++ir)
		std::cout << *ir << " ";

	std::cout << "\nOutput of crbegin and crend : ";
	for (auto ir = g1.crbegin(); ir != g1.crend(); ++ir)
		std::cout << *ir << " ";

   return EXIT_SUCCESS;
}
