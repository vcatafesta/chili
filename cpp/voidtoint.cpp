// voidtoint.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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
#include "color.h"

using std::cout;

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

template< class T > 
T findMax(const T const * data, const size_t const numItems) { 
	// Obtain the minimum value for type T 
	T largest = std::numeric_limits< T >::min(); 
	for(unsigned int i=0; i<numItems; ++i) 
		if (data[i] > largest) 
			largest = data[i]; 
	return largest; 
} 

//=================================================================

int main(int argc, char **argv) {
   qout(RED,"temp.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n", RESET, '\n');

	void* ptr;
	int *i = (int *) ptr;
	int *j = (int *) malloc(sizeof(int) * 5);
	free(i);
	free(j);

   qout(GREEN, "Hello, World!", RESET, '\n');
   return EXIT_SUCCESS;
}

