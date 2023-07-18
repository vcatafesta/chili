// bubblesort.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include "color.h"

void swap(int* a, int* b) {
	int temp = *a;
	*a = *b;
	*b = temp;
}

void bubblesort(int arr[], int n) {
	int i, j;
	for (i = 0; i < n - 1; i++) {
		for (j = 0; j < n - i - 1; j++) {
			if (arr[j] > arr[j + 1]) {
				swap(&arr[j], &arr[j + 1]);
			}
		}
	}
}

int main(int argc, char **argv) {
   printf("%sbubblesort.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", RED, RESET);
	int arr[] = { 64, 34, 25, 12, 22, 11, 90 };
	int n = sizeof(arr) / sizeof(arr[0]);

	printf("Array original : ");
	for (int i = 0; i < n; i++)
		printf("%d ", arr[i]);
	printf("\n");

	bubblesort(arr, n);
	printf("Array ordenado : ");
	for (int i = 0; i < n; i++)
		printf("%d ", arr[i]);

	return EXIT_SUCCESS;
}

