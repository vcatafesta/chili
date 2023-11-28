       program-id. Program1 as "mycob.Program1".

       data division.
       working-storage section.
       01 emp-record.
         02 empno pic 99.
         02 ename pic A(15).
         02 job pic X(10).
         02 salary pic 999.
          
       01 heading1.
         02 filler pic X(30) value spaces.
         02 filler pic X(18) value "ADICIONAR REGISTRO".
         02 filler pic X(35) value spaces.

       01 line-draw.
         02 cabec pic x(1) value "=" occurs 80 times.

       screen section.
       01 screen-heading1 foreground-color 1 background-color 0.
         02 filler value "EMPLOYEE DATA ENTRY" line 2 col 30.
       01 data-entry-screen1 foreground-color 2 background-color 0.
         02 filler value "Reg#     :" line 5 col 15.
         02 filler value "Nome     :" line 6 col 15.
         02 filler value "Job      :" line 7 col 15.
         02 filler value "Salary   :" line 8 col 15.

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
