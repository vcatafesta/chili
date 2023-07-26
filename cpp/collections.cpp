// collections.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <vector>
#include <array>
#include "color.h"


int main(int argc, char **argv) {
   printf("%scollections.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	int data[] = {1, 2, 3, 4, 5, 6};

	for (int n : data)
		std::cout << n << '\t';


   return EXIT_SUCCESS;
}
