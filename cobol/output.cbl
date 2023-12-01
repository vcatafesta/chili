       IDENTIFICATION DIVISION.
       PROGRAM-ID. OUTPUTE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT STUDENT ASSIGN TO 'input.txt'
               ORGANIZATION IS INDEXED
               ACCESS IS RANDOM
               RECORD KEY IS STUDENT-ID
               FILE STATUS IS FS.

       DATA DIVISION.
          FILE SECTION.
          FD STUDENT.
             01 STUDENT-FILE.
             05 STUDENT-ID PIC 9(5).
             05 NAME PIC A(25).
            
          WORKING-STORAGE SECTION.
          01 WS-STUDENT.
             05 WS-STUDENT-ID PIC 9(5).
             05 WS-NAME PIC A(25).
       
       PROCEDURE DIVISION.
          OPEN INPUT STUDENT.
             MOVE 20005 TO STUDENT-ID.
             
             READ STUDENT RECORD INTO WS-STUDENT-FILE
                KEY IS STUDENT-ID
                INVALID KEY DISPLAY 'Invalid Key'
                NOT INVALID KEY DISPLAY WS-STUDENT-FILE
             END-READ.
             
          CLOSE STUDENT.
       STOP RUN.    