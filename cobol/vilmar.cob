      * Programa Teste     
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       01 WS-NOME PIC X(20).
       01 NOME PIC X(50) VALUE "R202".
       01 IDADE PIC 9(3) VALUE 50.
       01 SALARIO PIC 9(6)V9(2) VALUE 20000.00.
       
       PROCEDURE DIVISION.
           DISPLAY "HELLO WORLD".
           DISPLAY "Nome    :" NOME.
           DISPLAY "Idade   :" IDADE.
           DISPLAY "Salario :" SALARIO.

           display "Digite um nome"
           accept WS-NOME
           display "nome digitado foi " WS-NOME
           STOP RUN.
       