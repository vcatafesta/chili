       >>SOURCE FORMAT FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. customer.
       AUTHOR. VILMAR CATAFESTA.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CustomerFile ASSIGN TO "customer.txt"
              ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CustomerReport assign to 'customer.rpt'
              ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD CustomerReport.
       01 PrintLine pic x(44).
       
       FD CustomerFile.
       01 CustomerData.
           02 IDNum PIC 9(8).
           02 CustName.
               03 FirstName PIC X(15).
               03 LastName PIC X(15).
           88 WS-EOF value HIGH-VALUE.    

       WORKING-STORAGE SECTION.
       01 PageHeading.
           02 filler pic x(13) value "Customer List".
       01 PageFooting.
           02 filler pic x(15) value spaces.
           02 filler pic x(7) value "Page :".
           02 PrnPageNum pic Z9.
       01 Heads pic x(36) value "IDNum   FirstName   LasName".     
       01 CustomerDetailLine.
           02 filler pic x value spaces.
           02 PrnCustID pic 9(5).
           02 filler pic x(4) value spaces.
           02 PrnFirstName pic x(15).
           02 filler pic XX value spaces.
           02 PrnLastName pic x(15).        
       01 ReportFooting pic X(13) value "END OF REPORT".
       01 LineCount pic 99 value zeros.
           88 NewPageRequired value 40 thru 99.
       01 PageCount pic 99 value zeros.
           
       01 WSCustomer.
           02 WSIDNum PIC 9(8).
           02 WSCustName.
               03 WSFirstName PIC X(15).
               03 WSLastName PIC X(15).
       01 WSEOF PIC A(1).

       PROCEDURE DIVISION.
            PERFORM 001-Main.
            PERFORM 002-Inclusao.
            PERFORM 003-Listagem.
            PERFORM 004-Print.
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

       003-Listagem.
            OPEN INPUT CustomerFile.
                PERFORM UNTIL WSEOF='Y'
                    READ CustomerFile INTO WSCustomer
                        AT END MOVE 'Y' TO WSEOF
                        NOT AT END DISPLAY WSCustomer
                    END-READ
                END-PERFORM
            CLOSE CustomerFile.

       004-Print.
           OPEN INPUT CustomerFile.
           OPEN OUTPUT CustomerReport.
           perform PrintPageHeading
           read CustomerFile
                at end
                set WS-EOF to TRUE
            end-read
            perform PrintReportBody until WS-EOF
            write PrintLine From ReportFooting after advancing
                5 lines 
            CLOSE CustomerFile.
            CLOSE CustomerReport.
            STOP RUN.
       

       PrintPageHeading.
            write PrintLine from PageHeading after advancing Page
            write PrintLine from Heads after advancing 5 lines
            move 3 to LineCount
            add 1 to PageCount.

       PrintReportBody.
            if NewPageRequired
                move PageCount to PrnPageNum
                write PrintLine from PageFooting after
                advancing 5 lines
                perform PrintPageHeading
            end-if
            move IDNum to PrnCustID
            move FirstName to PrnFirstName
            write PrintLine from CustomerDetailLine after
                advancing 1 line
            add 1 to LineCount
            read CustomerFile
                at end set WS-EOF to TRUE
            end-read.

       END PROGRAM customer.
