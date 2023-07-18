// setlocale.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <locale.h>
#include <errno.h>
#include <wchar.h>
#include "color.h"

#define MAX_SIZE 100

int main(void) {
  int x;
  wchar_t Nome[MAX_SIZE];

  setlocale(LC_ALL, "");  // Necessário para que o sistema saiba qual o conjunto de caracteres a usar.

/*   
  printf("Informe o Texto: ");
  if(!fgetws(Nome, MAX_SIZE, stdin)){  // Sempre teste o valor de retorno para saber se leitura foi bem sucedida.
    fprintf(stderr, "Erro de leitura: %s.\n", strerror(errno));
    return 1;  // Sai do programa com código de erro.
  }

  x=wcslen(Nome);  // wcslen() é a equivalente a strlen() quando se usa um vetor de wchar_t.
  if(Nome[x-1]==L'\n')
    Nome[--x]=L'\0';  // Remove quebra de linha no final da string.

  printf("%d wide-characters lidos.\n", x);
   
  printf("\n A palavra escrita foi: %ls", Nome);
  printf("\n A palavra de trás pra frente é: ");
   
  while(x-- > 0)
    printf("%lc", Nome[x]);
  printf("\n\n");
*/
  printf("Canto superior esquerdo simples: \u250c\n") ;

  return 0;  // Sai do programa indicando sucesso.
} 
