// Vilmar Catafesta <vcatafesta@gmail.com>

#include <stdio.h>
#include <stdlib.h>

#ifdef __GNUC__
#pragma GCC diagnostic ignored "-Wunused-local-typedefs"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wwrite-strings"
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"
#endif

int main() {
	printf("Sleeping..\n");
	sleep(1);
	printf("Sleeping..\n");
	sleep(1);
	printf("Done!\n");
	return 0;
}
