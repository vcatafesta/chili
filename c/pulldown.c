// pulldown.c, Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <curses.h>

int main() {
    char *itens[] = {"Item 1", "Item 2", "Item 3"};
    int n_itens = 3;
    int selecao = -1;

    // inicializa a tela e o modo de cbreak
    initscr();
    cbreak();

    // cria uma nova janela para o menu pulldown
    WINDOW *menuwin = newwin(5, 20, 2, 2);
    box(menuwin, 0, 0);
    refresh();

    // adiciona os itens ao menu pulldown
    for (int i = 0; i < n_itens; i++) {
        mvwprintw(menuwin, i+1, 2, itens[i]);
    }

    // exibe o menu pulldown e espera pela seleção do usuário
    wrefresh(menuwin);
    keypad(menuwin, TRUE);
    int ch = wgetch(menuwin);
    if (ch == KEY_DOWN) {
        selecao = 0;
    } else if (ch == KEY_UP) {
        selecao = n_itens - 1;
    } else if (ch >= '1' && ch <= '3') {
        selecao = ch - '1';
    }

    // finaliza a janela e a tela
    delwin(menuwin);
    endwin();

    // exibe a seleção do usuário
    if (selecao >= 0) {
        printf("Você selecionou o item %s\n", itens[selecao]);
    } else {
        printf("Nenhum item selecionado!\n");
    }

    initscr();
    cbreak();

    // define as cores
    start_color();
    init_pair(1, COLOR_CYAN, COLOR_BLACK);

    // cria uma nova janela
    int height = 5, width = 40;
    int starty = (LINES - height) / 2;
    int startx = (COLS - width) / 2;
    WINDOW *win = newwin(height, width, starty, startx);
    box(win, 0, 0);
    refresh();

    // exibe o texto centralizado na janela
    char *mensagem = "Olá, mundo!";
    int x = (width - strlen(mensagem)) / 2;
    int y = height / 2;
    wattron(win, COLOR_PAIR(1));
    mvwprintw(win, y, x, mensagem);
    wattroff(win, COLOR_PAIR(1));
    wrefresh(win);

    // aguarda pelo usuário antes de sair
    getch();

    // finaliza a janela e a tela
    delwin(win);
    endwin();

    return 0;
}



