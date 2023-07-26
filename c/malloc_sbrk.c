// malloc_sbrk.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h> // biblioteca para sbrk

void *alocarMemoria(size_t tamanho) {
    void *ponteiro;
    ponteiro = sbrk(0); // obtem o fim da memória atual
    void *novoFim = sbrk(tamanho); // incrementa o tamanho da memória
    if (novoFim == (void*) -1) {
        return NULL; // erro ao alocar memória
    } else {
        return ponteiro; // retorna o ponteiro para a memória alocada
    }
}

int main() {
    int *ponteiro;
    ponteiro = alocarMemoria(sizeof(int)); // aloca 4 bytes de memória
    *ponteiro = 42; // atribui valor 42 ao endereço de memória alocado
    printf("Valor alocado: %d\n", *ponteiro); // exibe o valor 42
    return 0;
}
