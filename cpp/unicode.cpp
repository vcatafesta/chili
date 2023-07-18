// vilmar.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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
#include <wchar.h>
#include <locale.h>
#ifdef _WIN32
   #include <Windows.h>
#include <dos.h>
#else
   #include <unistd.h>
#endif
#include "color.h"

#ifdef __cplusplus
using namespace std;
#endif /* __cplusplus */
#include <iostream>
#include <iomanip>

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

void qqout() {}
template <typename T, typename... Args>
void qqout(T arg, Args... args) {
   std::cout << arg << "";
   qqout(args...);
}

void qout() { std::cout << '\n'; }
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
   qout(RED,"\u2630 temp.cpp, Copyright \u24d2  2023 Vilmar Catafesta <vcatafesta@gmail.com>\u21b4", RESET, '\n');

   setlocale(LC_CTYPE, "");
   wchar_t star1 = 0x2606;
   wchar_t star2 = 0x2605;
   wprintf(L"Black Star: %lc\n",star1);
   wprintf(L"White Star: %lc\n",star2);
   printf("Hello there: \U0001F600\n");

	qout("\u0041");
	qout("\u21b4");
	qout("\u2122");
	qout("\u24c7");
	qout("\u24d2");
	qout("\u24e1");

	/*   
	int i;
    for (i = 0; i <= 0x10FFFF; i++) {
        printf("%04X ", i);
        if (i % 16 == 15) {
            printf("\n");
        }
    }

    std::cout << std::hex << std::setfill('0');
    for (int i = 0; i <= 0x10FFFF; i++) {
        std::cout << std::setw(4) << i << " ";
        std::cout << static_cast<char32_t>(i) << std::endl;
    }
	*/

	return EXIT_SUCCESS;
}

