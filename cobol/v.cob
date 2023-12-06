      *=================================================================
      * Author    :
      * Date      :
      * Purpose   :
      * Tectonics : cobc -x -j -O
      *=================================================================
      *>>SOURCE FORMAT FREE.
       IDENTIFICATION DIVISION.
        PROGRAM-ID.     v.
        AUTHOR.         Vilmar Catafesta.
        INSTALLATION.   Vilmar Catafesta.
        DATE-WRITTEN.   05/12/2023.
        DATE-COMPILED.  05/12/2023.
      *
      * PROJ DESC : SAMPLE COBOL PROGRAM TO DISPLAY EMPLOYEE
      *              NAME in SPOOL.
      *
      *=================================================================
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
        SPECIAL-NAMES.
         DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
      *
      *
       DATA DIVISION.
      *
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       77 black         pic 9 value 0.
       77 blue          pic 9 value 1.
       77 green         pic 9 value 2.
       77 cyan          pic 9 value 3.
       77 red           pic 9 value 4.
       77 magenta       pic 9 value 5.
       77 brown         pic 9 value 6.
       77 white         pic 9 value 7.
       77 cinza         pic 9 value 8.
       77 lightblue     pic 9 value 9.
       77 ligthgreen    pic 99 value 10.
       77 ligthcyan     pic 99 value 11.
       77 ligthred      pic 99 value 12.
       77 ligthmagenta  pic 99 value 13.
       77 yellow        pic 99 value 14.
       77 lightwhite    pic 99 value 15.

       01 COLOR-RED        PIC X(10) VALUE "\033[31m".
       01 COLOR-GREEN      PIC X(3) VALUE "32m".
       01 COLOR-YELLOW     PIC X(3) VALUE "33m".
       01 COLOR-RESET      PIC X(3) VALUE "0m".


       01 WRK-DATA.
           02 WRK-ANO PIC 9(04)  VALUE ZEROS.
           02 WRK-MES PIC 9(02)  VALUE ZEROS.
           02 WRK-DIA PIC 9(02)  VALUE ZEROS.

       01   WS-EMP-NAME.
            05 WS-FNAME PIC X(15) VALUE SPACE.
            05 FILLER   PIC X(01) VALUE SPACE.
            05 WS-LNAME PIC X(20) VALUE SPACE.

       01 WS-YR-MNTHS VALUE "JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ".
            05 WS-MNTH OCCURS 12 TIMES PIC X(3).

       01 WS-TEMP-REC.
            05 WS-DAYS OCCURS 07 TIMES.
                10 WS-HOURS OCCURS 24 TIMES.
                    15 WS-DAYS OCCURS 31 TIMES.
                        20 WS-TEMP PIC S9(3).

       01 WS-BOOKS.
            05 WS-BK-DTLS OCCURS 100 TIMES.
                10 WS-AUTHOR.
                    15 WS-FIRST-NAME PIC A(15).
                    15 WS-MID-NAME   PIC A(10).
                    15 WS-LAST-NAME  PIC A(10).
                10 WS-TITLE          PIC A(60).

       77 Var1  Pic 9999.
       77 Var2  Pic ZZZZ.
       77 Var3  Pic Z9999.
       77 Var4  Pic $$$$.
       77 Var5  Pic ZZZ.ZZ.
       77 Var6  Pic 999v99.
       77 Var7  Pic $999v99.

      *
      *
       PROCEDURE DIVISION.
      *
       0100-main.
           display "Copyright (c) 2023 Vilmar Catafesta"
                    " <vcatafesta@gmail.com>"
           display " "
           accept WRK-DATA from date YYYYMMDD.
           move 'VILMAR' to ws-fname.
           move 'CATAFESTA' to ws-lname.
           display "Entre com o valor : " with no advancing
           accept var1
           move var1 to var2 var3 var4 var5 var6 var7
           display "Nome :" ws-emp-name
           display "Data :" WRK-DIA"/"WRK-MES"/"WRK-ANO.
           display "var2 :" var2
           display "var3 :" var3
           display "var4 :" var4
           display "var5 :" var5
           display "var6 :" var6
           display "var7 :" var7
           goback.
       end program v.
