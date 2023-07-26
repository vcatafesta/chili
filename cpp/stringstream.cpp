// stringstream.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"

using namespace std;

int countWords(string str)
{
	int count = 0;
	stringstream s(str);
	string word;

	while (s >> word)
		count++;
	return count;
}

int main(int argc, char **argv) {
	std::cout << RED   << "stringstream.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';
	string s = "chililinux vilmar chilios chili " "contribution placements ";
	cout << GREEN << "Number of words are: " << RED << countWords(s);
	return EXIT_SUCCESS;
}

