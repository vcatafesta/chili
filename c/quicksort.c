// quicksort.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include "color.h"

#define sizeof_array(ARRAY)   (sizeof(ARRAY)/sizeof(ARRAY[0]))
#define arraylenght(ARRAY)    (sizeof(ARRAY)/sizeof(int*))
#define COUNTOF(x)            (sizeof(x)/sizeof(*x))

int LenArray(char *a[]) {
   int nlen = 0;
   while( a[nlen] ){
     nlen++;
   }
   return nlen;
}

int printarray(int *a) {
   int nlen = sizeof(a) / sizeof(int);
   printf("%02d------------\n", nlen);
   for(int i = 0; i <= nlen; i++){
      printf("%02d\t", a[i]);
   }
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);

    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quicksort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);

        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}

int main(int argc, char **argv) {
	int arr[] = { 1, 9, 3, 5, 6, 7, 8, 2, 4, 0};
//	int n = sizeof(arr) / sizeof(arr[0]);
//	int n = sizeof_array(arr);
	int n = COUNTOF(arr);
   printf("%squicksort.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);

	printf("Array size     : %d\n", n);
	printf("Array original : ");
	for (int i = 0; i < n; i++)
		printf("%d ", arr[i]);
	printf("\n");

	quicksort(arr, 0, n - 1);
	printf("Array ordenado : ");
	for (int i = 0; i < n; i++)
		printf("%d ", arr[i]);

   return EXIT_SUCCESS;
}


