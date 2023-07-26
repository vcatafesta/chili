// recursive.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
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

void print_number(int num) {
	printf("%s%d\n", CYAN, num);
	if ( num == 0 ) {
		return;
	}
	print_number(--num);
}

int main(int argc, char **argv) {
   printf("%srecursive.c%s, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", LIGHTYELLOW, RED, RESET);
   printf("%sHello World\n%s", LIGHTYELLOW, RESET);

   print_number(10);
   return EXIT_SUCCESS;
}

