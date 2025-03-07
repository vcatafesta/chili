       >>SOURCE FORMAT FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. teste.
       AUTHOR. VILMAR CATAFESTA.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CustomerFile ASSIGN TO "customer.dat"
              ORGANIZATION IS LINE SEQUENTIAL
              ACCESS IS SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD CustomerFile.
       01 CustomerData.
           02 IDNum PIC 9(8).
           02 CustName.
               03 FirstName PIC X(15).
               03 LastName PIC X(15).

       WORKING-STORAGE SECTION.
       01 WSCustomer.
           02 WSIDNum PIC 9(8).
           02 WSCustName.
               03 WSFirstName PIC X(15).
               03 WSLastName PIC X(15).

       PROCEDURE DIVISION.
       001-Main.
           OPEN OUTPUT CustomerFile.
               MOVE 1 TO IDNum.
               MOVE 'VILMAR' TO FirstName.
               MOVE 'CATAFESTA' TO LastName.
               WRITE CustomerData
               END-WRITE.
           CLOSE CustomerFile.
           PERFORM 002-Inclusao.

       002-Inclusao.
           OPEN EXTEND CustomerFile.
               DISPLAY "Customer ID " WITH NO ADVANCING
               ACCEPT IDNum
               DISPLAY "Customer First Name " WITH NO ADVANCING
               ACCEPT FirstName
               DISPLAY "Customer Last Name " WITH NO ADVANCING
               ACCEPT LastName
               WRITE CustomerData
               END-WRITE.
           CLOSE CustomerFile.
           STOP RUN.


       END PROGRAM teste.
