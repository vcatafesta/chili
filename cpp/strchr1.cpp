// strchr1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <cstring>
#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"

using namespace std;

int main(int argc, char **argv) {
	std::cout << RED   << "strchr1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
	std::cout << GREEN << "Hello, World!" << RESET << '\n';

	char str[] = "My name is Ayush";
	char ch = 'A', ch2 = 'z';
	if (strchr(str, ch) != NULL)
		cout << ch << " "
			<< "is present in string" << endl;
	else
		cout << ch << " "
			<< "is not present in string" << endl;
	if (strchr(str, ch2) != NULL)
		cout << ch2 << " "
			<< "is present in string" << endl;
	else
		cout << ch2 << " "
			<< "is not present in string" << endl;

   return EXIT_SUCCESS;
}
