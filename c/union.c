// union.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include "color.h"

union test1 {
	int x;
	int y;
}Test1;

union test2 {
	int x;
	char y;
}Test2;

union test3 {
	int arr[10];
	char y;
}Test3;

int main(int argc, char **argv) {
   printf("%sunion.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
	printf("sizeof(test1) = %lu, sizeof(test2) = %lu, sizeof(test3) = %lu\n", sizeof(Test1), sizeof(Test2), sizeof(Test3));
   return EXIT_SUCCESS;
}
