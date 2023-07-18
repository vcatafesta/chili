#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <string.h>
#include <iostream>
#include <fstream>
#include <istream>
#include <iostream.h>
#include <istream.h>
#include <windows.h>
#include <conio.h> // getch()

using namespace std;
typedef short int SINT;

// WATCOM SOMENTE - tirar o c_str() para imprimir string
std::ostream & operator<<( std::ostream & stream, const std::string & string ) { stream << string.c_str(); return stream; }

#define bytes     " bytes "
//**************************************************************
#define ms_char     char
#define sizeof_char 1
#define min_char    -127
#define max_char    127
//**************************************************************
#define ms_uchar    unsigned char
#define sizeof_uchar 1
#define min_uchar    0
#define max_uchar    255
//**************************************************************
#define ms_int      signed int
#define sizeof_int  4
#define min_int     -2147483648
#define max_int     2147483647
//**************************************************************
#define ms_uint     unsigned int
#define sizeof_uint 4
#define min_uint     0
#define max_uint     4294967295
//**************************************************************
#define ms_sint     short int;
#define sizeof_sint 2
#define min_sint   -32768
#define max_sint   32767
//**************************************************************
#define ms_usint    unsigned short int;
#define sizeof_usint  2
#define min_usint   0
#define max_usint   65535
//**************************************************************
#define ms_lint     signed long int;
#define sizeof_lint  4
#define min_lint    -2147483648
#define max_lint    2147483647
//**************************************************************
#define ms_ulint    unsigned long int;
#define sizeof_ulint  4
#define min_ulint    0
#define max_ulint    4294967295
//**************************************************************
#define sizeof_f    4
#define sizeof_d
