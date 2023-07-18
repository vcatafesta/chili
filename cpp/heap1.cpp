// heap1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <string>
#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include "color.h"

using namespace std;

int main(int argc, char **argv) {
	std::cout << RED   << "heap1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
	std::cout << GREEN << "Hello, World!" << RESET << '\n';

	vector <int> vt1, vt2;
	vector <int>::iterator Itera1, Itera2;

	int i;
	for ( i = 1 ; i <=5 ; i++ )
		vt1.push_back( i );

	random_shuffle( vt1.begin( ), vt1.end( ) );

	cout << "vector vt1 is        : ( " ;
	for ( Itera1 = vt1.begin( ) ; Itera1 != vt1.end( ) ; Itera1++ )
		cout << *Itera1 << " ";
	cout << ")" << endl;

	sort_heap (vt1.begin( ), vt1.end( ) );
	cout << "heap vt1 sorted range: ( " ;
	for ( Itera1 = vt1.begin( ) ; Itera1 != vt1.end( ) ; Itera1++ )
		cout << *Itera1 << " ";
	cout << ")" << endl;

	return EXIT_SUCCESS;
}
