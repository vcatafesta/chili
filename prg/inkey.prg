#include <inkey.ch>

function main
	while lastkey() != K_ESC
		? "Inkey, Copyright(c), Vilmar Catafesta, 2018"
		? "Tecle uma tecla, ESC sair:"
		nkey := inkey(0)
		? lastkey()
	enddo	