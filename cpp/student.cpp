// student.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

class student {
	int rno;
	char name[10];
	double fee;

public:
	student() {
		cout << "Enter the RollNo:";
		cin >> rno;
		cout << "Enter the Name:";
		cin >> name;
		cout << "Enter the Fee:";
		cin >> fee;
	}
	void show();

	void display() {
		cout << endl << rno << "\t" << name << "\t" << fee;
	}
};

void student::show() {
	cout << endl << rno << "\t" << name << "\t" << fee;
	return;
}

int main(int argc, char **argv) {
   std::cout << RED   << "student.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n" << RESET << '\n';
   std::cout << GREEN << "Hello, World!" << RESET << '\n';

	student s; // constructor gets called automatically when we create the object of the class
	s.display();
	s.show();

   return EXIT_SUCCESS;
}

