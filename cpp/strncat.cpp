// strncat.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#ifdef __cplusplus
	#include <iostream>  // std::cout
	#include <cstddef>   // std::size_t
	#include <valarray>  // std::valarray, std::slice
	#include <string>
	#include <cctype>
	#include <array>
	#include <algorithm>
	#include <functional>
	#include <map>
	#include <vector>
	#include <chrono>
	#include <thread>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h>
#ifdef _WIN32
   #include <Windows.h>
	#include <dos.h>
#else
   #include <unistd.h>
#endif
#include "color.h"
#include "funcoes.cpp"

#ifdef __cplusplus
using namespace std;
#endif

#if defined( __GNUC__ )
//#pragma GCC diagnostic ignored "-Wwrite-strings"
//#pragma GCC diagnostic ignored "-Wunused-parameter"
//#pragma GCC diagnostic ignored "-Wuninitialized"
//#pragma GCC diagnostic ignored "-Wunused-function"
//#pragma GCC diagnostic ignored "-Wduplicated-cond"
#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wformat"
#pragma GCC diagnostic ignored "-Wformat-extra-args"
#endif

#define CURSOR(top, bottom) 	(((top) << 8) | (bottom))
#define getrandom(min, max)	((rand()%(int)(((max) + 1)-(min)))+ (min))

//=================================================================

int main(int argc, char **argv) {
   qout(RED,"\u2630 strncat.cpp, Copyright \u24d2  2023 Vilmar Catafesta <vcatafesta@gmail.com>\u21b4", RESET, '\n');

	char dest[50]	= "Using strncat function,";
	char src[50] 	= " this part is added and this is ignored";
	char *temp     = space(50);

	qout(strlen(temp));
	qout("dest ",src) ;
	qout("src  ",dest) ;
	temp = strncat(dest, src, 19);
	qout("strncat(dest,src) ",dest) ;
	qout(strlen(temp));

   qout(GREEN, "Hello, World!", RESET, '\n');
   return EXIT_SUCCESS;
}

