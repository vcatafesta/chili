TITLE PRM71:ADICAO E SUBTRACAO
;Programa para ilustração do programa DEBUG
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
   MOV AX,000BH ;carrega o primeiro valor em AX
   MOV BX,00A1H ;carrega o segundo valor em BX
   ADD AX,BX ;soma os dois valores e armazena
; o resultado em AX
   MOV BX,0005H ;carrega o terceiro valor em BX
   SUB AX,BX ;subtrai o terceiro valor do resultado
; da operação anterior
   MOV AH,4CH ;código para devolver o controle p/ DOS
   INT 21H ;interrupção que executa a função em AH
MAIN ENDP
   END MAIN
