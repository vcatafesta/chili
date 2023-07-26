// getline.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include "color.h"

int main(int argc, char **argv) {
   printf("%sgetline.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	std::string greeting;
	getline(std::cin, greeting);
	greeting += "Hello, ";
	std::cout << greeting << '\n';
	std::cout << "Length : " << greeting.length() << '\n';
	std::cout << "Size   : " << greeting.size() << '\n';
   return EXIT_SUCCESS;
}

