      ************************
      * Author: Bruno Harnik *
      * Purpose: Time Travel *
      ************************
       IDENTIFICATION DIVISION.
           PROGRAM-ID. BOLINHO.
           AUTHOR. Bruno Harnik.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQUIVO-ESTOQUE ASSIGN TO DISK
           ORGANIZATION        IS INDEXED
           ACCESS MODE         IS DYNAMIC
           RECORD KEY          IS SKU
           ALTERNATE RECORD KEY    IS NOME WITH DUPLICATES
           FILE STATUS             IS WS-STATUS-ARQUIVO.

           SELECT ARQUIVO-MARGEM ASSIGN TO DISK
           ORGANIZATION        IS INDEXED
           ACCESS MODE         IS DYNAMIC
           RECORD KEY          IS SKU-MARGEM
           ALTERNATE RECORD KEY    IS MARGEM WITH DUPLICATES
           FILE STATUS             IS WS-STATUS-ARQUIVO-MARGEM.
       
       DATA DIVISION.
       FILE SECTION.
       FD ARQUIVO-ESTOQUE
           LABEL RECORDS ARE STANDARD
           VALUE OF FILE-ID IS "ESTOQUE.DAT".
           01 PRODUTO.
               05 SKU              PIC 9(04).
               05 NOME             PIC X(30).
               05 VALIDADE.
                   10 DIA          PIC 99.
                   10 MES          PIC 99.
                   10 ANO          PIC 9(04).
               05 VALOR-CUSTO      PIC 9(04)V99.
               05 VALOR-VENDA      PIC 9(04)V99.
               05 QTD-ESTOQUE      PIC 9(04).

       FD ARQUIVO-MARGEM
           LABEL RECORDS ARE STANDARD
           VALUE OF FILE-ID IS "MARGEM.DAT".
           01 PRODUTO-MARGEM.
               05 SKU-MARGEM              PIC 9(04).
               05 MARGEM                  PIC 9(04)V99.

       WORKING-STORAGE SECTION.
           77 WS-STATUS-ARQUIVO            PIC X(02).
           77 WS-STATUS-ARQUIVO-MARGEM     PIC X(02).
           77 WS-MENSAGEM                  PIC X(50) VALUE SPACES.
           77 WS-TEMPORIZADOR              PIC 9(05) VALUE ZEROS.
           77 WS-CODIGO-ESC                PIC X(02).
           
           77 WS-CHAVE-VALIDACAO           PIC X VALUE "N".
               88 WS-CHAVE-VALIDACAO-SIM         VALUE "N".
               88 WS-CHAVE-VALIDACAO-NAO         VALUE "S".

           77 WS-ANO-RESTO                 PIC 9.
           77 WS-ANO-DIVISAO               PIC 9(04).

       SCREEN SECTION.
       01 TELA-MENSAGEM.
           05 BLANK SCREEN BACKGROUND-COLOR 04 FOREGROUND-COLOR 15.
           05 PIC X(50) FROM WS-MENSAGEM LINE 13 COLUMN 15.
       
       01 TELA-MENU-PRINCIPAL.
           05 BLANK SCREEN BACKGROUND-COLOR 03 FOREGROUND-COLOR 00.
           05 VALUE "*----------------------------*" LINE 02 COLUMN 25.
           05 VALUE "|  .~~~O~~~.                 |" LINE 03 COLUMN 25.
           05 VALUE "| (         )   Bomboniere   |" LINE 04 COLUMN 25.
           05 VALUE "|  \  ~~~  /    Bolinho      |" LINE 05 COLUMN 25.
           05 VALUE "|   \_____/                  |" LINE 06 COLUMN 25.
           05 VALUE "*----------------------------*" LINE 07 COLUMN 25.
           05 VALUE "Escolha com a letra destacada:" LINE 10 COLUMN 25.
           05 VALUE "C" FOREGROUND-COLOR 15          LINE 12 COLUMN 20.
           05 VALUE "adastrar novo produto"          LINE 12 COLUMN 21.
           05 VALUE "R" FOREGROUND-COLOR 15          LINE 13 COLUMN 20.
           05 VALUE "emover registro de produto"     LINE 13 COLUMN 21.
           05 VALUE "E" FOREGROUND-COLOR 15          LINE 14 COLUMN 20.
           05 VALUE "ditar registro de produto"      LINE 14 COLUMN 21.
           05 VALUE "A" FOREGROUND-COLOR 15          LINE 15 COLUMN 20.
           05 VALUE "valiar estoque"                 LINE 15 COLUMN 21.
           05 VALUE "M" FOREGROUND-COLOR 15          LINE 16 COLUMN 20.
           05 VALUE "ostrar lista completa"          LINE 16 COLUMN 21.
           05 VALUE "S" FOREGROUND-COLOR 15          LINE 17 COLUMN 20.
           05 VALUE "air"                            LINE 17 COLUMN 21.
           05 PIC X TO WS-CODIGO-ESC LINE 20 COLUMN 60 AUTO.

       01 TELA-SAIDA.
           05 BLANK SCREEN BACKGROUND-COLOR 07 FOREGROUND-COLOR 15.
           05 VALUE "Deseja realmente sair?"         LINE 10 COLUMN 29.
           05 VALUE "Enter ou Tab - "                LINE 12 COLUMN 30.
           05 VALUE "Sair"     FOREGROUND-COLOR 14   LINE 12 COLUMN 45.
           05 VALUE "Esc - "                         LINE 14 COLUMN 28.
           05 VALUE "Voltar ao programa"  FOREGROUND-COLOR 14
                                                     LINE 14 COLUMN 34.
           05 PIC XX TO WS-CODIGO-ESC LINE 20 COLUMN 60 AUTO.

       01 TELA-CADASTRO.
           05 BLANK SCREEN BACKGROUND-COLOR 03 FOREGROUND-COLOR 00.
           05 VALUE "Cadastro de produto no estoque" LINE 02 COLUMN 25.
           05 VALUE "___________________________________________________
                    "_____________________________"  LINE 03 COLUMN 01.
           05 VALUE "Nome do produto:"               LINE 06 COLUMN 12.
           05 PIC X(30) USING NOME FOREGROUND-COLOR 14 
                                                     LINE 06 COLUMN 29.
           05 VALUE "Data de validade:"              LINE 09 COLUMN 11.
           05 PIC 99 USING DIA FOREGROUND-COLOR 14
                                                     LINE 09 COLUMN 29.
           05 VALUE "/"                              LINE 09 COLUMN 31.
           05 PIC 99 USING MES FOREGROUND-COLOR 14  
                                                     LINE 09 COLUMN 32.
           05 VALUE "/"                              LINE 09 COLUMN 34.
           05 PIC 9999 USING ANO FOREGROUND-COLOR 14
                                                     LINE 09 COLUMN 35.
           05 VALUE "Valor de custo:"                LINE 12 COLUMN 13.
           05 PIC 9(04)V99 USING VALOR-CUSTO FOREGROUND-COLOR 14
                                                     LINE 12 COLUMN 29.
           05 VALUE "Valor de venda:"                LINE 15 COLUMN 13.
           05 PIC 9(04)V99 USING VALOR-VENDA FOREGROUND-COLOR 14
                                                     LINE 15 COLUMN 29.
           05 VALUE "Quantidade em estoque:"         LINE 18 COLUMN 06.
           05 PIC 9(04) USING QTD-ESTOQUE FOREGROUND-COLOR 14
                                                     LINE 18 COLUMN 29.

       PROCEDURE DIVISION.
      *************************
      * Parágrafos Principais *
      *************************
       P-ABERTURA-ARQUIVO-ESTOQUE.
           OPEN I-O ARQUIVO-ESTOQUE
           IF WS-STATUS-ARQUIVO NOT = "00"
               IF WS-STATUS-ARQUIVO = "30"
                   OPEN OUTPUT ARQUIVO-ESTOQUE
                   MOVE "Arquivo de estoque sendo criado..."
                       TO WS-MENSAGEM
                   PERFORM P-MSG-ZERA THRU P-MSG-FIM
                   CLOSE ARQUIVO-ESTOQUE
                   GO TO P-ABERTURA-ARQUIVO-ESTOQUE
               ELSE
                   MOVE "Erro na abertura do arquivo de estoque..."
                       TO WS-MENSAGEM
                   PERFORM P-MSG-ZERA THRU P-MSG-FIM
                   GO TO P-FIM-EXIT.

       P-ABERTURA-ARQUIVO-MARGEM.
           OPEN I-O ARQUIVO-MARGEM
           IF WS-STATUS-ARQUIVO-MARGEM NOT = "00"
               IF WS-STATUS-ARQUIVO-MARGEM = "30"
                   OPEN OUTPUT ARQUIVO-MARGEM
                   MOVE "Arquivo de margens sendo criado..." 
                       TO WS-MENSAGEM
                   PERFORM P-MSG-ZERA THRU P-MSG-FIM
                   CLOSE ARQUIVO-MARGEM
                   GO TO P-ABERTURA-ARQUIVO-MARGEM
               ELSE
                   MOVE "Erro na abertura do arquivo de margens..."
                       TO WS-MENSAGEM
                   PERFORM P-MSG-ZERA THRU P-MSG-FIM
                   GO TO P-FIM-EXIT.
       
       P-MENU-PRINCIPAL.
           
           DISPLAY TELA-MENU-PRINCIPAL
           ACCEPT TELA-MENU-PRINCIPAL.

           IF WS-CODIGO-ESC = "C" OR "c"
               PERFORM P-CAD-ZERA-VARS THRU P-CAD-DISPLAY
           ELSE IF WS-CODIGO-ESC = "S" OR "s"
               GO TO P-FIM-CONFIRMACAO
           ELSE
               MOVE "Opcao invalida!" TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM.
           GO TO P-MENU-PRINCIPAL.
               
      **************************
      * Parágrafos de cadastro *
      **************************
       P-CAD-ZERA-VARS.
           MOVE SPACES TO NOME
           MOVE ZEROS TO SKU VALIDADE VALOR-CUSTO VALOR-VENDA
               QTD-ESTOQUE.

       P-CAD-DISPLAY.
           DISPLAY TELA-CADASTRO
           ACCEPT TELA-CADASTRO.

           PERFORM P-VALIDA-FORM
           IF WS-CHAVE-VALIDACAO = "N" GO TO P-CAD-DISPLAY.
       
       P-CAD-SUCESSO.
           MOVE "Registro gravado com sucesso!" TO WS-MENSAGEM
           PERFORM P-MSG-ZERA THRU P-MSG-FIM.

       P-CAD-SAIDA.
           EXIT.
       
      ***************************
      * Parágrafos de Validação *
      ***************************
       P-VALIDA-FORM.
           
           MOVE "S" TO WS-CHAVE-VALIDACAO

           IF NOME EQUAL SPACES
               MOVE "Erro: preencha o nome." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.

           IF DIA EQUAL ZEROS
               MOVE "Erro: preencha o dia." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.
           
           IF MES EQUAL ZEROS
               MOVE "Erro: preencha o mes." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.
           
           IF ANO EQUAL ZEROS
               MOVE "Erro: preencha o ano." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.
           
           IF VALOR-CUSTO EQUAL ZEROS
               MOVE "Erro: preencha o valor de custo." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.
           
           IF VALOR-VENDA EQUAL ZEROS
               MOVE "Erro: preencha o valor de venda." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.
           
           IF MES > 12
               MOVE "Erro: o ano tem no maximo 12 meses." TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.

           IF (MES = 01 OR
               MES = 03 OR
               MES = 05 OR
               MES = 07 OR
               MES = 08 OR
               MES = 10 OR
               MES = 12) AND
               DIA > 31
               MOVE "Erro: esse mes tem no maximo 31 dias."
                   TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.

           IF (MES = 04 OR
               MES = 06 OR
               MES = 09 OR
               MES = 11) AND
               DIA > 30
               MOVE "Erro: esse mes tem no maximo 30 dias."
                   TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.

            DIVIDE ANO BY 4 GIVING WS-ANO-DIVISAO REMAINDER WS-ANO-RESTO

            IF MES = 02 AND
               WS-ANO-RESTO = 0 AND
               DIA > 29
               MOVE "Erro: esse mes tem no maximo 29 dias."
                   TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.

            IF MES = 02 AND
               WS-ANO-RESTO NOT = 0 AND
               DIA > 28
               MOVE "Erro: esse mes tem no maximo 28 dias."
                   TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               MOVE "N" TO WS-CHAVE-VALIDACAO.

            
                   

      **************************
      * Parágrafos de mensagem *
      **************************
       P-MSG-ZERA.
           MOVE ZEROS TO WS-TEMPORIZADOR.

       P-MSG-DISPLAY.
           DISPLAY TELA-MENSAGEM.

       P-MSG-TEMPO.
           ADD 1 TO WS-TEMPORIZADOR
           IF WS-TEMPORIZADOR < 2500
               GO TO P-MSG-TEMPO.

       P-MSG-FIM.
           MOVE SPACES TO WS-MENSAGEM
           EXIT.
           
      *****************************
      * Parágrafos de Finalização *
      *****************************
       P-FIM-CONFIRMACAO.
           DISPLAY TELA-SAIDA
           ACCEPT TELA-SAIDA
           ACCEPT WS-CODIGO-ESC FROM ESCAPE KEY
           IF WS-CODIGO-ESC = 00
               GO TO P-FIM-FECHA-ARQUIVOS
           ELSE IF WS-CODIGO-ESC = 01
               GO TO P-MENU-PRINCIPAL
           ELSE
               MOVE "Opcao invalida!" TO WS-MENSAGEM
               PERFORM P-MSG-ZERA THRU P-MSG-FIM
               GO TO P-FIM-CONFIRMACAO.

       P-FIM-FECHA-ARQUIVOS.
           CLOSE ARQUIVO-ESTOQUE
           CLOSE ARQUIVO-MARGEM.

       P-FIM-EXIT.
           EXIT PROGRAM.

       P-FIM-STOP-RUN.
           STOP RUN.