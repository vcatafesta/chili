// io.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <fstream>
#include <vector>
#include <array>
#include "color.h"

int main(int argc, char **argv) {
   printf("%sio.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	std::cout << CYAN << "write" << RESET << '\n';
	std::ofstream fileOUT ("hello.txt");
	std::vector<std::string> names;

	names.push_back("Vilmar");
	names.push_back("Evili");
	names.push_back("Tharic");
	fileOUT << "hey" << '\n';
	for (std::string name: names) {
		fileOUT << name << '\n';
	}
	fileOUT.close();

	std::cout << RED << "read 1" << RESET << '\n';
	std::ifstream fileIN ("hello.txt");
	std::string input;
	while (fileIN >> input)  {
		names.push_back(input);
	}

	for (std::string name: names) {
		std::cout << '\t' << name << '\n';
	}
	fileIN.close();

	std::cout << YELLOW "read 2" << RESET << '\n';
	std::ifstream fileLINE ("hello.txt");

	if (fileLINE.is_open()) {
		std::cout << "\tIt worked\n";
	}
	std::string line;
	getline(fileLINE, line);
	std::cout << '\t' << line << '\n';
	fileLINE.close();

   return EXIT_SUCCESS;
}
