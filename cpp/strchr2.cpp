// strchr1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
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

	char string[]={"/home/test/sample"};
	int len;

	//position of last char
	char* pos;

	// save length of string
	len = strlen(string);

	// Find the last character with
	pos = strrchr(string,'/') ;
	printf("%s\n",string);

	// replace last occurrence of / with NULL character.
	*pos='\0';
	printf("%s\n",string);

   return EXIT_SUCCESS;
}
