#include <curses.h>    //Incluiremos a biblioteca ao nosso sistema                
#include <stdio.h>

void sair (void);      //Esta função fará com que o programa seja fechado

int main(void)
{
    int intKey;      //Variável que receberá as teclas passada pelo usuário 
    WINDOW *janela1, *janela2;
    initscr();      /* Esta função  inicializa a ncurses. Para todos os programas devemos 
                       sempre inicializar a ncurses e depois finalizar, como veremos adiante. */

    start_color(); //Esta função torna possível o uso das cores

    //Abaixo estamos definindo os pares de cores que serão utilizados no programa
    init_pair(1,COLOR_WHITE,COLOR_BLUE); 
    init_pair(2,COLOR_BLUE,COLOR_WHITE);
    init_pair(3,COLOR_RED,COLOR_WHITE); 
    init_pair(4,COLOR_GREEN,COLOR_BLACK); 

    bkgd(COLOR_PAIR(1));        /*Aqui nós definiremos que a cor de fundo do nosso 
                                  programa será azul e a cor dos textos será branca.*/

    for(;;)
    {	 
        attron(COLOR_PAIR(3)); /* Estamos alterando o par de cores para 3 em vez de utilizar o
								  par de cor por omissão(1). */
	mvprintw(2,1,"Menu Principal");   // Imprimimos um texto na tela na linha 2, coluna 1
	attroff(COLOR_PAIR(3));   /* Estamos alterando o par com a cor por omissão, ou
									 seja, retornando para o par de cor 1. */
	attron(COLOR_PAIR(2));  
	mvprintw(4,5,"1. Janela 1"); //Imprimimos um texto na tela na linha 4, coluna 5
	mvprintw(5,5,"2. Janela 2"); //Imprimimos um texto na tela na linha 5, coluna 5
	mvprintw(6,5,"3. Sair");     //Imprimimos um texto na tela na linha 6, coluna 5
	mvprintw(8,5,"3. Digite sua opção: ");     //Imprimimos um texto na tela na linha 8, coluna 5
	intKey = getch();
	attroff(COLOR_PAIR(2));
	refresh();                                      //Atualiza a tela   

	switch (intKey)
        { 
	    case 1: janela1 = newwin(5, 40, 5, 10);     /*Criaremos uma no janela com 5 linhas, 40 colunas 
														e que aparecera na coluna 5, linha 10 */
 			      wbkgd(janela1,COLOR_PAIR(4));       //Definiremos a cor de fundo da janela1
			      //Abaixo imprimiremos um texto dentro da janela1
                              wattron(janela1, A_BOLD);
			      mvwprintw(janela1,2,1,"JANELA1 Verde com A_BOLD. Aperte qualquer tecla para sair.");
                              wattroff(janela1, A_BOLD);
			      wrefresh(janela1); //Atualizaremos a janela1
			      wgetch(janela1);   //Esperaremos que alguma tecla seja apertada
                              delwin(janela1);   //Deletaremos a janela
     			      break;
	    case 2: janela2 = newwin(5, 40, 5, 10);    /*Criaremos uma no janela com 5 linhas, 40 colunas 
														e que aparecera na coluna 5, linha 10 */
			      wbkgd(janela2,COLOR_PAIR(4));      //Definiremos a cor de fundo da janela2
                              box(janela2, ACS_VLINE, ACS_HLINE); //Aqui colocaremos uma borda na janela2
			      //Abaixo imprimiremos um texto dentro da janela2
			      mvwprintw(janela2,2,2,"JANELA2 Verde sem A_BOLD. Aperte qualquer tecla para sair.");
			      wrefresh(janela2); //Atualizaremos a janela2
			      wgetch(janela2);   //Esperaremos que alguma tecla seja apertada
                              delwin(janela2);   //Deletaremos a janela
     			      break;
	    case 3: sair();               // Sai do programa
		    break;
	}
	refresh();                                      //Atualiza a tela   
    }
}

void sair()
{
    endwin(); /* Sempre que finalizarmos um programa com a biblioteca curses, devemos 
                 executar este comando. */
    exit(0);   
}
