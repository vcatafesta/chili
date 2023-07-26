// wcscat.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

#ifdef __cplusplus
using namespace std;
#endif /* __cplusplus */

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
   qout(RED,"\u2630 wcscat.cpp, Copyright \u24d2  2023 Vilmar Catafesta <vcatafesta@gmail.com>\u21b4", RESET, '\n');

	setlocale(LC_ALL, "en_US.utf8");
	wchar_t dest[50] = L"\u0905 \u0906 \u0907 \u0908 ";
	wchar_t src[50] = L"\u0915 \u0916 \u0917 \u0918 ";
	wcscat(dest, src);
	wcout << "After appending: " << dest ;

   return EXIT_SUCCESS;
}

