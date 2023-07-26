#include <stdio.h>

int main()
{
	int a;
	int *p;
	a = 10;
	p = &a;
	printf("============================================\n");
	printf("a  = %d\n", a);
	printf("p  = %d\n", p);
	printf("*p = %d\n", *p); // *p = value at address pointer by p
	printf("&a = %d\n", &a); // &a = address of a

	*p = 12;
	printf("a  = %d\n", a);
	printf("sizeof of integer a  = %d bytes\n", sizeof(a));
	printf("sizeof of integer p  = %d bytes\n", sizeof(p));
	printf("sizeof of integer *p = %d bytes\n", sizeof(*p));
	printf("Address p   is = %d\n", p);
	printf("Address p+1 is = %d\n", p+1);
	return 0;
}
