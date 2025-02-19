PROCEDURE MAIN
   LOCAL nRet
   nRet := HB_PROCESSRUN( "duf" )  // Comando a ser executado
   IF nRet != 0
      ? "Erro ao executar o comando"
   ELSE
      ? "Comando executado com sucesso"
   ENDIF
RETURN
