      * io.cbl

       IDENTIFICATION DIVISION.
      *----------------------------------------------------------------
       PROGRAM-ID.
           io.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
      *----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       77 WSK-EMPREGADO         PIC X(100).
       01 WSK-REGISTRO.
          02 WKS-EMP-NOME       PIC X(61)       VALUE
      -   "VILMAR CATAFESTA".
          02 WKS-EMP-IDADE      PIC 9(02)       VALUE 53.
          02 WKS-EMP-SALARIO    PIC 9(05)V99    VALUE 5300.77.
      *----------------------------------------------------------------
       PROCEDURE DIVISION.
       00001-FN-MAIN SECTION.
       00001-FN-PARA.
           DISPLAY "NOME    :" WKS-EMP-NOME.
           DISPLAY "IDADE   :" WKS-EMP-IDADE.
           DISPLAY "SALARIO :" WKS-EMP-SALARIO.
           STOP 'PAUSA'.

       STOP RUN.
