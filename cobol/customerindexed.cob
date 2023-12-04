       >>SOURCE FORMAT FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. customerindexed.
       AUTHOR. VILMAR CATAFESTA.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CustomerFile ASSIGN TO "customer.dat"
              ORGANIZATION IS INDEXED
              ACCESS MODE IS RANDOM
              RECORD KEY IS IDNum.
       DATA DIVISION.
       FILE SECTION.
       FD CustomerFile.
       01 CustomerData.
            02 IDNum     PIC 99.
            02 FirstName PIC X(15).
            02 LastName  PIC X(15).

       WORKING-STORAGE SECTION.
       01 Choice PIC 9.
       01 StayOpen PIC X VALUE 'Y'.
       01 CustExists PIC X.

       PROCEDURE DIVISION.
       001-Main.
           OPEN I-O CustomerFile.
           PERFORM UNTIL StayOpen='N'
           DISPLAY ' '
           DISPLAY "CUSTOMER RECORDS"
           DISPLAY "1 - Add Customer"
           DISPLAY "2 - Delete Customer"
           DISPLAY "3 - Update Customer"
           DISPLAY "4 - Get Customer"
           DISPLAY "0 - Quit"
           DISPLAY ' '
           DISPLAY "Choice : " WITH NO ADVANCING
           accept Choice
           EVALUATE Choice
                WHEN 1 perform AddCust
                WHEN 2 perform DeleteCust
                WHEN 3 perform UpdateCust
                WHEN 4 perform GetCust
                WHEN OTHER move 'N' to StayOpen
           END-EVALUATE
           end-perform.
           CLOSE CustomerFile.
           stop run.
       
AddCust.
    display ' '
    display "ID        : " with no advancing.
    accept IDNum.
    display "FirstName : " with no advancing.
    accept FirstName.
    display "LastName  : " with no advancing.
    accept LastName.
    write CustomerData
        invalid key display "ID Taken"
    end-write.

DeleteCust.
    display ' '
    display "ID        : " with no advancing.
    accept IDNum.
    delete CustomerFile
        invalid key display "Key Doesn't exist"
    end-delete.

UpdateCust.
    move 'Y' to CustExists
    display ' '
    display "ID        : " with no advancing
    accept IDNum
    read CustomerFile
        invalid key move 'N' to CustExists
    end-read
    if CustExists='N'
        display "Customer Doesn't exist"
    else
        display "ID        : " with no advancing
        accept IDNum
        display "FirstName : " with no advancing
        accept FirstName
        display "LastName  : " with no advancing
        accept LastName
    end-if
    rewrite CustomerData
        invalid key display 'Customer not updated'
    end-rewrite.

GetCust.   
    move 'Y' to CustExists
    display ' '
    display "ID        : " with no advancing
    accept IDNum
    read CustomerFile
        invalid key move 'N' to CustExists
    end-read
    if CustExists='N'
        display "Customer Doesn't exist"
    else
        display "ID        : " IDNum
        display "FirstName : " FirstName
        display "LastName  : " LastName
    end-if.
