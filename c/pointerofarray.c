#include <stdio.h>

int main(){
	int a[5];
	*a     = 10; //*(a+0) = 10;
	*(a+1) = 20;
	*(a+2) = 30;
	*(a+3) = 40;
	*(a+4) = 50;
	printf("%d\n", a[0]);
	printf("%d\n", a[1]);
	printf("%d\n", a[2]);
	printf("%d\n", a[3]);
	printf("%d\n", a[4]);

	int b[] = {11, 22, 36, 5, 2};
	int sum = 0;
	int *p;

	// Old version
	for(p = &b[0]; p <= &b[4]; p++)
		sum += *p;
	printf("Sum is : %d\n", sum);

	// New version
	sum = 0;
	for(p = b; p <= b + 4; p++)
		sum += *p;
	printf("Sum is : %d\n", sum);

	//printf("%p\n", b++);  	// error compiler
	printf("%d\n", b[0]);  		// ok
	printf("%d\n", *(b+1));		// ok
	printf("%p\n", *(b+1));    // ok
	printf("%d\n", b+1);			// erro
	printf("%p\n", b+1);       // erro

	int *c = b;
	printf("%d ", *(c));			// ok
	printf("%d ", *(++c));		// ok
	printf("%d ", *(++c));		// ok
	printf("%d ", *(++c));		// ok
	printf("%d\n", *(++c));		// ok

	int *d = b;
	printf("%d ", *(d++));		// ok
	printf("%d ", *(d++));		// ok
	printf("%d ", *(d++));		// ok
	printf("%d ", *(d++));		// ok
	printf("%d\n", *(d++));		// ok
	return 0;
}
