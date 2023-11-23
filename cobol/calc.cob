       IDENTIFICATION DIVISION.
       PROGRAM-ID. CalculadoraSimples.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NUMERO1       PIC 9(5).
       01 NUMERO2       PIC 9(5).
       01 RESULTADO     PIC 9(10).
       01 OPERACAO      PIC X(1).
       
       PROCEDURE DIVISION.
           DISPLAY "Digite o primeiro número: ".
               ACCEPT NUMERO1.
           DISPLAY "Digite o segundo número: ".
               ACCEPT NUMERO2.
           DISPLAY "Escolha a operação (+, -, *, /): ".
               ACCEPT OPERACAO.
           EVALUATE OPERACAO
           WHEN '+'
               COMPUTE RESULTADO = NUMERO1 + NUMERO2
           WHEN '-'
               COMPUTE RESULTADO = NUMERO1 - NUMERO2
           WHEN '*'
               COMPUTE RESULTADO = NUMERO1 * NUMERO2
           WHEN '/'
           IF NUMERO2 NOT = 0
               COMPUTE RESULTADO = NUMERO1 / NUMERO2
           ELSE
               DISPLAY "Erro: Divisão por zero não permitida."
           END-IF
           WHEN OTHER
           DISPLAY "Operação inválida."
           END-EVALUATE.
           DISPLAY "Resultado: " RESULTADO.
           STOP RUN.                
      