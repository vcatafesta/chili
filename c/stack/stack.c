#include <stdio.h>
#include <string.h>

void f3(char hello[]){
	printf("from f3 :%x\n", &hello);
	f3(hello);
}

int main(){
	char hello[] = "Hello World";
	printf("from main :%x\n", &hello);
	f3(hello);
	return 0;
}

