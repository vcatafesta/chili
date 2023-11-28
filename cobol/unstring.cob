      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UnstringCob.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77 WS-POINTER       PIC 9(02) VALUES ZEROS.
       77 WS-CONTADOR-1    PIC 9(02) VALUES ZEROS.
       77 WS-CONTADOR-2    PIC 9(02) VALUES ZEROS.
       77 WS-CONTADOR-3    PIC 9(02) VALUES ZEROS.
       77 WS-NOME-COMPLETO PIC X(60) VALUES SPACES.
       77 WS-PRIMEIRO-NOME PIC X(40) VALUES SPACES.
       77 WS-SEGUNDO-NOME  PIC X(20) VALUES SPACES.
       77 WS-ULTIMO-NOME   PIC X(20) VALUES SPACES.
       77 WS-TOT-CHARS     PIC 9(02) VALUES ZEROS.
       77 WS-COUNT         PIC 9(02) VALUES ZEROS.
       PROCEDURE DIVISION.
       main.
           INITIALIZE
                   WS-POINTER
                   WS-CONTADOR-1
                   WS-CONTADOR-2
                   WS-CONTADOR-3
                   WS-NOME-COMPLETO
                   WS-PRIMEIRO-NOME
                   WS-SEGUNDO-NOME
                   WS-ULTIMO-NOME

           MOVE "EVILI FRANCIELE DA SILVA SOARES CATAFESTA"
               TO WS-NOME-COMPLETO
           MOVE 1 TO WS-COUNT

           UNSTRING WS-NOME-COMPLETO
              INTO WS-PRIMEIRO-NOME
                    WS-SEGUNDO-NOME
                    WS-ULTIMO-NOME
              WITH POINTER WS-COUNT
              TALLYING IN WS-TOT-CHARS
           END-UNSTRING.

           DISPLAY "1st:" WS-PRIMEIRO-NOME
           DISPLAY "2st:" WS-SEGUNDO-NOME
           DISPLAY "3st:" WS-ULTIMO-NOME
           DISPLAY "3st:" WS-COUNT
           DISPLAY "3st:" WS-TOT-CHARS

           STOP RUN.
       END PROGRAM UnstringCob.
