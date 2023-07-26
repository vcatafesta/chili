#include "funcoes.c"

int main() {
	int i = 0;

	while(i <= 1000) {
   	printf("%d %p\n", i++, &i);
  	}

	return 0;
}
