// iter1.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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
#include <list>
#include <set>
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

template <class Rep, class Period>
void sleep_for (const chrono::duration<Rep,Period>& rel_time);

template< class Clock, class Duration >
void sleep_until( const std::chrono::time_point<Clock,Duration>& sleep_time );

void currentTime(chrono::system_clock::time_point tp) {
   time_t ts = chrono::system_clock::to_time_t(tp);
   cout << std::ctime(&ts) << endl;
}

//=================================================================

int main(int argc, char **argv) {
   qout(RED,"\u2630 iter1.cpp, Copyright \u24d2  2023 Vilmar Catafesta <vcatafesta@gmail.com>\u21b4", RESET, '\n');

	qqout("tradicional : ");
   int v[] = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};
   for(int i = 0; i < 10; i++)
      qqout(v[i], ",");
   qout(); 

   qqout("iterator : ");
   std::vector<int> x = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};
   for(int i = 0; i < 10; i++)
      qqout(x[i], ",");
   qout(); 

   qqout("ponteiro : ");
	int *b = v;
	int *e = v + 10;
   for(int *i = b; i != e; i++)
      qqout(*i, ",");
   qout(); 

   qqout("iterator : ");
   std::vector<int> a = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};
   std::vector<int>::iterator c = a.begin();
   std::vector<int>::iterator d = a.end();
	for(std::vector<int>::iterator i = c; i != d; i++)
      qqout(*i, ",");
   qout(); 

   qqout("iter auto : ");
//	auto a1 = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};
//	std::vector<int> a1 = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};
//	std::list<int> a1 = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};
	std::set<int> a1 = {5, 4, 8, 2, 9, 3, 2, 1, 5, 4};

   auto b1 = a1.begin();
   auto c1 = a1.end();
	for(auto i = b1; i != c1; i++)
      qqout(*i, ",");
   qout(); 

   qqout("iter auto : ");
	for(auto i : a1)
      qqout(i, ",");
   qout(); 

	qqout("std::find : ");
	auto i = std::find(b1, c1, 9);
	if(i != c1)
		qout("Valor encontrado");

   return EXIT_SUCCESS;
}

