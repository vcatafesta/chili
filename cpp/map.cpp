// map.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream>  // std::cout
#include <cstddef>   // std::size_t
#include <valarray>  // std::valarray, std::slice
#include <string>
#include <cctype>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h> //wait
#include <unistd.h>
#include <map>
#include "color.h"

using namespace std;

void qout() {
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

int main(int argc, char **argv) {
   qout(RED,"temp.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n", RESET, '\n');

	// Create a map of strings to integers
	std::map<std::string, int> map;

	// Insert some values into the map
	map["one"] = 1;
	map["two"] = 2;
	map["three"] = 3;

	// Get an iterator pointing to the first element in the map
	std::map<std::string, int>::iterator it = map.begin();

	// Iterate through the map and print the elements
	while (it != map.end()) {
		std::cout << "Key: " << it->first << ", Value: " << it->second << std::endl;
		++it;
	}

	qout(GREEN, "Hello, World!", RESET, '\n');
	return EXIT_SUCCESS;
}

