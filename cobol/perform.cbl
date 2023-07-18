       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORM1.
       ENVIRONMENT DIVISION.
       DATA DIVISION.

      *------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 WS-COUNTER PIC 9.

      *------------------------------------------------------
       PROCEDURE DIVISION.
       MAINLINE SECTION.
       START-UP.
               PERFORM INIT-SECT
               PERFORM LOOP-SECT UNTIL WS-COUNTER > 4
               PERFORM END-PARA
               STOP 'Press <CR> to stop'
               STOP RUN.
      *------------------------------------------------------
       INIT-SECT SECTION.
       INIT-PARA.
           DISPLAY "IN INIT PARA"
           MOVE ZERO TO WS-COUNTER.
       INIT-EXIT.
           EXIT.
      *------------------------------------------------------
       LOOP-SECT SECTION.
       LOOP-PARA.
           ADD 1 TO WS-COUNTER
           DISPLAY "DOING LOOP PARA...." WS-COUNTER.
       LOOP-EXIT.
           EXIT.
      *------------------------------------------------------
       END-SECT SECTION.
       END-PARA.
           DISPLAY "IN END PARA - STOPPING".
       END-EXIT.
           EXIT.
