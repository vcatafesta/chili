TITLE PROGRAMA OI ASSEMBLY

.model   SMALL
.STATCK  100h
.DATA
MENSAGEM1   DB  'OI ASSEMBLY $'
.CODE

MOV AX, @DATA
MOV DS, AX

LEA DX, MENSAGEM1
MOV AH,9
INT 21h

MOV AH,4Ch
INT 21h
END

