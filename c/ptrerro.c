#include <stdio.h>

int main(){

	int *ptrerro;	// assigning value to an uninitialized pointer is dangerous.
	*ptrerro = 1;  // segmentation fault error

	return 0;
}
