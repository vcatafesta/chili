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
       01 WSEOF PIC A(1).

       PROCEDURE DIVISION.
        PERFORM 001-Main.
        PERFORM 002-Inclusao.
        PERFORM 003-Print.
        STOP RUN.
       
       001-Main.
           OPEN EXTEND CustomerFile.
               MOVE 1 TO IDNum.
               MOVE 'VILMAR' TO FirstName.
               MOVE 'CATAFESTA' TO LastName.
               WRITE CustomerData
               END-WRITE.
           CLOSE CustomerFile.
       
       002-Inclusao.
           OPEN EXTEND CustomerFile.
               DISPLAY "Customer ID         : " WITH NO ADVANCING
               ACCEPT IDNum
               DISPLAY "Customer First Name : " WITH NO ADVANCING
               ACCEPT FirstName
               DISPLAY "Customer Last Name  : " WITH NO ADVANCING
               ACCEPT LastName         
               WRITE CustomerData
               END-WRITE.
           CLOSE CustomerFile.

       003-Print.
           OPEN INPUT CustomerFile.
               PERFORM UNTIL WSEOF='Y'
                   READ CustomerFile INTO WSCustomer
                       AT END MOVE 'Y' TO WSEOF
                       NOT AT END DISPLAY WSCustomer
                   END-READ
               END-PERFORM
           CLOSE CustomerFile.
       
       END PROGRAM teste.
