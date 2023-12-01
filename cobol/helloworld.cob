      *=================================================================
      * Author    :
      * Date      :
      * Purpose   :
      * Tectonics : cobc -x -j -O
      *=================================================================
      *>>SOURCE FORMAT FREE.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       AUTHOR. VILMAR CATAFESTA.
      *=================================================================
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
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

       01 NR1 PIC +ZZZ9.
       01 NR2 PIC +9999.
       01 NR3 PIC S9999.
       01 WRK-DATA.
           02 WRK-ANO PIC 9(04)  VALUE ZEROS.
           02 WRK-MES PIC 9(02)  VALUE ZEROS.
           02 WRK-DIA PIC 9(02)  VALUE ZEROS.

       PROCEDURE DIVISION.
       0100-start-here.
           display "Hello World!".
           MOVE 2      TO NR1
           MOVE 3      TO NR2
           MOVE 2023   TO NR3
           DISPLAY NR1
           DISPLAY NR2
           DISPLAY NR3
           ACCEPT WRK-DATA FROM DATE YYYYMMDD.
           DISPLAY 'DATA ' WRK-DIA ' DE ' WRK-MES ' DE ' WRK-ANO.
           STOP RUN.
       END PROGRAM YOUR-PROGRAM-NAME.
