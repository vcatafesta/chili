// xmalloc.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <dlfcn.h>

void error_and_exit() {
   printf("error: memory exhausted\n");
  	exit(EXIT_FAILURE);
}

typedef void *(*malloc_like_function) (size_t);
void *malloc(size_t size) {
	malloc_like_function sysmalloc = (malloc_like_function)dlsym(RTLD_NEXT, "malloc");
	void *result = sysmalloc(size);
	if (result == NULL) {
	   error_and_exit();
	}
//	memset(result, 0xCD, size);
	memset(result, 32, size);
	return result;
}

int main(int argc, char **argv) {
	int *p1 = malloc(sizeof(int));
	int *p2 = malloc(sizeof(int));
	int *p3 = malloc(1000000000);

//	*p1 = 4;
//	*p2 = 234;

   printf("%d, %d\n", *p1, *p2);
   return EXIT_SUCCESS;
}

