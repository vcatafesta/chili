#include <stdio.h>
#include <stdlib.h>

int main()
{
	char chr;
   printf("Enter a character: ");
   scanf("%C",&chr);
   if(chr>=65 && chr == 97 && chr <= 122){
   	printf("%c is a lower case character ",chr);
	}
	else{
   	printf("%c is not a Alphabets ",chr);
	}
	return 0;
}

