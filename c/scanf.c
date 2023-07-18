#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

int main(int argc, char **argv) {
	int x = 7;
	printf("x = %d\n", x);

	printf("new x? ");
	scanf("%d", &x);
	printf("x = %d\n", x);

   return 0;
}

