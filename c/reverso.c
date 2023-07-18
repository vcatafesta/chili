// reverso.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <ncurses.h>

int main(int argc, char **argv) {
   printf("reverso.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n\n");
    char buffer[10];
    initscr(); // inicializa a biblioteca ncurses
    printw("Digite algo: ");
    echo(); // desativa a opção de exibir os caracteres digitados
    getstr(buffer); // lê a entrada de dados e armazena em buffer
    endwin(); // finaliza a biblioteca ncurses
    printw("\nO que foi digitado: %s", buffer);
   return EXIT_SUCCESS;
}

