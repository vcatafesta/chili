       IDENTIFICATION DIVISION.
       PROGRAM-ID. cep.
      * Programa que le os logradouros de Pimenta Bueno
      * buscando por um bairro especifico passado pelo jcl     
       ENVIRONMENT DIVISION.
      *-----------------------------------------------------------------
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT CEPS ASSIGN TO 'cep.txt'
               ORGANIZATION IS LINE SEQUENTIAL.            
      *-----------------------------------------------------------------           
       DATA DIVISION.
           FILE SECTION.
           FD CEPS
           DATA RECORD IS REG-CEPS.
           01 REG-CEPS.
               10 CEP          PIC X(08).
               10 TIPO         PIC X(03).
               10 LOGRADOURO   PIC X(40).
               10 BAIRRO       PIC X(29).
      *-----------------------------------------------------------------                 
       WORKING-STORAGE SECTION.
           01 CBAIRRO  PIC X(29) VALUE SPACES.
           01 WS-EOF   PIC X(01) VALUE 'N'.
           01 WS-SP    PIC X(01) VALUE SPACES.
           01 nConta   PIC 9(10) VALUE 0.           
           01 WS-MSG   PIC X(50) VALUE SPACES.           
      *-----------------------------------------------------------------           
       SCREEN SECTION.
       01 SS-TELA-MENSAGEM.
           05 BLANK SCREEN BACKGROUND-COLOR 04 FOREGROUND-COLOR 15.
           05 PIC X(50) FROM WS-MSG LINE 13 COLUMN 15.
      *-----------------------------------------------------------------           
       PROCEDURE DIVISION.
       Begin.
          MOVE "teste" TO WS-MSG.
          PERFORM fnMsg.
          DISPLAY "Busca Bairro".
          DISPLAY "Copyright(c) Macrosof Inforamtica Ltda".
          DISPLAY "ENTRE COM O BAIRRO : " WITH NO ADVANCING.
          ACCEPT CBAIRRO.
          OPEN INPUT CEPS.
          DISPLAY "PROCURANDO LOGRADOUROS DE : " CBAIRRO.
          DISPLAY WS-SP.
          READ CEPS AT END MOVE 'S' TO WS-EOF.
          PERFORM PROCESS-INIC THRU PROCESS-FIM UNTIL WS-EOF = 'S'.
          CLOSE CEPS.
          MOVE 0 TO RETURN-CODE.
          STOP RUN.
       
       fnMsg.
           Display SS-TELA-MENSAGEM.

       PROCESS-INIC.
           IF BAIRRO = CBAIRRO THEN
               ADD 1 TO nconta
               DISPLAY "ID     : " nconta
               DISPLAY "CEP    : " CEP
               DISPLAY "TIPO   : " TIPO
               DISPLAY "RUA    : " LOGRADOURO
               DISPLAY "BAIRRO : " BAIRRO
               DISPLAY WS-SP
           ELSE
               DISPLAY "NOT FOUND"
           END-IF.
           READ CEPS AT END MOVE 'S' TO WS-EOF.

       PROCESS-FIM.
       END PROGRAM cep.