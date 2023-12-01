      *teste.cbl
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-MESSAGE PIC A(20) VALUE SPACES.
       01 WS-NAME    PIC A(20) VALUE SPACES.
              
       PROCEDURE DIVISION.
      * THE-ONLY SECTION.
      * THE-ONLY-PARAGRAPH.
           MOVE 'Hello world' to WS-MESSAGE.  display WS-MESSAGE.
           display 'Please enter your name:'. accept ws-name.
           display 'Nice to meet you, ' ws-name.
           move 'Goodbye' to WS-MESSAGE.      display ws-message.
           stop 'Press <CR> to stop'.
           STOP RUN.

               
