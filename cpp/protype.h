#ifndef PROTYPE_H
#define PROTYPE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <ctype.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <curses.h>

/*-----------------------------------------------------------------------------------------------*/
#ifdef __cplusplus
	#include <iostream>
	using namespace std;
#endif
#if defined(__BORLANDC__)	
	#pragma warn -nak	
#endif	
#if defined( __GNUC__ )
	//#include <curses.h>
	#pragma GCC diagnostic ignored "-Wwrite-strings"
	#pragma GCC diagnostic ignored "-Wunused-variable"
	#pragma GCC diagnostic ignored "-Wformat"
	#pragma GCC diagnostic ignored "-Wuninitialized"
	#pragma GCC diagnostic ignored "-Wunused-function"
	#pragma GCC diagnostic ignored "-Wduplicated-cond"
	#pragma GCC diagnostic ignored "-Wformat-extra-args"
#endif
/*-----------------------------------------------------------------------------------------------*/
// C++9
//enum Range   { Max = 2147483648L, Min = 255L };
enum Days    {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
enum _color_ {c1 = 0x0003 };
/*-----------------------------------------------------------------------------------------------*/
// C++11
//enum Range   : LONG  { Max = 2147483648L, Min = 255L };
//enum Days    : BYTE  {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
//enum _color_ : DWORD {c1 = 0x0003 };
/*-----------------------------------------------------------------------------------------------*/	
#define fi 
#define true            1
#define false           0
#ifndef OK
	#define OK	         1
#endif
#define NOK	            0
#define write				printf
#define p 					printf
#define print				printf
#define MALLOC(ptr, size) { \
										ptr = malloc(size); \
										if (ptr == NULL) { \
											fprintf(stderr, "Erro na alocacao de memoria. \n"); \
											exit(1); \
										} \
									} \

/*-----------------------------------------------------------------------------------------------*/	
typedef char						MS_CHAR;
typedef char 						*TString;
typedef const char   			MS_TCHAR;
typedef unsigned const char   MS_UCCHAR;
typedef unsigned const char   MS_UTCHAR;
typedef int                   MS_INT;
typedef signed int   			MS_SINT;
typedef unsigned int   			MS_UINT;
typedef size_t              	MS_SIZE_T;
typedef long int     			MS_LINT;
typedef unsigned long int     MS_ULINT;
typedef short             		MS_SHORT;
/*-----------------------------------------------------------------------------------------------*/	
#endif
