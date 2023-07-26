*
 * ============================================================================
 *
 *       Filename:  search.c
 *
 *    Description:  Implementa a Busca binária recursiva e iterativa e compara
 *                  com a busca sequencial.
 *
 *        Version:  1.0
 *        Created:  09/04/2018 16:40:20
 *       Compiler:  gcc
 *
 *         Author:  Gustavo Pantuza (gustavopantuza@gmail.com),
 *   Organization:  Comunidade de Ciência da Computação
 *
 * ============================================================================
 */


#include <stdlib.h>
#include <stdio.h>


#define VECTOR_SIZE 10



/**
 * Busca sequencialmente o item dentro do vetor vector.
 * Caso encontrado retorna o índice do item. Caso contrário
 * retorna -1.
 */
int
sequential_search (int vector[VECTOR_SIZE], int item)
{
    for (int i = 0; i < VECTOR_SIZE; i++) {

        if (vector[i] == item) {
            return i;
        }
    }

    return -1;
}




/**
 * Busca recursivamente o item dentro do vetor vector. A cada iteração
 * reduz o espaço de busca pela metade. Quando encontra o item retorna
 * o índice onde ele foi encontrado. Caso contrário retorna -1
 */
int
recursive_binary_search(int vector[VECTOR_SIZE], int begin, int end, int item)
{
    int i = (begin + end) / 2;

    if (begin > end) {
        return -1;
    }

    if (vector[i] == item) {
        return i;
    }

    if (vector[i] < item) {
        return recursive_binary_search(vector, i + 1, end, item);

    } else {  // vector[i] > item
        return recursive_binary_search(vector, begin, i - 1, item);
    }
}




/**
 * Busca iterativamente o item dentro do vetor vector. A cada iteração
 * reduz o espaço de busca pela metade sem fazer chamadas recursivas.
 * Ao encontrar o item retorna seu índice. Caso contrário retorna -1
 */
int
iterative_binary_search(int vector[VECTOR_SIZE], int item)
{
    int begin = 0;
    int end = VECTOR_SIZE - 1;

    while (begin <= end) {  /* Condição de parada */

        int i = (begin + end) / 2;  /* Calcula o meio do sub-vetor */

        if (vector[i] == item) {  /* Item encontrado */
            return i;
        }

        if (vector[i] < item) {  /* Item está no sub-vetor à direita */
            begin = i + 1;
        } else {  /* vector[i] > item. Item está no sub-vetor à esquerda */
            end = i;
        }
    }

    return -1;
}






int
main (int argc, char* argv[])
{
    int vector[VECTOR_SIZE] = {5, 23, 27, 30, 39, 45, 56, 71, 80, 92};


    for (int i = 0; i < VECTOR_SIZE; i++) {

        /* Current item to be searched */
        int item = vector[i];

        /* Tests Sequential search */
        printf("Sequential search %d: \t\t%d\n", item,
                sequential_search(vector, item));


        /* Tests Recursive binary search */
        printf("Recursive binary search %d: \t%d\n", item,
                recursive_binary_search(vector, 0, VECTOR_SIZE - 1, item));


        /* Tests Iterative binary search */
        printf("Iterative binary search %d: \t%d\n", item,
                iterative_binary_search(vector, item));

        printf("\n");
    }

    return EXIT_SUCCESS;
}