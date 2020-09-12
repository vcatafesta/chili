      *----------------------------------------------------------------*
      * PROGRAMA.: ARQUIVO.
      * ANALISTA.: FELIPE BARBOSA FERREIRA.
      * AUTOR....: FELIPE BARBOSA FERREIRA.
      * DATA.....: 05/11/2016.
      * OBJETIVO.: Trabalhando com arquivos
      *
      *----------------------------------------------------------------*
      * VRS001 05/11/2016 - (FELIPE BARBOSA FERREIRA) - IMPLANTACAO
      *----------------------------------------------------------------*
      *
      ******************************************************************
       IDENTIFICATION                   DIVISION.
      ******************************************************************
      *
       PROGRAM-ID. ARQUIVO.
      *
      ******************************************************************
       ENVIRONMENT                      DIVISION.
      ******************************************************************
      *
      *----------------------------------------------------------------*
       CONFIGURATION                    SECTION.
      *----------------------------------------------------------------*
      *
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
      *----------------------------------------------------------------*
       INPUT-OUTPUT                     SECTION.
      *----------------------------------------------------------------*
      *
       FILE-CONTROL.
      *
      * -- Arquivo de leitura
	       SELECT ARQUIVO-ENTRADA
               ASSIGN 'arquivo-entrada.txt'
                   FILE STATUS IS IN-FILE-EST-ARQ-ENTD.
      *
      * -- Arquivo de escrita
           SELECT ARQUIVO-SAIDA
               ASSIGN 'arquivo-saida.txt'
                   FILE STATUS IS IN-FILE-EST-ARQ-SAID.
      *
      ******************************************************************
       DATA                             DIVISION.
      ******************************************************************
      *
      *----------------------------------------------------------------*
       FILE                             SECTION.
      *----------------------------------------------------------------*
      *
      * -- Descricao do arquivo de entrada
       FD ARQUIVO-ENTRADA.
      *
      * Layout do arquivo: ARQUIVO-ENTRADA
       01 ARQUIVO-ENTRADA-REG.
           03 ARQ-ENTD-NM-PSS           PIC  X(020).
           03 ARQ-ENTD-NM-PSS-SNM       PIC  X(040).
           03 ARQ-ENTD-DT-PSS-NSC       PIC  X(010).
      *
      * -- Descricao do arquivo de saida
       FD ARQUIVO-SAIDA.
      *
      * Layout do arquivo: ARQUIVO-SAIDA
       01 ARQUIVO-SAIDA-REG.
           03 ARQ-SAID-NM-PSS           PIC  X(020).
           03 ARQ-SAID-DT-PSS-NSC       PIC  X(010).
      *
      *----------------------------------------------------------------*
       WORKING-STORAGE                  SECTION.
      *----------------------------------------------------------------*
      *
       77 CTL-INICIO                    PIC  X(026) VALUE
                                           '*** W.S.S. COMECA AQUI ***'.
       77 CTL-PROG                      PIC  X(015) VALUE
                                                      '*** ARQUIVO ***'.
       77 CTL-VERS                      PIC  X(006) VALUE 'VRS001'.
      *
       77 CTL-FIM                       PIC  X(032) VALUE
                                             '*** WSS TERMINA AQUI ***'.
      *
      *----------------------------------------------------------------*
       LOCAL-STORAGE                    SECTION.
      *----------------------------------------------------------------*
      *
      * -- Declaracao de file-status do arquivo: ARQUIVO-ENTRADA
       01 IN-FILE-EST-ARQ-ENTD          PIC  X(002) VALUE SPACES.
      *
      * -- Declaracao de file-status do arquivo: ARQUIVO-SAIDA
       01 IN-FILE-EST-ARQ-SAID          PIC  X(002) VALUE SPACES.
      *
      *----------------------------------------------------------------*
      * -- Armazena o codigo e texto de erro
      *----------------------------------------------------------------*
      *
       77 CD-ERRO                       PIC S9(009) VALUE ZEROS.
       77 TX-ERRO                       PIC  X(120) VALUE SPACES.
      *
      *
       77 CTL-FINAL-SS                  PIC X(40) VALUE
                                 '*** STORAGE SECTION TERMINA AQUI ***'.
      *
      ******************************************************************
       PROCEDURE DIVISION.
      ******************************************************************
      *
      *----------------------------------------------------------------*
       000000-ROTINA-PRINCIPAL          SECTION.
      *----------------------------------------------------------------*
      *
      * -- Exibe mensagem
           DISPLAY 'Teste com arquivos. Declarações!'.
      *
      * -- Encerra a execucao
           PERFORM 999900-RETORNA.
      *
       000000-FIM.
           EXIT.
      *
      *----------------------------------------------------------------*
       999900-ERROS                     SECTION.
      *----------------------------------------------------------------*
      *
       999001-ERRO-01.
           MOVE 999                     TO CD-ERRO.
           STRING 'Erro '
                   DELIMITED BY SIZE  INTO TX-ERRO
           END-STRING.
           PERFORM 999900-RETORNA.
      *
       999900-RETORNA.
      *
      * -- Verifica se ocorreu erro no processamento
           IF CD-ERRO NOT EQUAL ZEROS
               DISPLAY 'Ocorreu erro na execução do programa.'
               DISPLAY 'Código do erro...: ' CD-ERRO
               DISPLAY 'Descrição do erro: ' TX-ERRO
           END-IF.
      *
           GOBACK.
      *
      *----------------------------------------------------------------*

