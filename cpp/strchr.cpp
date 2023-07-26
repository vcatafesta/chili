// strchr.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <cstring>
#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"

using namespace std;

int main(int argc, char **argv) {
   std::cout << RED   << "strchr.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
   std::cout << GREEN << "Hello, World!" << RESET << '\n';

	char str[] = "My name is Ayush";
	char* ch = strchr(str, 'a');
	cout << ch - str + 1;

   return EXIT_SUCCESS;
}
