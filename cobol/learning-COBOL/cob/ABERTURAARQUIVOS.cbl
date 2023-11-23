       IDENTIFICATION DIVISION.
       PROGRAM-ID. ABERTURAARQUIVOS.
      ******************************************
      * OBJETIVO: ABERTURA DE ARQUIVOS
      * AUTOR: LUCAS
      ******************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CLIENTES ASSIGN TO
           'C:\Users\Lucas\Desktop\Workspace\learning-COBOL\cobol\CLIENT
      -    'ES.DAT'
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               FILE STATUS IS CLIENTES-STATUS
               RECORD KEY  IS CLIENTES-CHAVE.
       DATA DIVISION.
       FILE SECTION.
       FD CLIENTES.
       01 CLIENTS-REG.
           05 CLIENTES-CHAVE.
               10 CLIENTES-FONE PIC 9(09).
           05 CLIENTES-NOME     PIC X(30).
           05 CLIENTES-EMAIL    PIC X(40).


       WORKING-STORAGE SECTION.
       77 WRK-OPCAO    PIC X(1).
       77 WRK-MODULO   PIC X(25).
       77 WRK-TECLA    PIC X(1).
       77 CLIENTES-STATUS   PIC 9(02).

       SCREEN SECTION.
       01 TELA.
           05 LIMPA-TELA.
               10 BLANK SCREEN.
               10 LINE 01 COLUMN 01 PIC X(20) ERASE EOL
                   BACKGROUND-COLOR 3.
               10 LINE 01 COLUMN 25 PIC X(20)
      ********************* FOREGROUND-COLOR DEFINE A COR DA FONTE
                  BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
                  FROM 'SISTEMA DE CLIENTES'.
               10 LINE 02 COLUMN 01 PIC X(25) ERASE EOL
                   BACKGROUND-COLOR 1 FROM WRK-MODULO.

       01 MENU.
           05 LINE 07 COLUMN 15 VALUE '1 - INCLUIR'.
           05 LINE 08 COLUMN 15 VALUE '2 - CONSULTAR'.
           05 LINE 09 COLUMN 15 VALUE '3 - ALTERAR'.
           05 LINE 10 COLUMN 15 VALUE '4 - EXCLUIR'.
           05 LINE 11 COLUMN 15 VALUE '5 - RELATORIO'.
           05 LINE 12 COLUMN 15 VALUE 'X - SAIDA'.
           05 LINE 14 COLUMN 15 VALUE 'OPCAO: '.
           05 LINE 14 COLUMN 23 USING WRK-OPCAO.

       PROCEDURE DIVISION.
       0001-PRINCIPAL SECTION.
           PERFORM 1000-INICIAR.
           PERFORM 2000-PROCESSAR.
           PERFORM 3000-FINALIZAR.
           STOP RUN.

       1000-INICIAR.
      ***************** INPUT E OUTPUT
           OPEN I-O CLIENTES
               IF CLIENTES-STATUS = 35 THEN
                   OPEN OUTPUT CLIENTES
                   CLOSE CLIENTES
                   OPEN I-O CLIENTES
               END-IF.
           DISPLAY TELA.
           ACCEPT MENU.

       2000-PROCESSAR.
           EVALUATE WRK-OPCAO
               WHEN 1
                   PERFORM 5000-INCLUIR
               WHEN 2
                   CONTINUE
               WHEN 3
                   CONTINUE
               WHEN 4
                   CONTINUE
               WHEN 5
                   CONTINUE
               WHEN OTHER
                   IF WRK-OPCAO NOT EQUAL 'X'
                       DISPLAY 'ENTRE COM A OPCAO CORRETA'
                   END-IF
           END-EVALUATE.

       3000-FINALIZAR.
      ******************** FORCANDO O FECHAMENTO
           CLOSE CLIENTES.

       5000-INCLUIR.
           MOVE 'MODULO - INCLUSAO ' TO WRK-MODULO.
           DISPLAY TELA.
           ACCEPT WRK-TECLA AT 1620.
