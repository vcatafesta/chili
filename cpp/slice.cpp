// slice.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <cctype>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include "color.h"
#include <iostream> 	// std::cout
#include <cstddef> 	// std::size_t
#include <valarray> 	// std::valarray, std::slice

using namespace std;

int main(int argc, char **argv) {
   std::cout << RED   << "slice.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';

	std::valarray<int> sample(12);
	// initialising valarray
	for (int i = 0; i < 13; ++i)
		sample[i] = i;
  
	// using slice from start 1 and size 3 and stride 4
	std::valarray<int> bar = sample[std::slice(2, 3, 4)];
  
	// display slice result
	std::cout << "slice(2, 3, 4):";
	for (std::size_t n = 0; n < bar.size(); n++)
		std::cout << ' ' << bar[n];
	std::cout << '\n';

   return EXIT_SUCCESS;
}

