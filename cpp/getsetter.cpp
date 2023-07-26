// getsetter.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>
#include <string>
#include <cctype>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include "color.h"

using namespace std;

class Stove {
	private:
		int velocidade = 0;
	public:
		int temperature = 0;
		Stove(int velocidade) {
			setVelocidade(velocidade);
		}

	int getVelocidade() {
		return velocidade;
	}		

	void setVelocidade(int velocidade) {
		this->velocidade = velocidade;
	}		

};

int main(int argc, char **argv) {
   std::cout << RED   << "getsetter.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';

	Stove stove(10);
	stove.temperature = 40;
	std::cout << "Temperatura is : " << GREEN << stove.temperature << RST <<'\n';
	std::cout << " Velocidade is : " << GREEN << stove.getVelocidade() << RST <<'\n';
	stove.setVelocidade(120);
	std::cout << " Velocidade is : " << GREEN << stove.getVelocidade() << RST <<'\n';
   return EXIT_SUCCESS;
}

