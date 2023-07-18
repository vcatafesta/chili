; use ; para fazer comentários em programas assembly
;.MODEL SMALL ;modelo de memória
;.STACK ;espaço de memória para instruções do programa na pilha
.CODE ;as linhas seguintes são instruções do programa
   mov ah,01h ;   move o valor 01h para o registrador ah
   mov cx,07h ;move o valor 07h para o registrador cx
   int 10h ;interrupção 10h
   mov ah,4ch ;move o valor 4ch para o registrador ah
   int 21h ;interrupção 21h
.DATA
x db  1
END ;finaliza o código do programa
