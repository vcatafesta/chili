#include <stdio.h>
/******************************************************************/
void print(char *cStr)
{
	int count = 0;
	while(*cStr){
		count++;
		printf("%d %c\n", count, *cStr);
		cStr++;
	}
	printf("\n");
}
/******************************************************************/
int main()
{
	//char cStr[20] = "Hello";
	char *cStr = "Hello";
	print(cStr);
}
/******************************************************************/
