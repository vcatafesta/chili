// pull.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <curses.h>

int main() {
    // inicializa a tela e o modo de cbreak
    initscr();
    cbreak();

    // cria uma nova janela para o menu
    int height = 8, width = 40;
    int starty = (LINES - height) / 2;
    int startx = (COLS - width) / 2;
    WINDOW *menu_win = newwin(height, width, starty, startx);
    box(menu_win, 0, 0);
    refresh();

    // define as opções de menu
    char *choices[] = {
        "Escolha uma opção:",
        "1. Opção 1",
        "2. Opção 2",
        "3. Opção 3",
        "4. Sair",
    };
    int n_choices = sizeof(choices) / sizeof(char *);
    int choice;

    // exibe as opções de menu na janela
    keypad(menu_win, TRUE);
    mvwprintw(menu_win, 1, 1, choices[0]);
    for (int i = 1; i < n_choices; i++) {
        mvwprintw(menu_win, i+1, 1, choices[i]);
    }
    wrefresh(menu_win);

    // espera pelo usuário selecionar uma opção
    while (1) {
        choice = wgetch(menu_win) - '0';
        if (choice >= 1 && choice <= n_choices-1)
            break;
    }

    // executa a opção selecionada
    switch (choice) {
        case 1:
            mvprintw(LINES-2, 0, "Você selecionou a Opção 1.");
            break;
        case 2:
            mvprintw(LINES-2, 0, "Você selecionou a Opção 2.");
            break;
        case 3:
            mvprintw(LINES-2, 0, "Você selecionou a Opção 3.");
            break;
        case 4:
            mvprintw(LINES-2, 0, "Você escolheu sair.");
            break;
    }

    // aguarda pelo usuário antes de sair
    getch();

    // finaliza a janela e a tela
    delwin(menu_win);
    endwin();

    return 0;
}
