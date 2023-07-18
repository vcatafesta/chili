// factorial.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <cstring>
#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include "color.h"
#include <bits/stdc++.h>

using namespace std;
void print();
int factorial(int n);
int multiply(int a, int b);

int factorial(int n) {
	if (n == 1)
		return 1;
	print();
	return n * factorial(n - 1);
}

int multiply(int a, int b) {
	return a * b;
}

void print() {
	std::cout << GREEN << "Calculando factorial..." << RESET << '\n';
}

int main(int argc, char **argv) {
	std::cout << RED   << "factorial.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';

	int a    = 1;
	int b    = 2;
	int fact = 5;

	cout << multiply(a, b) << endl;
	cout << factorial(5) << endl;
	return EXIT_SUCCESS;
}
