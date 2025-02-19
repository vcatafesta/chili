PROCEDURE MAIN
    LOCAL cDir, cCommand, cOutputFile, cLine, aFiles
    LOCAL i, fHandle

    // Defina o diretório a ser listado
    cDir := "/home/usuario/"  // Substitua pelo diretório desejado

    // Defina o arquivo de saída temporário
    cOutputFile := "/tmp/output.txt"  // Caminho do arquivo temporário

    // Monta o comando find para listar todos os arquivos
    cCommand := "find . -type f > output.txt"

    // Executa o comando find, redirecionando a saída para o arquivo temporário
    HB_PROCESSRUN(cCommand)

    // Agora, leia o arquivo temporário para obter os resultados
    aFiles := {}
    IF FILE(cOutputFile)  // Verifique se o arquivo foi gerado
        // Abra o arquivo e leia as linhas
        fHandle := FOpen(cOutputFile, FO_READ)
        WHILE !hb_FEOF(fHandle)  // Usa FEOF() para verificar o final do arquivo
            cLine := FRead(fHandle)  // Lê o conteúdo do arquivo
            AADD(aFiles, cLine)  // Adiciona a linha ao array aFiles
        END
        FClose(fHandle)
    END

    // Exibe os arquivos encontrados
    IF Len(aFiles) > 0
        FOR i := 1 TO Len(aFiles)
            ? aFiles[i]  // Exibe o nome do arquivo
        NEXT
    ELSE
        ? "Nenhum arquivo encontrado."
    ENDIF

    // Remove o arquivo temporário após o uso
    FERASE(cOutputFile)  // Remove o arquivo temporário

    RETURN

