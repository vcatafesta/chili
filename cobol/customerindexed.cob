       >>SOURCE FORMAT FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. customerindexed.
       AUTHOR. VILMAR CATAFESTA.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CustomerFile ASSIGN TO "customer.dat"
                         ORGANIZATION IS INDEXED
                         ACCESS MODE  IS RANDOM
                         RECORD KEY   IS IDNum
                         FILE STATUS  IS TEMP-ST.
       DATA DIVISION.
       FILE SECTION.
       FD CustomerFile.
       01 CustomerData.
            02 IDNum     pic 99.
            02 FirstName pic x(15).
            02 LastName  pic x(15).

       WORKING-STORAGE SECTION.
       01 Choice     pic 9.
       01 StayOpen   pic x value 'Y'.
       01 CustExists pic x.
       01 RUNDATA-FS pic 99.

       PROCEDURE DIVISION.
       001-Main.
            perform 001-menu.
            stop run.

       001-menu.
            Perform openDatabase.
            Perform Until StayOpen='N'
                Display ' '
                Display "CUSTOMER RECORDS"
                Display "----------------"
                Display "1 - Add Customer"
                Display "2 - Delete Customer"
                Display "3 - Update Customer"
                Display "4 - Get Customer"
                Display "0 - Quit"
                Display ' '
                Display "Choice : " WITH NO ADVANCING
                Accept Choice
                Evaluate Choice
                    When 1 Perform AddCust
                    When 2 Perform DeleteCust
                    When 3 Perform UpdateCust
                    When 4 Perform GetCust
                    When Other move 'N' to StayOpen
                End-Evaluate
            End-Perform.
            Perform closeDatabase.
            Stop Run.
              
openDatabase.
    Open I-O CustomerFile.
    if RUNDATA-FS not equal to 0
        display "** ERROR ** not able to open customefile file **"
        go to closeDatabase
    end-if.

closeDatabase.         
    Close CustomerFile.
    if RUNDATA-FS not equal to 0
        display "** ERROR ** unable to cloe customefile file **"
        
    end-if.

AddCust.
    Display ' '
    Display "ID        : " with no advancing Accept IDNum
    Display "FirstName : " with no advancing Accept FirstName
    Display "LastName  : " with no advancing Accept LastName
    Write CustomerData
        Invalid Key Display "ID Taken"
    End-Write.

DeleteCust.
    Display ' '
    Display "ID        : " with no advancing Accept IDNum
    Delete CustomerFile
        Invalid Key display "Key Doesn't exist"
    End-Delete.

UpdateCust.
    move 'Y' to CustExists
    display ' '
    display "ID        : " With No Advancing Accept IDNum
    read CustomerFile
        invalid key move 'N' to CustExists
    end-read
    if CustExists='N'
        display "Customer Doesn't exist"
    else
        display "ID        : " with no advancing accept IDNum
        display "FirstName : " with no advancing accept FirstName
        display "LastName  : " with no advancing accept LastName
    end-if
    rewrite CustomerData
        invalid key display 'Customer not updated'
    end-rewrite.

GetCust.   
    move 'Y' to CustExists
    display ' '
    display "ID        : " With No Advancing Accept IDNum
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
