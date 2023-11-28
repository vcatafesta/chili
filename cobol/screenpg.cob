      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. screenpg.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77     WS-COR-BG  PIC 9(1) VALUE 0.
       77     WS-COR-FG  PIC 9(1) VALUE 7.
       77     WS-COR-FG1 PIC 9(1) VALUE 2.
       
       77     WS-DT-SISTEMA PIC X(06).
       01     WS-DATE.
              03 WS-ANO PIC X(02).
              03 WS-MES PIC X(02).
              03 WS-DIA PIC X(02).

       01     WS-FORMAT-DATE.
              03 WS-DIA PIC X(02).
              03 FILLER PIC X VALUE "/".
              03 WS-MES PIC X(02).
              03 FILLER PIC X(03) VALUE "/20".
              03 WS-ANO PIC X(02).

       01     WS-CADASTRO.
              03 WS-DT   PIC X(10).
              03 WS-DATA PIC X(10).
              03 WS-CODI PIC 9(06).
              03 WS-NOME PIC X(40).
              03 WS-ENDE PIC X(40).
              03 WS-CIDA PIC X(25).
              03 WS-ESTA PIC X(02).
              03 WS-SAIR PIC X(01).

       SCREEN SECTION.
       01     SCREEN-01.
              03 BLANK SCREEN BACKGROUND-COLOR WS-COR-BG.
              03 LINE 01 COLUMN 01 VALUE "BANCO MUNDIAL"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 LINE 01 COLUMN 62 VALUE "DATA"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L01C069 PIC X(10)
                 LINE 01 COLUMN 67 FROM WS-DT
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 LINE 02 COLUMN 30 VALUE
                 "FICHA DA CADASTRO"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
      ******************************************************************
              03 LINE 04 COLUMN 01 VALUE "DATA  :"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L04C015 PIC X(10)
                 LINE 04 COLUMN 15
                 USING WS-DATA
                 FOREGROUND-COLOR WS-COR-FG1 BACKGROUND-COLOR WS-COR-BG.
      ******************************************************************
              03 LINE 04 COLUMN 43 VALUE "CODIGO:"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L04C050 PIC 9(06)
                 LINE 04 COLUMN 50
                 USING WS-CODI
                 FOREGROUND-COLOR WS-COR-FG1 BACKGROUND-COLOR WS-COR-BG.
      ******************************************************************
              03 LINE 05 COLUMN 01 VALUE "NOME  :"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L05C015 PIC X(40)
                 LINE 05 COLUMN 15
                 USING WS-NOME
                 FOREGROUND-COLOR WS-COR-FG1 BACKGROUND-COLOR WS-COR-BG.
      ******************************************************************
              03 LINE 06 COLUMN 01 VALUE "ENDE  :"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L06C015 PIC X(40)
                 LINE 06 COLUMN 15
                 USING WS-ENDE
                 FOREGROUND-COLOR WS-COR-FG1 BACKGROUND-COLOR WS-COR-BG.
      ******************************************************************
              03 LINE 07 COLUMN 01 VALUE "CIDA  :"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L07C015 PIC X(25)
                 LINE 07 COLUMN 15
                 USING WS-CIDA
                 FOREGROUND-COLOR WS-COR-FG1 BACKGROUND-COLOR WS-COR-BG.
      ******************************************************************
              03 LINE 07 COLUMN 43 VALUE "ESTA :"
                 FOREGROUND-COLOR WS-COR-FG BACKGROUND-COLOR WS-COR-BG.
              03 WX-L07C050 PIC X(2)
                 LINE 07 COLUMN 50
                 USING WS-ESTA
                 FOREGROUND-COLOR WS-COR-FG1 BACKGROUND-COLOR WS-COR-BG.
                
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           ACCEPT WS-DT-SISTEMA FROM DATE
           MOVE 1 TO WS-CODI
           MOVE WS-DT-SISTEMA TO WS-DATE
           MOVE CORR WS-DATE TO WS-FORMAT-DATE
           MOVE WS-FORMAT-DATE TO WS-DT
           MOVE WS-FORMAT-DATE TO WS-DATA

           DISPLAY SCREEN-01
           ACCEPT  SCREEN-01
           GOBACK.

       END PROGRAM screenpg.
