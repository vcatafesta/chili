       program-id. Program1 as "mycob.Program1".
       author. Vilmar Catafesta.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
           SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       input-output section.
       file-control.
            select in-file
                assign to "filler.dat"
                organization is line sequential.
            select print-file
                assign to "filler.rpt"
                organization is line sequential.
       data division.
       file section.
       fd in-file
            record contains 33 characteres
            data record is tax-record.         
       01 tax-record.
            05 tax-name pic x(20).
            05 province-code pic x(2).
            05 gross-salary pic 9(6).
            05 exemption-amount pic 9(5).
       fd print-line.
            
       working-storage section.
       77 preto     pic 9 value 0.
       77 azul      pic 9 value 1.
       77 verde     pic 9 value 2.
       77 ciano     pic 9 value 3.
       77 vermelho  pic 9 value 4.
       77 magenta   pic 9 value 5.
       77 amarelo   pic 9 value 6.
       77 branco    pic 9 value 7.
       77 cinza     pic 9 value 8.

       01 emp-record.
         02 empno   pic 99.
         02 ename   pic A(15).
         02 job     pic X(10).
         02 salary  pic 999.99 value zeros.
          
       01 heading1.
         02 filler  pic X(30) value spaces.
         02 filler  pic X(18) value "ADICIONAR REGISTRO".
         02 filler  pic X(35) value spaces.

       01 line-draw.
         02 cabec   pic x(1) value "=" occurs 80 times.

       screen section.
       01 screen-heading1 foreground-color amarelo
            background-color preto.
         02 filler  value "CADASTRO DE FUNCIONARIO" line 2 col 30.

       01 data-entry-screen1 foreground-color verde
            background-color preto.
         02 filler  value "Reg#     :" line 5 col 15.
         02 filler  value "Nome     :" line 6 col 15.
         02 filler  value "Job      :" line 7 col 15.
         02 filler  value "Salary   :" line 8 col 15.

       procedure division.
       proc-1.
           display screen-heading1.
           display data-entry-screen1.
           accept empno  line 5 col 26.
           accept ename  line 6 col 26.
           accept job    line 7 col 26.
           accept salary line 8 col 26.
           stop run.

       end program Program1.
