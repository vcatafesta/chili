// tamarray.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

int tamanhoArray(int *arr) {
    int tamanho = sizeof(arr) / sizeof(arr[0]);
    return tamanho;
}

int tamanhoArray1(int arr[]) {
    int tamanho = sizeof(arr) / sizeof(arr[0]);
    return tamanho;
}

int main() {
    int numeros[] = {1, 2, 3, 4, 5};
    int tamanho  = tamanhoArray(numeros);
    int tamanho1 = tamanhoArray1(numeros);
    printf("O tamanho do array eh: %d\n", tamanho);
    printf("O tamanho do array eh: %d\n", tamanho1);
    return 0;
}
