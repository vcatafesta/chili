       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROGCOB04.
      **************************************************
      * AREA DE COMENTARIOS - REMARKS
      * AUTHOR = LUCAS  LRM
      * DATA   = 16/11/2020
      * OBJETIVO: RECEBER NOME E SAL�RIO
      * IMPRIMIR FORMATADO - USO DA V�RGULA
      **************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      * Definindo o ponto como v�rgula.
           DECIMAL-POINT IS COMMA. 
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 WRK-NOME           PIC X(20) VALUE SPACES.
      * V99
      * V = V�rgula
      * 99 quantidades de casas. = 02 casas. EX.: 000000,00
       77 WRK-SALARIO        PIC 9(06)V99 VALUE ZEROS.
      * Cont�m os 9 porque caso o n�mero seja 0 � necess�rio mostrar.
      * 9 ir� listar 0. Z ir� omitir os zeros.
       77 WRK-SALARIO-ED     PIC $ZZZ.ZZ9,99
       PROCEDURE DIVISION.
          ACCEPT WRK-NOME    FROM CONSOLE.
          ACCEPT WRK-SALARIO FROM CONSOLE.
      ************ MOSTRA DADOS
          DISPLAY 'NOME' WRK-NOME.
      * Movendo o valor de uma v�riavel para outra vari�vel.
          MOVE WRK-SALARIO TO WRK-SALARIO-ED.
          DISPLAY 'SALARIO' WRK-SALARIO.
          STOP RUN.