// memusage.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <sys/resource.h>
#include <unistd.h>

#define RAM 1024 * 1000

long get_mem_usage() {
	struct rusage myusage;

	getrusage(RUSAGE_SELF, &myusage);
	return myusage.ru_maxrss;
}

int main(int argc, char **argv) {
	long baseline = get_mem_usage();

	for (int i=1; i <= 100; i++) {
		char *p = malloc(RAM);
		memset(p, 32, RAM);
//		sleep(1);
	   printf("Usage: %d => %ld + %ld\n", i, baseline, get_mem_usage()-baseline);
	}
   return EXIT_SUCCESS;
}

