// referencia.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

void func(int *x) {
    *x = *x + 1;
    printf("x dentro da função = %d\n", *x);
}
void func1(int x) {
    x = x + 1;
    printf("x dentro da função = %d\n", x);
}

int mainParametro() {
    int x = 5;
    func1(x);
    printf("x fora da função = %d\n", x);
    return 0;
}

int main() {
    int x = 5;
    func(&x);
    printf("x fora da função = %d\n", x);
	 mainParametro();
    return 0;
}

