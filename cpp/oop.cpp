// oop.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>  // std::cout
#include <cstddef>   // std::size_t
#include <valarray>  // std::valarray, std::slice
#include <string>
#include <cctype>
#include <cstring>
#include <vector>
#include <array>
#include <map>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h> //wait
#include <unistd.h>
#include "color.h"

using namespace std;

void qqout() {}
template <typename T, typename... Args>
void qqout(T arg, Args... args) {
   std::cout << arg << "";
   qqout(args...);
}

void qout() {
	std::cout << '\n';
}
template <typename T, typename... Args>
void qout(T arg, Args... args) {
   std::cout << arg << "";
   qout(args...);
}

template <class T, typename X>
std::string replicate(T ch, X tam) {
   std::string replicate;
   replicate.assign(tam, ch);
   return replicate;
}

size_t my_strlen(char *c) {
   size_t i = 0;
   while(*c != NULL) {
      c++;
      i++;
   }
   return i;
}

size_t LenArray(char **a) {
   size_t i = 0;
   //while(*(a+i)){
   while( a[i] ){
      i++;
   }
   return i;
}

//=================================================================
class Employee {
protected:
	double Salary;
private:
public:
	string Name;
	string Company;
	int Age;

	Employee(string name, string company, int age) {
		Name    = name;
		Company = company;
		Age     = age;
	}
	void setName(string Name) {
		this->Name = Name;
	}
	string getName() {
		return this->Name;
	}

	string setgetName(string name) {
		if (! name.empty())
			this->Name = name;
		return Name;
	}

	void show() {
		qout("Name    = ", Name);
		qout("Company = ", Company);
		qout("Age     = ", Age);
	}
};

//=================================================================

int main(int argc, char **argv) {
	qout(RED,"temp.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>", RESET);
	qout(GREEN, "Hello, World!", RESET);
	qout();

	/*
	Employee employee1;
	employee1.Name    = "Vilmar Catafesta";
	employee1.Company = "TurboNET";
	employee1.Age     = 56;
	employee1.show();
  	*/

	Employee employee1 = Employee("Evili", "Quantum Fomento Mercantil LTDA", 39);
	employee1.show();
	employee1.setgetName("Tharic");
	employee1.show();
	qout("Name    = ", employee1.setgetName(""));
  	
	return EXIT_SUCCESS;
}

