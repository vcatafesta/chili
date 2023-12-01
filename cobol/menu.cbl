      *menu.cbl
       IDENTIFICATION DIVISION.
       PROGRAM-ID. menu.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 opt  PIC 999     VALUE 99.
       01 I    PIC 999     VALUE 0.
       01 max  PIC 999     VALUE 20.
       01 cr   PIC X(9)    VALUE SPACES.
              
       PROCEDURE DIVISION.
           Begin.
               DISPLAY " Hello".
               PERFORM UNTIL 1 > 1
                      PERFORM MyMenu
               END-PERFORM.
               STOP RUN.
       
           MyMenu.
               CALL 'SYSTEM' USING 'clear'.
               DISPLAY " ".
               DISPLAY "         MENU".
               DISPLAY "===============================".
               DISPLAY "1. Show Odd  no.s from 1 to 21".
               DISPLAY "2. Show Even no.s from 2 to 22".
               DISPLAY "3. Display a message".
               DISPLAY "0. Quit".
               DISPLAY "===============================".
               DISPLAY " ".
               DISPLAY "OPCAO ==> " WITH NO ADVANCING.
               ACCEPT opt.

               IF opt = 1 THEN
                   MOVE 1 TO i
                   MOVE 21 TO max
                   PERFORM ShowTwos
               END-IF.
               IF opt = 2 THEN
                   MOVE 2 TO i
                   MOVE 22 TO max
                   PERFORM ShowTwos
               END-IF.
               IF opt = 3 THEN
                   MOVE 3 TO i
      *            CALL 'SYSTEM' USING 'clear'
                   DISPLAY "+-----------------------+"
                   DISPLAY "|  WELCOME TO COBOL     |"
                   DISPLAY "+-----------------------+"
               END-IF.
               IF opt = 0 THEN
                   DISPLAY 'Thanks for watching'
                   STOP RUN
               END-IF.
               DISPLAY "CR to continue..." WITH NO ADVANCING.
               ACCEPT cr.                   

           ShowTwos.
               PERFORM UNTIL i > max
                   DISPLAY i " " WITH NO ADVANCING
                   ADD 2 TO i
               END-PERFORM.
               DISPLAY " ".
                   
                          