// heap.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"

using namespace std;

int main(int argc, char **argv) {
   printf("%sheap.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	vector<int> v = {8, 6, 2, 1, 5, 10};

	make_heap(v.begin(), v.end());

	cout << "heap: ";
	for (const auto &i : v) {
	cout << i << ' ';
	}

	sort_heap(v.begin(), v.end());

	std::cout <<endl<< "now sorted: ";
	for (const auto &i : v) {												
		cout << i << ' ';
	}
	std::cout <<endl;
   return EXIT_SUCCESS;
}
