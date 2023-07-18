#include <stdio.h>
#include <string.h>

int main()
{
	char *str1  = "abcd";
	char str2[] = "abcd";
	printf("%d %d %d", sizeof(str1), sizeof(str2), sizeof("abcd"));
}

