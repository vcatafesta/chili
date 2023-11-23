       IDENTIFICATION DIVISION.
       PROGRAM-ID. LeituraGravacaoDados.

       DATA DIVISION.
       FILE SECTION.
       FD DadosArquivo.
       01 Registro.
           05 NOME         PIC X(30).
           05 ENDERECO      PIC X(50).
           05 CIDADE       PIC X(20).
           05 ESTADO       PIC X(2).

       WORKING-STORAGE SECTION.
       01 OPCAO        PIC 9.

       PROCEDURE DIVISION.
           PERFORM EXIBIR-MENU UNTIL OPCAO = 3.
           STOP RUN.

       EXIBIR-MENU.
           DISPLAY "MENU:".
           DISPLAY "1. Inserir dados".
           DISPLAY "2. Imprimir dados".
           DISPLAY "3. Sair".
           DISPLAY "Escolha uma opcao (1-3): ".
           ACCEPT OPCAO.
           EVALUATE OPCAO
               WHEN 1
                   PERFORM INSERIR-DADOS
               WHEN 2
                   PERFORM IMPRIMIR-DADOS
               WHEN 3
                    DISPLAY "Saindo do programa..."
               WHEN OTHER
                    DISPLAY "Opcao invalida. Tente novamente.".
           END-EVALUATE.

       INSERIR-DADOS.
           DISPLAY "Digite o nome: ".
           ACCEPT NOME.
           DISPLAY "Digite o endereco: ".
           ACCEPT ENDERECO.
           DISPLAY "Digite a cidade: ".
           ACCEPT CIDADE.
           DISPLAY "Digite o estado: ".
           ACCEPT ESTADO.

           OPEN OUTPUT DadosArquivo.
           MOVE NOME TO Registro.
           WRITE Registro.
           CLOSE DadosArquivo.
           DISPLAY "Dados inseridos no arquivo com sucesso!".

           IMPRIMIR-DADOS.
               DISPLAY "Imprimindo dados do arquivo...".
               OPEN INPUT DadosArquivo.
               READ DadosArquivo INTO Registro AT
                   END DISPLAY "Arquivo vazio.".
               PERFORM UNTIL EOF
                   DISPLAY "Nome   : " NOME.
                   DISPLAY "Endereco: " ENDERECO.
                   DISPLAY "Cidade : " CIDADE.
                   DISPLAY "Estado : " ESTADO.
                   READ DadosArquivo INTO Registro AT END SET EOF TO TRUE.
               END-PERFORM.

           CLOSE DadosArquivo.
               DISPLAY "Dados impressos com sucesso!".
