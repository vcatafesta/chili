// array_stl.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <vector>
#include <array>
#include "color.h"

void print_vector(std::vector<int> &data)
{
	for(int i = 0; i < data.size(); i++) {
		std::cout << data[i] << '\t';
	}
	std::cout << '\n';
}

void print_array(std::array<int,20> &data)
{
	for(int i = 0; i < data.size(); i++) {
		std::cout << data[i] << '\t';
	}
	std::cout << '\n';
}

int main(int argc, char **argv) {
   printf("%sarray_stl.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	std::array<int, 20> data;

	for (int i = 1; i < data.size(); i++)
		data[i] = i;


	print_array(data);
   return EXIT_SUCCESS;
}
