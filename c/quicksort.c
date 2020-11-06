#include <iostream>
#include <stdio.h>
using namespace std;

int LenArray(char *a[])
{
   int nlen = 0;
   //while(*(a+nlen)){
   while( a[nlen] ){
     nlen++;
   }
	return nlen;
}

void print(int a[]) {
	int i=0;
	while( a[i++] ) {
		cout << a[i] << "-";
	}
	cout << endl;
}

int partition(int a[], int p, int r) {
	int x = a[r];
	int j = p - 1;
	for (int i = p; i < r; i++) {
		if (x <= a[i]) {
			j = j + 1;
			int temp = a[j];
			a[j] = a[i];
			a[i] = temp;
		}
	}
	a[r] = a[j + 1];
	a[j + 1] = x;
	return (j + 1);
}

void quickSort(int a[], int p, int r) {
	if (p < r) {
	int q = partition(a, p, r);
	quickSort(a, p, q - 1);
	quickSort(a, q + 1, r);
	}
}

int main() {
	int a[] = { 1, 9, 0, 5, 6, 7, 8, 2, 4, 3 };
	quickSort(a, 0, 9);
	print(a);
	return 0;

}

