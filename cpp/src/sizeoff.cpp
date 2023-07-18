// sizeoff.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <iostream>
#include "color.h"

int main(int argc, char **argv) {
   printf("%ssizeoff.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
   std::cout << "Size of char      : " << sizeof(char) << '\n';
   std::cout << "Size of int       : " << sizeof(int) << '\n';
   std::cout << "Size of short int : " << sizeof(short int) << '\n';
   std::cout << "Size of long int  : " << sizeof(long int) << '\n';
   std::cout << "Size of float     : " << sizeof(float) << '\n';
   std::cout << "Size of double    : " << sizeof(double) << '\n';
   std::cout << "Size of wchar_t   : " << sizeof(wchar_t) << '\n';
   return EXIT_SUCCESS;
}
