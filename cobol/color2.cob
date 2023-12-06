       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMPLE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       SOURCE-COMPUTER. IBM-ATX.
       OBJECT-COMPUTER. IBM-ATX.
       SPECIAL-NAMES.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 300-ACTIVE-SPACES VALUE SPACES.
           05 300-COMPANY-NAME PIC X(30).
           05 300-LAST-NAME PIC X(25).
           05 300-FIRST-NAME PIC X(15).
           05 300-MAIL-ADDRESS PIC X(30).


       SCREEN SECTION.

       01 CLEAR-SCREEN.
           05 BLANK SCREEN BACKGROUND-COLOR 6 FOREGROUND-COLOR 2.

       01 INPUT-SCREEN AUTO.
           05 BACKGROUND-COLOR 6 FOREGROUND-COLOR 5.
           05 LINE 6 COLUMN 22 VALUE IS 'COMPANY: '.
           05 COMPANY-NAME REVERSE-VIDEO PIC X(30)
           USING 300-COMPANY-NAME.
           05 LINE 7 COLUMN 20 VALUE IS 'LAST NAME: '.
           05 LAST-NAME REVERSE-VIDEO PIC X(25) USING 300-LAST-NAME.
           05 LINE 8 COLUMN 19 VALUE IS 'FIRST NAME: '.
           05 FIRST-NAME REVERSE-VIDEO PIC X(15)
           USING 300-FIRST-NAME.
           05 LINE 9 COLUMN 22 VALUE IS 'ADDRESS: '.
           05 MAIL-ADDRESS REVERSE-VIDEO PIC X(30)
           USING 300-MAIL-ADDRESS.


       PROCEDURE DIVISION.
       100-MAIN-MODULE.

       DISPLAY CLEAR-SCREEN.
       display "Enter your last name: " at 1010.
       accept 300-LAST-NAME at 1033.
       DISPLAY CLEAR-SCREEN.
       DISPLAY INPUT-SCREEN.
       ACCEPT INPUT-SCREEN.
           display "company name is: " 300-COMPANY-NAME upon console
       STOP RUN.

      * You could also code the Accept/Display statement like this:
      * another-way.
      * display "Enter your last name: " at 1010.
      * accept lastName at 1033.
      * display "Enter your first name: " at 1110.
      * accept firstName at 1133.
      * display "Enter your address: " at 1210.
      * accept mailing-address at 1233.
      * stop run.
