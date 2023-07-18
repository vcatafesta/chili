// expression.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include "color.h"

int main(int argc, char **argv) {
   printf("%sexpression.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	std::string answer = "Vilmar";
	std::string guess;
	std::cout << "Gues my name! : ";
	std::cin  >> guess;

	if (guess == answer) {
		std::cout << "Você acertou!";
	}

   return EXIT_SUCCESS;
}

