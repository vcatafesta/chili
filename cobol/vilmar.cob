       identification division.
       program-id. vilmar.
       environment division.
       data division.
            working-storage section.
               01 ws-nome   pic x(20).
               01 nome      pic x(50)       value "r202".
               01 idade     pic 9(2)        value 57.
               01 salario   pic 9(6)v9(2)   value 20000.00.
            
       procedure division.
            display "nome      : " nome
            display "idade     : " idade
            display "salario   : " salario

            display "nome      : " with no advancing
            accept ws-nome
            display "resultado : " ws-nome
            stop run.
