#include "hbclass.ch"

PROCEDURE MAIN
    LOCAL cDir, aFiles, cFile
    LOCAL cArquivoDbf

    // Diretório para listar os arquivos
    cDir := "/home"
    
    // Usando a função DIRECTORY() para listar os arquivos
    aFiles := DIRECTORY(cDir + "*.*")  // Lista todos os arquivos e diretórios

    // Definir o nome do arquivo DBF
    cArquivoDbf := "arquivos.dbf"

    // Criar o arquivo DBF usando DBCREATE
    IF !FILE(cArquivoDbf)
        DBCREATE(cArquivoDbf, { { "caminho", "C", 255,0 } })
    ENDIF

    // Abrir o banco de dados
    USE arquivos.dbf ALIAS arquivos

    // Inserir os arquivos listados no banco de dados
    FOR EACH cFile IN aFiles
        IF cFile[1] != "." .AND. cFile[1] != ".."  // Ignora "." e ".."
            APPEND BLANK
            REPLACE caminho WITH cDir + "/" + cFile[1]
        ENDIF
    NEXT

    browse()

    // Fechar o banco de dados
    USE

    ? "Arquivos inseridos no banco de dados com sucesso!"
RETURN

