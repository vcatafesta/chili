      ******************************************************************
      * Author: Vilmar Catafesta.
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. loop.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77 WS-CONT          PIC 9(2) VALUE ZEROS.
       77 WS-VAR           PIC X(10) VALUE 'VILMAR'.
       01 WS-VAR-DATA      PIC X(100) VALUE SPACES.
       01 WS-VAR-LENGTH    PIC 9(3)  VALUE 10.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM 10 TIMES
               ADD 1 TO WS-CONT
               DISPLAY 'TESTE-' WS-CONT
           END-PERFORM

           initialize WS-CONT
           PERFORM UNTIL WS-CONT > 10
               ADD 1 TO WS-CONT
               DISPLAY 'TESTE-' WS-CONT
           END-PERFORM

           MOVE 0 TO WS-CONT
           PERFORM VARYING WS-CONT FROM 1 BY 1 UNTIL WS-CONT > 40
               ADD 1 TO WS-CONT
               DISPLAY WS-VAR '-VARYING-' WS-CONT
           END-PERFORM

           MOVE 'VILMAR' TO WS-VAR-DATA
           DISPLAY 'Valor original: ' WS-VAR-DATA

           MOVE 15 TO WS-VAR-LENGTH
           DISPLAY 'Novo tamanho: ' WS-VAR-LENGTH

           MOVE 'NOVO VALOR' TO WS-VAR-DATA(1:WS-VAR-LENGTH)
           DISPLAY 'Novo valor: ' WS-VAR-DATA


           DISPLAY "Hello world"
           STOP RUN.
       END PROGRAM loop.
