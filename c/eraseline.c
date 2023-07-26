#include <stdio.h>

void console_erase_line(void)
{
	printf("\x1B[K");
}

int main(void)
{
	printf("Vilmar Catafesta\n");
	console_erase_line();
	return 0;
}
