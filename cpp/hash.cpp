// hash.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include "color.h"

using namespace std;

class thash {
//	string name;
//	string lastname;
	static int count;

//private:
//	static int count;

public:
	string name;
	string lastname;
	thash() {
		count++;
		cout << "    Enter the Name : ";
		cin >> name;
		cout << "Enter the Lastname : ";
		cin >> lastname;
	}

	static int getCount() { return count; } // método estático público para obter o valor atual do contador

	void display() {
		cout << " Counter : " << getCount << '\n' ;
		cout << "    Name : " << name     << '\n';
		cout << "Lastname : " << lastname << '\n';
	}
};

int thash::count = 0; // inicializar o contador estático com zero

int main(int argc, char **argv) {
   std::cout << RED   << "student.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
   std::cout << GREEN << "Hello, World!" << RESET << '\n';

	while(1) {
		thash oName;
		oName.display();
		oName.name = "Gatinho";
		oName.display();
	}

   return EXIT_SUCCESS;
}

