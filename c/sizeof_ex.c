// sizeof_ex.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int main(int argc, char **argv) {
	int a;
	short b;
	long c;
	long long d;
	long double e;
	size_t f;
	unsigned int g;
	ushort h;

	printf("sizeof_ex.c, Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
	printf("size of int          = %ld bytes\n", sizeof(a));
	printf("size of short        = %ld bytes\n", sizeof(b));
	printf("size of long         = %ld bytes\n", sizeof(c));
	printf("size of long long    = %ld bytes\n", sizeof(d));
	printf("size of long double  = %ld bytes\n", sizeof(e));
	printf("size of size_t       = %ld bytes\n", sizeof(f));
	printf("size of unsigned int = %ld bytes\n", sizeof(g));
	printf("size of ushort       = %ld bytes\n", sizeof(h));

	return EXIT_SUCCESS;
}
