#include <stdio.h>
#include <stdlib.h>

#define sizeof_array(ARRAY) (sizeof(ARRAY)/sizeof(ARRAY[0]))
#define arraylenght(ARRAY) (sizeof(ARRAY)/sizeof(int*))
#define COUNTOF(x) (sizeof(x)/sizeof(*x))

int LenArray( char *a[])
{
   int nlen = 0;
   while( a[nlen] ){
     nlen++;
   }
	return nlen;
}

int printarray(int *a)
{
	int nlen = sizeof(a) / sizeof(int);
	printf("%02d------------\n", nlen);
	for(int i = 0; i <= nlen; i++){
		printf("%02d\n", a[i]);
	}
}

int partition(int a[], int p, int r)
{
	int ntemp;
	int x = a[r];
	int j = (p - 1);

	for (int i = p; i < r; i++) {
		if (x <= a[i]) {
			j = j + 1;
			ntemp = a[j];
			a[j] = a[i];
			a[i] = ntemp;
		}
	}
	a[r] = a[j + 1];
	a[j + 1] = x;
	return (j + 1);
}

void quickSort(int a[], int p, int r)
{
	if (p < r) {
		int q = partition(a, p, r);
		quickSort(a, p, q - 1);
		quickSort(a, q + 1, r);
	}
}

int main()
{
	int a[] = { 1, 9, 3, 5, 6, 7, 8, 2, 4, 0};
	printf("Original:\n");
	printarray(a);
	quickSort(a, 0, 9);
	printf("Reordenado:\n");
	printarray(a);
	return 0;

}

